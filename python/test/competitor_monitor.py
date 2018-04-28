#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
获取和竞对产品的对应关系
'''
__author__ = '付国良'

import os
import requests
import json
import re
import multiprocessing
from requestsProxy import requestsWithProxy
from getProxy import getProxies
from bs4 import BeautifulSoup
from Print import *

_PathResult = 'competitor/monitor/'
_PathMapping = 'competitor_mapping.txt'
_Proxies = []


wn_print_header()

class NoFoundError(BaseException):
    def __init__(self):
        BaseException.__init__(self, '团号不存在')


def getIds():
    '''
    获取和竞对产品的ID对应关系
    :return: 二维数组
    '''
    ret = []
    with open(_PathMapping, 'r') as f:
        for line in f.readlines():
            if line == '' or line[0] == '#' or line == os.linesep:
                continue
            arr = line.replace(os.linesep, '').split(',')
            ret.append(arr)
    return ret


def getGroupId():
    '''
    将ID按照不同平台进行分组
    '''
    def addIdToList(id, list):
        if id != '0' and id.isdigit():
            return list.append(id)

    wannarList, usitripList, lulutripList, tourfunList = [], [], [], []
    for x in getIds():
        if not isinstance(x, list):
            continue
        if len(x) > 3:
            addIdToList(x[0], wannarList)
            addIdToList(x[1], usitripList)
            addIdToList(x[2], lulutripList)
            addIdToList(x[3], tourfunList)
    return [wannarList, usitripList, lulutripList, tourfunList]


def purifyPrice(str):
    '''
    字符串中只保留数字,获取金额
    '''
    L = re.findall(r"\d+\.?\d*", str)
    if len(L) > 0:
        return float(L[0])
    else:
        return 0


def getWannarResponse(id):
    '''
    获取 [玩哪儿] 数据
    '''
    price, orglPrice, discount = 0, 0, 0
    param = {'query': 'tour_id:%s' % id,
             'solr': 'tour',
             'fields': 'tour_id, tour_url, tour_day, tour_code, tour_code_op, tour_agent_id, tour_departure, tour_leave, is_discount_now, current_price, tour_discount_start, tour_discount_end, tour_discount_percent_now, tour_special_promotion, tour_recommand'}
    url = 'https://www.wannar.com/api/5.04/list/get-list.php'
    text = requests.post(url, data=param, timeout=20).text
    try:
        j = json.loads(text)
        data = j['data'][0]
        price = data['current_price'] / 100
        if 'is_discount_now' in data.keys() and data['is_discount_now']:
            discount = 100 - (data['tour_discount_percent_now'])
    except BaseException as e:
        wn_print('***错误*** [id: %s]' % id, e)
    finally:
        if discount != 0 and price != 0:
            orglPrice = round(price / ((100 - discount) / 100), 1)
        else:
            orglPrice = price
        # print('[id: %s] 原价: %s  现价: %s  折扣: %s' % (id, orglPrice, price, discount))
        return [str(id), str(orglPrice), str(price), str(discount)]


def getUsitripResponse(id):
    '''
    获取 [走四方] 数据
    4435: 正常有折扣
    107885: 进入404
    1065: 未有产品
    '''
    price, orglPrice, discount = 0, 0, 0
    try:
        url = 'http://m.usitrip.com/travel/%s.html' % id
        response = requests.get(url, timeout=30)
        if response.status_code == 404:
            url = 'http://m.usitrip.com/activity/info/number-%s.html' % id
            response = requests.get(url)
            if response.status_code == 404:
                print('① ID不正确 [id: %s]' % id)
            else:
                soup = BeautifulSoup(response.text, "html.parser")
                x = soup.select('span.in-price')
                if len(x) > 0:
                    y = x[0]
                    if y and y.find('b'):
                        a = y.find('b').get_text()
                        price = purifyPrice(a)
                    else:
                        print('② 格式未处理 [id: %s]' % id)
                else:
                    print('③ 未找到span.in-price [id: %s]' % id)
        else:
            soup = BeautifulSoup(response.text, "html.parser")
            x = soup.select('div.money')
            if len(x) > 0:
                y = x[0]
                if y.find('em'):
                    a = y.find('em').attrs['cur_usd']
                    price = purifyPrice(a)
                else:
                    a = y.select('span.js_product_special_price')[0].attrs['cur_usd']
                    price = purifyPrice(a)
                    b = y.find('del').attrs['cur_usd']
                    orglPrice = purifyPrice(b)
            else:
                print('④ 未找到div.money [id: %s]' % id)

        orglPrice = orglPrice == 0 and price or orglPrice
    except BaseException as e:
        wn_print('***错误*** [id: %s]' % id, '\n', e)
    finally:
        if orglPrice != 0 and price != 0:
            discount = round(((orglPrice - price) / orglPrice) * 100, 1)
        # print('[id: %s] 原价: %s  现价: %s  折扣: %s' % (id, orglPrice, price, discount))
        return [str(id), str(orglPrice), str(price), str(discount)]


def getLulutripResponse(id):
    '''
    获取 [路路行] 数据
    2707: u_fs22
    8933: vire_cr
    2673: cur_price
    '''
    price, orglPrice, discount = 0, 0, 0
    try:
        url = 'http://app.lulutrip.com/tour/view/tourcode-%s' % id
        headers = {'Accept-Language': 'zh-CN,zh;q=0.8,ja;q=0.6,en-US;q=0.4,en;q=0.2,zh-TW;q=0.2',
                   'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36',
                   'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
                   'Cookie': 'CurrentLang=CN; crystal_ball_alert=-1; product_browsing_history=4681%2C; CurrentCurrency=USD; Lulutrip_LSM=d4fd9171715a00ca8b257c66fd5b6c33; PHPSESSID=h1tgeoc3i1bu2gcdmkndcifsq7; SERVER_ID=30ae5889-63b97057; _gat=1; CurrentLocation=China; navigationtype=NA; _ga=GA1.2.846197581.1480574939; Hm_lvt_56eb03d0c0e2c3293ca954328aa20fea=1480679005,1481609488,1481877718,1482200677; Hm_lpvt_56eb03d0c0e2c3293ca954328aa20fea=1482203126',
                   'Connection': 'keep-alive'}
        response = requests.get(url, headers=headers, timeout=30)
        if "alert('对不起，您输入的团号不存在')" in response.text:
            raise NoFoundError()

        soup = BeautifulSoup(response.text, "html.parser")
        # Price
        x = soup.select('span.u_fs22')
        if len(x) > 0:
            y = x[0]
            price = purifyPrice(y.string)
        else:
            # Discount
            x = soup.select('div.zk')
            if len(x) > 0:
                discount = purifyPrice(x[0].string)
                # Price
                p = soup.select('p.vire_cr')
                if len(p) > 0:
                    price = purifyPrice(p[0].find('i').string)
                else:
                    print('① 未找到p.vire_cr [id: %s]' % id)
            else:
                # Price
                p = soup.select('div.cur_price')
                if len(p) > 0:
                    wn_print(id)
                    price = purifyPrice(x[0].find('span').string)
                else:
                    print('② 未找到div.cur_price [id: %s]' % id)
    except BaseException as e:
        wn_print('***错误*** [id: %s]' % id, e)
    finally:
        if discount != 0 and price != 0:
            orglPrice = round(price / ((100 - discount) / 100), 1)
        else:
            orglPrice = price
        # print('[id: %s] 原价: %s  现价: %s  折扣: %s' % (id, orglPrice, price, discount))
        return [str(id), str(orglPrice), str(price), str(discount)]


def getTourfunResponse(id):
    '''
    获取 [途风] 数据
    '''
    price, orglPrice, discount = 0, 0, 0
    try:
        url = 'https://app.toursforfun.com/product/%s/detail' % id
        s = requestsWithProxy(url=url, proxyList=_Proxies)
        j = json.loads(s)
        if j['code'] == 1:
            info = j['data']['info']
            if info['special_price'] is not None:
                price = round(float(info['special_price']), 1)
                orglPrice = round(float(info['default_price']), 1)
                discount = 100 - round(float(price) / float(orglPrice), 2) * 100
            else:
                price = round(float(info['default_price']), 1)
        else:
            raise NoFoundError()
    except BaseException as e:
        wn_print('***错误*** [id: %s]' % id, e)
    finally:
        if discount != 0 and price != 0:
            orglPrice = round(price / ((100 - discount) / 100), 1)
        else:
            orglPrice = price
        # print('[id: %s] 原价: %s  现价: %s  折扣: %s' % (id, orglPrice, price, discount))
        return [str(id), str(orglPrice), str(price), str(discount)]


def saveWannar(ids):
    path = _PathResult + 'wannar.csv'
    with open(path, 'w') as f:
        count = 0
        for id in ids:
            rsp = getWannarResponse(id)
            str = ','.join(rsp) + os.linesep
            f.write(str)
            count += 1
            print('[wannar  ]: 还剩%s个' % (len(ids) - count))


def saveUsitrip(ids):
    path = _PathResult + 'usitrip.csv'
    with open(path, 'w') as f:
        count = 0
        for id in ids:
            rsp = getUsitripResponse(id)
            str = ','.join(rsp) + os.linesep
            f.write(str)
            count += 1
            print('[usitrip ]: 还剩%s个' % (len(ids) - count))


def saveLulutrip(ids):
    path = _PathResult + 'lulutrip.csv'
    with open(path, 'w') as f:
        count = 0
        for id in ids:
            rsp = getLulutripResponse(id)
            str = ','.join(rsp) + os.linesep
            f.write(str)
            count += 1
            print('[lulutrip]: 还剩%s个' % (len(ids) - count))


def saveTourfun(ids):
    path = _PathResult + 'tourfun.csv'
    with open(path, 'w') as f:
        count = 0
        for id in ids:
            rsp = getTourfunResponse(id)
            str = ','.join(rsp) + os.linesep
            f.write(str)
            count += 1
            print('[tourfun ]: 还剩%s个' % (len(ids) - count))


def competitor():
    # todo
    wnRst, usiRst, llRst, tfRst = [], [], [], []
    wnPath = '%swannar.csv' % _PathResult
    usiPath = '%susitrip.csv' % _PathResult
    llPath = '%slulutrip.csv' % _PathResult
    tfPaht = '%stourfun.csv' % _PathResult

    with open(wnPath, 'r') as f:
        wnRst = f.readlines()
    wn_print(wnRst)

def main():
    global _Proxies
    _Proxies = getProxies()

    groupIds = getGroupId()
    # 玩哪儿
    wnpro = multiprocessing.Process(target=saveWannar, args=(groupIds[0],))
    wnpro.start()

    # 走四方
    usipro = multiprocessing.Process(target=saveUsitrip, args=(groupIds[1],))
    usipro.start()

    # 路路行
    llpro = multiprocessing.Process(target=saveLulutrip, args=(groupIds[2],))
    llpro.start()

    # 途风
    tfpro = multiprocessing.Process(target=saveTourfun, args=(groupIds[3],))
    tfpro.start()

    # 等待所有进程执行完毕
    wnpro.join()
    usipro.join()
    llpro.join()
    tfpro.join()



if __name__ == '__main__':
    pass
    # main()
    # competitor()
