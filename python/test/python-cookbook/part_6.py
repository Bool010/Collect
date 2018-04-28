#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
cookbook 第6章 [数据编码与处理]

"""

# 本章主要关注的重点是利用Python来处理各种常见编码形式所呈现出的数据，比如CSV文件、JSON、XML以及二进制形式的打包记录。与数据结构那章不同，本章不会
# 把重点放在特定的算法之上，而是着重处理数据在程序中的输入和输出问题上。


''' 6.1: 读写CSV数据 '''
def node6_1():
    def question():
        '''
        问题: 我们想要读写CSV文件中的数据。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # 对于大部分类型的CSV数据，我们都可以用csv库来处理。比如，比如假设在名为stocks.csv的文件中包含有如下的股票市场数据:
        # Symbol,Price,Date,Time,Change,Volume
        # "AA",39.48,"6/11/2007","9:36am",-0.18,181800
        # "AIG",71.32,"6/11/2007","9:36am",-0.15,195500
        # "AXP",62.58,"6/11/2007","9:36am",-0.46,935000
        # "BA",98.31,"6/11/2007","9:36am",+0.12,104800
        # "C",53.08,"6/11/2007","9:36am",-0.25,360900
        # "CAT",78.29,"6/11/2007","9:36am",-0.23,225400

        # 下面的代码示例会告诉我们如何将这些数据读取为元组序列:
        import csv
        with open('stocks.csv') as f:
            f_csv = csv.reader(f)
            headers = next(f_csv)
            for row in f_csv:
                # Process row
                pass

        # 在上面的代码中，row将会是一个元组。因此，要访问特定的字段就需要用到索引，比如row[0]（表示Symbol）和row[4]（表示Change）。
        # 由于这样的索引常常容易混淆，因此这里可以考虑使用命名元组。示例如下:
        from collections import namedtuple
        with open('stocks.csv') as f:
            f_csv = csv.reader(f)
            headings = next(f_csv)
            Row = namedtuple('Row', headings)
            for r in f_csv:
                row = Row(*r)
                # Process row

        # 这样就可以使用每一列的标头比如row.Symbol和row.Change来取代之前的索引了。应该要指出的是，这个方法只有在每一列的标头都是合法的Python
        # 标识符才起作用，如果不是的话就必须调整原始的标头（比如把非标识符用下划线或其它类似的符号取代）。

        # 另一种可行的方式是将数据读取为字典序列。可以用下面的代码实现:
        import csv
        with open('stocks.csv') as f:
            f_csv = csv.DictReader(f)
            for row in f_csv:
                # print(row)
                # Process row
                pass

        # 在这个版本中，可以通过标头来访问每行中的元素。比如，比如row['Symbol']或者row['Change']。

        # 要写入CSV数据，也可以使用csv模块来完成，但是要创建一个写入对象。示例如下:
        headers = ['Symbol', 'Price', 'Date', 'Time', 'Change', 'Volume']
        rows = [("AA",39.48,"6/11/2007","9:36am",-0.18,181800),
                ("AIG",71.32,"6/11/2007","9:36am",-0.15,195500),
                ("AXP",62.58,"6/11/2007","9:36am",-0.46,935000),
                ("BA",98.31,"6/11/2007","9:36am",+0.12,104800)]
        with open('stocks.csv', 'w') as f:
            f_csv = csv.writer(f)
            f_csv.writerow(headers)
            f_csv.writerows(rows)


        # 如果数据是字典序列，那么可以这样处理:
        headers = ['Symbol', 'Price', 'Date', 'Time', 'Change', 'Volume']
        rows = [{'Symbol':"AA", 'Price':39.48, 'Date':"6/11/2007",
                 'Time':"9:36am", 'Change':-0.18, 'Volume': 181800},
                {'Symbol':"AIG", 'Price':71.32, 'Date':"6/11/2007",
                 'Time':"9:36am", 'Change':-0.15, 'Volume':195500},
                {'Symbol':"AXP", 'Price':62.58, 'Date':"6/11/2007",
                 'Time':"9:36am", 'Change':-0.46, 'Volume':935000},
                {'Symbol':"BA", 'Price':98.31, 'Date':"6/11/2007",
                 'Time':"9:36am", 'Change':0.12, 'Volume':104800}]
        with open('stocks.csv', 'w') as f:
            f_csv = csv.DictWriter(f, headers)
            f_csv.writeheader()
            f_csv.writerows(rows)
        pass
    
    
    def discuss():
        '''
        讨论
        '''
        import csv
        # 应该总是选择使用csv模块来处理，而不是自己手动分解和解析CSV数据。比如，我们可能会倾向于写出这样的代码:
        with open('stocks.csv') as f:
            for line in f:
                row = line.split(',')
                # process row

        # 这种方式的问题在于任然需要自己处理一些令人厌烦的细节问题。比如说，如果有任何字段是被引号括起来的，那么就要自己去除引号。此外，如果被引用的
        # 字段中恰好包含有一个逗号，那么产生出的那一行会因为大小错误而使得代码崩溃（因为原始数据也是用逗号分隔的）。

        # 默认情况下，csv库被实现为能够识别微软Excel所采用的CSV编码规则。这也许是最为常见的CSV编码规则了，能够带来最佳的兼容性。但是，如果查阅
        # csv文档就会发现有几种方法可以将编码微调为其他的格式（例如，修改分隔字符等）。比方说，如果想读取以tab键分隔的数据，可以使用下面的代码:
        # Example of reading tab-separated values
        with open('stock.tsv') as f:
            f_tsv = csv.reader(f, delimiter='\t')
            for row in f_tsv:
                # Process row
                pass

        # 如果正在读取CSV数据并将其转换为命名元组，那么在验证列标题时要小心，比如某个csv文件中可能在标题行中包含有非法的标识字符，就像下面的示例这
        # 样:
        # Street Address,Num-Premises,Latitude,Longitude
        # 5412 N CLARK,10,41.980262,-87.668452

        # 这会使得创建命名元组的代码出现VauleError异常。要解决这个问题，应该首先整理标题。例如，可以对非法的标识符字符进行正则替换，示例如下:
        import re
        from collections import namedtuple
        with open('stock.csv') as f:
            f_csv = csv.reader(f)
            headers = [re.sub('[^a-zA-Z_]', '_', h) for h in next(f_csv)]
            Row = namedtuple('Row', headers)
            for r in f_csv:
                row = Row(*r)
                # Process row
                # ...

        # 此外还需要强调的是，csv模块不会尝试去解释数据或者将数据转换为除去字符串之外的类型。如果这样的转换很重要，那么这就是我们需要自行处理的问题。
        # 下面这个例子演示了对CSV数据进行额外的类型转换:
        col_types = [str, float, str, str, float, int]
        with open('stocks.csv') as f:
            f_csv = csv.reader(f)
            headers = next(f_csv)
            for row in f_csv:
                # Apply conversions to the row items
                row = tuple(convert(value) for convert, value in zip(col_types, row))

        # 作为另外一种选择，下面这个例子演示了将选中的字段转换为字典:
        print('Reading as dicts with type conversion')
        field_types = [('Price', float),
                       ('Change', float),
                       ('Volume', int)]
        with open('stocks.csv') as f:
            for row in csv.DictReader(f):
                row.update((key, conversion(row[key]))
                           for key, conversion in field_types)
            print(row)

        # 一般来说，对于这样的而转换都应该小心为上。在现实世界中，CSV文件可能会缺少某些值，或者数据损坏了，以及出现其他一些可能会使类型转换操作失败
        # 的情况，这都是很常见的。因此，除非可以保证数据不会出错，否则就需要考虑这些情况（也许需要加上适当的异常处理代码）。

        # 最后，如果我们得目标是通过读取CSV数据来进行数据分析和统计，那么应该看看Pandas包（http://pandas.pydata.org）。Pandas中有一个方便的
        # 函数pandas.read_csv()，能够将CSV数据加载到DataFrame对象中。之后，就可以生成各种各样的统计摘要了，还可以对数据进行筛选并执行其他类型
        # 的高级操作。6.13节中给出了这样的一个例子。
        pass
    pass



''' 6.2: 读写JOSN数据 '''
def node6_2():
    def question():
        '''
        问题: 我们想读写JSON（JavaScript Object Notation）格式编码数据。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # json模块中提供了一种简单的方法来编码和解码JSON格式数据。这两个主要得函数就是json.dumps()以及json.loads()。这两个函数在命名上借鉴了
        # 其他序列化处理库的接口，比如pickle。下面的示例展示了如何将Python数据结构转换为JSON:
        import json
        data = {
            'name': 'ACME',
            'shares': 100,
            'price': 542.23
        }
        json_str = json.dumps(data)
        print(json_str)
        # 输出: {"name": "ACME", "shares": 100, "price": 542.23}

        # 而接下来的示例告诉我们如何把JSON编码的字符串再转换回Python数据结构:
        data = json.loads(json_str)

        # 如果要同文件而不是字符串打交道的话，就可以使用json.dump()以及json.load()来编码和解码json数据。示例如下:
        # Writing JSON data
        with open('data.json', 'w') as f:
            json.dump(data, f)

        # Reading 
        with open('data.json', 'r') as f:
            data = json.load(f)
        pass
    
    def discuss():
        '''
        讨论
        '''
        import json
        # JSON编码支持的基本类型有None, bool, int, float, 和str，当然还有包含了这些基本类型的列表、元组以及字典，JSON会假设键（key）是字符
        # 串（字典中的任何非字符串键在编码时都会转换为字符串）。要符合JSON规范，应该只对Python列表和字典进行编码。此外，在Web应用中，把最顶层对象
        # 定义为字典是一种标准做法。

        # JSON的编码格式几乎与Python语法一致。只有几个小地方稍有不同。比如True会被映射为true，False会被映射为false，而None会被映射为null。
        # 下面的示例展示了编码看起来是怎样的:
        print(json.dumps(False))
        # 输出: false

        d = {
            'a': True,
            'b': 'Hello',
            'c': None
        }
        print(json.dumps(d))
        # 输出: {"a": true, "b": "Hello", "c": null}

        # 如果要检查从JSON中解码得到的数据，那么仅仅将其打印出来就想确定数据的结构通常是比较困难的--尤其是如果数据中包含了深层次的嵌套结果或者有许
        # 多字段时，为了帮助解决这个问题，考虑使用pprint模块中的pprint()函数。那么做会把键按照字母顺序排列，并将字典以更加合理的方式输出。下面的
        # 示例展示了应该如何对Twitter上的索索结果以漂亮的格式进行输出:
        # from urllib.request import urlopen
        # import json
        # u = urlopen('http://search.twitter.com/search.json?q=python&rpp=5')
        # resp = json.loads(u.read().decode('utf-8'))
        # from pprint import pprint
        # pprint(resp)

        # 一般来说，JSON解码时会从所提供的数据中创建出字典或者列表。如果想创建其他类型的对象，可以为json.loads()方法提供object_pairs_hook或
        # 者object_hook参数。例如，下面的示例展示了我们应该如何将JSON数据解码为OrderedDict（有序字典），这样可以保持数据的顺序不变:
        s = '{"name": "ACME", "shares": 100, "price": 542.23}'
        from collections import OrderedDict
        data = json.loads(s, object_pairs_hook=OrderedDict)
        print(data)

        # 输出: OrderedDict([('name', 'ACME'), ('shares', 100), ('price', 542.23)])

        # 而下面的代码将JSON字典转变为Python对象
        class JSONObject:
            def __init__(self, d):
                self.__dict__ = d

        data = json.loads(s, object_hook=JSONObject)
        print(data.name)
        # 输出: ACME

        print(data.shares)
        # 输出: 100

        print(data.price)
        # 输出: 542.23

        # 在上一个实例中，通过解码JSON数据而创建的字典作为单独的参数传递给了__init__()。之后就可以自由的根据需要来使用它了，比如直接将它当做对象
        # 的字典实例来用。

        # 有几个选项对于编码JSON来说是很有用的。如果想让输出格式变得漂亮一些，可以再json.dumps()函数中使用indent参数，这样能够使得数据能够像
        # pprint()函数那样以漂亮的格式打印出来。示例如下:
        data = json.loads(s, object_pairs_hook=OrderedDict)
        print(json.dumps(data))
        # 输出: {"name": "ACME", "shares": 100, "price": 542.23}

        print(json.dumps(data, indent=4))
        # 输出:
        # {
        #     "name": "ACME",
        #     "shares": 100,
        #     "price": 542.23
        # }

        # 如果想在输出中对键进行排序处理，可以使用sort_keys参数:
        print(json.dumps(data, sort_keys=True))
        # 输出: {"name": "ACME", "price": 542.23, "shares": 100}

        # 类实例一般是无法序列化为JSON的。比如说:
        class Point:
            def __init__(self, x, y):
                self.x = x
                self.y = y

        p = Point(2, 3)
        # print(json.dumps(p))
        # 输出: 
        # Traceback (most recent call last):
        # File "part_6.py", line 299, in <module>
        #   node6_2()
        # File "part_6.py", line 296, in node6_2
        #   discuss()
        # File "part_6.py", line 292, in discuss
        #   print(json.dumps(p))
        # File "/usr/local/Cellar/python3/3.6.2/Frameworks/Python.framework/Versions/3.6/lib/python3.6/json/__init__.py", line 231, in dumps
        #   return _default_encoder.encode(obj)
        # File "/usr/local/Cellar/python3/3.6.2/Frameworks/Python.framework/Versions/3.6/lib/python3.6/json/encoder.py", line 199, in encode
        #   chunks = self.iterencode(o, _one_shot=True)
        # File "/usr/local/Cellar/python3/3.6.2/Frameworks/Python.framework/Versions/3.6/lib/python3.6/json/encoder.py", line 257, in iterencode
        #   return _iterencode(o, 0)
        # File "/usr/local/Cellar/python3/3.6.2/Frameworks/Python.framework/Versions/3.6/lib/python3.6/json/encoder.py", line 180, in default
        #   o.__class__.__name__)
        # TypeError: Object of type 'Point' is not JSON serializable
        
        # 如果想序列化类实例，可以提供一个函数将类实例作为输入并返回一个可以被序列化处理的字典。示例如下:
        def serialize_instance(obj):
            d = {'__classname__': type(obj).__name__}
            d.update(vars(obj))
            return d
        
        # 如果想取回一个实例，可以编写这样的代码来处理:
        # Dictionary mapping names to known classes
        classes = {
            'Point': Point
        }
        
        def unserialize_object(d):
            clsname = d.pop('__classname__', None)
            if clsname:
                cls = classes[clsname]
                obj = cls.__new__(cls) # Make instance without calling __init__
                for key, value in d.items():
                    setattr(obj, key, value)
                    return obj
            else:
                return d

        # 最后给出如何使用这些函数的示例:
        p = Point(2, 3)
        s = json.dumps(p, default=serialize_instance)
        print(s)
        # 输出: {"__classname__": "Point", "x": 2, "y": 3}

        a = json.loads(s, object_hook=unserialize_object)
        print(a)
        # 输出: <__main__.node6_2.<locals>.discuss.<locals>.Point object at 0x1035d0128>

        print(a.x)
        # 输出: 2

        print(a.y)
        # 输出: 3

        # json模块中还有很多其它选项，这些选项可以用来控制对数字、特殊值（比如NaN）等底层解释行为。请参阅文档（http://docs.python.org/3/lib
        # rary/json.html）以获得进一步的细节。
        pass
    pass


''' 6.3: 解释简单的XML文档 '''
def node6_3():
    def question():
        '''
        问题: 我们想从一个简单的XML文档中提取出数据。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # xml.etree.ElementTree模块可以用来从简单的XML文档中提取数据。为了说明，假设想对Planet Python（http://planet.python.org）上的
        # RSS订阅做解析并生成一个总结报告。下面的脚本可以完成这个任务:
        from urllib.request import urlopen
        from xml.etree.ElementTree import parse
        # Download the RSS feed and parse it
        u = urlopen('http://planet.python.org/rss20.xml')
        doc = parse(u)

        # Extract and output tags of interset
        for item in doc.iterfind('channel/item'):
            title = item.findtext('title')
            date = item.findtext('pubDate')
            link = item.findtext('link')
            print(title)
            print(date)
            print(link)
            print()
        # 如果运行上面的脚本会得到类似这样的输出:
        # Python Data: Text Analytics with Python – A book review
        # Tue, 26 Sep 2017 20:52:36 +0000
        # http://pythondata.com/text-analytics-with-python-book-review/

        # Weekly Python Chat: Linting Code
        # Tue, 26 Sep 2017 20:30:00 +0000
        # http://ccst.io/e/linting

        # Stack Abuse: Reading and Writing CSV Files in Python
        # Tue, 26 Sep 2017 19:00:20 +0000
        # http://stackabuse.com/reading-and-writing-csv-files-in-python/

        # Continuum Analytics Blog: Anaconda and Microsoft Partner to Deliver Python-Powered Machine Learning
        # Tue, 26 Sep 2017 13:00:29 +0000
        # https://www.anaconda.com/blog/news/anaconda-and-microsoft-partner-to-deliver-python-powered-machine-learning/

        # 显然，如果想做更多的处理，就需要将print()函数替换为其它更加有趣的处理函数。
        pass


    def discuss():
        '''
        讨论
        '''
        # 在许多应用中，同XML编码数据打交道时很常见的事情。这不仅是因为XML作为一种数据交换格式在互联网中使用广泛，而且XML还是用来保存应用程序数据
        # （例如文字处理、音乐库等）的常用格式。本节后面的讨论假设读者已经熟悉XML的基本概念。

        # 在许多情况下，XML如果只是简单的用来保存数据，那么文档结构就是紧凑而直接的。例如上面示例中RSS订阅源看起来类似于如下的XML文档:

        # xml.etree.ElementTree.parse()函数将整个XML文档解析为一个文档对象，之后就可以利用find()、iterfind()以及findtext()方法查询特定
        # 的XML元素。这些函数的参数就是特定的标签名称，比如channel/item或者title。

        # 当指定标签时，需要整体考虑文档的结构。每一个查找操作都是相对于一个起始元素来展开的。同样的，提供给每一个操作的标签名也是相对于起始元素的。
        # 在示例代码中，对doc.iterfind('channel/item')的调用会查找所有在channel元素之下的item元素，doc代表这文档的顶层（顶层'rss'元素）。
        # 之后对item.findtext()的调用就相对于已找到的'item'元素来展开。

        # 每个由ElementTree模块所代表的元素都有一些重要的属性和方法，他们对解析操作十分有用，tag属性包含了标签名称，text属性中包含有附着的文本，
        # 而get()方法可以用来提取出属性（如果有的话）。

        # 应该要指出的是xml.tree.ElementTree并不是解析XML的唯一选择。对于更加高级的应用，应该考虑使用lxml。lxml采用的编程接口和ElementTree
        # 一样，因此本节中展示的实例能够以同样的方式用lxml实现。只需要将一个导入语句修改为from lxml.etree import parse即可。lxml完全兼容于
        # XML标准，这为我们提供了极大的好处。此外，lxml运行起来非常快速，还提供验证、XSLT以及XPath这样的功能支持。
        pass

    pass



''' 6.4: 以增量方式解析大型XML文件 '''
def node6_4():
    def question():
        '''
        问题: 我们需要从一个大型的XML文档中提取出数据，而且对内存的使用要尽可能少。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # 任何时候，当要面对以增量方式处理数据的问题时，都应该考虑使用迭代器和生成器。下面是一个简单的函数，可用来以增量的方式处理大型的XML文件，它
        # 只用到了很少量的内存。
        from xml.etree.ElementTree import iterparse

        def parse_and_remove(filename, path):
            path_parts = path.split('/')
            doc = iterparse(filename, ('start', 'end'))
            # Skip the root element
            next(doc)

            tag_stack = []
            elem_stack = []
            for event, elem in doc:
                if event == 'start':
                    tag_stack.append(elem.tag)
                    elem_stack(elem)
                elif event == 'end':
                    if tag_stack == path_parts:
                        yield elem
                        elem_stack[-2].remove(elem)
                    try:
                        tag_stack.pop()
                        elem_stack.pop()
                    except IndexError:
                        pass

        # 要测试这个函数，只需要找一个大型的XML文件来配合测试即可。这种大型的XML文件常常可以再政府以及数据公开的网站上找到。比如，可以下载芝加哥的
        # 坑洞数据库XML。在写作本书时，这个下载文件中有超过100000行的数据，他们按照如下的方式编码:

        # ......

        # 假设我们想编写一个脚本来根据坑洞的数量对邮政编码（ZIP code）进行排序。可以编写如下的代码来实现:
        from xml.etree.ElementTree import parse
        from collections import Counter

        potholes_by_zip = Counter()
        doc = parse('pothotes.xml')

        for pothole in doc.iterfind('row/row'):
            potholes_by_zip[pothole.findtext('zip')] += 1

        for zipcode, num in potholes_by_zip.most_common():
            print(zipcode, num)

        # 这个脚本存在的唯一问题就是它将整个XML文件都读取到内存中后再做分析。在我们的机器上，运行这个脚本需要占据450MB内存，但是如果使用下面这份代
        # 码，程序只做了微笑的修改:
        from collections import Counter
        potholes_by_zip = Counter()

        data = parse_and_remove('potholes.xml', 'row/row')
        for pothole in doc.iterfind('row/row'):
            potholes_by_zip[pothole.findtext('zip')] += 1

        for zipcode, num in potholes_by_zip.most_common():
            print(zipcode, num)

        # 这个版本的代码运行起来只用了7MB内存--多么惊人的提升啊！
        pass
    
    
    def discuss():
        '''
        讨论
        '''
        # 本节中的示例依赖于ElementTree模块中的两个核心功能。首先，iterparse()方法允许我们对XML文档做增量式的处理。要使用它，只需要提供文件名
        # 以及一个事件列表即可。事件列表由1个或多个start/end，start-ns/end-ns组成。iterparse()创建出的迭代器产生出形式为（event, elem）
        # 的元组，这里的event是列出事件，而elem是对应的XML元素。

        # ......

        # 当某个元素首次被创建但是还没有填入任何其他数据时（比如子元素），会产生start事件，而end事件会在元素已经完成时产生。尽管没有在本节的示例中
        # 出现，start-ns和end-ns事件是用来处理XML命名空间声明的。

        # 在这个示例中，start和end事件是用来管理元素和标签查找的。这里的栈代表这文档结构中解析的当前层次（current hierarchial），同时也用来判
        # 断元素是否匹配传递给parse_end_remove()函数请求路径。如果有匹配满足，就通过yield将其发送给调用者，紧跟在yield之后的语句就是使得
        # ElementTree能够高效利用内存的关键所在:
        # elem_stack[-2].remove(elem)

        # 这一行代码使得之前通过yield产生出的元素从父节点中移除。因此可以假设其再也没有任何其它的引用存在，因此该元素被销毁进而可以回收它所占用的内
        # 存.

        # 这种迭代式的解析以及对节点的移除使得对整个文档的增量式扫描变得非常高效。在任何时刻都能构造出一颗完整的文档树。然而我们仍然可以编写代码以直
        # 接的方式来处理XML数据。

        # 这种技术的主要缺点就是运行时的性能。当进行测试时，将整个文档读进内存的版本运行起来大约比增量式处理的版本快2倍。但是在内存的使用上，先读入
        # 内存的版本占用的内存是增量式处理的60倍多。因此，如果内存使用量是更加需要关注的因素，那么显然增量是处理的版本才是大赢家。
        pass
    
    pass



''' 6.5: 将字典转换为XML '''
def node6_5():
    def question():
        '''
        问题: 我们想将Python中的字典转换为XML。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 尽管xml.etree.ElementTree库通常用来解析XML文档，但它同样也可用用来创建XML文档。例如，考虑下面这个函数:
        from xml.etree.ElementTree import Element
        def dic_to_xml(tag, d):
            '''
            Turn a simple dict of key/value pairs into XML
            :param tag:
            :param d:
            :return:
            '''
            elem = Element(tag)
            for key, val in d.items():
                child = Element(key)
                child.text = str(val)
                elem.append(child)
            return elem

        # 下面是使用这个函数的示例:
        s = {
            'name': 'GOOG',
            'shares': 100,
            'price': 490.1
        }
        e = dic_to_xml('stock', s)
        print(e)
        # 输出: <Element 'stock' at 0x109120a48>

        # 转换的结果是一个Element实例。对于I/O操作来说，可以利用xml.etree.ElementTree中的tostring()函数将其转换为字符串。示例如下:
        from xml.etree.ElementTree import tostring
        print(tostring(e))
        # 输出:
        # b'<stock><name>GOOG</name><shares>100</shares><price>490.1</price></stock>'

        # 如果想为元素附加上属性，可以使用set()方法实现:
        e.set('_id', '1234')
        print(tostring(e))
        # 输出:
        # b'<stock _id="1234"><name>GOOG</name><shares>100</shares><price>490.1</price></stock>'

        # 如果需要考虑元素间的顺序，可以使用OrderedDict（有序字典）来取代普通字典。参见1.7节中对有序字典的介绍。
        pass


    def discuss():
        '''
        讨论
        '''
        from xml.etree.ElementTree import Element
        from xml.etree.ElementTree import tostring

        def dic_to_xml(tag, d):
            '''
            Turn a simple dict of key/value pairs into XML
            :param tag:
            :param d:
            :return:
            '''
            elem = Element(tag)
            for key, val in d.items():
                child = Element(key)
                child.text = str(val)
                elem.append(child)
            return elem

        # 当创建XML时，也会会倾向于只是用字符串来完成。比如:
        def dict_to_xml_str(tag, d):
            '''
            Turn a simple dict of key/vaule pairs into XML
            :param tag:
            :param d:
            :return:
            '''
            parts = ['<{}>'.format(tag)]
            for key, val in d.items():
                parts.append('<{0}>{1}</{0}>'.format(key, val))
            parts.append('</{}>'.format(tag))
            return ''.join(parts)

        # 问题在于如果尝试收工处理的话，那么这就是在自找麻烦。比如，字典中如果包含有特殊字符时会发生什么？
        d = {'name': '<spam>'}
        # String creation
        print(dict_to_xml_str('item', d))
        # 输出: <item><name><spam></name></item>

        # Proper XML creation
        e = dic_to_xml('item', d)
        print(tostring(e))
        # 输出: b'<item><name>&lt;spam&gt;</name></item>'

        # 请注意在上面这个示例中，字符<和>分别被&lt;和&gt;取代了。
        # 下面的提示仅供参考。如果需要手动对这些字符串做转义处理，可以使用xml.sax.saxutils中的escape()和unescape()函数。示例如下:
        from xml.sax.saxutils import escape, unescape
        print(escape('<spam>'))
        # 输出: &lt;spam&gt;
        print(unescape('&lt;spam&gt;'))
        # 输出: <spam>

        # 为什么说创建Element实例要比使用字符串更好？除了可以产生正确的输出外，其他的原因在于这样可以更加方便地将Element实例组合在一起，创建出更
        # 大的XML文档。得到的Element实例也能够以各种方式进行处理，完全不必担心解析XML文本方面的问题。最重要的是，我们能够站在更高层面上对数据进行
        # 各种处理，只在最后把结果作为字符串输出即可。
        pass
    pass



''' 6.6: 解析、修改和重写XML '''
def node6_6():
    def question():
        '''
        问题: 我们想读取一个XML文档，对它做一些修改后再以XML的方式写回。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # xml.etree.ElementTree模块可以轻松的完成这样的任务。从本质上来说，开始时可以按照通常的方式来解析文档。例如，假设有一个名为pred.xml的
        # 文档，它看起来是这样的:
        # <?xml version="1.0"?>
        # <stop>
        #     <id>14791</id>
        #     <nm>Clark &amp; Balmoral</nm>
        #     <sri>
        #         <rt>22</rt>
        #         <d>North Bound</d>
        #         <dd>North Bound</dd>
        #     </sri>
        #     <cr>22</cr>
        #     <pre>
        #         <pt>5 MIN</pt>
        #         <fd>Howard</fd>
        #         <v>1378</v>
        #         <rn>22</rn>
        #     </pre>
        #     <pre>
        #         <pt>15 MIN</pt>
        #         <fd>Howard</fd>
        #         <v>1867</v>
        #         <rn>22</rn>
        #     </pre>
        # </stop>

        # 下面的示例采用ElementTree来读取这个文档，并对文档的结构做出修改:
        from xml.etree.ElementTree import parse, Element
        doc = parse('pred.xml')
        root = doc.getroot()
        print(root)
        # 输出: <Element 'stop' at 0x1038c3908>

        # Remove a few elements
        root.remove(root.find('sri'))
        root.remove(root.find('cr'))

        # Insert a new element after <nm>...</nm>
        print(root.getchildren().index(root.find('nm')))
        # 输出: 1
        
        e = Element('spam')
        e.text = 'This is a test'
        root.insert(2, e)
        
        # Write back to a file
        doc.write('newpred.xml', xml_declaration=True)
        
        # 这些操作的结果产生了一个新的XML文档，看起来是这样的:
        # <?xml version='1.0' encoding='us-ascii'?>
        # <stop>
        #     <id>14791</id>
        #     <nm>Clark &amp; Balmoral</nm>
        #     <spam>This is a test</spam><pre>
        #         <pt>5 MIN</pt>
        #         <fd>Howard</fd>
        #         <v>1378</v>
        #         <rn>22</rn>
        #     </pre>
        #     <pre>
        #         <pt>15 MIN</pt>
        #         <fd>Howard</fd>
        #         <v>1867</v>
        #         <rn>22</rn>
        #     </pre>
        # </stop>
        pass


    def discuss():
        '''
        讨论
        '''
        # 修改XML文档的结构是简单直接的，但是必须记住所有的修改主要是对父元素进行的，我们想把它当成一个列表一样对待。比如说，如果移除某个元素，那么
        # 就利用它的直接父节点的remove()方法完成。如果插入或添加新的元素，同样要使用父节点的insert()和append()方法来完成。这些元素也可以使用索
        # 引和切片操作来进行操控，比如element[i]或者element[i:j]。
        
        # 如果需要创建新的元素，可以使用Element类来完成，我们本节给出的示例中已经这么做了。这在6.5节中有更进一步的描述。
        pass
    pass



''' 6.7: 用命名空间来解析XML文档 '''
def node6_7():
    def question():
        '''
        问题: 我们要解析一个XML文档，但是需要使用XML命名空间来完成。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # 考虑使用了命名空间的如下XML文档:
        # <?xml version="1.0" encoding="utf-8"?>
        # <top>
        #     <author>David Beazley</author>
        #     <content>
        #         <html xmlns="http://www.w3.org/1999/xhtml">
        #             <head>
        #                 <title>Hello World</title>
        #             </head>
        #             <body>
        #                 <h1>Hello World!</h1>
        #             </body>
        #         </html>
        #     </content>
        # </top>

        # 如果解析这个文档并尝试执行普通的查询操作，就会发现没那么容易实现，因为所有的东西都变得特别的冗长啰嗦:
        from xml.etree.ElementTree import parse, Element
        # Some queries that work
        doc = parse('parse.xml')
        print(doc.findtext('author'))
        # 输出: David Beazley

        print(doc.find('content'))
        # 输出: <Element 'content' at 0x10cb09278>

        # A query involving a namespace (doesn't work)
        print(doc.find('content/html'))
        # 输出: None

        # Works if fully qualified
        print(doc.find('content/{http://www.w3.org/1999/xhtml}html'))
        # 输出: <Element '{http://www.w3.org/1999/xhtml}html' at 0x10a04bcc8>

        # Doesn't work
        print(doc.findtext('content/{http://www.w3.org/1999/xhtml}html/head/title'))
        # 输出: None

        # Fully qualified
        print(doc.findtext('content/{http://www.w3.org/1999/xhtml}html/{http://www.w3.org/1999/xhtml}head/{http://www.w3'
                           '.org/1999/xhtml}title'))
        # 输出: Hello World


        # 通常可以将命名空间的处理包装到一个通用的类中，这样可以省去一些麻烦:
        class XMLNamespace:
            def __init__(self, **kwargs):
                self.namespaces = {}
                for name, uri in kwargs.items():
                    self.register(name, uri)

            def register(self, name, uri):
                self.namespaces[name] = '{' + uri + '}'

            def __call__(self, path):
                return path.format_map(self.namespaces)

        # 要使用这个类，可以按照下面方式进行:
        ns = XMLNamespace(html='http://www.w3.org/1999/xhtml')
        print(doc.find(ns('content/{html}html')))
        # 输出: <Element '{http://www.w3.org/1999/xhtml}html' at 0x106de5db8>

        print(doc.findtext(ns('content/{html}html/{html}head/{html}title')))
        # 输出: Hello World
        pass


    def discuss():
        '''
        讨论
        '''
        # 对包含有命名空间的XML文档进行解析会非常频繁。XMLNamespace类的功能只是用来稍微简化一下这个过程，它允许在后续操作中使用缩短的命名空间名
        # 称，而不必去使用完全限定的URI。

        # 不幸的是，在基本的ElementTree解析器中不存在什么机制能获得有关命名空间的进一步信息。但是如果愿意使用iterparse()函数的话，还可以获得一
        # 些有关正在处理的命名空间范围的信息。示例如下:

        from xml.etree.ElementTree import iterparse
        for evt, elem in iterparse('parse.xml', ('end', 'start-ns', 'end-ns')):
            print(evt, elem)
        # 输出:
        # end <Element 'author' at 0x100e49598>
        # start-ns ('', 'http://www.w3.org/1999/xhtml')
        # end <Element '{http://www.w3.org/1999/xhtml}title' at 0x100e49728>
        # end <Element '{http://www.w3.org/1999/xhtml}head' at 0x100e496d8>
        # end <Element '{http://www.w3.org/1999/xhtml}h1' at 0x100e497c8>
        # end <Element '{http://www.w3.org/1999/xhtml}body' at 0x100e49778>
        # end <Element '{http://www.w3.org/1999/xhtml}html' at 0x100e49688>
        # end-ns None
        # end <Element 'content' at 0x100e495e8>
        # end <Element 'top' at 0x100e3b4a8>

        # 最后要提到的是，如果正在解析的文本用到了除命名空间之外的其他高级XML特性，那么最好还是使用lxml库。比方说，lxml对文档的DTD验证、更加完整
        # 的XPath支持和其他的高级XML特性提供了更好的支持。本节提到的技术知识为解析操作做了一点修改，使得这个过程能够稍微简单一些。
        pass
    
    pass



''' 6.8: 同关系型数据库进行交互 '''
def node6_8():
    def question():
        '''
        问题: 我们需要选择、插入或者删除关系型数据库中的行数据。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 在Python中，表达行数据的标准方式是采用元组序列。例如:
        stocks = [
            ('GOOG', 100, 409.1),
            ('APPL', 50, 545.75),
            ('FB', 150, 7.45),
            ('HPQ', 75, 33.2),
        ]
        # 当数据以这种形式呈现时，通过Python标准的数据库API（在PEP 249中描述）来同关系型数据库进行交互相对来说就显得很直接了。该API的要点就是数
        # 据库上的所有操作都通过SQL查询来实现。每一行输入或输出数据都由一个元组来表示。

        # 为了说明，我们可以使用Python自带的sqlite3模块。如果正在使用一个不同的数据库层的编程接口（MySQL）
        pass


    def discuss():
        '''
        讨论
        '''
        pass

    pass
