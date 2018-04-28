#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
cookbook 第2章 [字符串和文本]

2.6: 以不区分大小写的方式对文本做查找和替换
2.7: 定义实现最短匹配的正则表达式
2.8: 编写多行模式的正则表达式
2.9: 将Unicode文本统一表示为规范文本
2.10: 用正则表达式处理Unicode字符
2.11: 从字符串中去掉不需要的字符
2.12: 文本过滤和清理
2.13: 对齐文本字符串
2.14: 字符串连接及合并
2.15: 给字符串中的变量名做插值处理
2.16: 以固定的列数重新格式化文本
2.17: 在文本中处理HTML和XML实体
2.18: 文本分词
2.19: 编写一个简单的递归下降解析器
2.20: 在字节串上执行文本操作

"""


''' 2.6: 以不区分大小写的方式对文本做查找和替换 '''
def node2_6():
    ''
    ''' ============ 问题 ============ '''
    # 我们要以不区分大小写的方式在文本中进行查找，可能还需要做替换

    ''' ============ 方案 ============ '''
    # 要进行不区分大小写的文件操作，我们需要使用 re 模块并且对各种操作都要加上re.IGNORECASE标记。例如：
    import re
    text = 'UPPER PYTHON, lower python, Mixed Python'
    result = re.findall('python', text, flags=re.IGNORECASE)
    print(result)
    # 输出: # ['PYTHON', 'python', 'Python']

    # 上面这个例子揭示出了一种局限，那就是待替换的文本与匹配的文本大小写并不吻合。如果想修正这个问题，需要用到一个支撑函数(support function)，示例如下：
    def matchcase(word):
        def replace(m):
            text = m.group()
            if text.isupper():
                return word.upper()
            elif text.islower():
                return word.lower()
            elif text[0].isupper():
                return word.capitalize()
            else:
                return word

        return replace

    # 下面是使用这个函数的例子：
    x = re.sub('python', matchcase('snake'), text, flags=re.IGNORECASE)
    print(x)  # UPPER SNAKE, lower snake, Mixed Snake

    ''' ============ 讨论 ============ '''
    # 对于简单的情况，只需要加上re.IGNORECASE标记就足以进行不区分大小写的匹配操作了。
    # 但请注意的是这对于某些涉及大小写转换( case folding )的Unicode匹配来说可能是不够的。



''' 2.7: 定义实现最短匹配的正则表达式 '''
def node2_7():
    ''
    ''' ============ 讨论 ============ '''
    # 我们在尝试正则表达式对文本模式做匹配，但识别出来的是最长的可能匹配，相反，我们想将其修改为找出最短的可能匹配

    ''' ============ 方案 ============ '''
    # 这个问题通常会在匹配的文本被一对开始和结束分隔符抱起来的时候出现（例如带引号的字符串）。为了说明这个问题，请看下面的例子：
    import re
    str_pat = re.compile(r'\"(.*)\"')
    text1 = 'Computer says "no."'
    a = str_pat.findall(text1)
    print(a)
    # 输出: ['no.']

    text2 = 'Computer says "no." Phone says "yes."'
    b = str_pat.findall(text2)
    print(b)
    # 输出: ['no." Phone says "yes.']

    # 在这个例子中，模式r'\"(.*)\"' 尝试去匹配包含在引号中的文本。但是 * 操作符在正则表达式中采用的是贪心策略，
    # 所以匹配过程是基于找出最长的可能匹配来进行的。因此text2中的例子中，它错误的匹配成两个被引号包围的字符串。
    # 要解决这个问题，只要在模式中的 * 操作符后面加上 ? 修饰符就可以了。示例如下
    str_pat1 = re.compile(r'\"(.*?)\"')
    c = str_pat1.findall(text2)
    print(c)
    # 输出: ['no.', 'yes.']

    # 这么做是的匹配过程不会以贪心的方式进行，也就会产生出最短匹配了。

    ''' ============ 讨论 ============ '''
    # 本节提到了一个当编写含有句点(.)字符的正则表达式时常会遇到的问题。在模式中，句点除了换行符之外可匹配任意字符。但是，如果以开始
    # 和结束文本（比如说引号）将句点括起来的话，在匹配过程中将尝试找出最长的可能匹配结果。这会导致匹配时会跳过多个开始或结束文本，而
    # 将它们都包含在最长的匹配中。在 * 或 + 后添加一个 ? ，会强制将匹配算法调整为寻找最短的可能匹配。



''' 2.8: 编写多行模式的正则表达式 '''
def node2_8():
    ''
    ''' ============ 问题 ============ '''
    # 我们打算用正则表达式对一段文本块做匹配，但是希望在进行匹配时能够跨越多行。


    ''' ============ 方案 ============ '''
    # 这个问题一般出现在希望使用句点(.)来匹配任意字符，但是忘记了句点不能匹配换行符时。例如想匹配C语言风格的注释:
    import re
    comment = re.compile(r'/\*(.*?)\*/')
    text1 = '/* this is comment */'
    text2 = '''/* this is a 
                  multiline comment */'''
    a = comment.findall(text1)
    print(a)
    # 输出: [' this is comment ']

    b = comment.findall(text2)
    print(b)
    # 输出: []

    # 要解决这个问题，可以添加对换行符的支持。示例如下:
    comment1 = re.compile(r'/\*((?:.|\n)*?)\*/')
    c = comment1.findall(text2)
    print(c)
    # 输出: [' this is a \n              multiline comment ']

    # 在这个模式中，(?:.|\n)指定了一个非捕获组（即这个组制作匹配但不捕获结果，也不会分配组号）


    ''' ============ 讨论 ============ '''
    # re.compile() 函数可接受一个有用的标记--re.DOTALL。这使得正则表达式中的句点(.)可以匹配所有字符，也包括换行符。例如:
    comment2 = re.compile(r'/\*(.*?)\*/', flags=re.DOTALL)
    d = comment2.findall(text2)
    print(d)
    # 输出: [' this is a \n              multiline comment ']

    # 对于简单的情况，使用re.DOTALL标记就可以很好的完成工作。但是如果要处理极其复杂的模式，或者为了做分词而降单独的正则表达式
    # 合并在一起的情况，如果可以选择的话，通常更好的方法是定义自己的正则表达式模式，这样它无需额外的比较也能正确工作。



''' 2.9: 将Unicode文本统一表示为规范文本 '''
def node2_9():
    ''
    ''' ============ 问题 ============ '''
    # 我们正在同Unicode字符串打交道，但需要确保所有的字符串都拥有相同的底层表示。


    ''' ============ 方案 ============ '''
    # 在Unicode中，有些特定的字符可以被表示成多种合法的代码点序列。为了说明这个问题，请看下面的示例:
    s1 = 'Spicy Jalape\u00f1o'
    s2 = 'Spicy Jalapen\u0303o'
    print(s1)
    # 输出: Spicy Jalapeño
    print(s2)
    # 输出: Spicy Jalapeño
    print(s1 == s2)
    # 输出: False
    print(len(s1))
    # 输出: 14
    print(len(s2))
    # 输出: 15

    # 这里的文本'Spicy Jalapeño'以两种形式呈现。第一种使用的是字符ñ的全组成（fully composed）形式（U+00F1）。
    # 第二种使用的是拉丁字母'n'紧跟着一个'~'组合而成的字符（U+0303）

    # 对于一个比较字符串的程序来说，同一个文本拥有多种不同的表示形式是一个大问题。为了解决这个问题，应该先将文本统一表示为
    # 规范的形式，这可以通过unicodedata模块来完成

    import unicodedata
    t1 = unicodedata.normalize('NFC', s1)
    t2 = unicodedata.normalize('NFC', s2)
    print(t1 == t2)
    # 输出: True
    print(ascii(t1))
    # 输出: 'Spicy Jalape\xf1o'

    t3 = unicodedata.normalize('NFD', s1)
    t4 = unicodedata.normalize('NFD', s2)
    print(t3 == t4)
    # 输出: True
    print(ascii(t3))
    # 输出: 'Spicy Jalapen\u0303o'

    # normalize() 的第一个参数指定了字符串应该如何完成规范表示。NFC表示字符应该是全组成的（即如果可能的话就使用单个代码点）。
    # NFD表示应该使用组合字符，每个字符应该是能完全分解开的。
    # Python还支持NFKC和NFKD的规范表示形式，它们为处理特定类型的字符增加了额外的兼容功能，例如:

    s = '\ufb01'  # A single character
    print(s)
    # 输出: ﬁ
    print(unicodedata.normalize('NFD', s))
    # 输出: ﬁ
    print(unicodedata.normalize('NFKD', s))
    # 输出: fi
    print(unicodedata.normalize('NFKC', s))
    # 输出: fi
    # ** ﬁ和fi可是不同的

    ''' ============ 讨论 ============ '''
    # 对于任何需要确保以规范和一致性的方式处理Unicode文本的程序来说，规范化都是重要的一部分。尤其是在处理用户输入时接受到字符串时
    # 此时你无法控制字符串的编码形式，那么规范化文本的表示就显得尤为重要了。
    # 在对文本进行过滤和净化时，规范化同样也占据了重要的部分。假设想从某些文本中去除所有的音符标记（可能是为了进行搜索或匹配）
    t5 = unicodedata.normalize('NFD', s1)
    print(''.join(c for c in t5 if not unicodedata.combining(c)))

    # 最后一个例子展示了unicodedata 模块的另一个重要功能--用来检测字符是否属于某个字符类别。使用工具combining()函数可对字符做
    # 检查，判断它是否为一个组合类型字符。这个模块中还有一些函数可用来查找字符类别、检测数字字符等。
    # 很显然，Unicode是一个庞大的主题。要获得更多有关规范化文本方面的参考信息，可访问http://www.unicode.org/faq/normalization.html
    # Ned Batchelder也在他的网站http://nedbatchelder.com/text/unipain.html上对python中的Unicode处理给出了有些的示例说明。



''' 2.10: 用正则表达式处理Unicode字符 '''
def node2_10():
    def question():
        '''
        问题: 我们正在用正则表达式出来文本，但是需要考虑处理Unicode字符
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 默认情况下re模块已经对某些Unicode字符类型有了基本的认识。例如，\d已经可以匹配任意Unicode数字字符了
        import re
        num = re.compile('\d+')
        print(num.match('123'))
        # 输出: <_sre.SRE_Match object; span=(0, 3), match='123'>

        print(num.match('\u0661\u0662\u0663'))
        # 输出: <_sre.SRE_Match object; span=(0, 3), match='١٢٣'>

        # 如果需要在模式字符串中包含指定的Unicode字符，可以针对Unicdoe字符使用转义序列（例如\uFFFF或\UFFFFFFF）.比如：
        # 这里有一个正则表达式能够在多个不同的阿拉伯代码页中匹配所有字符
        arabic = re.compile('[\u0600-\u06ff\u0750-\u077f\u08a0-\u08ff]+')
        print(arabic)
        # 输出: re.compile('[\u0600-ۿݐ-ݿࢠ-ࣿ]+')

        # 当执行匹配和搜索操作时，一个好注意是首先将所有的文本都统一表示为标准形式。但是同样重要是需要注意一下特殊情况。例如
        # 当不区分大小写的匹配和大写转换匹配联合起来时，考虑会出现什么行为：
        pat = re.compile('stra\u00dfe', re.IGNORECASE)
        s = 'straße'
        print(pat.match(s))
        # 输出: <_sre.SRE_Match object; span=(0, 6), match='straße'>

        print(pat.match(s.upper()))
        # 输出: None

        print(s.upper())
        # 输出: STRASSE
        pass


    def discuss():
        '''
        讨论
        '''
        # 把Unicode和正则表达式混在一起使用绝对是个能让人头痛欲裂的办法。如果真的要这么做，应该考虑安装第三方的正则表
        # 达式库（http://pypi.python.org/pypi/regex）这些第三方库针对Unicode大写转换提供了完整的支持，还包括其
        # 他各种有趣的特性包括近似匹配
        pass
    pass



''' 2.11: 从字符串中去掉不需要的字符 '''
def node2_11():
    def question():
        '''
        问题: 我们想在字符串的开始、结尾或中间去掉不需要的字符，比如说空格符
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # strip()方法可用来从字符串的开始和结尾处去掉字符。lstrip()和rstrip()可分别从左或从右侧开始执行去除字符的操作。
        # 默认情况下这些方法去除的是空格符，但也可以指定其他的字符。例如:
        s = ' hello world \n'
        print(s.strip())
        # 输出: 'hello world'

        print(s.lstrip())
        # 输出: 'hello world \n'

        print(s.rstrip())
        # 输出: ' hello world'

        t = '-----hello====='
        print(t.lstrip('-'))
        # 输出: 'hello====='

        print(t.rstrip('='))
        # 输出: '-----hello'

        print(t.strip('-='))
        # 输出 'hello'
        pass

    def discuss():
        '''
        讨论
        '''
        # 当我们读取并整理数据以待稍后的处理时常常会用到这类strip()方法。例如，可以用他们来去掉空格、移除引号等。
        # 需要注意的是，去除字符的操作并不会对位于字符串中间的任何文本起作用。例如
        s = ' hello  world  \n'
        print(s.strip())
        # 输出: 'hello  world'

        # 如果要对里面的空格执行某些操作，应该使用其他技巧，比如使用replace()方法或正则表达式替换。例如:
        print(s.replace(' ', ''))
        # 输出: 'helloworld'

        import re
        print(re.sub('\s+', ' ', s))
        # 输出: ' hello world'

        # 我们通常会遇到的情况是将出去字符的操作同某些迭代操作结合起来，比如说从文件中读取问本行
        # 如果是这样的话，那就到了生成器表达式大显身手的时候了。例如:
        with open('filename') as f:
            lines = (line.strip() for line in f)
            for line in lines:
                print(line)
        # 这里，表达式lines = (line.strip() for line in f)的作用是完成数据的转化。它很高效，因为这里并没有先将数据
        # 读取到任何形式的临时列表中。它只是创建一个迭代器，在说有产生的文本行上都会执行strip操作
        # 对于更高级的strip操作，应该转而使用translate()方法。请参见下一节以获得进一步的细节。
        pass

    pass



''' 2.12: 文本过滤和清理 '''
def node2_12():
    def question():
        '''
        问题:某些无聊的脚本小子在 Web 页面表单中填入了'ṕŷt̃h̄o̅n̆'这样的文本我们想以某种方式将其清理掉
        '''
        pass


    def scheme():
        '''
        方案
        '''
        #   文本过滤和清理所涵盖的范围非常广泛，涉及文本解析和数据处理方面的问题。在非常简单的层次上，我们
        # 可能会用到基本的字符串函数（例如 str.upper() 和 str.lower()）将文本转换为标准形式。简单的
        # 替换操作可通过str.replace()或re.sub()来完成，他们把重点放在移除或修改特定的字符序列上。也
        # 可以利用unicodedata.normalize()来规范化文本。

        # 然而我们可能想更近一步。比方说也许想清除整个范围内的字符，或者去掉音符标志。要完成这些任务，可以
        # 使用经常被忽略的str.translate()方法。为了说明其用法，假设有如下这段混乱的字符串:
        s = 'python\fis\tawesome\r\n'

        # 第一步是清理空格。要做到这步，先建立一个小型转换表，然后使用translate()方法：
        remap = {
            ord('\t') : ' ',
            ord('\f') : ' ',
            ord('\r') : None  # Delete
        }
        a = s.translate(remap)
        print(a)
        # 输出: 'python is awesome\n'

        # 可以看到，类似\t和\f这样的空格符已经被重新映射成一个单独的空格。回车符\r已经完全被删除掉
        # 可以利用这种重新映射的思想进一步构建出更庞大的转换表。例如，我们把所有的Unicode组合字符都去掉
        import unicodedata
        import sys
        cmb_chrs = dict.fromkeys(c for c in range(sys.maxunicode) if unicodedata.combining(chr(c)))
        b = unicodedata.normalize('NFD', a)
        print(b)
        # 输出: 'python is awesome\n'

        print(b.translate(cmb_chrs))
        # 输出: 'python is awesome\n'

        # 在这个例子中，我们使用dict.fromkeys()方法构建了一个将每个Unicode组合字符都映射为None的字典
        # 原始输入会通过 unicdoedata.normalize()方法转换为分离形式，然后再通过translate()方法删除所有的重音符号
        # 我们可以利用相似的技术来去掉其他类型的字符（例如控制字符）

        # 下面我们来看另一个例子。这里有一张转换表将所有的Unicode十进制数字字符映射为他们对应的ASCII版本
        digitmap = { c: ord('0') + unicodedata.digit(chr(c))
                     for c in range(sys.maxunicode) if unicodedata.category(chr(c)) == 'Nd'}
        print(len(digitmap))
        # 输出: 580
        # ** 书中为460 **

        x = '\u0661\u0662\u0663'
        print(x.translate(digitmap))
        # 输出: 123

        # 另一种用来清理文本的技术涉及I/O解码和编码函数。大致思路是首先对文本做初步的清理，然后通过encode()和decode()
        # 操作来修改或清理文本。示例如下:
        b = unicodedata.normalize('NFD', a)
        b = b.encode('ascii', 'ignore').decode('ascii')
        print(b)
        # 输出: 'python is awesome\n'

        # 这里的normalize()方法先对原始文本做分解操作。后续的ASCII编码/解码只是简单的一次性丢弃所有不需要的字符
        # 很显然，这种方法只有当我们得最终目标就是ASCII形式的文本才有用。
        pass


    def discuss():
        '''
        讨论
        '''
        # 文本过滤和清理的一个主要问题就是运行时的性能。一般来说操作越简单，运行的就越快。对于简单的替换操作，用str.replace()
        # 通常是最快的方式--即使必须多次调用它也是如此。比方说要清理掉空格符，可以编写如下代码:
        def clean_spaces(s):
            if isinstance(s, str):
                s = s.replace('\r', '')
                s = s.replace('\t', '')
                s = s.replace('\f', '')
            return s
        # 如果试着调用它，就会发现这比使用translate()或者正则表达式要快的多。
        # 另一方面，如果需要做任何高级的操作，比如字符到字符的重映射或删除，那么translate()方法还是非常快的。
        # 从整体上来看，我们应该在具体的应用中取进一步揣摩性能方面的问题。不幸的是，想在技术上给出一条通用的建议是不可能的
        # 所以应该尝试多种不同的方法，然后做性能统计分析。
        # 尽管本节的内容主要关注的是文本，但类似的技术也同样适用于字节对象（byte），这包括简单的替换、翻译和正则表达式。
        pass

    pass



''' 2.13: 对齐文本字符串 '''
def node2_13():
    def question():
        '''
        问题: 我们需要以某种对齐方式将文本做格式化处理
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 对于基本的字符串对齐要求，可以使用字符串的ljsut()、rjust()和center()方法，示例如下:
        text = 'hello world'
        print(text.ljust(20))
        # 输出: 'hello world         '

        print(text.rjust(20))
        # 输出: '         hello world'

        print(text.center(20))
        # 输出: '    hello world     '

        # 所有的方法都可以接受一个可选的填充字符。例如:
        print(text.rjust(20, '='))
        # 输出: '=========hello world'

        print(text.center(20, '*'))
        # 输出: '****hello world*****'

        # format()函数也可以轻松的完成对齐的任务。需要做的就是合理利用'<'、'>'、'^'字符，以及一个期望的宽度值。例如:
        print(format(text, '>20'))
        # 输出: '         hello world'

        print(format(text, '<20'))
        # 输出: 'hello world         '

        print(format(text, '^20'))
        # 输出: '    hello world     '

        # 如果想包含空格之外的填充字符，可以在对齐字符之前指定:
        print(format(text, '=>20s'))
        # 输出: '=========hello world'

        print(format(text, '*^20s'))
        # 输出: '****hello world*****'

        # 当格式化多个值时，这些格式化代码也可以在format()方法中。例如:
        print('{:>10s} {:>10s}'.format('hello', 'world'))
        # 输出: '     hello      world'

        # format()的好处之一是它并不是特定于字符串的。它能作用于任何值。这使得它更加通用。例如，可以对数字做格式化处理:
        x = 1.2345
        print(format(x, '>10'))
        # 输出: '    1.2345'

        print(format(x, '^10.2f'))
        # 输出: '   1.23   '
        pass

    def discuss():
        '''
        讨论
        '''
        # 在较老的代码中，通常会发现%操作符用来格式化文本。例如:
        text = 'hello world'
        print('%-20s' % text)
        # 输出: 'hello world         '

        print('%20s' % text)
        # 输出: '         hello world'

        # 但是在新的代码中，我们应该会更钟情于使用format()函数或方法。format()比%操作符提供的功能要强大的多。此外，format()
        # 可用于任意类型的对象，比字符串的ljust()、rjust()以及center()方法要更加通用。
        # 想了解format()函数的所有功能，请参考Python的在线书册http://docs.python.org/3/libray/string.html#formatspec
        pass
    pass



''' 2.14: 字符串连接及合并 '''
def node2_14():
    def question():
        '''
        问题: 我们想将许多小字符合并成一个大的字符串
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # 如果我们想要合并的字符串在一个序列或可迭代对象中，那么将他们合并起来的最快方法就是使用join()方法。示例如下:
        parts = ['Is', 'Chicago', 'Not', 'Chicago?']
        print(' '.join(parts))
        # 输出: Is Chicago Not Chicago?

        print(','.join(parts))
        # 输出: Is,Chicago,Not,Chicago?

        print(''.join(parts))
        # 输出: IsChicagoNotChicago?

        # 初看上去语法可能显得有些奇怪，但是join()操作其实是字符串对象的一个方法。这么设计的部分原因是因为想要合并一起
        # 的对象可能是来自各种不同的数据序列，比如列表、元组、字典、文件、集合、生成器等。如果单独在每一种序列中实现一个
        # join()方法就显得太冗余了。因此只需要指定想要的分隔字符串，然后在字符串对象上使用join()方法将文本片段粘合在一起就可以了。

        # 如果只是想连接一些字符串，一般使用+操作符就足够完成任务了。
        a = 'Is Chicago'
        b = 'Not Chicago?'
        print(a + ' ' + b)
        # 输出: Is Chicago Not Chicago?

        # 针对更加复杂的字符串格式化操作，+操作符同样可以作为format()的替代，很好的完成任务:
        print('{} {}'.format(a, b))
        # 输出: Is Chicago Not Chicago?

        print(a + ' ' + b)
        # 输出: Is Chicago Not Chicago?

        # 如果打算在源代码中将字符串字面值合并在一起，可以简单的将他们排列在一起，中间不加+操作符，示例如下：
        x = 'Hello' 'World'
        print(x)
        # 输出: HelloWorld
        pass
    
    def discuss():
        '''
        讨论
        '''
        # 字符串连接这个主题可能看起来还没有高级到要用一整洁篇幅来讲解，但是程序员通常会在这个问题上作出错误的选择，使得他们的
        # 代码性能受到影响。

        # 最重要的一点是要意识到使用+操作符做大量的字符串连接是非常低效的，原因是由于内存拷贝和垃圾收集产生的影响。特别是你绝不会
        # 想写出这样的字符串连接:
        parts = ['Is', 'Chicago', 'Not', 'Chicago?']
        a = 'Is Chicago'
        b = 'Not Chicago?'
        s = ''
        for p in parts:
            s += p

        # 这种做法比使用join()方法要慢上许多。主要原因是因为每个+=操作都会创建一个新的额字符串对象。我们最好先收集所有需要连接的
        # 部分，最后再一次性将他们连接起来。

        # 一个相关的技巧（很漂亮的技巧）是利用生成器表达式，在将数据转换为字符串的同时完成连接操作
        data = ['ACME', 50, 91.1]
        print(','.join(str(d) for d in data))
        # 输出: ACME,50,91.1

        # 对于不必要的字符串连接也要引起重视。有时候在技术上并非必须的时候，程序员们也会忘乎所以的使用字符串连接操作。例如在打印的时候:
        print(a + ':' + b)      # 糟糕
        print(':'.join([a, b])) # 依旧糟糕
        print(a, b, sep=':')    # 好的

        # 将字符串连同I/O操作混合起来的时候需要对应用做仔细的分析。例如，考虑下两段代码:
        # Version 1
        # f.write(chunk1 + chunk2)

        # Version 2
        # f.write(chunk1)
        # f.write(chunk2)

        # 如果这两个字符串都很小，那么第一个版本的代码能够带来更好的性能，这是因为执行一次I/O操作系统调用的固有开销就很高。另一
        # 方面，如果这两个字符串都很大，那么第二个版本的代码会更加高效。因为这里避免创建大的临时结果，也没有对大块的内存进行拷贝
        # 这里必须再次强调，你需要对自己的数据做分析，一次才能判断哪一个方法可以获得更好的性能。

        # 最后但也是最重要的是，如果我们编写的代码要从许多短字符串中构建输出，则应该考虑编写生成器函数，通过yield关键字生成字符串片段
        # 代码如下:
        def sample():
            yield 'Is'
            yield 'Chicago'
            yield 'Not'
            yield 'Chicago?'

        # 关于这种方法有一个有趣的事实，那就是它不会假设产生的片段要如何组合在一起。比如说可以用join()将他们简单的连接起来
        # text = ''.join(sample())

        # 或者，也可以将这些片段重新定向到I/O:
        # for part in sample():
        #     f.write(part)

        # 又或者我们能以混合的方式将I/O操作智能化的结合在一起:
        def combine(source, maxsize):
            parts = []
            size = 0
            for part in source:
                parts.append(part)
                size += len(part)
                if size > maxsize:
                    yield ''.join(parts)
                    parts = []
                    size = 0
            yield ''.join(parts)

        # for part in combine(sample(), 32768):
        #     f.write(part)

        # 关键是这里的生成器函数并不需要知道精确的细节，他只是产生片段而已。
        pass
    pass



''' 2.15: 给字符串中的变量名做插值处理 '''
def node2_15():
    def question():
        '''
        问题: 我们想创建一个字符串，其中嵌入的变量名称会以字符串的值形式替换掉。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # Python并不支持在字符串中对变量做简单的值替换。但是，这个功能可以通过字符串的format()方法近似的模拟出来。示例如下:
        s = '{name} has {n} message'
        print(s.format(name='Guido', n=37))
        # 输出: Guido has 37 message

        # 另一种方式是，如果要被替换的变量的值确实能再变量中找到，则可以将format_map()和vars()联合起来使用，示例如下:
        name = 'Guido'
        n = 37
        print(s.format_map(vars()))
        # 输出: Guido has 37 message

        # 有关vars()的一个微妙特性是它也能作用于类实例上。比如:
        class Info:
            def __init__(self, name, n):
                self.name = name
                self.n = n
        a = Info('Guido', 37)
        print(s.format_map(vars(a)))
        # 输出: Guido has 37 message

        # 而format()和format_map()的一个缺点则是没有办法优雅地处理缺少某个值的情况。例如:
        # print(s.format(name='Guido'))
        # 输出:
        # Traceback (most recent call last):
        #   File "part_2.py", line 679, in <module>
        #     node2_15()
        #   File "part_2.py", line 670, in node2_15
        #     scheme()
        #   File "part_2.py", line 666, in scheme
        #     print(s.format(name='Guido'))
        # KeyError: 'n'

        # 避免出现这种情况的一种方法就是单独定义一个带有__missing__()方法的字典类，示例如下:
        class safesub(dict):
            def __missing__(self, key):
                return '{' + key + '}'

        # 现在用这个类来包装传给format_map()的输入参数:
        del n
        print(s.format_map(safesub(vars())))
        # 输出: Guido has {n} message

        # 如果发现自己在代码中常常需要执行这些步骤，则可以将替换变量的过程隐藏在一个小型的功能函数内， 这里要采用一种称之为
        # 'frame hack'的技巧（即需要同函数的帧栈打交道。sys._getframe这个特殊的函数可以让我们获得调用函数的栈信息）。示例如下:
        import sys
        def sub(text):
            return text.format_map(safesub(sys._getframe(1).f_locals))

        # 现在我们可以这样编写代码了:
        name = 'Guido'
        n = 37
        print(sub('Hello {name}'))
        # 输出: Hello Guido

        print(sub('You Have {n} message'))
        # 输出: You Have 37 message

        print(sub('Your favorite color is {color}'))
        # 输出: Your favorite color is {color}
        pass


    def discuss():
        '''
        讨论
        '''
        # 多年来由于Python缺乏真正的变量插值功能，由此产生了各种解决方案。作为本节中已给出的解决方案的替代，有时候我们会
        # 看到类似下面代码中的字符串格式化操作:
        name = 'Guido'
        n = 37
        # a = '%(name) has %(n) messages.' % vars()
        # print(a)
        # 输出: 在Python3.0中输出错误信息 unsupported format character 'm' (0x6d) at index 17
        # 书中输出: 'Guido has 37 messages.'

        # 我们还可能看到模板字符串(template string)的使用:
        import string
        s = string.Template('$name has $n message.')
        print(s.substitute(vars()))
        # 输出: Guido has 37 message.

        # 但是format()和format_map()方法比上面这些替代方案都要更加现代化，我们应该将其作为首选。使用format()的一个好处是
        # 可以同时得到所有关于字符串格式化方面的功能（对齐、填充、数值格式化等），而这些功能在字符串模板对象上是不可能做到的。

        # 在本节的部分内容中还提到了一些有趣的高级特性。字典类中鲜为人知的__missing__()方法可用来处理缺少值得行为。在safesub
        # 类中，我们将该方法定义为将缺失的值以占位符的形式返回，因此这里不会抛出KeyError异常，缺少的那个值会出现在最后生成的字符串
        # 中（可能会对调试有些帮助）

        # sub()函数使用了sys._getframe(1)来返回调用方的栈帧。通过访问属性f_locals来得到局部变量。无需赘言，在大部分代码中都应该
        # 避免去和栈帧打交道，但是对于类似完成字符串替换功能的函数来说，这回非常有用。插一句题外话，值得指出的是f_locals是一个字典，
        # 它完成对调用函数中局部变量的拷贝。尽管可以修改f_locals的内容，可是修改后并不会产生任何持续性的效果。因此，尽管访问不同的栈帧
        # 可能看起来是很邪恶的，但是想意外的覆盖或者修改调用方的本地环境也是不可能的。
        pass
    pass



''' 2.16: 以固定的列数重新格式化文本 '''
def node2_16():
    def question():
        '''
        问题: 我们有一些很长的字符串，想将它们重新格式化，使得他们能按照用户指定的列数来显示。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 可以使用textwarp模块来重新格式化文本的输出。例如，假设我们有如下这段长字符串:
        s = "Look into my eyes, Look into my eyes, the eyes, the eyes" \
            "the eyes, not around the eyes, don't look around the eyes," \
            "look into my eyes, you're under."

        # 这里可以用textwarp模板以多种方式来重新格式化字符串:
        import textwrap
        print(textwrap.fill(s, 70))
        # 输出: Look into my eyes, Look into my eyes, the eyes, the eyesthe eyes, not
        #      around the eyes, don't look around the eyes,look into my eyes, you're
        #      under.

        print(textwrap.fill(s, 40))
        # 输出: Look into my eyes, Look into my eyes,
        #      the eyes, the eyesthe eyes, not around
        #      the eyes, don't look around the
        #      eyes,look into my eyes, you're under.

        print(textwrap.fill(s, 40, initial_indent='  '))
        # 输出:   Look into my eyes, Look into my eyes,
        #      the eyes, the eyesthe eyes, not around
        #      the eyes, don't look around the
        #      eyes,look into my eyes, you're under.

        print(textwrap.fill(s, 40, subsequent_indent='  '))
        # 输出: Look into my eyes, Look into my eyes,
        #        the eyes, the eyesthe eyes, not around
        #        the eyes, don't look around the
        #        eyes,look into my eyes, you're under.
        pass

    def discuss():
        '''
        讨论
        '''
        # textwarp模块能够以简单直接的方式对文本格式做整理使其适合于打印————尤其是当希望输出结果能很好的显示在终端
        # 上时，关于终端尺寸的大小，可以通过 os.get_terminal_size()来获取，例如:
        import os
        print(os.get_terminal_size().columns)

        # fill方法还有一些额外的选项可以来控制如何处理制表符、句号等。请参阅textwarp.TextWrapper类的文档
        # （http://docs.python.org/3.3/library/textwrap/html#text wrap.TextWrapper）以获得进一步细节
        pass
    pass



''' 2.17: 在文本中处理HTML和XML实体 '''
def node2_17():
    def question():
        '''
        问题: 我们想将&entity或&#code这样的HTML或XML实体替换为他们相对应的文本，或者我们需要生成文本
             但是要对待特定的字符（比如<,>或者&）做转义处理
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 如果要生成文本，使用html.escape()函数来替换< or >这样的特殊字符相对来说是比较容易的。例如:
        s = 'Elements are written as "<tag>text</tag>".'
        import html
        print(s)
        # 输出: Elements are written as "<tag>text</tag>".

        print(html.escape(s))
        # 输出: Elements are written as &quot;&lt;tag&gt;text&lt;/tag&gt;&quot;.

        # Disable escaping of quotes
        print(html.escape(s, quote=False))
        # 输出: Elements are written as "&lt;tag&gt;text&lt;/tag&gt;".

        # 如果生成ASCII文本，并且向针对非ASCII字符将他们对应的字符编码实体嵌入到文本中，可以再各种同I/O相关的函数中使用
        # errors='xmlcharrefreplace'参数来实现。示例如下:
        s = 'Spicy Jalapeño'
        print(s.encode('ascii', errors='xmlcharrefreplace'))
        # 输出: b'Spicy Jalape&#241;o'

        # 要替换文本中的实体，那就需要不同的方法。如果实际上是在处理HTML或XML，首先应该尝试使用一个合适的HTML或XML解析器。
        # 一般来说，这些工具在解析过程中会自动处理相关的值替换，而我们完全无需为此操心。

        # 如果由于某种原因在得到的文本中带有一些实体，而我们想手工将他们替换掉，通常可以利用各种HTML或XML解析器自带的功能
        # 函数和方法来完成。示例如下:
        s = 'Spicy &quot;Jalape&#241;o&quot.'
        from html.parser import HTMLParser
        import html
        p = HTMLParser()
        print(p.unescape(s))
        print(html.unescape(s))  # in 3.5, use html.unescape() instead.
        # 输出: Spicy "Jalapeño".

        t = 'The Prompt is &gt;&gt;&gt;'
        from xml.sax.saxutils import unescape
        print(unescape(t))
        # 输出: The Prompt is >>>
        pass


    def discuss():
        '''
        讨论
        '''
        # 在生成HTML或XML文档时，适当地对特殊字符做转义处理常常是个容易忽视的细节。尤其是当自己用print()或其他一些节本的
        # 字符串格式化函数来产生这类输出时更是如此。简单的解决方案是使用想html.escape()这样的工具函数。

        # 如果需要反过来处理文本（即将HTML或XML实体转换成对应的字符），有许多想xml.sax.saxutils.unescape()这样的工具
        # 函数能帮上忙。但是，我们需要仔细考察一个合适的解析器应该如何使用。例如，如果是处理HTML或XML，像html.parser或
        # xml.etree.ElementTree这样的模块应该已经解决了有关替换文本中实现的细节问题
        pass
    pass



''' 2.18: 文本分词 '''
def node2_18():
    def question():
        '''
        问题: 我们有一个字符串，想从左到右将它解析为标准流（stream of tokens）。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 假设有如下的字符串文本:
        text = 'foo = 23 + 42 * 10'

        # 要对字符串做分词处理，需要做的不仅仅只是匹配模式。我们还需要有某种方法来识别出模式的类型。例如，我们可能想将字符串
        # 转换为如下的序列对:
        tokens = [('NAME', 'foo'),
                  ('EQ', '='),
                  ('NUM', '23'),
                  ('PLUS', '+'),
                  ('NUM', '42'),
                  ('TIMES', '*'),
                  ('NUM', '10')]
        # 要完成这样的分词处理，第一步是定义出所有可能的标记，包括空格。这可以通过正则表达式中的命名捕获组来实现，示例如下:
        import re
        NAME = r'(?P<NAME>[a-zA-Z_][a-zA-Z_0-9]*)'
        NUM = r'(?P<NUM>\d+)'
        PLUS = r'(?P<PLUS>\+)'
        TIMES = r'(?P<TIMES>\*)'
        EQ = r'(?P<EQ>\=)'
        WS = r'(?P<WS>\s+)'
        master_pat = re.compile('|'.join([NAME, NUM, PLUS, TIMES, EQ, WS]))
        print(master_pat)
        # 输出: re.compile('(?P<NAME>[a-zA-Z_][a-zA-Z_0-9]*)|(?P<NUM>\\d+)|(?P<PLUS>\\+)|(?P<TIMES>\\*)|(?P<EQ>\\=)|(?P<WS>\\s+)')

        # 在这些正则表达式模式中，形如?P<TOKENNAME>这样的预订是用来将名称分配给该模式的。这个我们稍后会用到。
        # 接下来我们使用模式对象的scanner()方法来完成分词操作。该方法会创建一个扫描对象，在给定的文本中重复调用match()对象
        # 一次匹配一个模式。

        # 要利用这项技术将其转换为代码，我们可以做些清理工作然后轻松的将其包含在一个生成器函数中，示例如下:
        from collections import namedtuple
        Token = namedtuple('Token', ['type', 'value'])
        def generate_tokens(pat, text):
            scanner = pat.scanner(text)
            for m in iter(scanner.match, None):
                yield Token(m.lastgroup, m.group())

        for token in generate_tokens(master_pat, 'foo = 42'):
            print(token)
        # 输出: Token(type='NAME', value='foo')
        #      Token(type='WS', value=' ')
        #      Token(type='EQ', value='=')
        #      Token(type='WS', value=' ')
        #      Token(type='NUM', value='42')

        # 如果想以魔种方式对标记流做过滤处理，那么定义更多的生成器函数，要么就用生成器表达式。例如，下面的代码告诉
        # 我们如何能过滤掉所有的空格标记。
        tokens = (tok for tok in generate_tokens(master_pat, text)
                  if tok.type != 'WS')
        for token in tokens:
            print(token)
        # 输出: Token(type='NAME', value='foo')
        #      Token(type='EQ', value='=')
        #      Token(type='NUM', value='23')
        #      Token(type='PLUS', value='+')
        #      Token(type='NUM', value='42')
        #      Token(type='TIMES', value='*')
        #      Token(type='NUM', value='10')
        pass


    def discuss():
        '''
        讨论
        '''
        # 对于更高级的文本解析，第一步往往是分词处理。要使用上面展示的文本扫描技术，有几个重要的细节需要牢记于心。第一
        # 对于每个出现在输入文本中的文本序列，都要确保有一个对应的正则表达式模式可以将其识别出来。如果发现有任何不能匹配的
        # 文本扫描过程就会停止。这就是为什么有必要再上面的示例中指定空格标记（WS）

        # 这些标记在正则表达式（即re.compile('|'.join([NAME, NUM, PLUS, TIMES, EQ, WS]))）中的顺序也很重要。当
        # 进行匹配时，re模块hi按照指定的顺序来对模式做匹配。如果碰巧某个模式是另一个较长模式的子串时，就必须确保较长的按个模
        # 式要先做匹配。示例如下:
        import re
        LT = r'(?P<LT><)'
        LE = r'(?P<LE><=)'
        EQ = r'(?P<EQ>=)'
        master_pat = re.compile('|'.join([LE, LT, EQ]))     # Correct
        # master_pat = re.compile('|'.join([LT, LE, EQ]))   # Incorrect

        # 第二个模式是错误的（注释掉的那一行），因为这样会把文本'<='匹配为LT('<')紧跟着EQ('='),而没有匹配为单独的标记LE('<=')
        # 这与我们得意愿不符。

        # 最后也是最重要的是，对于有可能形成子串的模式要多加小心。例如假设有如下两种模式:
        from collections import namedtuple
        Token = namedtuple('Token', ['type', 'value'])
        def generate_tokens(pat, text):
            scanner = pat.scanner(text)
            for m in iter(scanner.match, None):
                yield Token(m.lastgroup, m.group())

        PRINT = r'(?P<PRINT>print)' # 书中少写'?'
        NAME = r'(?P<NAME>[a-zA-Z_][a-zA-Z_0-9]*)' # 书中少写'?'
        master_pat = re.compile('|'.join([PRINT, NAME]))
        for tok in generate_tokens(master_pat, 'printer'):
            print(tok)
        # 输出: Token(type='PRINT', value='print')
        #      Token(type='NAME', value='er')

        # 对于更加高级的分词处理，我们应该去看看想PyParsing 或 PLY 这样的包，有关PLY的例子将在下一节中讲解。
        pass
    pass



''' 2.19: 编写一个简单的递归下降解析器 '''
def node2_19():
    def question():
        '''
        问题: 我们需要根据一组语法规则来解析文本，以此执行相应的操作或构建一个抽象的语法树来表示输入。
             语法规则很简单，因此我们倾向于自己编写解析器而不是使用某种解析器框架
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 在这个问题中，我们把重点放在根据特定的语法来解析文本上。要做到这些，应该以BNF或EBNF的形式定义出语法的正式规格。
        # 比如，对于简单的算术运算表达式，语法看起来是这样的。
        # expr ::= expr + term
        #      | expr - term
        #      | term

        # term ::= term * factor
        #      | term / factor
        #      | factor

        # factor ::= (expr)
        #        | NUM

        # 或者以EBNF的形式定义为如下形式:
        # expr ::= term { (+|-) term }*
        # term ::= factor { (*|/) factor }*
        # factor ::= (expr) | NUM

        # 在EBNF中，部分包括在{...}*中的规则是可选的。 *意味着零个或者更多重复项（和在正则表达式中的意义相同）。
        # 现在，如果我们队BNF还不熟悉的话，可以把它看作是规则替换或取代的一种规范形式，左侧的符号可以被右侧的符号所取代（反之亦然）
        # 一般来说，在解析的过程中我们会尝试输入的文本同语法做匹配，通过BNF来完成个各种替换和扩展。为了说明，假设正在解析一个类似于
        # 3+4*5这样的表达式。这个表达式首先应该被分解为标记流，这可以使用2.18节中描述的技术实现。得到的结果可能是这个样子:
        # NUM + NUM * NUM

        # 从这里开始，解析过程就设计通过替换的方式将语法匹配到输入标记上:
        # expr
        # expr ::= term { (+|-) term }*
        # expr ::= factor { (*|/) factor }* { (+|-) term }*
        # expr ::= NUM { (*|/) factor }* { (+|-) term }*
        # expr ::= NUM { (+|-) term }*
        # expr ::= NUM + term { (+|-) term }*
        # expr ::= NUM + factor { (*|/) factor }* { (+|-) term }*
        # expr ::= NUM + NUM { (*|/) factor }* { (+|-) term }*
        # expr ::= NUM + NUM * factor { (*|/) factor }* { (+|-) term }*
        # expr ::= NUM + NUM * NUM { (*|/) factor }* { (+|-) term }*
        # expr ::= NUM + NUM * NUM { (+|-) term }*
        # expr ::= NUM + NUM * NUM

        # 完成所有的替换需要花上一段时间，这是由输入的规模和尝试去匹配的语法规则所决定的。第一个输入标记是一个NUM，因此替换操作首先
        # 会把重点放在匹配这一部分上。一旦匹配上了，重点就转移到下一个标记+上，如此往复。当发现无法匹配下一个标记时。右手侧的特定部分
        # （ {(*/)factor}* ）就会消失。在一个成功的解析过程中，整个右手侧部分会完全根据匹配到的输入标记流来相应的扩展

        # 有了前面这些基础，下面就向各位展示如何构建一个递归下降的表达式计算器。
        import re
        import collections

        # Token specification
        NUM = r'(?P<NUM>\d+)'
        PLUS = r'(?P<PLUS>\+)'
        MINUS = r'(?P<MINUS>-)'
        TIMES = r'(?P<TIMES>\*)'
        DIVIDE = r'(?P<DIVIDE>/)'
        LPAREN = r'(?P<LPAREN>\()'
        RPAREN = r'(?P<RPAREN>\))'
        WS = r'(?P<WS>\s+)'
        master_pat = re.compile('|'.join([NUM, PLUS, MINUS, TIMES, DIVIDE, LPAREN, RPAREN, WS]))

        # Tokenizer
        Token = collections.namedtuple('Token', ['type', 'value'])
        def generate_tokens(text):
            scanner = master_pat.scanner(text)
            for m in iter(scanner.match, None):
                tok = Token(m.lastgroup, m.group())
                if tok.type != 'WS':
                    yield tok

        # Parser
        class ExpressionEvaluator:
            '''
            Implementation of a recursive descent parser. Each method implements a single grammar rule.
            Use the ._accept() method to test and accept the current lookahead token. Use the ._expect()
            method to exactly match and discard the next token on on the input (or raise a SyntaxError
            if it doesn't match)
            '''
            def parser(self, text):
                self.tokens = generate_tokens(text)
                self.tok = None         # Last symbol consumed
                self.nexttok = None     # Next symbol tokenized
                self._advance()         # Load first lookahead token
                return self.expr()

            def _advance(self):
                'Advance one token ahead'

                self.tok, self.nexttok = self.nexttok, next(self.tokens, None)

            def _accept(self, toktype):
                'Test and consume the next token if it matches toktype'

                if self.nexttok and self.nexttok.type == toktype:
                    self._advance()
                    return True
                else:
                    return False

            def _expect(self, toktype):
                'Consume next token if it match toktype or raise SyntaxError'

                if not self._accept(toktype):
                    raise SyntaxError('Expected' + toktype)

            def expr(self):
                "expression ::= term { ('+'|'-') term }*"

                exprval = self.term()
                while self._accept('PLUS') or self._accept('MINUS'):
                    op = self.tok.type
                    right = self.term()
                    if op == 'PLUS':
                        exprval += right
                    elif op == 'MINUS':
                        exprval -= right
                return exprval

            def term(self):
                "term ::= factor { ('*'|'/') factor }*"

                termval = self.factor()
                while self._accept('TIMES') or self._accept('DIVIDE'):
                    op = self.tok.type
                    right = self.factor()
                    if op == 'TIMES':
                        termval *= right
                    elif op == 'DIVIDE':
                        termval /= right
                return termval

            def factor(self):
                "factor ::= NUM | ( expr )"

                if self._accept('NUM'):
                    return int(self.tok.value)
                elif self._accept('LPAREN'):
                    exprval = self.expr()
                    self._expect('RPAREN')
                    return exprval
                else:
                    raise SyntaxError('Expected NUMBER or LPAREN')

        # 下面是以交互式的方式使用ExpressionEvaluator类的实例
        e = ExpressionEvaluator()
        print(e.parser('2'))
        # 输出: 2

        print(e.parser('2+ 3'))
        # 输出: 5

        print(e.parser('2 + 3 * 4'))
        # 输出: 14

        print(e.parser('2 + (3 + 4) * 5'))
        # 输出: 37

        # print(e.parser('2 + (3 + * 4)'))
        # 输出: SyntaxError: Expected NUMBER or LPAREN

        # 如果我们想做的不只是纯粹的计算，那就需要修改ExpressionEvaluator类来实现，比如下面的实现构建了一颗简单的解析树:
        class ExpressionTreeBuilder(ExpressionEvaluator):
            def expr(self):
                "expression ::= term { ('+'|'-') term }"

                exprval = self.term()
                while self._accept('PLUS') or self._accept('MINUS'):
                    op = self.tok.type
                    right = self.term()
                    if op == 'PLUS':
                        exprval = ('+', exprval, right)
                    elif op == 'MINUS':
                        exprval = ('-', exprval, right)
                return exprval

            def term(self):
                "term ::= factor { ('*'|'/') factor }"

                termval = self.factor()
                while self._accept('TIMES') or self._accept('DIVIDE'):
                    op = self.tok.type
                    right = self.factor()
                    if op == 'TIMES':
                        termval = ('*', termval, right)
                    elif op == 'DIVIDE':
                        termval = ('/', termval, right)
                return termval

            def factor(self):
                'factor ::= NUM | (expr)'

                if self._accept('NUM'):
                    return int(self.tok.value)
                elif self._accept('LPAREN'):
                    exprval = self.expr()
                    self._expect('RPAREN')
                    return exprval
                else:
                    raise SyntaxError('Expected NUMBER or LPAREN')

        # 下面展示了它是如何工作的:
        e = ExpressionTreeBuilder()

        print(e.parser('2 + 3'))
        # 输出: ('+', 2, 3)

        print(e.parser('2 + 3 * 4'))
        # 输出: ('+', 2, ('*', 3, 4))

        print(e.parser('2 + (3 + 4) * 5'))
        # 输出: ('+', 2, ('*', ('+', 3, 4), 5))

        print(e.parser('2 + 3 + 4'))
        # 输出: ('+', ('+', 2, 3), 4)
        pass


    def discuss():
        '''
        讨论
        '''
        # 文本解析是一个庞大的主题，一般会占用学生们编译原理课程的前三周时间。如果你正在寻找有关语法、解析算法和其他相关
        # 信息的背景知识，那么应该去找一本编译器方面的图书来读。无需赘言，本书是不会重复那些内容的。

        # 然而，要编写一个递归下降的解析器，总体思路还是比较简单的。我们要将每一条语法规则转变为一个函数或方法。因此，如果
        # 我们的语法看起来是这样子的:

        # expr ::= term { ('+'|'-') term }*
        # term ::= factor { ('*'|'/') factor }*
        # factor ::= '(' expr ')' | NUM

        # 就可以像下面这样将它们转换为对应的方法:
        # class ExpressionEvaluator:
        #     ...
        #     def expr(self):
        #         ...
        #     def term(self):
        #         ...
        #     def factor(self):
        #         ...

        # 每个方法的任务很简单--必须针对语法规则的每个部分从左到右扫描，在扫描过程中处理符号标记。从某种意义上说，这些方法的目的就是
        # 顺利的将规则消化掉，如果卡住了就产生一个语法错误。要做到这点，需要应用下面这些实现技术:

        # 1.如果规则中的下一个符号标记是另一个语法规则的名称（例如，term或者factor）就需要调用同名的方法。这就是算法中的'下降'部分--控制
        #   其下降到另一个语法规则中。有时候规则中会设计调用已经在执行的方法（例如，在规则factor ::= '(' expr ')' 中对expr的调用）。
        #   这就是算法中的递归部分。

        # 2.如果规则中的下一个符号标记是一个特殊的符号（例如'('），需要检查下一个标记，看它们是否能完全匹配。如果不能匹配，这就是语法错误
        #   本节给出的_expect()方法就是用来处理这些步骤的。

        # 3.如果规则中的下一个符号标记存在多种可能的选择（例如+或-），则必须针对每种可能性对下一个标记做检查，只有在有匹配满足时才能进到
        #   下一步。这就是本节给出_accept()方法的目的所在。这有点像_except()的弱化版，在_accept()中如果有匹配满足，就前进到下一步
        #   如果没有匹配，他只是简单的回退而不会引发一个错误（这样检查才可以继续进行下去）。

        # 4.对于语法规则中出现的重复部分（例如 expr ::=term { ('+'|'-')term }* ）,这是通过while循环来实现的。一般在循环体中手机或
        #   处理所有的重复项，知道无法找到更多的重复项为止。

        # 5.一旦整个语法规则都已经处理完，每个方法就返回一些结果给调用者。这就是在解析过程中将值进行传递的方法。比如，在计算器表达式中，表达式
        #   解析的部分会作为值来返回。最终他们会结合在一起，在最顶层的语法规则方法中得到执行。

        # 尽管本节给出的例子很简单，但递归下降解析器可以用来实现相当复杂的解析器。例如，Python代码本身是通过一个递归下降解析器来解释的
        # 如果对此很感兴趣，可以通过Python源代码中的Grammar/Grammar文件来一探究竟。即便如此，要自己手写一个解析器时仍然需要面对各种
        # 陷阱和局限

        # 局限之一就是对于任何涉及左递归形式的语法规则，都没法用递归下降解析器来解决。例如，假设需要解释如下的规则:
        # item ::= item ',' item
        #       | item

        # 要完成这样的解析我们可能会试着这样定义items()方法
        # def items(self):
        #     itemsval = self.items()
        #     if itemsval and self._accept(','):
        #         itemsval.append(self.items())
        #     else:
        #         itemsval = [self.items()]

        # 唯一的问题就是这样做行不通。实际上会产生一个无穷递归的错误。

        # 我们也可能会陷入到语法规则自身的麻烦中。例如，我们可能想知道表达式是否能以这种加简单的语法形式来描述:
        # expr ::= factor { ('+'|'-'|'*'|'/') factor }*
        # factor ::= '(' expression ')'
        #         | NUM

        # 这个语法从技术上来说是可能实现的。但是他却并没有遵守标准算数中关于计算顺序的约定。比如说，表达式'3 + 4 * 5'会被计算为35，
        # 而不是我们期望的23。因此这里需要单独的'expr'和'term'规则来确保计算结果的正确性。

        # 对于真正复杂的语法解析，最好还是使用像PyParsing或PLY这样的解析工具。如果使用PLY的话，解析表达式的代码看起来是这样的:

        from ply.lex import lex
        from ply.yacc import yacc

        # TokenList
        tokens = ['NUM', 'PLUS', 'MINUS', 'TIMES', 'DIVIDE', 'LPAREN', 'RPAREN']

        # Ignored charactes
        t_ignore = ' \t\n'

        # Token specifications (as regexs)
        t_PLUS = r'\+'
        t_MINUS = r'-'
        t_TIMES = r'\*'
        t_DIVIDE = r'/'
        t_LPAREN = r'\('
        t_RPAREN = r'\)'

        # Token processing functions
        def t_NUM(t):
            r'\d+'
            t.value = int(t.value)
            return t

        # Error handler
        def t_error(t):
            print('Bad character: {!r}'.format(t.value[0]))
            t.skip(1)

        # Build the lexer
        lexer = lex()

        # Grammar rules and handler functions
        def p_expr(p):
            '''
            expr : expr PLUS term
            | expr MINUS term
            '''
            if p[2] == '+':
                p[0] = p[1] + p[3]
            elif p[2] == '-':
                p[0] = p[1] - p[3]

        def p_expr_term(p):
            '''
            expr : term
            '''
            p[0] = p[1]

        def p_term(p):
            '''
            term : term TIMES factor
                 | term DIVIDE factor
            '''
            if p[2] == '*':
                p[0] = p[1] * p[3]
            elif p[2] == '/':
                p[0] = p[1] / p[3]

        def p_term_factor(p):
            '''
            term : factor
            '''
            p[0] = p[1]

        def p_factor(p):
            '''
            factor : NUM
            '''
            p[0] = p[1]

        def p_factor_group(p):
            '''
            factor : LPAREN expr RPAREN
            '''
            p[0] = p[2]

        def p_error(p):
            print('Syntax error')

        parser = yacc()
        print(parser.parse('2'))
        # 输出: 2

        print(parser.parse('2 + 3'))
        # 输出: 5

        print(parser.parse('2 + (3 + 4) * 5'))
        # 输出: 37

        # 如果想在编程中增加一点激动兴奋的感觉，编写解析器和编译器会是非常有趣的课题。再次说明，一本编译器方面的教科书会涵盖许多理论之下
        # 的许多底层细节。但是在网上同样也能找到需要优秀的在线资源。Python自带的ast模块也同样值得去看看。
        pass
    pass



''' 2.20: 在字节串上执行文本操作 '''
def node2_20():
    def question():
        '''
        问题: 我们想在字节串（Byte String）上执行常见的文本操作（例如拆分、搜索和替换）
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 字节串已经支持大多数和文本字符串一样的内建操作。例如:
        data = b'Hello world'

        print(data[0:5])
        # 输出: b'Hello'

        print(data.startswith(b'Hello'))
        # 输出: True

        print(data.split())
        # 输出: [b'Hello', b'world']

        print(data.replace(b'Hello', b'Hello Cruel'))
        # 输出: b'Hello Cruel world'

        # 类似这样的操作在字节数组上也能完成:
        data = bytearray(b'Hello World')
        print(data[0:5])
        # 输出: bytearray(b'Hello')

        print(data.startswith(b'Hello'))
        # 输出: True

        print(data.split())
        # 输出: [bytearray(b'Hello'), bytearray(b'World')]

        print(data.replace(b'Hello', b'Hello Cruel'))
        # 输出: bytearray(b'Hello Cruel World')

        # 我们可以再字节串上执行正则表达式的模式匹配操作，但是模式本身需要以字节串的形式来指定。示例如下:
        data = b'FOO:BAR,SPAM'
        import re

        # print(re.split('[:,]', data))
        # 输出: TypeError: cannot use a string pattern on a bytes-like object

        print(re.split(b'[:,]', data))
        # 输出: [b'FOO', b'BAR', b'SPAM']
        pass


    def discuss():
        '''
        讨论
        '''
        # 就绝大部分情况而言，几乎所有能在文本字符串上执行的操作同样也可以再字符串上进行。但是，还是有几个显著的区别值得大家注意。例如:
        a = 'Hello World' # Text string
        print(a[0])
        # 输出: H

        print(a[1])
        # 输出: e

        b = b'Hello World' # Byte string
        print(b[0])
        # 输出: 72

        print(b[1])
        # 输出: 101

        # 这种语义上的差异会对师徒按照字符的方式处理面向字节流数据的程序带来影响

        # 其次，字节串并没有提供一个漂亮的字符串表示，因此打印结果并不干净利落，除非首先将其解码为文本字符串。示例如下:
        s = b'Hello world'
        print(s)
        # 输出: b'Hello world'

        print(s.decode('ascii'))
        # 输出: Hello world

        # 同样道理，在字节串上是没有普通字符串那样的格式化操作的。
        # 如果想在字节串上做任何形式的格式化操作，应该使用普通的文本字符串然后再做编码。
        # 最后需要注意的是使用字节串会改变某些特定操作的语义--尤其是那些与文件系统相关的操作。例如，如果提供一个以字节而不是文本字符串
        # 来编码的文件名，文件系统通常都会禁止对文件名的编码/解码。

        # 最后要说的是，有些程序员可能会因为性能上有可能得到提升而倾向于将字节串作为文本字符串的替代来使用。尽管操纵字节确实要比文本来的
        # 略微高效一些（由于同Unicode相关的固有开销很高），但这么做通常会导致非常混乱和不符合语言习惯的代码。我们常会发现字节串和python
        # 中许多其他部分并不能很好的相容，这样为了保证结果的正确性，我们只能手动去执行各种各样的编码/解码操作。坦白的说，如果要同文本打
        # 交道，在程序中使用普通的文本字符串就好，不要使用字节串。
        pass
    pass