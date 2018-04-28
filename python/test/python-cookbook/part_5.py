#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
cookbook 第5章 [文件和I/O]

5.1: 读写文本数据
5.2: 将输出重定向到文件中
5.3: 以不同的分隔符或行结尾符完成打印
5.4: 读写二进制数据
5.5: 对已不存在的文件执行写入操作
5.6: 在字符串上执行I/O操作
5.7: 读写压缩的数据文件
5.8: 对固定大小的记录进行迭代
5.9: 将二进制数据读取到可变缓冲区中
5.10: 对二进制文件做内存映射
5.11: 处理路径名
5.12: 检测文件是否存在
5.13: 获取目录内容的列表
5.14: 绕过文件名编码
5.15: 打印无法解码的文件名
5.16: 为已经打开的文件添加或修改编码方式
5.17: 将字节数据写入文本文件
5.18: 将已有的文件描述符包装为文件对象
5.19: 创建临时文件和目录
5.20: 同串口进行通信
5.21: 序列化Python对象

"""

# 任何程序都需要处理输入和输出。本章介绍了处理跟中不同类型文件时的惯用方法，包括文本和二进制文件处理、文件编码以及其他一些相关的内容。用来处理文件名
# 和目录相关的技术也有涵盖。


''' 5.1: 读写文本数据 '''
def node5_1():
    def question():
        '''
        问题: 我们需要对文本数据进行读写操作，但这个过程有可能针对不同的文本编码进行，比如ASSII、UTF-8或UTF-16编码。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 可以使用open()函数配合rt模式来读取文本文件的内容。示例如下:
        # Read the entire file as a single string
        # with open('somefile.txt', 'rt') as f:
        #     data = f.read()

        # Iterate over the lines of the file
        # with open('somefile.txt', 'rt') as f:
        #     for line in f:
        #         # Process line
        #         # ...

        # 同样的要对文本文件执行写入操作，可以使用open()函数的wt模式来完成。如果待操作的文件已存在，那么这会清除并覆盖原来的内容。示例如下:
        # Write chunks of text data
        # with open('somefile.txt', 'wt') as f:
        #     f.write('text1')
        #     f.write('text2')

        # Redirected print statement
        # with open('somefile.txt', 'wt') as f:
        #     print(line1, file=f)
        #     print(line2, file=f)

        # 如果要在已存在的文件的结尾处追加内容，可以使用open()函数的at模式。
        # 默认情况下，文件的读取和写入采用的都是系统默认的文本编码方式，这可通过sys.getdefaultencoding()来查询。在大多数机器上，这项设定都被设
        # 置为utf-8。如果我们知道正在读取或写入的文件采用的是另外一种编码方式，那么可以为open()函数提供一个可选的编码参数。示例如下:
        # with open('somefile.txt', 'rt', encoding='latin-1') as f:
        #     ...

        # Python可以识别出几百种可能的文本编码。但是，一些常见的编码方式不外乎是ascii、latin-1、utf-8以及utf-16。如果要同Web应用程序打交道，
        # 采用utf-8编码通常是比较保险的。ascii编码对应于范围U+0000到U+007F中的7比特字符。latin-1编码则是字节0~255对Unicode字符U+0000到
        # U+00FF的直接映射。关于latin-1编码，值得注意的一点是，当读取到未知编码的文本时是不会产生解码错误的。以lantin-1方式读取文件可能不会产
        # 生完全正确的解码文本，但是要从中提取出有用的数据仍然是足够了。此外，如果稍后将数据重新写入到文件中，那么原始的输入数据将得到保留。
        pass


    def discuss():
        '''
        讨论
        '''
        # 一般来说，读写文本文件都是非常简单直接的。但是，这里还有几个微妙的细节需要引起注意。首先，我们在示例中采用了with语句，这会为使用的文件创
        # 建一个上下文环境（context）。当程序的控制流程离开with语句块后，文件将自动关闭。我们并不一定要使用with语句，但是如果不用的话请确保要记
        # 得手动关闭文件:
        f = open('somefile', 'rt')
        data = f.read()
        f.close()

        # 另一个席位的问题是关于换行符的识别，在UNIX和Windows上它们是不同的（即，\n和\r\n之争）。默认情况下Python在"通用换行符"模式下。在该模
        # 式中所有常见的换行格式都能识别出来。在读取时会将换行符转换成一个单独的\n字符。同样地，在输出时换行符\n会被转换为当前系统默认的换行符。如
        # 果你不想要这样的翻译行为，可以给open()函数提供一个newline=''的参数，示例如下:
        # Read with disabled newline translation
        # with open('somefile.txt', 'rt', newline='') as f:
        #     ...

        # 为了说明其中的区别，我们会在下面的例子中看到，如果在UNIX机器上读取由Windows系统编码的包含有原始数据hello world!\r\n的文本是，会出现
        # 什么样的结果:
        # Newline translation enabled (the default)
        f = open('hello.txt', 'rt')
        f.read()
        # 输出: 'hello world!\n'

        # Newline translation disabled
        g = open('hello.txt', 'rt', newline='')
        g.read()
        # 输出: 'hello world!\r\n'

        # 最后一个问题是关于文本文件中可能出现的编码错误。当我们读取或写入文本文件时，可能会遇到编码或解码错误。例如:
        f = open('sample.txt', 'rt', encoding='ascii')
        f.read()
        # UnicodeDecodeError: 'ascii' code can't decode byte 0xc3 in position

        # 如果遇到这个错误，这通常表示没有以正确的编码方式来读取文件。应该仔细阅读要读取文件的相关规范，并检查自己的操作是否正确（例如不要用latin-
        # 1 编码方式读取，换成utf-8或者任何所需要的编码方式）。如果还是有可能出现编码错误。则可以为open()函数提供一个可选的errors参数来处理错误
        # 下面是几个常见的错误处理方案的例子:
        # Replace bad chars with Unicode U+ffdd replacement char
        f = open('sample.txt', 'rt', encoding='ascii', errors='replace')
        f.read()

        g = open('sample.txt', 'rt', encoding='ascii', errors='ignore')
        g.read()

        # 如果常常在摆弄open()函数的encoding和errors参数，并为此做了大量的技巧性操作（hacks）那就适得其反了，因为生活本不应该如此艰难。关于文
        # 本，第一条守则就是只需要确保总是采用正确的文本编码形式即可。当对此抱有疑问时，请使用默认的编码设定（通常是utf-8）。
        pass
    pass


''' 5.2: 将输出重定向到文件中 '''
def node5_2():
    def question():
        '''
        问题: 我们想将print()函数的输出重定向到一个文件中。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 对于这个问题，只需要想这样对print()函数加上file关键字参数即可:
        with open('somefile.txt', 'wt') as f:
            print('Hello World!', file=f)
        pass


    def discuss():
        '''
        讨论
        '''
        # 对于这个主题确实没多少东西可说。只是要确保文件是以文本模式打开的。如果文件是二进制模式打开的话，打印就会失败。
        pass

    pass



''' 5.3: 以不同的分隔符或行结尾符完成打印 '''
def node5_3():
    def question():
        '''
        问题: 我们想通过print()函数输出数据，但是同时也希望修改分隔符或者行结尾符。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # 可以在print()函数中使用sep和end关键字参数来根据需要修改输出。示例如下:
        print('ACME', 50, 91.5)
        # 输出: ACME 50 91.5

        print('ACME', 50, 91.5, sep=',')
        # 输出: ACME,50,91.5

        print('ACME', 50, 91.5, sep=',', end='!!\n')
        # 输出: ACME,50,91.5!!

        # 使用end参数也是在输出中禁止打印出换行符的方式。示例如下:
        for i in range(5):
            print(i)
        # 输出:
        # 0
        # 1
        # 2
        # 3
        # 4

        for i in range(5):
            print(i, end=' ')
        # 输出: 0 1 2 3 4
        pass
    
    def discuss():
        '''
        讨论
        '''
        # 除了空格之外，当还需要用其它字符分隔文本时，通常在print()函数中通过sep关键字参数指定一个不同的分隔符就是最简单的方法了。有时候我们会看
        # 到有的程序员会利用str.join()来实现同样的效果。例如:
        print(','.join(['ACME', '50', '91.5']))
        # 输出: ACME,50,91.5

        # str.join()的问题就在于它只能处理字符串。这意味着我们常常得做些转换才能让其正常工作。比如说:
        row = ['ACME', 50, 91.5]
        print(','.join(row))
        # 输出: TypeError: join() takes exactly one argument (3 given)

        print(','.join(str(x) for x in row))
        # 输出: ACME,50,91.5

        # 其实不必这么大费周折，只要print()函数就可以办到了:
        print(*row, sep=',')
        # 输出: ACME,50,91.5
        pass
    pass



''' 5.4: 读写二进制数据 '''
def node5_4():
    def question():
        '''
        问题: 我们需要读写二进制数据，比如图像、声音文件等。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 使用open()函数的rb或者wb模式就可以实现对二进制数据的读或写。示例如下:
        # Read the entire file as a single byte string
        with open('somefile.bin', 'rb') as f:
            data = f.read()

        # Write binary data to a file
        with open('somefile.bin', 'wb') as f:
            f.write(b'Hello World')

        # 当读取二进制数据时，很重要的一点是所有的数据将以字节串（byte string）的形式返回，而不是文本字符串。同样地，当写入二进制数据时，数据必须
        # 是以对象的形式来提供，而且该对象可以将数据以字节形式暴露出来（即，字节串、bytearray对象等）。
        pass


    def discuss():
        '''
        讨论
        '''
        # 当读取二进制数据时，由于字节串和文本字符串之间存在着微妙的语义差异，这可能会造成一些潜在的问题。特别要注意的是，在做索引和迭代操作时，字节
        # 串会返回代表该字节的整数值而不是字符串。示例如下:

        # Text string
        t = 'Hello World'
        print(t[0])
        # 输出: H

        for c in t:
            print(c)
        # 输出:
        # H
        # e
        # l
        # l
        # o
        #
        # W
        # o
        # r
        # l
        # d

        # Byte string
        b = b'Hello World'
        print(b[0])
        # 输出: 72

        for c in b:
            print(c)
        # 输出:
        # 72
        # 101
        # 108
        # 108
        # 111
        # 32
        # 87
        # 111
        # 114
        # 108
        # 100

        # 如果需要在二进制文件中读取或写入文本内容，请确保要进行编码或解码操作。示例如下:
        with open('somefile.bin', 'rb') as f:
            data = f.read(16)
            text = data.decode('utf-8')

        with open('somefile.bin', 'wb') as f:
            text = 'Hello World'
            f.write(text.encode('utf-8'))

        # 关于二进制I/O，一个鲜为人知的行为是，像数组和C结构体这样的对象可以直接用来进行写操作，而不必先将其转换为byte对象。示例如下:
        import array
        nums = array.array('i', [1, 2, 3, 4])
        with open('data.bin', 'wb') as f:
            f.write(nums)

        # 这种行为可适用于任何实现了所谓的"缓冲区接口（buffer interface）"的对象，该接口直接将对象底层的内存缓冲区暴露给可以在其上进行的操作。
        # 写入二进制数据就是这样一种操作。

        # 有许多对象还支持直接将二进制数据读入它们的底层内存中。只要使用文件对象的readinto()方法就可以了。示例如下:
        a = array.array('i', [0, 0, 0, 0, 0, 0, 0, 0])
        with open('data.bin', 'rb') as f:
            f.readinto(a)

        # 但是，使用这项技术的时候要特别小心，因为这常常是与平台特性相关的。而且可能依赖于字（word）的大小和字节序（即大端和小端）等属性。请参见
        # 5.9节中的另一个例子。在该例中我们将二进制数据读入到一个可变缓冲区（mutable buffer）中。
        pass

    pass



''' 5.5: 对已不存在的文件执行写入操作 '''
def node5_5():
    def question():
        '''
        问题: 我们想将数据写入到一个文件中，但只在该文件已不在文件系统中时才这么做。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 这个问题可以通过使用open()函数鲜为人知的x模式替代常见的w模式来解决。示例如下:
        with open('somefile.txt', 'wt') as f:
            f.write('Hello\n')

        with open('somefile.txt', 'xt') as f:
            f.write('World\n')
        # 输出: FileExistsError: [Errno 17] File exists: 'somefile.txt'

        # 如果文件是二进制模式的，那么用xb模式替代xt即可。
        pass

    def discuss():
        '''
        讨论
        '''
        # 本节中的实例以一种非常优雅的方式解决了一个常会在写文件时出现的问题（即，意外的覆盖了某个已存在的文件）。另一种解决方案是首先像这样检查文件
        # 是否已经存在:
        import os
        if not os.path.exists('somefile.txt'):
            with open('somefile', 'wt') as f:
                f.write('Hello\n')
        else:
            print('File already exists')
        pass
        # 输出: File already exists

        # 很明显，使用x模式更加简单直接。需要注意的是，x模式是Python3中对open()函数的扩展，在早期Python版本或者在Python的实现中用到的底层C函
        # 数库里都不存在这样的模式。
    pass



''' 5.6: 在字符串上执行I/O操作 '''
def node5_6():
    def question():
        '''
        问题: 我们想将一段文本或二进制字符串写入类似于文件的对象上。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        import io
        # 使用io.StringIO()和io.BytesIO()类来创建类似于文件的对象，这些对象可操作字符串数据。示例如下:
        s = io.StringIO()
        s.write('Hello World\n')
        print(s.getvalue())
        # 输出: Hello World

        print('This is a test', file=s)
        print(s.getvalue())
        # 输出:
        # Hello World
        # This is a test

        # Wrap a file interface around an existing string
        s = io.StringIO('Hello\nWorld\n')
        print(s.read(4))
        # 输出: Hell

        print(s.read())
        # 输出:
        # o
        # World

        # io.StirngIO类智能用于对文本的处理。如果要操作二进制数据，请使用io.BytesIO。示例如下:
        s = io.BytesIO()
        s.write(b'binary data')
        print(s.getvalue())
        # 输出: b'binary data'
        pass


    def discuss():
        '''
        讨论
        '''
        # 当出于某种原因需要模拟出一个普通文件时，这种情况下StringIO和ByteIO类是最为适用的。例如，在单元测试中没可能会使用StringIO来创建一个文
        # 件型对象，对象中包含了测试用的数据。之后我们可将这个对象发送给一个可以接受普通文件的函数。
        
        # 请注意，StringIO和ByteIO实例是没有真正的文件描述符来对应的。因此，它们没法工作在需要一个真正的系统及文件例如文件、管道或套接字的代码环
        # 境中。
        pass
    pass



''' 5.7: 读写压缩的数据文件 '''
def node5_7():
    def question():
        '''
        问题: 我们需要读写以gzip或bz2格式压缩过的文件中的数据。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # gzip和bz2模块使得同这类压缩性文件打交道变得非常简单。这两个模块都提供了open()的其他实现，可用于处理压缩文件。例如要将压缩文件以文本方式
        # 读取，可以这样处理:
        # gzip compression
        import gzip
        with gzip.open('somefile.gz', 'rt') as f:
            text = f.read()

        # bz2 compression
        import bz2
        with bz2.open('somefile.bz2', 'rt') as f:
            text = f.read()

        # 与之相似，要写入压缩数据，可以这样处理:
        # gzip compression
        with gzip.open('somefile.gz', 'wt') as f:
            text = 'Hello World'
            f.write(text)

        # bz2 compression
        with bz2.open('somefile.bz2', 'wt') as f:
            text = 'Hello World'
            f.write(text)

        # 如示例代码所示，以上所有的I/O操作都会采用文本形式并执行Unicode编码/解码操作。如果想处理二进制数据，请使用rb或wb模式。
        pass
    
    
    def discuss():
        '''
        讨论
        '''
        # 大部分情况下读写压缩数据都是简单而直接的。但是请注意，选择正确的文件模式是至关重要的。如果没有指定模式，那么默认的模式是二进制，这回是的期
        # 望接受文本程序崩溃。gzip.open()和bz2.open()所接受的参数与內建的open()函数一样，也支持encoding、errors、newline等关键字参数。

        # 当写入压缩数据时，压缩级别可通过compresslevel关键字参数来指定，这是可选的。示例如下:
        import gzip
        with gzip.open('somefile.gz', 'wt', compresslevel=5) as f:
            text = 'Hello World'
            f.write(text)
        # 默认级别是9，代表着最高的压缩等级。低等级的压缩可带来更好的性能表现，但压缩比就没那么大。

        # 最后，gzip.open()和bz2.open()有一个较少提到的特性，那就是他们能够对已经以二进制模式打开的文件进行叠加操作。示例如下:
        f = open('somefile.gz', 'rb')
        with gzip.open(f, 'rt') as g:
            text = g.read()
        # 这种行为使得gzip和bz2模块可以同各种类型的类文件对象比如套接字、管道和文件内存一起工作。
        pass
    
    pass



''' 5.8: 对固定大小的记录进行迭代 '''
def node5_8():
    def question():
        '''
        问题: 与其按行来迭代文件，我们想对一系列固定大小的记录或数据块进行迭代。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 可以利用iter()和functools.partial()来完成这个巧妙的技巧，示例如下:
        from functools import partial
        RECORD_SIZE = 32
        with open('somefile.data', 'rb') as f:
            records = iter(partial(f.read, RECORD_SIZE), b'')
            for record in records:
                pass
        # 示例中的records对象是可迭代的，它会产生固定大小的数据块直到到达文件结尾。但是请注意，如果文件大小不是记录大小的整数倍的话，那么最后产生
        # 出的那个数据块可能比所期望的字节数要少。
        pass


    def discuss():
        '''
        讨论
        '''
        # 关于iter()函数，一个少有人知的特性是，如果传递一个可调用对象及一个哨兵值给它，那么它可以创建出一个迭代器。得到的迭代器会重复调用用户提供
        # 的可迭代对象，知道它的返回值为哨兵值为止，此时迭代过程停止。

        # 在我们给出的解决方案中，functools.partial用来创建可调用对象，每次调用它时都从文件中读取固定的字节数。b''在这里作为哨兵值，当读取到文
        # 件结尾时就会返回这个值，此时迭代过程结束。

        # 最后但也很重的是，解决方案中展示的文件是以二进制模式打开的。对于读取固定大小的记录，这恐怕是最为常见的情况了。如果要针对文本文件，那么按行
        # 读取（默认的迭代行为）更为普遍一些。
        pass
    pass



''' 5.9: 将二进制数据读取到可变缓冲区中 '''
def node5_9():
    def question():
        '''
        问题: 我们想将二进制数据直接读取到可变缓冲区中，中间不经过任何拷贝环节。也许我们想原地修改数据再将它写回到文件中去。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 要将数据读取到可变数组中，使用文件对象的readinto()方法即可。示例如下:
        import os.path
        def read_into_buffer(filename):
            buf = bytearray(os.path.getsize(filename))
            with open(filename, 'rb') as f:
                f.readinto(buf)
            return buf

        # 下面来演示这个函数的用法:
        # Write a sample file
        with open('sample.bin', 'wb') as f:
            f.write(b'Hello World')

        buf = read_into_buffer('sample.bin')
        print(buf)
        # 输出: bytearray(b'Hello World')

        buf[0:5] = b'Hallo'
        print(buf)
        # 输出: bytearray(b'Hallo World')

        with open('newsample.bin', 'wb') as f:
            f.write(buf)

        pass

    def discuss():
        '''
        讨论
        '''
        # 文件对象的readinto()方法可用来将数据填充到任何预分配好的数组中，这包括array模块或者numpy这样的模块所创建的数组。与普通的read()方法
        # 不同的是，readinto()是为已存在的缓冲区填充内容，而不是分配新的对象然后再将它们返回。因此，可以用readinto()来避免产生额外的内存分配动
        # 作。例如，如果正在读取一个由相同大小的记录组成的二进制文件，可以像这样编写代码:

        record_size = 32
        buf = bytearray(record_size)
        with open('somefile', 'rb') as f:
            while True:
                n = f.readinto(buf)
                if n < record_size:
                    break

        # 这里用到另一个有趣的特性应该就是内存映像（memoryview）了，它使得我们可以对已存在的缓冲区做切片处理，但是中间不涉及任何拷贝操作，我们甚
        # 至还可以修改它的内容。示例如下:
        bytearray(b'Hello World')
        m1 = memoryview(buf)
        m2 = m1[-5:]
        print(m2)
        # 输出: <memory at 0x110485ac8>

        m2[:] = b'WORLD'
        print(buf)
        # 输出: bytearray(b'Hello WORLD')

        # 使用f.readinto()需要注意的一点是，必须总是确保要检查它的返回值，即实际读取的字节数。

        # 如果字节数小于所提供的缓冲区大小，这可能表示数据被截断或遭到了破坏（例如，如果期望读取到一个准确的字节数时）。

        # 最后可以再各种库模块中找到那些带有"into"的函数（例如recv_into()、pack_into()等）。Python中有许多模块都已经支持直接I/O访问了，可
        # 以用来填充或修改数组和缓冲区中的内容。

        # 请参见6.12节中那个解释二进制结构体和memoryview用法的示例，那个例子明显要更加高级一些。
        pass
    pass



''' 5.10: 对二进制文件做内存映射 '''
def node5_10():
    def question():
        '''
        问题: 我们想通过内存映射的方式将一个二进制文件加载到可变的字节数组中，这样可以随机访问其内容，或者是实现就地修改。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 可以使用mmap模块实现对文件内存映射操作。下面给出一个实用函数，以可移植的方式演示如何打开一个文件并对它进行内存映射操作:
        import os
        import mmap

        def memory_map(filename, access=mmap.ACCESS_WRITE):
            size = os.path.getsize(filename)
            fd = os.open(filename, os.O_RDWR)
            return mmap.mmap(fd, size, access=access)

        # 要使用这个函数，需要准备一个已经创建好的文件并为之填充一些数据。下面的例子告诉我们如何创建一个初始文件，然后将其扩展为所需要的大小。
        size = 1000000
        with open('data', 'wb') as f:
            f.seek(size-1)
            f.write(b'\x00')

        # 下面是用memory_map()函数对文件内容做内存映射操作的例子:
        m = memory_map('data')
        print(len(m))
        # 输出: 1000000

        print(m[0:10])
        # 输出: \x00\x00\x00\x00\x00\x00\x00\x00\x00\x00

        print(m[0])
        # 输出: 0

        # Reassign a slice
        m[0:11] = b'Hello World'
        m.close()

        # Verify that changes were made
        with open('data', 'rb') as f:
            print(f.read(11))
        # 输出: b'Hello World'

        # 由mmap()返回的mmap对象也可以当做上下文管理器使用，在这种情况下，底层的文件会自动关闭。示例如下:
        with memory_map('data') as m:
            print(len(m))
            print(m[0:10])
        # 输出:
        # 1000000
        # b'Hello World'

        print(m.closed)
        # 输出:
        # True

        # 默认情况下，memory_map()函数打开的文件既可以读也可以写。对文件的任何更改都会拷贝回原始的文件中。如果需要只读访问，可以为access参数提
        # 供mmap.ACCESS_READ值。示例如下:
        m = memory_map('filename', mmap.ACCESS_READ)

        # 如果只想在本地修改数据，并不想将这些修改写会到原始文件中，可以使用mmap.ACCESS_COPY参数:
        m = memory_map('filename', mmap.ACCESS_COPY)

        pass


    def discuss():
        '''
        讨论
        '''
        # 通过mmap将文件映射到内存中后，我们能够以高效和优雅的方式对文件的内容进行随机访问。比方说，与其打开文件后通过组合各种seek()、read()和
        # write()调用来访问，不如简单的将文件映射到内存，然后通过切片操作来访问数据。
        import os
        import mmap
        def memory_map(filename, access=mmap.ACCESS_WRITE):
            size = os.path.getsize(filename)
            fd = os.open(filename, os.O_RDWR)
            return mmap.mmap(fd, size, access=access)

        # 通常，由mmap()暴露出的内存看起来就像一个bytearray对象。但是利用memoryview能够以不同的方式来解读数据。比如:
        m = memory_map('data')
        # Memoryview of unsigned integers
        v = memoryview(m).cast('I')
        v[0] = 7
        print(m[0:4])
        # 输出: b'\x07'\x00\x00

        m[0:4] = b'\x07\x01\x00\x00'
        print(v[0])
        # 输出: 263

        # 应该强调的是，对某个文件进行内存映射并不会导致将整个文件读取到内存中。也就是说，文件并不会拷贝到某种内存缓冲区域或数组上。相反，操作系统只
        # 是为文件内容保留一段虚拟内存而已。当访问文件的不同区域时，文件的这些区域将被读取并按照需要映射到内存区域中。但是，文件中从未访问过的部分会
        # 简单的留在磁盘上，这一切都是以透明的方式在幕后完成的。

        # 如果有多个Python解释器对同一个文件做了内存映射，得到的mmap对象可用来在解释器之间交换数据。也就是说，所有的解释器可以同时读/写数据，在一
        # 个解释器中对数据做出的修改会自动反应到其他的解释器上。很明显，这里需要一些额外的步骤来处理同步问题，但是有时候可用这种方法作为通过管道或
        # socket传输数据的替代方式。

        # 本节中的实例已经尽量以通用的形式实现，能够在UNIX和Windows上都适用。请注意，对mmap()的使用，不同的平台上回存在一些差异。此外，还有选项
        # 可用来创建匿名的内存映射区域。如果对此感兴趣，请确保仔细阅读有关这个主题的Python文档http://docs.python.org/3/library/mmap.html
        pass

    pass



''' 5.11: 处理路径名 '''
def node5_11():
    def question():
        '''
        问题: 我们需要处理路径名以找出基文件名、目录名、绝对路径等相关信息。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 要操纵路径名，可以使用os.path模块中的函数。下面是一个交互式的例子，用来说明其中一些核心功能:
        import os
        path = '/Users/fuguoliang/Desktop/Python/python-cookbook/part_5.py'

        # Get the last component of the path
        print(os.path.basename(path))
        # 输出: part_5.py

        # Get the directory name
        print(os.path.dirname(path))
        # 输出: /Users/fuguoliang/Desktop/Python/python-cookbook

        # Join path components together
        print(os.path.join('tmp', 'data', os.path.basename(path)))
        # 输出: tmp/data/part_5.py

        # Expand the user's home directory
        path = '~/Desktop/python-cookbook/part_5.py'
        print(os.path.expanduser(path))
        # 输出: /Users/fuguoliang/Desktop/python-cookbook/part_5.py

        # Split the file extension
        print(os.path.split(path))
        # 输出: ('~/Desktop/python-cookbook', 'part_5.py')

        pass


    def discuss():
        '''
        讨论
        '''
        # 对于任何需要处理文件名的问题，都应该使用os.path模块而不是通过使用标准的字符串操作来自己实现这部分功能。部分原因是为了考虑可移植性。os.
        # path模块知道UNIX和Windows系统之间的一些差异，能够可靠的处理类似Data/data.csv和Data\data.csv这样的文字名。其次，我们真的不应该花
        # 时间去重新造轮子。通常最好的就是使用了那些已经提供了的功能。

        # 应该值得一提的是，os.path模块中还有许多功能在本节中没有展示出来。可以参阅文档以获得更多同文件测试、符号链接等功能相关的函数。
        pass
    pass



''' 5.12: 检测文件是否存在 '''
def node5_12():
    def question():
        '''
        问题: 我们需要检测某个文件或目录是否存在。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 可以通过os.path模块来检测摸个文件或目录是否存在。实例如下:
        import os
        print(os.path.exists('/etc/passwd'))
        # 输出: True

        print(os.path.exists('/tmp/spam'))
        # 输出: False

        # 之后可以执行进一步的测试来查明这个文件的类型。如果文件不存在的话，下面这些检测就会返回False:
        # Is a regular file
        print(os.path.isfile('/etc/passwd'))
        # 输出: True

        # Is a directory
        print(os.path.isdir('/etc/passwd'))
        # 输出: False

        # Is a symbolic link
        print(os.path.islink('/usr/local/bin/python3'))
        # 输出: True

        # Get the file linked to
        print(os.path.realpath('/usr/local/bin/python3'))
        # 输出: /usr/local/Cellar/python3/3.6.2/Frameworks/Python.framework/Versions/3.6/bin/python3.6

        # 如果需要得到元数据（即，文件大小或修改日期），这些功能在os.path模块中也有提供:
        print(os.path.getsize('/etc/passwd'))
        # 输出: 5925

        print(os.path.getmtime('/etc/passwd'))
        # 输出: 1440397265.0

        import time
        print(time.ctime(os.path.getmtime('/etc/passwd')))
        # 输出: Mon Aug 24 14:21:05 2015

        pass


    def discuss():
        '''
        讨论
        '''
        # 利用os.path模块来对文件做检测是简单而直接的。也许编写脚本时唯一需要注意的事情就是关于权限的问题了---尤其是获取元数据的操作。比如:
        import os
        # 如果要尝试以下例子请先创建一个foo.txt，并将文件的权限变为只读。则会报一下错误
        print(os.path.getsize('/Users/fuguoliang/Desktop/foo.txt'))
        # 输出: PermissionError: [Errno 13] Permission denied: '/Users/fuguoliang/Desktop/foo.txt'
        pass
    pass



''' 5.13: 获取目录内容的列表 '''
def node5_13():
    def question():
        '''
        问题: 我们想获取文件系统中某个目录下所包含的文件列表
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 可以使用os.listdir()函数来获取目录中的文件列表。示例如下:
        import os
        names = os.listdir('/Users/fuguoliang/Desktop/Python/python-cookbook')
        print(names)
        # 输出: ['.DS_Store', '__pycache__', 'parser.out', 'parsetab.py', 'part_2.py', 'part_3.py', 'part_4.py',
        # 'part_5.py']

        # 这么做会得到原始的目录文件列表，包括所有的文件、子目录、符号链接等，如果需要以某种方式来筛选数据，可以考虑利用列表推导式结合os.path模块
        # 中的各种函数来完成。示例如下:
        import os.path
        # Get all regular files
        names = [name for name in os.listdir('somedir')
                 if os.path.isfile(os.path.join('somedir', name))]

        # Get all dirs
        dirnames = [name for name in os.listdir('somedir')
                    if os.path.isdir(os.path.join('somedir', name))]

        # 字符串的startswith()和endwith（）方法对于筛选目录中的内容也同样有用。比如:
        pyfiles = [name for name in os.listdir('somedir')
                   if name.endswith('.py')]

        # 至于文件名的匹配，可能会想到glob或者fnmatch模块。示例如下:
        import glob
        pyfiles = glob.glob('somedir/*.py')

        from fnmatch import fnmatch
        pyfiles = [name for name in os.listdir('somedir')
                   if fnmatch(name, '*.py')]
        pass
    scheme()


    def discuss():
        '''
        讨论
        '''
        # 得到目录中内容的列表很简单，但是这只会带来目录中每个条目的名称。如果想得到一些附加的元数据，比如文件大小、修改日期等，要么使用os.path模
        # 块中的其它函数，要么使用os.stat()函数。要收集这些数据，请参见示例:

        # Example of getting a directory listing

        import os
        import os.path
        import glob

        pyfiles = glob.glob('*.py')

        # Get file sizes and modification dates
        name_sz_date = [(name, os.path.getsize(name), os.path.getmtime(name))
                        for name in pyfiles]

        for name, size, mtime in name_sz_date:
            print(name, size, mtime)

        # Alternative: Get file metadata
        file_metadata = [(name, os.stat(name)) for name in pyfiles]
        for name, meta in file_metadata:
            print(name, meta.st_size, meta.st_mtime)

        # 最后但也很重要的是，请注意有关文件名编码时会出现一些微妙的问题。一般来说想os.listdir()这样的函数返回的条目都会根据系统默认的文件名编码
        # 方式来进行解码处理。但是，有可能在特定条件下回遇到无法解码的文件名。5.14节和5.15节中有更多关于处理这样的名称时应该注意的细节。
        pass
    pass



''' 5.14: 绕过文件名编码 '''
def node5_14():
    def question():
        '''
        问题: 我们想对使用了原始文件名的文件执行I/O操作，这些文件名没有根据默认的文件名编码规则来解码或编码。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 默认情况下，所有的文件名都会根据sys.getfilesystemencoding()返回的文本编码形式进行编码和解码。例如:
        import sys
        print(sys.getfilesystemencoding())
        # 输出: utf-8

        # 如果想基于某些原因想忽略这种编码，可以使用原始字节串来指定文件名。示例如下:
        # Write a file using a unicode filename
        with open('jalape\xf1o.txt', 'w') as f:
            f.write('Spicy!')

        # Directory listing (decoded)
        import os
        print(os.listdir('.'))
        # 输出: ['.DS_Store', '__pycache__', 'jalapeño.txt', 'parser.out', 'parsetab.py', 'part_2.py', 'part_3.py',
        # 'part_4.py', 'part_5.py']

        # Directory listing (raw)
        print(os.listdir(b'.'))
        # 输出: [b'.DS_Store', b'__pycache__', b'jalapen\xcc\x83o.txt', b'parser.out', b'parsetab.py', b'part_2.py',
        # b'part_3.py', b'part_4.py', b'part_5.py']

        # Open file with raw filename
        with open(b'jalapen\xcc\x83o.txt') as f:
            print(f.read())
            # 输出: Spicy!

        # 在上两个操作中可以看到，当给同文件相关的函数比如open()和os.listdir()提供字节串参数时，对文件名的处理就发生了微小的改变。
        pass


    def discuss():
        '''
        讨论
        '''
        # 一般情况下，不应该去担心有关文件名编码和解码的问题---普通的文件名操作应该能够正常的工作。但是有许多操作系统可能会允许用户通过意外或恶意的
        # 方式创建出文件名不遵守期望的编码规则的文件。这样的文件名可能会使得处理大量文件的Python程序莫名其妙的崩溃。

        # 在读取目录和同文件名打交道时，以原始的为加码的字节座位文件名就可以避免这样的问题，只是编程的时候要更麻烦一些。

        # 请参见5.15节中关于打印出无法解码的文件名的相关示例。
        pass
    pass



''' 5.15: 打印无法解码的文件名 '''
def node5_15():
    def question():
        '''
        问题: 我们的程序接收到一个目录内容的列表，但是当程序试着打印出文件名时，会出现UnicodeEncodeError异常并伴随着一条难以理解的提示信息："不
        允许代理（surrogates not allowed）"，然后程序就崩溃了。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 当打印来路不明的文件时，可以使用下面的方式来避免出现错误：
        def bad_filename(filename):
            return repr(filename)[1:-1]

        filename = "x"
        try:
            print(filename)
        except UnicodeDecodeError:
            print(bad_filename(filename))

        pass


    def discuss():
        '''
        讨论
        '''
        # 当程序必须去操纵文件系统时，本节提到了一个一般情况下很罕见但却非常令人头痛的问题。默认情况下，Python假设所有的文件名都是根据
        # sys.getfilesystemencoding()返回的编码形式进行编码的。但是，某些文件系统不一定会强制执行这种编码约束，因此会允许文件以不恰当的编码方
        # 式来命名。这并不常见，但是总有某些用户会做出些愚蠢的事情，意外地创建出这么一个文件夹（即，可能在某些有问题得代码中将不恰当的文件名传给open
        # ()）。因此危险总是存在的。

        # 当执行类似os.listdir()这样的命令时，错误的文件名会使Python陷入窘迫的境地。一方面Python不能最直接丢弃错误的名字，而另一方面它无法将文
        # 件名转为合适的文本字符串。对于这个问题，Python的解决方案是在文件名中取出一个无法解码的字节值\xhh，将其映射到一个所谓的"代理编码（
        # surrogate encoding）"中，代理编码由Unicode字符\udchh来表示。参见下面的示例，在一个有缺陷的目录列表中包含这一个名为båd.txt的文件，
        # 该文件名的编码方式为Latin-1而不是UTF-8，我们来看看现实出来的结果：
        import os
        import sys
        files = os.listdir('.')
        print(files)
        # 输出: ['spam.py', 'b\udce4d.txt', 'foo.txt']

        # 如果代码只是用来操纵文件名或者甚至将文件名传递给函数（比如open()），一切都能正常工作。只有当把文件名输出时才会陷入麻烦（即，打印到屏幕、
        # 记录到日志上等）。具体而言，如果是这打印上面这个列表，程序就会崩溃：
        for name in files:
            print(name)

        # 崩溃的原因在于字符\udce4不是合法的Unicode字符。它实际上是2个字符组合的后半部分，这个组合称之为代理对（surrogate pair）。但是，由于
        # 前半部分丢失了，因此是非法的Unicode。所以，唯一能成功产生输出的方式是，当遇到有问题得文件名时采取纠正的措施。比如，将代码改写为下面的方
        # 式就能产生出结果了:
        def bad_filename(filename):
            return repr(filename)[1:-1]

        for name in files:
            try:
                print(name)
            except UnicodeDecodeError:
                print(bad_filename(name))

        # 函数bad_filename()要实现什么功能很大程度上取决于自己的选择。比如，另一种选择是以其它方式重新编码，就像这样：
        def badfilename(filename):
            temp = filename.encode(sys.getfilesystemencoding(), errors='surrogateescape')
            return temp.decode('latin-1')

        # 大部分读者可能会忽略这一节的内容。但是，如果要编写完成关键任务的脚本，需要可靠的与文件名以及文件系统打交道，那么就需要好好考虑本节的内容。
        # 否则可能就会需要周末被叫去办公室调试一个看似无法理解的错误。
        pass

    pass


''' 5.16: 为已经打开的文件添加或修改编码方式 '''
def node5_16():
    def question():
        '''
        问题: 我们想为一个已经打开的文件添加或修改Unicode编码，但不必首先将其关闭。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 如果想为一个以二进制模式打开的文件对象添加Unicode编码/解码，可以用io.TextIOWrapper()对象将其包装。示例如下：
        import urllib.request
        import io

        u = urllib.request.urlopen('http://www.python.org')
        f = io.TextIOWrapper(u, encoding='utf-8')
        text = f.read()
        print(text)

        # 如果想修改一个已经以文本模式打开的文件的编码方式，可以在用新的编码替换之前的编码前，用detach()方法将已有文本编码层移除。下面是修改sys.
        # stdout编码的例子:
        import sys
        print(sys.stdout.encoding)
        # 输出: UTF-8

        sys.stdout = io.TextIOWrapper(sys.stdout.detach(), encoding='latin-1')
        print(sys.stdout.encoding)
        # 输出: latin-1

        # 这么做可能会破坏终端上的输出，这里只是用做说明使用。
        pass


    def discuss():
        '''
        讨论
        '''
        import io
        import sys
        # I/O系统是以一些列的层次来构建的。我们可以通过下面这个涉及文本文件的简单例子来观察这些层次：
        f = open('sample.txt', 'w')
        print(f)
        # 输出: <_io.TextIOWrapper name='sample.txt' mode='w' encoding='UTF-8'>

        print(f.buffer)
        # 输出: <_io.BufferedWriter name='sample.txt'>

        print(f.buffer.raw)
        # 输出: <_io.FileIO name='sample.txt' mode='wb' closefd=True>

        # 在这个例子中，io.TextIOWrapper是一个文本处理层，它负责编码和解码Unicode。而io.BufferedWriter是一个缓冲I/O层，负责处理二进制数据
        # 最后，io.FileIO是一个原始文件，代表这操作系统底层的文件描述符。添加或修改文本的编码设计添加或修改最上层的io.TextIOWrapper层。

        # 作为一般的规则，直接通过访问上面展示的属性来操纵不同的层次是不安全。比如，如果用这种技术来修改编码的话，看看会出现什么情况：
        print(f)
        # 输出: <_io.TextIOWrapper name='sample.txt' mode='w' encoding='UTF-8'>
        f = io.TextIOWrapper(f.buffer, encoding='latin-1')

        print(f)
        # 输出: <_io.TextIOWrapper name='sample.txt' encoding='latin-1'>

        # f.write('Hello')
        # 输出: ValueError: I/O operation on closed file.

        # 这根本不起作用，因为f之前的值已经被销毁，在这个过程中导致底层的文件将被关闭。detach()方法将最上层的io.TextIOWrapper层同文件分离开来
        # 并将下一个层次（io.BufferedWritter）返回。在这之后，最上层将不再起作用。示例如下:
        f = open('sample.txt', 'w')
        print(f)
        # 输出: <_io.TextIOWrapper name='sample.txt' mode='w' encoding='UTF-8'>

        b = f.detach()
        print(b)
        # 输出: <_io.BufferedWriter name='sample.txt'>

        # f.write('Hello')
        # 输出: ValueError: underlying buffer has been detached

        # 一旦完成分离，就可以为返回的结果添加一个新的最上层。示例如下:
        f = io.TextIOWrapper(b, encoding='latin-1')
        print(f)
        # 输出: <_io.TextIOWrapper name='sample.txt' encoding='latin-1'>

        # 尽管我们已经展示了如何修改编码方式，其实也可以利用这项技术来修改文本行的处理、错误处理机制以及其他有关文件处理方面的行为。示例如下:
        sys.stdout = io.TextIOWrapper(sys.stdout.detach(), encoding='ascii', errors='xmlcharrefreplace')
        print('Jalape\u00f1o')
        # 输出: Jalape&#241;o

        # 在输出中，我们注意到非ASCII字符已经被&#241所取代了。
        pass

    pass



''' 5.17: 将字节数据写入文本文件 '''
def node5_17():
    def question():
        '''
        问题: 我们想将一些原始字节写入到以文本模式代开的文件中。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 只需要简单的将字节数据写入到文件底层的buffer中就可以了。示例如下:
        import sys
        sys.stdout.write(b'Hello\n')
        # 输出: TypeError: write() argument must be str, not bytes

        print(sys.stdout.buffer.write(b'Hello\n'))
        # 输出:
        # Hello
        # 6
        
        # 同样地，我们也可以从文本文件中读取二进制数据，只要buffer属性来读取即可。
        pass


    def discuss():
        '''
        讨论
        '''
        # I/O系统是以不同的层次来构建的。文本文件是通过在缓冲的二进制模式文件之上添加一个Unicode编码/解码层来构建的。buffer属性简单地只想底层的
        # 文件。如果访问该属性，就可以绕过文本编码/解码层了。
        
        # 例子中的sys.stdout可以被视为特殊情况。默认情况下，sys.stdout总是以文本模式打开的。但是，如果要编写一个需要将二进制数据转储到标准输出
        # 的脚本，就可以使用上面演示的技术来绕过文本编码层。
        pass

    pass


''' 5.18: 将已有的文件描述符包装为文件对象 '''
def node5_18():
    def question():
        '''
        问题: 我们有一个以整数值表示的文件描述符，它已经同操作系统中已打开的I/O通道建立起了联系（即，文件、管道、socket等）。而我们希望以高级的
        Python文件对象来包装这个文件描述符。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # 文件描述符与一般打开的文件相比是有区别的。区别在于，文件描述符只是一个由操作系统分配的整数句柄，用来指代某种操作系统I/O通道。如果刚好有这
        # 样一个描述文件符，就可以通过open()函数用Python文件对象进行包装。这很简单，只需将整数形式的文件描述符作为第一个参数取代文件名就可以了。
        # 示例如下:
        # Open a low-level file descriptor
        import os
        fd = os.open('somefile.txt', os.O_WRONLY | os.O_CREAT)

        # Turn into a proper file
        f = open(fd, 'wt')
        f.write('hello world\n')
        f.close()

        # 当高层的文件对象被关闭或销毁时，底层的文件描述符也会被关闭。如果不想要这样的行为，只需给open()提供一个可选的closefd=False参数即可。示
        # 例如下:
        # Create a file object, but don't close underlying fd when done
        f = open(fd, 'wt', closefd=False)
        pass
    
    
    def discuss():
        '''
        讨论
        '''
        # 在UNIX系统上，这种包装文件描述符的技术可以用来方便地对不同方式打开的I/O通道（即，管道、Socket等）提供一个类似于文件的接口。例如，下面是
        # 一个有关socket的例子:
        from socket import socket, AF_INET, SOCK_STREAM
        def echo_client(client_sock, addr):
            print('Got connection from', addr)

            # Make text-mode file wrappers for socket reading/writing
            client_in = open(client_sock.fileno(), 'rt', encoding='latin-1', closefd=False)
            client_out = open(client_sock.fileno(), 'wt', encoding='latin-1', closefd=False)

            # Echo lines back to the client using file I/O
            for line in client_in:
                client_out.write(line)
                client_out.flush()
            client_sock.close()

        def echo_server(address):
            sock = socket(AF_INET, SOCK_STREAM)
            sock.bind(address)
            sock.listen(1)
            while True:
                client, addr = sock.accept()
                echo_client(client, addr)

        # 需要重点强调的是，上面例子仅仅只是用来说明內建open()函数的一种特性，而且只能工作在基于UNIX的系统上。如果想在socket上加一个类似文件的接
        # 口，并且需要做到跨平台，那么就应该使用socket的makefile()方法来替代。但是，如果不需要考虑可移植性的话，就会发现上面给出的解决方案在性能
        # 上要比makefile()高出不少。

        # 也可以利用这项技术为一个已经打开的文件创建一种别名，使得它的工作方式能够稍微区别与首次打开时的样子。比方说，下面这段代码告诉我们如何创建一
        # 个文件对象，使得它能够在stdout上产生出二进制数据（通常stdout是以文本模式打开的）：
        import sys
        # Create a binary-mode file for stdout
        bstout = open(sys.stdout.fileno(), 'wb', closefd=False)
        bstout.write(b'Hello World\n')
        bstout.flush()

        # 尽管我们可以将一个已存在的文件描述符包装成一个合适的文件，但是请注意，并非所有的文件模式都可以得到支持，而且某些特定类型的文件描述符可能还
        # 带有有趣的副作用（尤其是面对错误处理、文件结尾的情况时）。具体的行为也可能因为操作系统的不同而有所区别。特别是，上面所有的示例代码都没法在
        # 非UNIX系统下工作。因此，最进本的底线是需要对自己的实现进行彻底的测试，确保代码能够按照期望的方式工作。
        pass
    pass



''' 5.19: 创建临时文件和目录 '''
def node5_19():
    def question():
        '''
        问题: 当程序运行时，我们需要创建临时文件或目录以便使用。在这之后，我们可能希望将这些文件和目录销毁掉。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # tempfile模块中有各种函数可以用来完成这个任务。要创建一个未命名的临时文件，可以使用tempfile.TemporaryFile:
        from tempfile import TemporaryFile
        with TemporaryFile('w+t') as f:
            # Read/Write to the file
            f.write('Hello World\n')
            f.write('Testing\n')

            # Seek back to beginning and read the data
            f.seek(0)
            data = f.read()
            print(data)
            # 输出:
            # Hello World
            # Testing

        # Temporary file is destroyed

        # 或者如果你喜欢的话也可以这样使用文件:
        f = TemporaryFile('w+t')
        # Use the temporary file
        f.close()
        # file is destroryed

        # TemporaryFile()的第一个参数是文件模式，通常以w+t处理文本模式而以w+b处理二进制数据。这个模式可以同时支持读写，在这里是很有用的，因为关
        # 闭文件后再来修改文件模式实际上会销毁文件对象。此外，TemporaryFile()也可以接受和內建的open()函数一样的参数。示例如下:
        with TemporaryFile('w+t', encoding='utf-8') as f:
            pass

        # 在大多数UNIX系统上，由TemporaryFile()创建的文件都是未命名的，而且在目录中也没有对应的条目。如果想要解放这种限制，可以使用
        # NamedTemporaryFile()来替代。示例如下:
        from tempfile import NamedTemporaryFile
        with NamedTemporaryFile('w+t') as f:
            print('filename is :', f.name)
            # 输出: filename is : /var/folders/t9/dx7w7mm934b7qyxljdd6j3740000gn/T/tmpja5odsio
        # File automatically destroyed

        # 这里，在已打开文件的f.name属性中就包含了临时文件的文件名。如果需要将它传给其他需要打开这个文件的代码时，这就显得很有用了。对于
        # TemporaryFile()而言，结果文件会在关闭时自动删除。如果不想要这种行为，可以提供一个delete=False关键字参数。示例如下:
        with NamedTemporaryFile('w+t', delete=False) as f:
            print('filename is:', f.name)

        # 要创建一个临时目录，可以使用tempfile.TemporaryDirectory()来实现。示例如下:
        from tempfile import TemporaryDirectory
        with TemporaryDirectory() as dirname:
            print('dirname is:', dirname)
            # Use the directory

        # Directory and all contents destroyed
        pass


    def discuss():
        '''
        讨论
        '''
        # 要和临时文件还有临时目录打交道，最方便的是使用TemporaryFile()、NamedTemporaryFile()以及TemporaryDirectory()这三个函数了。因
        # 为他们能自动处理有关创建和清除的所有步骤。从较低的层次来看，也可以使用mkstemp()和mkdtemp()来创建临时文件和目录。示例如下:
        import tempfile
        from tempfile import NamedTemporaryFile

        print(tempfile.mkstemp())
        # 输出: (3, '/var/folders/t9/dx7w7mm934b7qyxljdd6j3740000gn/T/tmp6attb3y1')

        print(tempfile.mkdtemp())
        # 输出: /var/folders/t9/dx7w7mm934b7qyxljdd6j3740000gn/T/tmpmps30675

        # 但是，这些函数并不会进一步去处理文件管理的任务。例如，mkstemp()函数只是简单地返回一个原始的操作系统文件描述符，然后由我们自行将其转换为
        # 一个合适的文件。同样地，如果想将文件清理掉的话，这个任务也是由我们自己完成。

        # 一般情况下，临时文件都是在系统默认的区域中创建的，比如/var/tmp或者类似的地方。要找出实际的位置，可以使用tempfile.gettempdir()函数。
        # 示例如下:
        print(tempfile.gettempdir())
        # 输出: /var/folders/t9/dx7w7mm934b7qyxljdd6j3740000gn/T

        # 所有同临时文件相关的函数都允许使用prefix、suffix和dir关键字参数来覆盖目录。例如:
        f = NamedTemporaryFile(prefix='mytemp', suffix='.txt', dir='/tmp')
        print(f.name)
        # 输出: /tmp/mytemp8ee899.txt

        # 最后但也很重要的是，在有可能的范围内，tempfile模块创建的临时文件都是以最安全的方式来进行的。这包括只为当前用户提供可访问的权限，并且在创
        # 建文件时采取了响应的步骤来避免出现竞态条件。请注意，在不同的平台下这可能会有一些差别。因此，对于更精细的要点，应该确保自己去查阅官方文档（
        # http://docs.python.org/3/library/tempfile.html）
        pass
    pass



''' 5.20: 同串口进行通信 '''
def node5_20():
    def question():
        '''
        问题: 我们想通过串口读取和写入数据，典型情况下是同某种硬件设备进行交互（即，机器或传感器）
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 尽管可以直接通过Python內建的I/O原语来完成这个任务，但对于串口通信来说最好还是使用pySerial包比较好。这个包使用起来非常的简单，要代开一
        # 个串口，只要使用这样的代码即可:
        import serial
        ser = serial.Serial('/dev/tty.usbmodem641', # Device name varies
                            baudrate=9600,
                            bytesize=8,
                            parity='N',
                            stopbits=1)
        # 设备名称可能会根据设备的类型和操作系统而有所不同。比如，在Windows上可以使用0、1这样的数字代表设备来打开通信端口，比如'COM0'、'COM1'，
        # 一旦打开后，就可以通过read()、readline()和write()调用来读写数据了。示例如下:
        ser.write(b'G1 X50 Y50\r\n')
        resp = ser.readline()
        # 从这一点上看，大部分情况下的串口通信任务应该是非常简单的。
        pass


    def discuss():
        '''
        讨论
        '''
        # 尽管表面上看起来是非常的简单，串口通信常常会变得相当的混乱。应该使用一个像pySerial这样包的原因就在它对一些高级特性提供了支持（即，超时处
        # 理、流控、刷新缓冲区、握手机制等）。比如，如果想开启RTS-CTS握手，只要简单地为Serial()提供一个rtscts=True关键字参数即可。pySerial提
        # 供的文档非常的棒，所以在这里多解释也没多大用处。

        # 请记住所有涉及串口的I/O操作都是二进制的。因此，确保在代码中使用的是字节而不是文本（或者根据需要执行适当的文本编码/解码操作）。当需要创建
        # 以二进制编码的命令或数据包时，struct模块也会起到不少作用。
        pass
    pass



''' 5.21: 序列化Python对象 '''
def node5_21():
    def question():
        '''
        问题: 我们需要将Python对象序列化为字节流，这样就可以将其保存到文件中、存储到数据库中或者通过网络连接进行传输。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 序列化数据最常见的做法就是使用pickle模块。要将某个对象转存到文件中，就可以这样做:
        import pickle
        data = [1, 2, 3, 4, 5, 6]
        f = open('somefile', 'wb')
        pickle.dump(data, f)

        # 要将对象转存为字符串，可以使用pickle.dumps():
        s = pickle.dumps()

        # 如果要从字节流中重新创建出对象，可以使用pickle.load()或者pickle.loads()函数。示例如下:
        # Restore from a file
        f = open('somefile', 'rb')
        data = pickle.load(f)

        # Restore from a string
        data = pickle.loads(s)
        pass


    def discuss():
        '''
        讨论
        '''
        # 对于大部分程序来说，只要掌握dump()和load()函数的用法就可以高效地利用pickle模块了。pickle模块能够兼容大部分Python数据类型和用户自定
        # 义的类实例。如果正在使用的库可以保存/恢复Python对象到数据库中，或者通过网络传输对象，那么很有可能在使用pickle。

        # pickle是一种Python专有的自描述式的数据编码。说到自描述，因为序列化的数据中包含有每个对象的开始和结束以及有关对象类型的信息。因此，不需
        # 要担心应该如何定义记录--Pickle就能完成了。例如，如果需要处理多个对象，可以这么做:
        import pickle
        f = open('somedata', 'wb')
        pickle.dump([1, 2, 3, 4], f)
        pickle.dump('hello', f)
        pickle.dump({'Apple', 'Pear', 'Banana'}, f)
        f.close()

        f = open('somedata', 'rb')
        print(pickle.load(f))
        # 输出: [1, 2, 3, 4]

        print(pickle.load(f))
        # 输出: hello

        print(pickle.load(f))
        # 输出: {'Banana', 'Apple', 'Pear'}

        # 可以对函数、类以及实例进行pickle处理，但由此产生的数据只会对代码对象所关联的名称进行编码。例如:
        import math
        import pickle
        print(pickle.dumps(math.cos))
        # 输出: b'\x80\x03cmath\ncos\nq\x00.'

        # 当对数据做反序列化处理时，会假设所有需要的源文件都是可用的。模块、类以及函数会根据需要自动导入。对于需要在不同机器上解释器之间共享Python
        # 数据的应用，这会成为一个潜在的维护性问题，因为所有的机器都必须能够访问到相同的源代码。

        # ***** 警告 *****
        # 绝对不能对非受信任的数据使用pickle.load()。由于会产生副作用，pickle会自动加载模块并创建实例。但是，了解pickle是如何运作的骇客可以故
        # 意创建出格式不正确的数据，使得Python解释器有机会去执行任意的系统命令。因此有必要将pickle限制为只在内部使用，解释器和数据之间要能够彼此
        # 验证对方。

        # 某些特定类型的对象是无法进行pickle操作的。这些对象一般来说都会涉及某种外部系统状态，比如打开文件、打开网络连接、线程、进程、栈帧等。用户
        # 自定义的类有时候可以通过提供__getstate__()和__setstate__()方法来规避这些限制。如果定义了这些方法，pickle.dump()就会调用
        # __getstate__()来得到一个就可以被pickle处理的对象。同样的，在unpickle的时候就会调用__setstate__()了。为了说明，下面这个类在内部定
        # 义了一个线程，但是仍然可以进行pickle/unpickle操作:

        # countdown.py
        import time
        import threading

        class Countdown:
            def __init__(self, n):
                self.n = n
                self.thr = threading.Thread(target=self.run)
                self.thr.daemon = True
                self.thr.start()

            def run(self):
                while self.n > 0:
                    print('T-minus', self.n)
                    self.n -= 1
                    # time.sleep(1)

            def __getstate__(self):
                return self.n

            def __setstate__(self, n):
                self.__init__(n)

        # 用下面的代码实验一下pickle操作:
        c = Countdown(30)

        # After a few monents
        f = open('csate.p', 'wb')
        import pickle
        pickle.dump(c, f)
        f.close()

        # 现在退出Python，重启之后再试试这个:
        f = open('cstate.p', 'rb')
        pickle.load(f)

        # 可以看到线程又魔法般地重新焕发出声明了，而且是从上次执行pickle操作时间剩下的计数开始执行。

        # 对于大型的数据结构，比如由array模块或numpy库创建的二进制数组，pickle就不是一种特别高效的编码了。如果需要移动大量的数组型数据，那么最好
        # 简单的将数据按块保存在文件中，或者使用更加标准的编码，比如HDF5（由第三方库支持）。

        # 由于pickle是Python的专有特性，而且同源代码关联紧密，因此不应该把pickle作为长期存储的格式。比如说，如果源代码发生改变，那么存储的所有数
        # 据就会失效且变得无法读取。坦白说，要将数据保存在数据库和归档存储中，最好使用更加标准的数据编码，比如XML、CSV或者JOSN。这些编码的标准化程
        # 度更高，许多编程语言都支持，而且更能适应于源代码的修改。

        # 最后同样重要的是，请注意pickle模块中有这大量的选项和棘手的阴暗角落。对于大部分常见的用途，我们不必要担心这些问题。但是如果要构建一个大型
        # 的应用，其中要用pickle来做序列化的话，那么就应该好好参考官方文档（http://docs.python.org/3/library/pickle.html）
        pass
    pass