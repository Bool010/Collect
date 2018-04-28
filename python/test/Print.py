#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
格式化输出
'''
__author__ = '付国良'

from contextlib import contextmanager

# 临时函数
@contextmanager
def __wn_print_temp():
    print('\n-----------------------------------------------------------')
    yield
    print('-----------------------------------------------------------\n')

# 生成不同位数的空字符串
def __wn_empty_str(len):
    r = ''
    for i in range(len):
        r += ' '
    return r


# 打印数组
def __wn_print_array(content):
    i = 0
    print('[ Array ] count: %s' % len(content))
    for v in content:
        print('%s: %s' % (i, v))
        i += 1


# 打印字典
def __wn_print_dict(content):
    print('[ Dictionary ] count: %s' % len(content))
    m = 0
    for k in content.keys():
        if isinstance(k, int) or isinstance(k, float):
            k = str(k)
        m = max(m, len(k)) + 1
    for k, v in content.items():
        if isinstance(k, int) or isinstance(k, float):
            k = str(k)
        print('%s%s= %s' % (k, __wn_empty_str(m - len(k)), v))


# 打印元组
def __wn_print_tuple(content):
    print('[ Tuple ] count: %s' % len(content))
    i = 0
    for v in content:
        print('%s: %s' % (i, v))
        i += 1

# print
def wn_print_line(char='#'):
    a = []
    for x in range(80):
        a.append(char)
    print(''.join(a))

# print_header
def wn_print_header(char='#'):
    wn_print_line(char=char)

# print_footer
def wn_print_footer():
    print('' + '\n' + '\n')

# 格式化打印函数
def wn_print(content, *args):
    with __wn_print_temp():
        if isinstance(content, list):
            __wn_print_array(content)
        elif isinstance(content, dict):
            __wn_print_dict(content)
        elif isinstance(content, tuple):
            __wn_print_tuple(content)
        else:
            print(content, *args)

# prin


