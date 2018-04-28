#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
cookbook 第3章 [数字、日期和时间]

3.1: 对数值进行取整
3.2: 执行精确的小数计算
3.3: 对数值做格式化输出
3.4: 同二进制、八进制和十六进制数打交道
3.5: 从字节串中打包和解包大整数
3.6: 复数运算
3.7: 处理无穷大和NaN
3.8: 分数的计算
3.9: 处理大型数组的计算
3.10: 矩阵和线性代数的计算
3.11: 随机选择
3.12: 时间换算
3.13: 计算上周5的日期
3.14: 找出当月的日期范围
3.15: 将字符串转换为日期
3.16: 处理涉及时区的时间问题

"""



''' 3.1: 对数值进行取整 '''
def node3_1():
    def question():
        '''
        问题: 我们想将一个浮点数取整到固定小数位。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # 对于简单的取整操作，使用內建的round(value, ndigits)函数即可。示例如下:
        print(round(1.23, 1))
        # 输出: 1.2

        print(round(1.27, 1))
        # 输出: 1.3

        print(round(-1.27, 1))
        # 输出: -1.3

        print(round(1.25361, 3))
        # 输出: 1.254

        # 当某个值恰好等于两个整数间的一半时，取整操作会取到离该值最近的那个偶数上。也就是说，像1.5或2.5这样的值都会取整到2。
        print(round(1.5, 0), round(2.5, 0))
        # 输出: 2.0 2.0

        # 传递给round()的参数ndigits可以是负数，在这种情况下会相应地取整到十位、百位、千位等。示例如下:
        a = 1627731
        print(round(a, -1))
        # 输出: 1627730

        print(round(a, -2))
        # 输出: 1627700

        print(round(a, -3))
        # 输出: 1628000
        pass
    
    
    def discuss():
        '''
        讨论
        '''
        # 在对值进行输出时别把取整和格式化操作混为一谈，如果只是将数值以固定的位数输出，一般来说用不着round()的。相反只要在
        # 格式化时指定所需要的精度就可以了。示例如下:
        x = 1.23456
        print(format(x, '0.2f'))
        # 输出: 1.23

        print(format(x, '0.3f'))
        # 输出: 1.235

        print('value is {:0.3f}'.format(x))
        # 输出: value is 1.235

        # 此外，不要采用对浮点数取整的方式来'修正'精度上的问题。比如我们可能会倾向于这样做:
        a = 2.1
        b = 4.2
        c = a + b
        print(c)
        # 输出: 6.300000000000001

        c = round(c, 2)
        print(c)
        # 输出: 6.3

        # 对于大部分设计浮点数的应用程序来说，一般来讲都不必（或者说不推荐）这么做。尽管这样会引入一些小误差，但这些误差是可以理解的，
        # 也是可以容忍的。如果说避免出现误差的行为非常重要（例如在金融类应用中），那么可以考虑使用decimal模块，这也正是下一模块的主题。
        pass
    
    pass



''' 3.2: 执行精确的小数计算 '''
def node3_2():
    def question():
        '''
        问题: 我们需要对小数进行精度计算，不希望因为浮点数天生的误差而带来影响。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 关于浮点数，一个尽人皆知的问题就是他们无法精确的表达出所有的十进制小数位。此外，甚至连简单的数学计算也会引入微小的误差。例如:
        a = 2.1
        b = 4.2
        c = a + b
        print(c)
        # 输出: 6.300000000000001

        print(c == 6.3)
        # 输出: False

        # 这些误差实际上是底层CPU的浮点运算单元和IEEE 754浮点数算数标准的一种'特性'，由于python的浮点数类型保存的数据采用的是原始表示
        # 形式，因此如果编写的代码如果用到了float实例，那就无法避免这样的误差。

        # 如果期望得到更高的经度（并愿意为此牺牲掉一些性能），可以使用decimal模块
        from decimal import Decimal
        a = Decimal('4.2')
        b = Decimal('2.1')
        print(a + b)
        # 输出: 6.3

        print(a+b == Decimal('6.3'))
        # 输出: True

        # 这么做初看起来似乎有点怪异（将数字以字符串的形式来指定）。但是，Decimal对象能以任何期望的方式来工作（支持所有常见的数学操作）。
        # 如果要将它们打印出来或是在字符串格式化函数中使用，它们看起来就和普通的数字一样。

        # decimal模块的主要功能是允许控制计算过程的各个方面，这包括数字的位数和四舍五入。要做到这些，我们需要创建一个本地的上下文环境
        # 然后修改其设定。示例如下:
        from  decimal import localcontext
        a = Decimal('1.3')
        b = Decimal('1.7')
        print(a / b)
        # 输出: 0.7647058823529411764705882353

        with localcontext() as ctx:
            ctx.prec = 3
            print(a / b)
            # 输出: 0.765

        with localcontext() as ctx:
            ctx.prec = 50
            print(a / b)
            # 输出: 0.76470588235294117647058823529411764705882352941176
        pass


    def discuss():
        '''
        讨论
        '''
        # decimal 模块实现了IBM的通用十进制算数规范（General Decimal Arithmetic Specification）。不用说，这里面有着数量庞大的配置
        # 选项，这些都超出了本书的范围。

        # python新手可能会倾向于利用decimal模块来规避处理float数据类型所固有的精度问题。但是正确理解你的应用领域是至关重要的。如果我们处理
        # 的是科学或工程类的问题，例如计算机图形学或者大部分带有科学性质的问题，那么更常见的做法是直接使用普通额浮点数类型。首先，在真实的世界中
        # 极少有什么东西需要计算到小数点后17位（float提供17位精度）。因此在计算中引入微小的误差根本就不足挂齿。其次原生的浮点数运算性能要快上
        # 许多--如果要执行大量的计算，那性能问题就显得很重要了。

        # 也就是说我们无法完全忽略误差。数学家花费了大量的时间来研究各种算法，其中一些算法的误差处理能力优于其他算法。我们同样还需要对类似相减
        # 抵消（subtractive cancellation）以及把大数和小数加在一起时的情况要多加小心。示例如下:
        nums = [1.23e+18, 1, -1.23e+18]
        print(sum(nums))
        # 输出: 0.0

        # 上面的例子可以通过使用match.fsum()以更加精确的实现来解决:
        import math
        print(math.fsum(nums))
        # 输出: 1.0

        # 但对于其他的算法，需要研究算法本身，并理解其误差传播（error propagation）性质。

        # 综上所述，decimal模块主要用在涉及像金融这一类业务的程序中。在这样的程序里，计算中如果出现微小的误差是相当令人生厌的。因此，decimal
        # 模块提供了一种规避误差的方式。当用Python做数据库的接口是也会常常遇到Decimal对象 --尤其是当访问金融数据时更是如此。
        pass
    pass



''' 3.3: 对数值做格式化输出 '''
def node3_3():
    def question():
        '''
        问题: 我们需要对数值做格式化输出，包括控制位数、对齐、包含千位分隔符以及其他一些细节。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 要对一个单独的数值做格式化输出，使用內建的format()函数即可。示例如下:
        x = 1234.56789

        # Two decimal places of accuracy
        print(format(x, '0.2f'))
        # 输出: 1234.57

        # Right justified in 10 chars, one-digit accuracy
        print(format(x, '>10.1f'))
        # 输出: '    1234.6'

        # Left justified
        print(format(x, '<10.1f'))
        # 输出: '1234.6    '

        # Centered
        print(format(x, '^10.1f'))
        # 输出: '  1234.6  '

        # Inclusion of thousands separator
        print(format(x, ','))
        # 输出: 1,234.56789
        print(format(x, '0,.1f'))
        # 输出: 1,234.6

        # 如果想采用科学计数法，只要把f改为e或者E即可，根据希望采用的指数规格来指定。示例如下:
        print(format(x, 'e'))
        # 输出: 1.234568e+03

        print(format(x, '0.2E'))
        # 输出: 1.23E+03

        # 以上两种情况中，指定宽度和精度的一般格式为'[<>^]?width[,]?(.digits)?',这里width和digits为整数，而?代表可选部分。
        # 同样的格式也可用于字符串的.format()方法中。示例如下:
        print('The value is {:0,.2f}'.format(x))
        # 输出: The value is 1,234.57
        pass


    def discuss():
        '''
        讨论
        '''
        # 对数值做格式化输出通常都是很直接的。本节展示的技术技能用于浮点型数，也可适用于decimal模块中的Decimal对象

        # 当需要限制数值的位数时，数值会根据round()函数的规则来进行取整。示例如下:
        x = 1234.56789
        print(format(x, '0.1f'))
        # 输出: 1234.6

        print(format(-x, '0.1f'))
        # 输出: -1234.6

        # 对数值加上千分分隔符的格式化操作并不是特定于本地环境的。如果需要将这个需求纳入考虑，应该考察一下local模块中的函数。还可以利用字符串
        # translate()方法交换不同的分隔字符。示例如下:
        swap_separators = {ord('.'): ',',
                           ord(','): '.'}
        print(format(x, ',').translate(swap_separators))
        # 输出: 1.234,56789

        # 在很多python代码中，常用%操作符来对数值做格式化处理。示例如下:
        print('%0.2f' % x)
        # 输出: 1234.57

        print('%10.1f' % x)
        # 输出: '    1234.6'

        print('%-10.1f' % x)
        # 输出: '1234.6    '

        # 这种格式化操作仍然是可以接受的，但是比起来更加现代化的format()方法，这种方法就显得不是那么强大了。比如说，当使用%操作符来格式化
        # 数值时，有些功能就没法得到支持了（例如添加千位分隔符）。
        pass
    pass



''' 3.4: 同二进制、八进制和十六进制数打交道 '''
def node3_4():
    def question():
        '''
        问题: 我们需要对二进制、八进制或十六进制表示的数值做转换或输出
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 要将一个整数转换为二进制、八进制或十六进制的文本字符串形式，只要分别使用內建的bin()、oct()和hex()函数即可，示例如下:
        x = 1234
        print(bin(x))
        # 输出: 0b10011010010

        print(oct(x))
        # 输出: 0o2322

        print(hex(x))
        # 输出: 0x4d2

        # 此外如果不希望出现0b、0o、0x这样的前缀，可以使用format()函数。示例如下:
        print(format(x, 'b'))
        # 输出: 10011010010

        print(format(x, 'o'))
        # 输出: 2322

        print(format(x, 'x'))
        # 输出: 4d2

        # 整数是有符号的，因此要处理负数的话，输出中也会带上一个符号。示例如下:
        x = -1234
        print(format(x, 'b'))
        # 输出: -10011010010

        print(format(x, 'x'))
        # 输出: -4d2

        # 相反如果需要产生一个无符号的数值，需要加上最大值来设置比特位的长度。比如要展示一个32位数，可以像这样实现:
        x = -1234
        print(format(2**32 + x, 'b'))
        # 输出: 11111111111111111111101100101110

        print(format(2**32 + x, 'x'))
        # 输出: fffffb2e

        # 要将字符串形式的整数转换为不同的进制，只需要使用int()函数再配合适当的进制即可。示例如下:
        print(int('4d2', 16))
        # 输出: 1234

        print(int('10011010010', 2))
        # 输出: 1234
        pass


    def discuss():
        '''
        讨论
        '''
        # 对于大部分的情况，处理二进制、八进制、十六进制数都是非常直接的。只是需要记住，这些转换只适用于转换整数的文本表示形式，实际
        # 上在底层只有一种整数类型。

        # 最后，对于那些用到了八进制的程序员来说还有一个地方需要注意。在python中指定八进制数的语法和许多编程语言稍有不同。比方说，如果
        # 试着做如下的操作，则会得到一个语法错误
        # import os
        # os.chmod('script.py', 0755)
        # SyntaxError: invalid token

        # 请确保在八进制数前添加0o前缀，就像这样:
        # os.chmod('script.py', 0o0755)

        # 备注: os.chmod(path, mode)函数是用来修改文件或目录的权限。
        pass
    pass



''' 3.5: 从字节串中打包和解包大整数 '''
def node3_5():
    def question():
        '''
        问题: 我们有一个字节串，需要将其解包为一个整型数值。此外，还需要将一个大整数重新转换为一个字节串
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 假设程序需要处理一个有着16个元素的字节串，其中保存着一个128位的整数。示例如下:
        data = b'\x00\x124V\x00x\x90\xab\x00\xcd\xef\x01\x00#\x004'

        # 要将字节解释为整数，可以使用int.from_bytes(),然后像这样指定字节序即可:
        print(len(data))
        # 输出: 16

        print(int.from_bytes(data, 'little'))
        # 输出: 69120565665751139577663547927094891008

        print(int.from_bytes(data, 'big'))
        # 输出: 94522842520747284487117727783387188

        # 要将一个大整数重新转换为字节串，可以使用int.to_bytes()方法，只要指定字节数和字节序即可。示例如下:
        x = 94522842520747284487117727783387188
        print(x.to_bytes(16, 'big'))
        # 输出: b'\x00\x124V\x00x\x90\xab\x00\xcd\xef\x01\x00#\x004'

        print(x.to_bytes(16, 'little'))
        # 输出: b'4\x00#\x00\x01\xef\xcd\x00\xab\x90x\x00V4\x12\x00'
        pass


    def discuss():
        '''
        讨论
        '''
        # 在大整数和字节串之间互相转换并不算是常见的操作。但是，有时候在特定的应用领域中却有这样的需求，例如加密技术或网络应用中。
        # 比方说IPV6网络地址就是由一个128位的整数来表示的。如果正在编写的代码需要将这样的值从数据记录中提取出来，就得面对这个问题。

        # 作为本节中技术的替代方案，我们可能会强相遇使用struct模块来完成解包，具体可参照6.11节。这行得通，但是struct模块可解包
        # 的整数大小是有限制的。因此，需要解包多个值，然后再将他们合并起来以得到最终的结果。示例如下:
        data = b'\x00\x124V\x00x\x90\xab\x00\xcd\xef\x01\x00#\x004'
        import struct
        hi, lo = struct.unpack('>QQ', data)
        print((hi << 64) + lo)
        # 输出: 94522842520747284487117727783387188

        # 字节序的规范(大端或小端)指定了组成整数的字节是从低位到高位排列还是从高位到低位排列。只要我们精心构造一个十六进制数，就能很
        # 容易看出这其中的意义:
        x = 0x01020304
        print(x.to_bytes(4, 'big'))
        # 输出: b'\x01\x02\x03\x04'

        print(x.to_bytes(4, 'little'))
        # 输出: b'\x04\x03\x02\x01'

        # 如果尝试将一个整数打包成字节串，但字节大小不合适的话就会得打一个错误信息。如果需要的话，可以使用int.bit_length()方法来确定
        # 用到多少位才能保存这个值。
        x = 523 ** 23
        print(x)
        # 输出: 335381300113661875107536852714019056160355655333978849017944067

        # x.to_bytes(16, 'little')
        # OverflowError: int too big to convert

        print(x.bit_length())
        # 输出: 208

        nbytes, rem = divmod(x.bit_length(), 8)
        print(rem)
        if rem:
            nbytes += 1
        print(x.to_bytes(nbytes, 'little'))
        # 输出: b'\x03X\xf1\x82iT\x96\xac\xc7c\x16\xf3\xb9\xcf\x18\xee\xec\x91\xd1\x98\xa2\xc8\xd9R\xb5\xd0'
        pass
    pass



''' 3.6: 复数运算 '''
def node3_6():
    def question():
        '''
        问题: 我们的代码在痛最新的Web认证方案交互时遇到了奇点(singularity)问题，而唯一的解决方案是在复平面解决，或者也许只需要
             利用复数完成一些计算就可以了。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 复数可以通过complex(real, imag)函数来指定，或者通过浮点数再加上后缀j来指定也行。示例如下:
        a = complex(2, 4)
        b = 3 - 5j
        print(a)
        # 输出: (2+4j)

        print(b)
        # 输出: (3-5j)

        # 实部、虚部以及共轭值都可以很方便的提取出来，示例如下:
        print(a.real)
        # 输出: 2.0

        print(a.imag)
        # 输出: 4.0

        print(a.conjugate())
        # 输出: (2-4j)

        # 此外，所有常见的算数运算操作都适用于复数:
        print(a + b)
        # 输出: (5-1j)

        print(a * b)
        # 输出: (26+2j)

        print(a / b)
        # 输出: (-0.4117647058823529+0.6470588235294118j)

        # 最后，如果要执行有关复数的函数操作，例如求正弦、余弦、平方根，可以使用cmath模块:
        import cmath
        print(cmath.sin(a))
        # 输出: (24.83130584894638-11.356612711218174j)

        print(cmath.cos(a))
        # 输出: (-11.36423470640106-24.814651485634187j)

        print(cmath.exp(a))
        # 输出: (-4.829809383269385-5.5920560936409816j)
        pass


    def discuss():
        '''
        讨论
        '''
        # Python中大部分和数学相关的模块都可适用于复数。例如，如果使用numpy模块，可以很直接的创建复数数组，并对他们执行操作:
        import numpy as np
        a = np.array([2+3j, 4+5j, 6-7j, 8+9j])
        print(a)
        # 输出: [ 2.+3.j  4.+5.j  6.-7.j  8.+9.j]

        print(a + 2)
        # 输出: [ 4.+3.j  6.+5.j  8.-7.j  10.+9.j]

        print(np.sin(a))
        # 输出: [ 9.15449915-4.16890696j   -56.16227422 -48.50245524j   -153.20827755-526.47684926j  4008.42651446-589.49948373j]

        # Python中的标准数学函数默认情况下不会产生复数值，因此像这样的值不会意外的出现在代码里。例如:
        import math
        # math.sqrt(-1)
        # ValueError: math domain error

        # 如果希望产生复数结果，那必须明确使用cmath模块或者在可以感知复数的库中声明对复数类型的使用。示例如下:
        import cmath
        print(cmath.sqrt(-1))
        # 输出: 1j
        pass
    pass



''' 3.7: 处理无穷大和NaN '''
def node3_7():
    def question():
        '''
        问题: 我们需要对浮点数的无穷大、负无穷大或NaN进行判断测试。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        import math
        # Python中并没有特殊的语法来表示这些特殊的浮点数值，但是它们可以通过float()来创建。示例如下:
        a = float('inf')
        b = float('-inf')
        c = float('nan')
        print(a)
        # 输出: inf

        print(b)
        # 输出: -inf

        print(c)
        # 输出: nan

        # 要检测是否出现了这些值，可以使用math.isinf()和math.isnan()函数。示例如下:
        print(math.isinf(a))
        # 输出: True

        print(math.isnan(c))
        # 输出: True
        pass


    def discuss():
        '''
        讨论
        '''
        # 要获得关于这些特殊的浮点数值的详细信息，应该参考IEEE 754规范。但是这里有几个棘手的细节问题需要搞清楚，尤其是设计到比较
        # 操作和操作符时可能出现的问题。

        # 无穷大值在数学计算中会进行传播。例如:
        a = float('inf')
        print(a + 45)
        # 输出: inf

        print(a * 10)
        # 输出: inf

        print(10 / a)
        # 输出: 0.0

        # 但是，某些特定的操作会导致未定义的行为并产生NaN的结果。例如:
        a = float('inf')
        print(a/a)
        # 输出: nan

        b = float('-inf')
        print(a + b)
        # 输出: nan

        # NaN会通过所有的操作进行传播，且不会引发任何异常。例如:
        c = float('nan')
        print(c + 23)
        # 输出: nan

        print(c / 2)
        # 输出: nan

        print(c * 2)
        # 输出: nan

        import math
        print(math.sqrt(c))
        # 输出: nan

        # 有关NaN，一个微妙的特性是它们在做比较时从不会被判定为相等。例如:
        c = float('nan')
        d = float('nan')
        print(c == d)
        # 输出: False

        print(c is d)
        # 输出: False

        # 正因如此，唯一安全检查NaN的方法是使用math.isnan()，正如本节示例代码中的那样。
        # 有时候程序员希望在出现无穷大或者NaN结果时可以修改python的行为，让它们抛出异常。fpectl模块可以用来调整这个行为，但是在
        # 标准的python中它是没有开启的。而这个模块是同平台相关的，只针对专家级的程序员使用。可以参见Python的在线文档（http://doc
        # s.python.org/3/library/fpectl.html）以获得进一步的细节。
        pass
    pass



''' 3.8: 分数的计算 '''
def node3_8():
    def question():
        '''
        问题: 仿佛进入时光机一样，我们突然发现自己在做涉及分数处理的小学生家庭作业，也许我们正在为自己的木材商店编写测量计算的代码。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # fractions 模块可以用来处理涉及分数的数学计算问题。示例如下:
        from fractions import Fraction
        a = Fraction(5, 4)
        b = Fraction(7, 16)

        print(a + b)
        # 输出: 27/16

        print(a * b)
        # 输出: 35/64

        # 我们也可以很轻松的获取它的分子和分母:
        c = a * b
        print(c.numerator)
        # 输出: 35

        print(c.denominator)
        # 输出: 64

        # 还可以将它转换为浮点数:
        print(float(c))
        # 输出: 0.546875

        # Limiting the denominator of value
        print(c.limit_denominator(8))
        # 输出: 4/7

        # Converting a float to a fraction
        x = 3.75
        y = Fraction(*x.as_integer_ratio())
        print(y)
        # 输出: 15/4
        pass


    def discuss():
        '''
        讨论
        '''
        # 在大多数程序中，涉及分数的计算问题并不常见。但是在有些场景中使用分数还是有道理的。比如，允许程序接受以分数形式给出的单位
        # 计量并执行相应的计算，这样可以避免用户手动将数据转换为Decimal对象或浮点数。
        pass
    pass



''' 3.9: 处理大型数组的计算 '''
def node3_9():
    def question():
        '''
        问题: 我们需要对大型的数据集比如数组或网格（grid）进行计算。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 对于任何涉及数组的计算密集型任务，请使用NumPy库。NumPy的主要特性是为Python提供了数组对象，比标准Python中的列表有着
        # 更好的性能表现，因此更加适合于做数学计算。下面是一个简短的示例，用来说明列表同NumPy数组在行为上的几个重要不同之处:

        # Python lists
        x = [1, 2, 3, 4]
        y = [5, 6, 7, 8]
        print(x * 2)
        # 输出: [1, 2, 3, 4, 1, 2, 3, 4]

        # print(x + 10)
        # 输出: TypeError: can only concatenate list (not "int") to list

        print(x + y)
        # 输出: [1, 2, 3, 4, 5, 6, 7, 8]


        # Numpy arrays
        import numpy as np
        ax = np.array([1, 2, 3, 4])
        ay = np.array([5, 6, 7, 8])
        print(ax * 2)
        # 输出: [2 4 6 8]

        print(ax + 10)
        # 输出: [11 12 13 14]

        print(ax + ay)
        # 输出: [ 6  8 10 12]

        print(ax * ay)
        # 输出: [ 5 12 21 32]

        # 可以看到，有关数组的几个基本数学运算在行为上都有所不同。特别是，NumPy中的数组在进行标量运算（ax * 2或ax + 10）时是针对
        # 逐个元素进行计算的。此外，当两个操作数都是数组时，NumPy数组在进行数学运算时会针对数组的所有元素进行计算，并产生出一个新的
        # 数组作为结果。

        # 由于数学操作会同时施加于所有元素之上，这一事实使得对整个数组的计算变得非常简单和快速。比如想计算多项式的值:
        def f(x):
            return 3*x**2 - 2*x + 7
        print(f(ax))
        # 输出: [ 8 15 28 47]

        # NumPy提供了一些'通用函数'的集合，他们也能对数组进行操作。这些通用函数可作为math模块中所对应函数的替代。示例如下:
        print(np.sqrt(ax))
        # 输出: [ 1.          1.41421356  1.73205081  2.        ]

        print(np.cos(ax))
        # 输出: [ 0.54030231 -0.41614684 -0.9899925  -0.65364362]

        # 使用NumPy中的通用函数，其效率要比对数组进行迭代然后使用math模块中的函数每次只处理一个元素快上百倍。因此，只要有可能就应该
        # 使用这些通用函数。

        # 在底层，NumPy数组的内存分配方式和C或者Fortran一样。即，他们是大块的连续内存，由同一种数据类型的数据组成。正是因为这样，
        # NumPy才能创建比通常Python中的列表要大的多的数组。例如，想创建一个10000 * 10000的二维浮点数组，这根本不是问题:
        grid = np.zeros(shape=(10000, 10000), dtype=float)
        print(grid)
        # 输出: [[ 0.  0.  0. ...,  0.  0.  0.]
        #       [ 0.  0.  0. ...,  0.  0.  0.]
        #       [ 0.  0.  0. ...,  0.  0.  0.]
        #       ...,
        #       [ 0.  0.  0. ...,  0.  0.  0.]
        #       [ 0.  0.  0. ...,  0.  0.  0.]
        #       [ 0.  0.  0. ...,  0.  0.  0.]]

        # 所有的常见操作仍然可以同时施加于所有的元素之上:
        grid += 10
        print(grid)
        # 输出:
        # [[ 10.  10.  10. ...,  10.  10.  10.]
        # [ 10.  10.  10. ...,  10.  10.  10.]
        # [ 10.  10.  10. ...,  10.  10.  10.]
        # ...,
        # [ 10.  10.  10. ...,  10.  10.  10.]
        # [ 10.  10.  10. ...,  10.  10.  10.]
        # [ 10.  10.  10. ...,  10.  10.  10.]]

        # 关于NumPy，一个特别值得提起的方面就是NumPy扩展了Python列表的索引功能--尤其是针对多维数组时更是如此。为了说明我们先构造
        # 一个简单的二维数组然后做些实验:
        a = np.array([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]])
        print(a)
        # 输出:
        # [[ 1  2  3  4]
        #  [ 5  6  7  8]
        #  [ 9 10 11 12]]

        # Select row 1
        print(a[1])
        # 输出: [5 6 7 8]

        # Select column 1
        print(a[:, 1])
        # 输出: [ 2  6 10]

        # Select a subregion and change it
        print(a[1:3, 1:3])
        # 输出:
        # [[6  7]
        #  [10 11]]

        a[1:3, 1:3] += 10
        print(a)
        # 输出:
        # [[ 1  2  3  4]
        #  [ 5 16 17  8]
        #  [ 9 20 21 12]]

        # Broadcast a row vector across an operation on all rows
        print(a + [100, 101, 102, 103])
        # 输出:
        # [[101 103 105 107]
        #  [105 117 119 111]
        #  [109 121 123 115]]

        # Conditional assignment on an array
        print(np.where(a < 10, a, 10))
        # 输出:
        # [[ 1  2  3  4]
        #  [ 5 10 10  8]
        #  [ 9 10 10 10]]
        pass


    def discuss():
        '''
        讨论
        '''
        # Python中大量的科学和工程类函数库都以NumPy做为基础，它也是广泛使用中最为庞大和复杂的模块之一。尽管如此，对于NumPy我们还是
        # 可以从构建简单的例子开始，逐步实验，最后实现一些有用的应用。

        # 提到NumPy的用法，一个相对来说比较常见的导入方式是import numpy as np，正如给出的示例中那样，这么做缩短了名称，方便我们
        # 每次在程序中输入。

        # 要获得更多信息，一定要去看看NumPy的官方站点http://www.numpy.org
        pass
    pass



''' 3.10: 矩阵和线性代数的计算 '''
def node3_10():
    def question():
        '''
        问题: 我们要执行矩阵和线性代数方面的操作，比如矩阵乘法、求行列式、解线性方程等。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # NumPy库中有一个matrix对象可用来处理这种情况。Matrix对象和3.9节中描述的数组对象有些类似，但是在计算时遵守线性代数规则。
        # 下面的例子展示了几个重要的特性:
        import numpy as np
        m = np.matrix([[1, -2, 3], [0, 4, 5], [7, 8, -9]])
        print(m)
        # 输出:
        # [[ 1 -2  3]
        #  [ 0  4  5]
        #  [ 7  8 -9]]

        # Return transpose
        print(m.T)
        # 输出:
        # [[ 1  0  7]
        #  [-2  4  8]
        #  [ 3  5 -9]]

        # Return inverse
        print(m.I)
        # 输出:
        # [[ 0.33043478 -0.02608696  0.09565217]
        #  [-0.15217391  0.13043478  0.02173913]
        #  [ 0.12173913  0.09565217 -0.0173913 ]]

        # Create a vector and multiply
        v = np.matrix([[2], [3], [4]])
        print(v)
        # 输出:
        # [[2]
        #  [3]
        #  [4]]

        print(m * v)
        # 输出:
        # [[ 8]
        #  [32]
        #  [ 2]]

        # 更多的操作可在numpy.linalg子模块中找到。例如:
        import numpy.linalg

        # Determinant（行列式）
        print(numpy.linalg.det(m))
        # 输出: -230.0

        # Eigenvalues（特征值）
        print(numpy.linalg.eigvals(m))
        # 输出: [-13.11474312   2.75956154   6.35518158]

        # Solve for x in mx = v
        x = numpy.linalg.solve(m, v)
        print(x)
        # 输出:
        # [[ 0.96521739]
        #  [ 0.17391304]
        #  [ 0.46086957]]

        print(m * x)
        # 输出:
        # [[2.]
        #  [3.]
        #  [4.]]

        print(v)
        # 输出:
        # [[2]
        #  [3]
        #  [4]]
        pass


    def discuss():
        '''
        讨论
        '''
        # 显然，线性代数是个庞大的课题，远超出本书的范围。但是如果需要处理矩阵和向量，NumPy是个很好的起点。
        # 请访问http://www.numpy.org以获得更多详细的信息
        pass
    pass



''' 3.11: 随机选择 '''
def node3_11():
    def question():
        '''
        问题: 我们想从序列中随机挑选出元素，或者想生成随机数。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # random模块中有各种函数可用于需要随机数和随机选择的场景。例如，要从序列中随机挑选出元素，可以使用random.choice():
        import random
        values = [1, 2, 3, 4, 5, 6]
        print(random.choice(values))
        # 输出: 1

        print(random.choice(values))
        # 输出: 1

        print(random.choice(values))
        # 输出: 3

        print(random.choice(values))
        # 输出: 2

        print(random.choice(values))
        # 输出: 1

        # 如果想取样出N个元素，将选出的元素移除以做进一步的考察，可以使用random.sample()
        print(random.sample(values, 2))
        # 输出: [2, 5]

        print(random.sample(values, 2))
        # 输出: [1, 6]

        print(random.sample(values, 3))
        # 输出: [3, 5, 6]

        print(random.sample(values, 3))
        # 输出: [4, 3, 1]

        # 如果只是想在序列中原地打乱元素的顺序（洗牌），可以使用random.shuffle():
        random.shuffle(values)
        print(values)
        # 输出: [1, 4, 3, 2, 6, 5]

        random.shuffle(values)
        print(values)
        # 输出: [2, 1, 4, 5, 6, 3]

        # 要产生随机整数，还可以使用random.randint():
        print(random.randint(0, 10))
        # 输出: 2

        print(random.randint(0, 10))
        # 输出: 9

        print(random.randint(0, 10))
        # 输出: 3

        print(random.randint(0, 10))
        # 输出: 9

        print(random.randint(0, 10))
        # 输出: 4

        print(random.randint(0, 10))
        # 输出: 7

        # 要产生0到1之间均匀分布的浮点数值，可以使用random.random():
        print(random.random())
        # 输出: 0.8651300452516131

        print(random.random())
        # 输出: 0.2745363895697409

        print(random.random())
        # 输出: 0.7144255525655793

        # 如果要得到由N个随机比特位所表示的整数，可以使用random.getrandbits():
        print(random.getrandbits(200))
        # 输出: 1208037810197949734673342951080220332464781173102064958805147
        pass

    def discuss():
        '''
        讨论
        '''
        # random模块采用马特赛特旋转算法（Mersenne Twister，也称为梅森特旋转算法）来计算随机数。这是一个确定性算法，但是
        # 可以通过random.seed()函数来修改初始的种子值。
        import random
        random.seed()               # Seed based on system time or os.urandom()
        random.seed(12345)          # Seed based on integer given
        random.seed(b'bytedata')    # Seed based on byte data

        # 除了以上展示的功能外，random模块还包括了计算均匀分布、高斯分布和其他概率分布的函数。比如，random.uniform()可以计算
        # 均匀分布值，而random.gauss()则可以计算出正态分布值。请查阅文档以获得对其他所支持的分布的相关信息。

        # random模块中的函数不应该用在对加密处理的相关程序中。如果需要这样的功能，考虑使用ssl模块中函数来替代。例如，ssl.RADN_bytes()
        # 可以用来产生加密安全的随机字节序列。
        pass
    pass



''' 3.12: 时间换算 '''
def node3_12():
    def question():
        '''
        问题: 我们的代码需要进行简单的时间转换工作，比如将日转换为秒，将小时转换为分钟等。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 我们可以利用datetime模块来完成不同时间单位间的换算。例如，要表示一个时间间隔，可以像这样创建一个timedelta实例:
        from datetime import timedelta
        a = timedelta(days=2, hours=6)
        b = timedelta(hours=4.5)
        c = a + b
        print(c)
        # 输出: 2 days, 10:30:00

        print(c.days)
        # 输出: 2

        print(c.seconds)
        # 输出: 37800

        print(c.seconds / 3600)
        # 输出: 10.5

        print(c.total_seconds() / 3600)
        # 输出: 58.5

        # 如果需要表示特定的日期和时间，可以创建datetime实例并使用标准的数学运算来操纵它们。示例如下:
        from datetime import datetime
        a = datetime(2012, 9, 23)

        print(a + timedelta(days=10))
        # 输出: 2012-10-03 00:00:00

        b = datetime(2012, 12, 21)
        d = b - a
        print(d.days)
        # 输出: 89

        now = datetime.today()
        print(now)
        # 输出: 2017-07-26 18:05:06.465322

        # 当执行计算时，应该要注意的是datetime模块是可以正确处理闰年的。
        pass


    def discuss():
        '''
        讨论
        '''
        # 对于大部分基本的日期和时间操控问题，datetime模块已足够满足要求了。如果需要处理更为复杂的日期问题，比如处理时区、模糊时间
        # 范围、计算节日的日期等，可以试试dateutil模块。

        # 为了举例说明，可以使用dateutil.relativedelta()函数完成许多痛datetime模块相似的时间计算。然而，dateutil的一个显著
        # 特点是在处理有关月份的问题时能填补datetime模块留下的空缺（可正确处理不同月份中的天数）。示例如下:
        from datetime import datetime
        from datetime import timedelta
        a = datetime(2012, 9, 23)
        # print(a + timedelta(months=1))
        # 输出: TypeError: 'months' is an invalid keyword argument for this function

        from dateutil.relativedelta import relativedelta
        print(a + relativedelta(months=+1))
        # 输出: 2012-10-23 00:00:00

        print(a + relativedelta(months=+4))
        # 输出: 2013-01-23 00:00:00

        # Time between two dates'
        b = datetime(2012, 12, 21)
        d = b - a
        print(d)
        # 输出: 89 days, 0:00:00

        d = relativedelta(b, a)
        print(d)
        # 输出: relativedelta(months=+2, days=+28)

        print(d.months)
        # 输出: 2

        print(d.days)
        # 输出: 28
        pass
    pass



''' 3.13: 计算上周5的日期 '''
def node3_13():
    def question():
        '''
        问题: 我们希望有一个通用的解决方案能找出一周中上一次出现某天时的日期。比方说上周五是几月几号？
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # Python的datetime模块中更有一些实用函数和类可以帮助我们完成这样的计算。关于这个问题，一个优雅、通用的解决方案看起来是这样的:
        from datetime import datetime, timedelta
        weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday',
                    'Friday', 'Saturday', 'Sunday']
        def get_previous_byday(dayname, start_date=None):
            if start_date is None:
                start_date = datetime.today()
            day_num = start_date.weekday()
            day_num_target = weekdays.index(dayname)
            days_ago = (7 + day_num - day_num_target) % 7
            if days_ago == 0:
                days_ago = 7
            target_date = start_date - timedelta(days=days_ago)
            return target_date

        # 在交互式解释器环境中使用这个函数看起来是这样的:
        print(datetime.today())
        # 输出: 2017-07-27 11:12:22.292965

        print(get_previous_byday('Monday'))
        # 输出: 2017-07-24 11:13:08.213710

        print(get_previous_byday('Thursday'))
        # 输出: 2017-07-20 11:16:48.833345

        print(get_previous_byday('Friday'))
        # 输出: 2017-07-21 11:18:15.109513

        # 可选的start_date参数可通过另一个datetime实例来提供。例如:
        print(get_previous_byday('Sunday', start_date=datetime(2012, 12, 27)))
        # 输出: 2012-12-23 00:00:00
        pass


    def discuss():
        '''
        讨论
        '''
        # 上面的解决方案将起始日期和目标日期映射到它们在一周之中的位置上（周一为第0天，以此类推）。然后用取模运算计算上一次目标日期
        # 出现时间到起始日期为止一共经过了多少天。之后，从起始日期中减去一个合适的timedate实例就得到了我们所要的日期。

        # 如果需要执行大量类似日期的计算，最好安装python-dateutil包。例如下面这个例子是使用dateutil模块中的relativedelta()
        # 函数来执行同样的计算:
        from datetime import datetime
        from dateutil.relativedelta import relativedelta
        from dateutil.rrule import FR
        d = datetime.now()
        print(d)
        # 输出: 2017-07-27 11:29:13.038575

        # Next Friday
        print(d + relativedelta(weekday=FR))
        # 输出: 2017-07-28 11:37:41.447967

        # Last Friday
        print(d + relativedelta(weekday=FR(-1)))
        # 输出: 2017-07-21 11:40:30.495030
        pass
    pass



''' 3.14: 找出当月的日期范围 '''
def node3_14():
    def question():
        '''
        问题: 我们有一些代码需要循环迭代当月中的某个日期，我们需要一种高效的方法来计算出日期的范围
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 对日期进行循环迭代并不需要实现构建一个包含所有日期的列表。只需要计算出范围的开始和结束日期，然后在迭代时利用datetime.timedelta
        # 对象来递增日期就可以了。

        # 下面这个函数可以接受任意的datetime对象，并返回一个包含本月第一天和下个月第一天日期的元组。示例如下:
        from datetime import datetime, date, timedelta
        import calendar

        def get_month_range(start_date=None):
            if start_date is None:
                start_date = date.today().replace(day=1)
            _, days_in_month = calendar.monthrange(start_date.year, start_date.month)
            end_date = start_date + timedelta(days=days_in_month)
            return (start_date, end_date)

        # 当准备好这个函数后，对日期范围做循环迭代就变得非常简单了:
        a_day = timedelta(days=1)
        first_day, last_day = get_month_range()
        while first_day < last_day:
            print(first_day)
            first_day += a_day
        # 输出:
        # 2017-07-01
        # 2017-07-02
        # 2017-07-03
        # 2017-07-04
        # 2017-07-05
        # 2017-07-06
        # 2017-07-07
        # 2017-07-08
        # 2017-07-09
        # 2017-07-10
        # 2017-07-11
        # 2017-07-12
        # 2017-07-13
        # 2017-07-14
        # 2017-07-15
        # 2017-07-16
        # 2017-07-17
        # 2017-07-18
        # 2017-07-19
        # 2017-07-20
        # 2017-07-21
        # 2017-07-22
        # 2017-07-23
        # 2017-07-24
        # 2017-07-25
        # 2017-07-26
        # 2017-07-27
        # 2017-07-28
        # 2017-07-29
        # 2017-07-30
        # 2017-07-31
        pass


    def discuss():
        '''
        讨论
        '''
        # 上面的代码首先计算出响应月份中第一天的日期。一种快速求解的方法是利用date或datetime对象的replace()方法，只要将属性days
        # 设为1就可以了。关于replace()方法，一个好的方面就是它创建出的对象和我们得输入对象类型是一致的。因此，如果输入的是一个date
        # 实例，那么得到的结果同样也是一个date实例。同样，如果输入时datetime实例，得到的也是datetime实例。

        # 此外，我们用calendar.monthrange()函数来找出待求解的月份中有多少天。当需要得到有关日历方面的基本信息时，calendar模块都
        # 会非常有用。monthrange()是其中唯一一个可以返回元组的函数，元组中包含当月第一个工作日的日期（返回值为0~6，一次代表周一到周
        # 日）

        # 一旦知道了这个月有多少天，那么结束日期就可以通过在起始日期上加上一个合适的timedelta对象来表示。尽管很微不足道，但本节中给出
        # 的解决方案中一个重要方面就是结束日期并不包含在范围内（因为实际上他是下个月的第一天）。这这好应对了Python中的切片和range行为
        # 这些操作永远不会将结束点包含在内。

        # 要循环迭代日期范围，我们这里采用了标准的算数以及比较操作符。比如，timedelta实例可用来递增日期，而<操作符用来检查当前日期是否
        # 超过了结束日期。

        # 最理想的方法是创建一个专门处理日期的函数，而且用法和Python內建的range()一样。幸运的是，用生成器来实现这样一个函数真的是非常
        # 容易:
        from datetime import datetime, timedelta
        def date_range(start, stop, step):
            while start < stop:
                yield start
                start += step

        # 下面是这个函数的使用示例:
        for d in date_range(datetime(2012, 9, 1), datetime(2012, 10, 1), timedelta(hours=30)):
            print(d)
        # 输出:
        # 2012-09-01 00:00:00
        # 2012-09-02 06:00:00
        # 2012-09-03 12:00:00
        # 2012-09-04 18:00:00
        # 2012-09-06 00:00:00
        # 2012-09-07 06:00:00
        # 2012-09-08 12:00:00
        # 2012-09-09 18:00:00
        # 2012-09-11 00:00:00
        # 2012-09-12 06:00:00
        # 2012-09-13 12:00:00
        # 2012-09-14 18:00:00
        # 2012-09-16 00:00:00
        # 2012-09-17 06:00:00
        # 2012-09-18 12:00:00
        # 2012-09-19 18:00:00
        # 2012-09-21 00:00:00
        # 2012-09-22 06:00:00
        # 2012-09-23 12:00:00
        # 2012-09-24 18:00:00
        # 2012-09-26 00:00:00
        # 2012-09-27 06:00:00
        # 2012-09-28 12:00:00
        # 2012-09-29 18:00:00

        # 这里要再一次说明，之所以上述实现会如此简单，一个很重要的原因就是日期和时间可以通过标准的算术和比较操作符来进行操作。
        pass
    pass



''' 3.15: 将字符串转换为日期 '''
def node3_15():
    def question():
        '''
        问题: 我们的程序接收到字符串形式的临时数据，但是我们想将这些字符串转换为datetime对象，一次对他们执行一些非字符串的操作。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 一般来说，Python中的标准模块datetime是用来处理这种问题得简单方案。示例如下:
        from datetime import datetime
        text = '2012-09-20'
        y = datetime.strptime(text, '%Y-%m-%d')
        z = datetime.now()
        diff = z - y
        print(diff)
        # 输出: 1771 days, 14:25:21.290172
        pass


    def discuss():
        '''
        讨论
        '''
        from datetime import datetime
        # datetime.strptime()方法支持许多格式化代码，比如%Y代表4位数字表示的年份，而%m代表以2位数字表示的月份。同样值得一提的是
        # 这些格式化占位符也可以反过来用在datetime对象转化为字符串上。如果需要以字符串形式来表示datetime对象并且向让输出格式变得美
        # 观时，这就能够派上用场了。

        # 比如，假设有一些代码生成了datetime对象，但是需要将它们格式化为美观、方便人们阅读的日期形式，以便将其放在自动生成的信件或报
        # 告的开头处:
        z = datetime.now()
        print(z)
        # 输出: 2017-07-27 14:48:55.360544

        nice_z = datetime.strftime(z, '%A %B %d, %Y')
        print(nice_z)
        # 输出: Thursday July 27, 2017

        # 这里值得一提的是strptime()的性能通常比我们想象的还要糟糕许多，这是因为该函数是以纯Python代码实现的，而且需要处理各种各样
        # 的系统区域设定。如果要再代码中解析大量的日期，而事先不知道日期的准确格式，那么自行实现一个解决方案可能会获得巨大的性能提升。
        # 例如，如果知道日期是以'YYYY-MM-DD'的形式表示的，可以像这样编写一个函数:
        from datetime import datetime
        def parse_ymd(s):
            year_s, mon_s, day_s = s.split('-')
            return datetime(int(year_s), int(mon_s), int(day_s))

        # 我们进行了对比测试，上面这个函数比datetime.strptime()快了7倍多。如果需要处理大量涉及日期的数据时，这很可能就是需要考虑的
        # 问题了。
        pass
    pass



''' 3.16: 处理涉及时区的时间问题 '''
def node3_16():
    def question():
        '''
        问题: 我们有一个电话会议订在芝加哥时间2012年12月21日上午9点30分。那么在印度班加罗尔的朋友应该在当地时间几点出现才能赶上会议？
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 对于几乎任何涉及到时区的问题，都应该使用pytz模块来解决。这个Python包提供了奥尔森时区数据库，这也是很多语言和操作系统所使用的
        # 时区信息标准。

        # pyzt模块主要用来本地化由datetime库创建的日期。例如，下面这段代码告诉我们如何以芝加哥时间来表示日期:
        from datetime import datetime, timedelta
        from pytz import timezone
        d = datetime(2012, 12, 21, 9, 30, 0)
        print(d)
        # 输出: 2012-12-21 09:30:00

        # Localize the date for Chicago
        central = timezone('US/Central')
        loc_d = central.localize(d)
        print(loc_d)
        # 输出: 2012-12-21 09:30:00-06:00

        # 一旦日期经过了本地化处理，它就可以转换为其他的时区。要知道同一时间班加罗尔是几点，可以这样做:
        # Convert to Bangalore time
        bang_d = loc_d.astimezone(timezone('Asia/Kolkata'))
        print(bang_d)
        # 输出: 2012-12-21 21:00:00+05:30

        # 如果打算对本地化的日期做算数计算，需要特别注意夏令时转换和其他方面的细节。比如，2013年美国的标准夏令时于本地时间3月10日凌晨
        # 2点开始（此时时间要往前拨1小时）。如果直接进行算数计算就会得到错误的结果。例如:
        d = datetime(2013, 3, 10, 1, 45)
        loc_d = central.localize(d)
        print(loc_d)
        # 输出: 2013-03-10 01:45:00-06:00

        later = loc_d + timedelta(minutes=30)
        print(later)
        # 输出: 2013-03-10 02:15:00-06:00

        # 结果是错误的，因为上面的代码没有把本地时间中跳过的1小时给算上。要使用这个问题可以使用timezone对象的normalize()方法。示例如下:
        from datetime import timedelta
        later = central.normalize(loc_d + timedelta(minutes=30))
        print(later)
        # 输出: 2013-03-10 03:15:00-05:00
        pass


    def discuss():
        '''
        讨论
        '''
        # 为了不让我们的头炸掉，通常用来处理本地时间的方法是将所有的日期都转换为UTC（世界统一时间）时间，然后在所有的内部存储和处理中都是用
        # UTC时间。示例如下:
        from datetime import datetime, timedelta
        from pytz import timezone
        import pytz

        central = timezone('US/Central')
        d = datetime(2013, 3, 10, 1, 45)
        loc_d = central.localize(d)
        print(loc_d)
        # 输出: 2013-03-10 01:45:00-06:00

        utc_d = loc_d.astimezone(pytz.utc)
        print(utc_d)
        # 输出: 2013-03-10 07:45:00+00:00

        # 一旦转换为UTC时间，就不用担心夏令时以及其他的那些麻烦事了。因此，我们可以像之前那样对日期执行普通的算数运算。如果需要将时间以
        # 本地时间输出，只需要将起转换为合适的时区即可。示例如下:
        later_utc = utc_d + timedelta(minutes=30)
        print(later_utc.astimezone(central))
        # 输出: 2013-03-10 03:15:00-05:00

        # 在同时区打交道时，一个常见的问题是如何知道时区的名称？例如，在本节的实例中我们怎么知道'Asia/Kolkata'才是表示印度时间的正确
        # 时区呢？要找出时区名称，可以考察一下pyzt.country_timezones，这是一个字典，可以使用ISO 3166国家代码座位key来查询。示例
        # 如下:
        print(pytz.country_timezones['IN'])
        # 输出: [u'Asia/Kolkata']

        # 当读到这里的时候，根据PEP 431的描述，为了增强对时区的支持pyzt模块可能将不再建议使用。但是，本节中提到的许多建议依然是使用的
        # （即，建议使用UTC时间等）
        pass
    pass