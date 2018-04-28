#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from wsgiref.simple_server import make_server, demo_app
from Test import application

# 创建一个服务器，IP地址为空，端口号是8000，处理函数是application()
app = demo_app
httpd = make_server('', 8786, app)

print('Serving HTTP on port 8786...')

# 开始监听HTTP请求
httpd.serve_forever()