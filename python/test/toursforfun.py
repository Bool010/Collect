#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
途风
'''
__author__ = '付国良'

import requests
import os
import json
from Print import wn_print_footer, wn_print_header, wn_print
from getProxy import getProxies
import time
import pandas as pd
import re
import multiprocessing
import math
from requestsProxy import requestsWithProxy

wn_print_header()

_ProcessCount = 12 # 一般为电脑cpu核心数或N倍
_ProxyList = []
_PathForId = '/Users/fuguoliang/Desktop/Python/toursforfun_ids.txt'
_Path1 = '/Users/fuguoliang/Desktop/Python/competitor/'
_Path2 = '/Users/fuguoliang/Desktop/Python/competitor/tourforfun/'


def getIds():
    '''
    获取途风ID
    '''
    ids = []
    if os.path.exists(_PathForId) and os.path.isfile(_PathForId):
        with open(_PathForId, 'r') as f:
            for line in f.readlines():
                ids.append(int(line))
    return ids


def getUrl(id):
    '''
    获取途风URL
    '''
    url = "https://app.toursforfun.com/product/%s/detail" % id
    return url


def paserResponse(url, count=0):
    '''
    解析响应数据
    '''
    try:
        s = requestsWithProxy(url, _ProxyList)
        j = json.loads(s)
        if j['code'] == 1:
            info = j['data']['info']
            # 产品ID
            code = info['product_id']

            # 产品标题
            title = info['name'].replace(',', '')

            # 当前价格
            price = ''

            # 折扣
            discount = ''

            # 普通价格
            defaultPrice = str(round(float(info['default_price']), 1))
            price = defaultPrice

            # 特殊价格
            specialPrice = info['special_price']
            if specialPrice is not None:
                specialPrice = str(round(float(info['special_price']), 1))
                price = specialPrice
                discount = str(100 - (round(float(specialPrice) / float(defaultPrice), 2) * 100)) + '%'

            # 促销
            isPromotion = str(info['is_promotion']) == '0' and ' ' or 'Y'

            # 特殊
            isSpecial = str(info['is_special']) == '0' and ' ' or 'Y'

            # 秒杀
            isSeckill = str(info['is_seckill']) == '0' and ' ' or 'Y'

            # 天数
            days = info['duration']['time']

            # 已售
            ordered = str(info['ordered'])

            # 出发
            departure = '、'.join(info['start_city'])

            # 结束
            end = '、'.join(info['end_city'])

            return [code, price, discount, ordered, isPromotion, isSpecial, isSeckill, days,
                    departure, end, title]
        else:
            pass

    except BaseException as e:
        paserResponse(url, count=count + 1)
        if count == 5:
            path = _Path2 + 'error.txt'
            with open(path, 'a') as f:
                f.write(url + os.linesep)


def getToursforfunData(ids, processTag):
    '''
    爬取途风数据
    '''
    path = '%sdata%s.txt' % (_Path2, processTag)
    with open(path, 'w') as f:
        while len(ids) > 0:
            print('[%s]: 还剩%s个' % (processTag, len(ids)))
            data = paserResponse(getUrl(ids[0]))
            if isinstance(data, list):
                wn_print('|||'.join(data))
                f.write('|||'.join(data) + os.linesep)
            ids.pop(0)


def getLocalDatas():
    '''
    读取本地数据,将Data文件拼接到一个数组中
    '''
    datas = []
    for i in range(_ProcessCount):
        path = _Path2 + 'data' + str(i) + '.txt'
        print(path)
        with open(path, 'r') as f:
            for line in f.readlines():
                a = line.replace(os.linesep, '').split('|||')
                datas.append(a)
    print(len(datas))
    return datas


def creatCSV():
    '''
    创建CVS文件
    '''
    datas = getLocalDatas()
    t = time.strftime('%Y-%m-%d', time.localtime())
    path = _Path2 + t + '.csv'
    with open(path, 'w') as f:
        for x in datas:
            if isinstance(x, list):
                s = ','.join(x)
                f.write(s + os.linesep)
    wn_print('.csv 文件路径 %s' % path)


def creatDir():
    '''
    创建存储数据文件夹
    '''
    if not (os.path.exists(_Path1) and os.path.isdir(_Path1)):
        os.mkdir(_Path1)

    if not (os.path.exists(_Path2) and os.path.isdir(_Path2)):
        os.mkdir(_Path2)


def openProcess():
    '''
    开启进程获取数据，并写入文件
    '''
    processList = []
    ids = getIds()
    length = math.floor(len(ids) / _ProcessCount)
    wn_print(len(ids), length)
    start = 0
    for x in range(_ProcessCount):
        remainLen = len(ids) - (length * (x + 1))
        if remainLen > length:
            L = ids[start:start + length]
        else:
            L = ids[start:len(ids)]
        start += length
        process = multiprocessing.Process(target=getToursforfunData, args=(L, x))
        processList.append(process)
        process.start()

    for x in processList:
        x.join()


def deleteErrorFile():
    '''删除存储解析发生错误的文件'''
    try:
        os.system('rm -f %s' % _Path2 + 'error.txt')
    except:
        pass


def deleteTempFile():
    '''
    删除临时存储数据的文件
    '''
    try:
        for i in range(_ProcessCount):
            path = '%sdata%s.txt' % (_Path2, i)
            os.system('rm -f %s' % path)
    except:
        pass


def main():
    '''
    程序主入口
    '''

    # 获取可用代理列表并存入Global
    global _ProxyList
    _ProxyList = getProxies()

    creatDir()
    deleteErrorFile()
    openProcess()
    creatCSV()
    deleteTempFile()


if __name__ == '__main__':
    wn_print('请先配置路径')
    # main()

wn_print_footer()
