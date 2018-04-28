#!/usr/bin/env python3
# -*- coding: utf-8 -*-

__author__ = '付国良'

import json

def shiwusuo(title, location, phone, href):
    return '''<tr style="border:thin"><td style="border:2px solid #8ca9d7;">{}<br>{}<br>電話番号:{}<br><a href="{}"><span 
    style="float:right;color:white;border:2px solid #af632b;background-color:#f68b3e;font-weight:bold">&nbsp;ルート案内&nbsp;</span><br>
            </a></td></tr>'''.format(title, location, phone, href)


def title_format(t):
    if len(t) == 2:
        return '&nbsp;&nbsp;{}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{}&nbsp;'.format(t[0], t[1])
    elif len(t) == 3:
        return '&nbsp;&nbsp;{}&nbsp;&nbsp;&nbsp;{}&nbsp;&nbsp;&nbsp;{}&nbsp;'.format(t[0], t[1], t[2])
    else:
        print('标题发生错误')

def xian_content(arr, idx, platform):
    content = []
    for x in arr:
        content.append(shiwusuo(x['title'], x['location'], x['phone'], x[platform]))
    b = '\n'.join(content)
    return '''<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" 
    style="border-collapse: separate;border-spacing: 1px;margin-top:5px;display:none" 
    bgcolor="#d7e2f0" id="xian{}">\n{}\n</table>'''.format(idx, b)


def xian(arr, idx, title, platform):
    x = xian_content(arr, idx, platform)
    return '''<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:5px;" bgcolor="#fcd5b5">
    <tr>
        <td height="41" align="middle" colspan="3">
            <span style="color:black;font-weight:bold">{}</span>
            <span style="color:black;font-weight:bold">
                <input type="image" src="images/arrow_down.png" height="24" onclick="toggle('xian{}')"/>
            </span>
        </td>
    </tr>
    {}
    </table>'''.format(title_format(title), idx, x)



def new(platform):
    '''
    事先准备好nenkin.json文件，生成html代码，只是<table>
    :param platform: iOS, Android
    :return: 写入到文件mm12.html
    '''
    with open('nenkin.json', 'r') as f:
        a = json.loads(f.read())
        for idx, val in enumerate(a, 1):
            # print(val)
            name = val['name']
            data = val['data']
            content = xian(data, idx, name, 'apple' if (platform == 'iOS') else 'google')
            with open('mm12.html', 'a') as f:
                f.write(content)


new('iOS')

