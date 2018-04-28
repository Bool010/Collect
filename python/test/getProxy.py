#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
获取代理
'''
__author__ = '付国良'

import requests
import os
from bs4 import BeautifulSoup
from Print import wn_print

__PROXIES = []
__Path = '/Users/fuguoliang/Desktop/Python/availableProxy.txt'
__URLTest = 'https://app.toursforfun.com/product/102/detail'
__Type = 'https'

def __getDoc__(url):
    '''
    获取URL返回代码
    '''
    try:
        header = {'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1'}
        return requests.get(url, headers=header).text
    except BaseException as e:
        wn_print('获取Url发生错误: %s' % e)
        return ''


def __proxyList__(url):
    '''
    根据URL获取代理列表
    '''
    L = []
    doc = __getDoc__(url)

    try:
        soup = BeautifulSoup(doc, "html.parser")
        table = soup.find('table', id='ip_list')
        trs = table.find_all('tr')
        for tr in trs:
            tds = tr.find_all('td')
            if len(tds) > 1:
                s = '%s:%s:%s' % (tds[5].string.lower(), tds[1].string, tds[2].string)
                L.append(s)
    except:
        print('从%s获取代理失败' % url)
        pass

    return L


def __urlList__():
    '''
    代理URL
    '''
    return ['http://www.xicidaili.com/nn/1',
            'http://www.xicidaili.com/nn/2',
            'http://www.xicidaili.com/nn/3',
            'http://www.xicidaili.com/wn/1',
            'http://www.xicidaili.com/wn/2',
            'http://www.xicidaili.com/wn/3']


def __getProies__(type='https'):
    '''
    获取某种类型[http or https]代理列表
    '''
    global __PROXIES
    L = []
    for x in __PROXIES:
        p = x.split(':')
        if p[0].lower() == type.lower():
            L.append(x)
    return L


def __getProxyList__(isSaveTxt=False, path='proxy.txt'):
    '''
    获取代理列表
    :param isSaveTxt: 是否保存为文本
    :return: 代理数组 [ip:port]
    '''

    # 从代理网站解析URL获取代理列表
    global __PROXIES
    S = set()
    for url in __urlList__():
        L = __proxyList__(url)
        for proxy in L:
            S.add(proxy)

    # 是否保存为文本
    if isSaveTxt:
        with open(path, 'w') as f:
            for proxy in list(S):
                f.write(proxy + os.linesep)
    __PROXIES = list(S)

    # 如果失败，从文本中读取
    if len(__PROXIES) == 0:
        print('从文本文件中读取代理...')
        with open(path, 'r') as f:
            for line in f.readlines():
                S.add(str(line).strip(os.linesep))
    __PROXIES = list(S)

    return list(S)



def __getAvailableProxyList__(url, type='https', isReset=False, isSaveTxt=True, savePath='availableProxy.txt'):
    '''
    获取可用代理列表
    '''
    print('正在获取可用代理列表...')

    global __PROXIES
    if len(__PROXIES) == 0:
        isReset = True
    if isReset:
        __getProxyList__()
    print('共有%s个代理' % len(__PROXIES))

    ret = []
    L = __getProies__(type)
    print('共有%s个%s类型代理' % (len(L), type))
    i = 0

    for proxy in L:
        p = proxy.split(':')
        dic = {type.lower(): 'http://%s:%s' % (p[1], p[2])}
        try:
            i += 1
            print('正在尝试第%s个: %s' % (i, proxy))
            headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'}
            requests.get(url, headers=headers, proxies=dic, timeout=3)
            ret.append(proxy)
            print('||||||||| 发现%s个可用代理 |||||||||' % len(ret))
        except BaseException as e:
            continue
            pass

    # 保存可用代理为TXT
    if isSaveTxt and len(ret) > 0:
        with open(savePath, 'w') as f:
            for proxy in ret:
                f.write(proxy + os.linesep)
    return ret



def getProxies(isRefreshNet=False, isRefreshLocal=False):

    # 从本地代理中筛选可用代理
    if isRefreshLocal:
        __getAvailableProxyList__(url=__URLTest, type=__Type, savePath=__Path, isReset=isRefreshNet)

    # 从文本文件中读取可用的代理
    L = []
    if os.path.exists(__Path) and os.path.isfile(__Path):
        with open(__Path, 'r') as f:
            for line in f.readlines():
                L.append(str(line).strip(os.linesep))
    return L


if __name__ == '__main__':
    __getAvailableProxyList__(url=__URLTest, type=__Type, savePath=__Path)

