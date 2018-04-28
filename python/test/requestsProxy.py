#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
使用代理的方式获取数据
'''
__author__ = '付国良'

import requests

def requestsWithProxy(url, proxyList, timeout=10, retryCount=3):
    count = 0
    for proxy in proxyList:
        p = proxy.split(':')
        dic = {p[0]: 'http://%s:%s' % (p[1], p[2])}
        try:
            headers = {
                'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'
            }
            text = requests.get(url, headers=headers, proxies=dic, timeout=timeout).text
            ret = text
            if ret is None:
                raise BaseException()
        except:
            count += 1
            # 重试下一个代理
            if count < len(proxyList):
                continue
            # 递归retry
            if retryCount > 0:
                print('重试%s' % retryCount)
                requestsWithProxy(url, proxyList=proxyList, retryCount=retryCount-1)
            else:
                return None
        else:
            return ret