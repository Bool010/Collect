#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
WebServer2
简单的WSGI(web server getway interface)服务器实现
'''
__author__ = '付国良'

import socket
import sys


class WSGIServer:
    address_family = socket.AF_INET
    sock_type = socket.SOCK_STREAM
    request_queue_size = 1

    def __init__(self, server_address):
        # Create listening socket
        self.listen_socket = listen_socket = socket.socket(
            self.address_family,
            self.sock_type
        )

        # Allow to reuse the same address
        listen_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

        # Bind
        listen_socket.bind(server_address)

        # Activate
        listen_socket.listen(self.request_queue_size)

        # Get server host name and port
        host, port = self.listen_socket.getsockname()[:2]
        self.server_name = socket.getfqdn(host)
        self.server_port = port

        # Return headers set by Web framework/ Web application
        self.headers_set = []



    def set_app(self, application):
        self.application = application



    def server_forever(self):
        list_socket = self.listen_socket
        while True:
            # New client connection
            self.client_connection, client_address = list_socket.accept()

            # Handle one request and close the client connection. Then
            # loop over to wait for another client connection
            self.hand_one_request()

            # Construct environment dictionary using request data
            env = self.get_environ()



    def handle_one_request(self):
        self.request_data = request_data = self.client_connection.recv(1024)

        # Print formatted request data a la 'curl -v'
        print(''.join(
            '< {line}\n'.format(line=line)
            for line in request_data.splitlines()
        ))
        self.parse_request(request_data)



    def parse_request(self, text):
        request_line = text.splitlines()[0]
        request_line = request_line.rstrip('\r\n')

        # Break down the request line into components
        (self.request_method,
         self.path,
         self.request_version
         ) = request_line.split()

