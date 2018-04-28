#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
终端指令
'''
__author__ = '付国良'

import os

class Command:

    @classmethod
    def clear(cls):
        os.system('clear')

    @classmethod
    def history(cls):
        os.system('clear')

    @classmethod
    def mkdir(cls, path):
        try:
            os.mkdir(r'%s' % path)
            print('创建文件夹成功, 路径: %s' % path)
        except Exception as e:
            print('错误信息: %s' % e)

    @classmethod
    def rmdir(cls, path):
        try:
            os.rmdir(path)
            print('删除文件夹成功, 路径: %s' % path)
        except Exception as e:
            print('错误信息: %s' % e)

    @classmethod
    def pwd(cls):
        os.system('pwd')




