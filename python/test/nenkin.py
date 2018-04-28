#!/usr/bin/env python3
# -*- coding: utf-8 -*-

__author__ = '付国良'

from bs4 import BeautifulSoup
import requests
import json
import re


BASEURL = 'http://www.nenkin.go.jp/'

def parse_data(url, retry=5):
    '''
    解析事务所中的内容
    :param url: 事务所链接
    :param retry: 失败时重试次数
    :return:
    '''
    try:
        pat = re.compile(r'href="([^"]*)"')

        doc = str(requests.get(url, timeout=30).content, 'utf-8', errors='replace')
        soup = BeautifulSoup(doc, "html.parser")
        # h1bg
        h1bg = soup.find('div', {'class': 'h1bg'})
        title = h1bg.find('h1').string
        print(title)

        # box2
        box2 = soup.find('div', {'class': 't-box2'})
        trs = box2.find_all('tr')
        datas = []
        for tr in trs:
            # th
            th = tr.find('th')

            # td
            td = tr.find('td')
            td = str(td)
            td = td.replace('<br>', '\n')
            td = del_html_tag(td)
            s = th.string + ': ' + td
            datas.append(s)

        # externalLink
        map = soup.find('a', {'class': 'externalLink'})
        href = pat.search(str(map)).group(1)
        google = href

        a = href.split('/')
        print(a)
        if len(a) > 6:
            query = a[5]
            temp = a[6].split(',')
            print(temp)
            if len(temp) > 1:
                lat = temp[0].replace('@', '')
                lon = temp[1]
                apple = 'http://maps.apple.com/?q=' + query + '&sll=' + lat + ',' + lon
            else:
                apple = 'http://maps.apple.com/?q=' + title
        else:
            apple = 'http://maps.apple.com/?q=' + title
    except:
        datas = []
        google = 'error'
        apple = 'error'
        if retry > 0:
            retry = retry - 1
            parse_data(url, retry)
        print('发生错误')
    finally:
        return {'data': datas, 'google': google, 'apple': apple}


def get_provinces():
    '''
    获取省份名称和链接
    :return:
    '''
    url = BASEURL + 'section/soudan/index.html'
    doc = str(requests.get(url, timeout=60).content, 'utf-8', errors='replace')
    soup = BeautifulSoup(doc, "html.parser")
    innerLinks = soup.find_all('li', attrs={'class': 'innerLink'})
    pat = re.compile(r'href="([^"]*)"')
    ret = []
    for innerLink in innerLinks:
        s = str(innerLink)
        # href
        href = pat.search(s).group(1)
        # title
        title = del_html_tag(s)
        if 'index.html' in href:
            dic = {'title': title,
                   'href': href}
            ret.append(dic)
    return ret


def get_office():
    '''
    获取事务所链接
    :return:
    '''
    pat = re.compile(r'href="([^"]*)"')
    provices = get_provinces()
    ret = []
    for provice in provices:
        datas = []
        url = BASEURL + provice['href']
        doc = str(requests.get(url, timeout=60).content, 'utf-8', errors='replace')
        soup = BeautifulSoup(doc, "html.parser")
        box2 = soup.find('div', {'class': 't-box2'})
        a_s = box2.find_all('a')
        for a in a_s:
            href = pat.search(str(a)).group(1)
            if '/section/soudan/' in href:
                title = a.string
                datas.append({'title': title, 'href': href})
        ret.append({'provice': provice['title'], 'data': datas})
    with open('office.txt', 'w') as f:
        f.write(json.dumps(ret))
    return ret


def json_data():
    '''
    生成JSON字符串
    :return:
    '''
    with open('office.txt', 'r') as f:
        s = f.read()
        offices = json.loads(s)

    for office in offices:
        for dic in office['data']:
            url = BASEURL + dic['href']
            print(url)
            x = parse_data(url)
            dic['google'] = x['google']
            dic['apple'] = x['apple']
            dic['data'] = x['data']
    return json.dumps(offices)


def del_bracket(s):
    '''
    删除括号中的内容
    :param s: 输入
    :return:
    '''
    a1 = re.compile(r'\（.*?\）')
    return a1.sub('', s)


def del_html_tag(text):
    '''
    删除HTML-tag
    :param text: 输入
    :return:
    '''
    dr = re.compile(r'<[^>]+>', re.S)
    dd = dr.sub('', text)
    return dd


def modifiy_jsontxt():
    '''
    修改json格式
    :return:
    '''
    with open('json.txt', 'r') as f:
        a = json.loads(f.read())
        ret = []
        for b in a:
            one = {'name': b['provice']}
            two = []
            for c in b['data']:
                dic3 = {'title': c['title'],
                        'href': BASEURL + c['href'],
                        'google': c['google'],
                        'apple': c['apple']}
                d = c['data']
                if (len(d) > 1) and ('所在地: ' in d[0]) and ('電話番号: ' in d[1] or 'お問い合わせ先: ' in d[1]):
                    dic3['location'] = d[0].replace('所在地: ', '').replace(' ', '')
                    dic3['phone'] = del_bracket(d[1]).replace('電話番号: ', '').replace('お問い合わせ先: ', '').replace(' ', '')
                else:
                    dic3['location'] = 'error'
                    dic3['phone'] = 'error'
                two.append(dic3)
            one['data'] = two
            ret.append(one)
    s = json.dumps(ret)
    with open('newjson.txt', 'w') as f:
        f.write(s)


# ①先打开这个获取事务所信息
# get_office()


# ②再打开这个获取json字符串
# x = json_data()
# with open('json.txt', 'w') as f:
#     f.write(x)
# print(x)


# ③修改json格式
# modifiy_jsontxt()

