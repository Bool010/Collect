import scrapy
import json
from tutorial.items import BookInfoItem
from scrapy.http import Request
import requests
from lxml import etree


class ShiShuSpider(scrapy.spiders.Spider):
    name = "ShiShu"
    allowed_domains = ["shicimingju.com"]
    start_urls = ["http://www.shicimingju.com/book/"]

    def parse(self, response):
        bookindexs = response.xpath("//*[@id='bookindex']/ul/li")
        for sel in bookindexs:
            href = sel.xpath('a/@href').extract()[0]
            url = 'http://www.shicimingju.com' + href
            yield scrapy.Request(url, callback=self.parse_book)


    def parse_book(self, response):
        '''
        目录结构
        :param response:
        :return:
        '''

        # 书名
        bookinfo = response.xpath("//*[@id='bookinfo']")
        bookName = bookinfo.xpath('h1/text()').extract()[0]
        bookName = bookName.replace('《', '').replace('》', '')

        bookinfo2 = response.xpath("//*[@id='bookinfo2']/p/text()").extract()
        # 简介
        intro = bookinfo2[:-2]

        # 作者
        author = bookinfo2[-2]

        # 朝代
        time = bookinfo2[-1]

        # 分类
        category = response.xpath("//*[@id='daohang']/a/text()").extract()
        del category[0]
        if "史书典籍分类标签" in category:
            del category[1]
        category.pop()

        # 目录
        mulu = response.xpath("//*[@id='mulu']/ul/li")
        for sel in mulu:
            hrefs = sel.xpath('a/@href').extract()
            if len(hrefs) > 0:
                href = hrefs[0]
                url = 'http://www.shicimingju.com' + href
                yield Request(url=url,
                              meta={'bookname': bookName},
                              callback=self.parse_content)

        ret = {
            "bookname": bookName,
            "intro": intro,
            "author": author,
            "time": time,
            "category": category,
            "data": []
        }
        with open(bookName + '.json', 'wt') as f:
            f.write(json.dumps(ret, ensure_ascii=False))



    def parse_content(self, response):
        '''
        章节内容
        :param response:
        :return:
        '''

        bookname = response.meta["bookname"]
        # 标题
        con = response.xpath("//*[@id='con']")
        title = con.xpath('h2/text()').extract()[0]

        # 内容
        con = response.xpath("//*[@id='con2']")
        texts = con.xpath('p/text()').extract()

        content = {
            "title": title,
            "data": texts
        }
        with open(bookname + '.json', 'a+') as f:
            d = json.loads(f)
            print('======================')
            print(d)
            d["data"].append(content)
            f.write(json.dumps(d, ensure_ascii=False))
