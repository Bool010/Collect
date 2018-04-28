#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
cookbook 第4章 [迭代器和生成器]

4.1: 手动访问迭代器中的元素
4.2: 委托迭代
4.3: 用生成器创建新的迭代模式
4.4: 实现迭代协议
4.5: 反向迭代
4.6: 定义带有额外状态的生成器函数
4.7: 对迭代器做切片操作
4.8: 跳过可迭代对象中的前一部分元素
4.9: 迭代所有可能的组合或排列
4.10: 以索引值对的形式迭代序列
4.11: 同时迭代多个序列
4.12: 在不同的容器中进行迭代
4.13: 创建处理数据的管道
4.14: 扁平化处理嵌套型的序列
4.15: 合并多个有序序列，再对整个有序序列进行迭代
4.16: 用迭代器取代while循环

"""

# 迭代器是Python中最强有力的特性之一。从高层次看，我们可以简单的把迭代器看做是一种处理序列中元素的方式。但是这里还有着更多的可能，比如
# 创建自己的可迭代对象、在itertools模块中选择使用的迭代模式、构建生成器函数等。本章的目标是解决有关迭代中的一些常见问题。

''' 4.1: 手动访问迭代器中的元素 '''
def node4_1():
    def question():
        '''
        问题: 我们要处理某个可迭代对象中的元素，但是基于某种原因不能也不想使用for循环。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 要手动访问可迭代对象中的元素，可以使用next()函数，然后自己编写代码来捕获StopIteration异常。例如，下面这个例子采用手工方
        # 式从文件中读取问本行:
        with open('/etc/passwd') as f:
            try:
                while True:
                    line = next(f)
                    print(line)
            except StopIteration:
                pass

        # 一般来说，StopIteration异常是用来通知我们迭代结束的。但是，如果是手动使用next()（就像例子中的那样），也可以命令它返回一个
        # 结束值，比如说None。示例如下:
        with open('/etc/passwd') as f:
            while True:
                line = next(f, None)
                if line is None:
                    break
                print(line)
        pass


    def discuss():
        '''
        讨论
        '''
        # 大多数情况下，我们会用for语句来访问可迭代对象中的元素。但是，偶尔也会碰到需要对底层迭代机制做更精确控制的情况。因此，了解迭代
        # 时实际发生了些什么是很有帮助的。

        # 下面的加护例子对迭代时发生的基本过程做了解释说明:
        items = [1, 2, 3]
        # Get the iterator
        it = iter(items)    # Invokes items.__iter__()

        # Run the iterator
        print(next(it))     # Invokes it.__next__()
        # 输出: 1

        print(next(it))
        # 输出: 2

        print(next(it))
        # 输出: 3

        print(next(it))
        # 输出: Traceback (most recent call last): ... StopIteration

        # 本章后面的示例将对迭代技术进行扩展，因此假定读者对基本的迭代协议已有所了解。请确保将这第一个例子深深刻在脑海里。
        pass
    pass



''' 4.2: 委托迭代 '''
def node4_2():
    def question():
        '''
        问题: 我们构建了一个自定义的容器对象，其内部持有一个列表、元组或其他的可迭代对象。我们想让自己的新容器能够完成迭代操作。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 一般来说我们要做的就是定义一个__iter__()方法，将迭代请求委托到对象内部持有的容器上。示例如下:
        class Node:
            def __init__(self, value):
                self._value = value
                self._children = []

            def __repr__(self):
                return 'Node({!r})'.format(self._value)

            def add_child(self, node):
                self._children.append(node)

            def __iter__(self):
                return iter(self._children)

        # Example
        root = Node(0)
        child1 = Node(1)
        child2 = Node(2)
        root.add_child(child1)
        root.add_child(child2)
        for ch in root:
            print(ch)
        # 输出:
        # Node(1)
        # Node(2)

        # 在这个例子中，__iter__()方法只是简单地将迭代请求转发给对象内部持有的_children属性上。
        pass


    def discuss():
        '''
        讨论
        '''
        # Python的迭代协议要求__iter__()返回一个特殊的迭代器对象，由该对象实现的__next__()方法来完成实际的迭代。如果要做的只是
        # 迭代另一个容器中的内容，我们不必担心底层细节是如何工作的，所以要做的是转发迭代请求。

        # 示例中用到的iter()函数对代码做了一定程度的简化。iter(s)通过调用s.__iter__()来简单的返回底层的迭代器，这和len(s)调用
        # s.__len__()的方式是一样的。
        pass
    pass



''' 4.3: 用生成器创建新的迭代模式 '''
def node4_3():
    def question():
        '''
        问题: 我们想实现一个自定义的迭代模式，是其区别与常见的內建函数（即range()、reversed()等）。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 如果我们想实现一种新的迭代模式，可以使用生成器函数来定义。这里有一个生成器可产生某个范围内的浮点数:
        def frange(start, stop, increment):
            x = start
            while x < stop:
                yield x
                x += increment
        # 要使用这个函数，可以使用for循环对其迭代，或者通过其他可以访问可迭代对象中元素的函数（例如sum()、list()等）来使用。示例如下:
        for n in frange(0, 4, 0.5):
            print(n)
        # 输出:
        # 0
        # 0.5
        # 1.0
        # 1.5
        # 2.0
        # 2.5
        # 3.0
        # 3.5

        print(list(frange(0, 1, 0.125)))
        # 输出: [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875]
        pass


    def discuss():
        '''
        讨论
        '''
        # 函数中只要出现了yield语句就会将其转变成一个生成器。与普通函数不同，生成器只会在响应迭代操作时才运行。这里有一个实验性的例子，我
        # 们可以试试看，以了解这样的函数底层机制究竟是如何运转的:
        def countdown(n):
            print('Starting to count from', n)
            while n > 0:
                yield n
                n -= 1
            print('Done')

        # Create the generator, notice no output appears
        c = countdown(3)
        print(c)
        # 输出: <generator object countdown at 0x10eccbc30>

        # Run to first yield and emit a value
        print(next(c))
        # 输出: 3

        print(next(c))
        # 输出: 2

        print(next(c))
        # 输出: 1

        print(next(c))
        # 输出: Traceback (most recent call last): ... StopIteration

        # 这里核心特性是生成器函数只会在响应迭代过程中的'next'操作时才会运行。一旦生成器函数返回，迭代也就停止了。但是，通常用来处理迭代
        # 的for循环语句替代我们处理了这些细节，因此一般情况下不必为此操心。
        pass
    pass



''' 4.4: 实现迭代协议 '''
def node4_4():
    def question():
        '''
        问题: 我们正在构建一个自定义的对象，希望它可以支持迭代操作，但是也希望有一种简单的方式实现迭代协议。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # 目前看来，要在对象上实现可迭代功能，最简单的方式就是使用生成器函数。在4.2节中。我们用Node类来表示树结构。也许你想实现一个迭
        # 代器以深度优先的模式遍历树的节点。下面是可能的做法:
        class Node:
            def __init__(self, value):
                self._value = value
                self._children = []

            def __repr__(self):
                return 'Nodel({!r})'.format(self._value)

            def add_child(self, node):
                self._children.append(node)

            def __iter__(self):
                return iter(self._children)

            def depth_first(self):
                yield self
                for c in self:
                    yield from c.depth_first()

        # Example
        #           0
        #         __|__
        #        |     |
        #        1     2
        #       _|_    |
        #      |   |   |
        #      3   4   5
        root = Node(0)
        child1 = Node(1)
        child2 = Node(2)
        root.add_child(child1)
        root.add_child(child2)
        child1.add_child(Node(3))
        child1.add_child(Node(4))
        child2.add_child(Node(5))
        for ch in root.depth_first():
            print(ch)
        # 输出:
        # Nodel(0)
        # Nodel(1)
        # Nodel(3)
        # Nodel(4)
        # Nodel(2)
        # Nodel(5)

        # 在这份代码中，depth_first()的实现非常容易阅读，描述起来也很方面。它首先产生出自身，然后迭代每个子节点，利用子节点的depth_
        # first()方法（通过yield from语句）产生出其他元素。
        pass
    
    
    def discuss():
        '''
        讨论
        '''
        # Python的迭代协议要求__iter__()返回一个特殊的迭代器对象，该对象必须实现__next__()方法，并使用StopIteration异常来通知迭代
        # 的完成。但是，实现这样的对象通常会比较繁琐。例如，下面的代码展示了depth_first()的另一种实现，这里使用一个相关联的迭代器类。
        class Node:
            def __init__(self, value):
                self._value = value
                self._children = []

            def __repr__(self):
                return 'Nodel({!r})'.format(self._value)

            def add_child(self, node):
                self._children.append(node)

            def __iter__(self):
                return iter(self._children)

            def depth_first(self):
                return DepthFirstIterator(self)


        class DepthFirstIterator:
            def __init__(self, start_node):
                self._node = start_node
                self._children_iter = None
                self._child_iter = None

            def __iter__(self):
                return self

            def __next__(self):
                # Return myself if just started; create an iterator for children
                if self._children_iter is None:
                    self._children_iter = iter(self._node)
                    return self._node

                # If processing a child, return its next item
                elif self._child_iter:
                    try:
                        nextchild = next(self._child_iter)
                        return nextchild
                    except StopIteration:
                        self._child_iter = None
                        return next(self)
                    
                # Advance to the next child and start its iteration
                else:
                    self._child_iter = next(self._children_iter).depth_first()
                    return next(self)

        # DepthFirstIterator类的工作方式和生成器版本的实现相同但是却复杂了许多，因为迭代器必须维护迭代工作中许多复杂的状态，要记住
        # 当前迭代过程进行到了哪里了。坦白的说，没有人喜欢编写这些令人费解的代码。把迭代器以生成器的方式来定义就皆大欢喜了。
        pass
    pass



''' 4.5: 反向迭代 '''
def node4_5():
    def question():
        '''
        问题: 我们想要反向迭代序列中的元素。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 可以使用內建的reversed()函数来实现反向迭代。实例如下:
        a = [1, 2, 3, 4]
        for x in reversed(a):
            print(x)
        # 输出:
        # 4
        # 3
        # 2
        # 1

        # 反向迭代只有在待处理的对象拥有可确定的大小，或者实现了__reversed__()特殊方法时，才能奏效。如果这两个条件都无法满足，则必
        # 须首先将这个对象转换为列表。示例如下:

        # Print a file backwards
        # f = open('somefile')
        # for line in reversed(list(f)):
        #     print(line)

        # 请注意，像上述代码中那样将可迭代对象转换为列表可能会消耗大量内存，尤其是当可迭代对象较大时更是如此。
        pass


    def discuss():
        '''
        讨论
        '''
        # 许多程序员都没有意识到如果他们实现了__reversed__()方法，那么就可以在自定义的类上实现反向迭代。示例如下:
        class Countdown:
            def __init__(self, start):
                self.start = start

            # Forward iterator
            def __iter__(self):
                n = self.start
                while n > 0:
                    yield n
                    n -= 1

            # Reverse iterator
            def __reversed__(self):
                n = 1
                while n <= self.start:
                    yield n
                    n += 1

        # 定义一个反向迭代器可使代码变得更加高效，因为这样就无需先把数据放到列表中，然后再反向去迭代列表了。
        pass
    pass



''' 4.6: 定义带有额外状态的生成器函数 '''
def node4_6():
    def question():
        '''
        问题: 我们想定义一个生成器函数，但是它还设计一些额外的状态，我们希望能以某种形式将这些状态暴露给用户。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # 我们想让生成器将状态暴露给用户，别忘了可以轻易地将其实现为一个类，然后把生成器函数的代码放到__iter__()方法中即可。示例如下:
        from collections import deque

        class LineHistory:
            def __init__(self, lines, histlen=3):
                self.lines = lines
                self.history = deque(maxlen=histlen)

            def __iter__(self):
                for lineno, line in enumerate(self.lines, 1):
                    self.history.append((lineno, line))
                    yield line

            def clear(self):
                self.history.clear()

        # 要是用这个类，可以将其看做是一个普通的生成器函数。但是由于它会创建一个类实例，所以可以访问内部属性。比如history属性或者
        # clear()方法。示例如下:
        # with open('somefile.txt') as f:
        #     lines = LineHistory(f)
        #     for line in lines:
        #         if 'Python' in line:
        #             for lineno, hline in lines.history:
        #                 print('{}:{}'.format(lineno, hline), end='')                        
        pass
    
    
    def discuss():
        '''
        讨论
        '''
        # 有了生成器之后很容易掉入一个陷阱，即，试着只用函数来解决所有问题。如果生成器函数需要以不寻常的方式同程序中其他部分交互的话
        # （比如暴露属性，允许通过方法调用来获得控制等），那就会导致出现相当复杂的代码。如果遇到了这种情况，就像示例中做的那样，用类
        # 来定义就好了。将生成器函数定义在__iter__()方法中并没有对算法做任何改变。又有状态只是类的一部分，这一事实使得我们可以很容
        # 易将其属性和方法来提供给用户交互。
        
        # 上面所示的方法有一个潜在的微妙之处，那就是如果打算用除了for循环之外的技术来驱动迭代过程的话，可能需要额外调用一次iter()。
        # 比方说:
        # f = open('somefile.xit')
        # lines = Linehistory(f)
        # next(lines)
        # 输出: TypeError: 'Linehistory' object is no an iterator
        
        # Call iter() first, then start iterating
        # it = iter(lines)
        # next(it)
        # 输出: 'hello world\n'
        
        # next(it)
        # 输出: 'this is a test\n'
        pass
    pass



''' 4.7: 对迭代器做切片操作 '''
def node4_7():
    def question():
        '''
        问题: 我们想对迭代器产生的数据做切片处理，但是普通的切片操作符在这里不管用。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # 要对迭代器和生成器做切片操作，itertools.islice()函数是完美的选择。示例如下:
        def count(n):
            while True:
                yield n
                n += 1
        c = count(0)
        # print(c[10: 20])
        # 输出: TypeError: 'generator' object is not subscriptable

        # Now using islice()
        import itertools
        for x in itertools.islice(c, 10, 20):
            print(x)
        # 输出:
        # 10
        # 11
        # 12
        # 13
        # 14
        # 15
        # 16
        # 17
        # 18
        # 19
        pass
    scheme()
    
    
    def discuss():
        '''
        讨论
        '''
        # 迭代器和生成器是没法执行普通的切片操作的，这是因为它们不知道它们的长度是多少（而且他们也没有实现索引）。islice()产生的结果
        # 是一个迭代器，它们可以产生出所需要的切片元素，但这是通过访问并丢弃所有起始索引之前的元素来实现的。之后的元素会由islice对象
        # 产生出来，直到到达结束索引为止。

        # 需要重点强调的是islice()会消耗掉所有提供的迭代器中的数据。由于迭代器中的元素只能访问一次，没有办法倒回去，因此这里就需要引
        # 起我们的注意了。如果之后还需要倒回去访问前面的数据，那也许就应该先将数据转到列表去。
        pass
    pass



''' 4.8: 跳过可迭代对象中的前一部分元素 '''
def node4_8():
    def question():
        '''
        问题: 我们想对某个可迭代对象做迭代处理，但是我们对前面几个元素并不感兴趣，只想将它们废弃。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # itertools模块中有一些函数可用来解决这个问题。第一个是itertools.dropwhile()函数。要使用它只要提供一个函数和一个可迭代
        # 对象即可。该函数返回的迭代器会丢弃掉序列中的前面几个元素，只要它们在所提供的函数中返回True即可（即，我们提供的那个函数起一个
        # 筛子的作用，满足条件的都会被丢弃直到有元素不满足为止）。这之后，序列中剩余的全部元素都会产生出来。

        # 为了说明，假设我们正在读取一个文件，文件的开头有一系列的注释行。示例如下:
        # with open('/etc/passwd') as f:
        #     for line in f:
        #         print(line, end='')

        # 如果想跳过所有的初始注释行，这里有一种方法:
        from itertools import dropwhile
        with open('/etc/passwd') as f:
            for line in dropwhile(lambda line: line.startswith('#'), f):
                print(line, end='')

        # 这个例子是根据测试函数的结果来跳过前面的元素。如果恰好知道要跳过多少个元素，那么可以使用itertools.islice()。示例如下:
        from itertools import islice
        items = ['a', 'b', 'c', 1, 4, 10, 15]
        for x in islice(items, 3, None):
            print(x)
        # 输出:
        # 1
        # 4
        # 10
        # 15

        # 在这个例子中，islice()的最后一个参数None用来表示想要前3个元素之外的所有元素，而不是只要前3个元素（即，表示切片[3:]，而不是[:3]）
    pass


    def discuss():
        '''
        讨论
        '''
        # dropwhile()和islice()都是很方便使用的函数，可以利用他们来避免写出如下所示的混乱代码:
        with open('/etc/passwd') as f:
            # Skip over intial comments
            while True:
                line = next(f, '')
                if not line.startswith('#'):
                    break

        # Process remaining lines
        while line:
            # Replace with useful processing
            print(line, end='')
            line = next(f, None)

        # 只丢弃可迭代对象中的前一部分元素和对全部元素进行过滤也是有所区别的。例如，本节第一个示例也许可以重写为如下代码:
        with open('/etc/passwd') as f:
            lines = (line for line in f if not line.startswith('#'))
            for line in lines:
                print(line, end='')

        # 这么做显然会会丢弃开始部分的注释行，但这样会丢弃整个文件中出现的所有注释行。而本节开始给出的解决方案知乎丢弃元素，直到有某个
        # 元素全部会不经过筛选而直接返回。

        # 最后应该要强调的是，本节所展示的技术可适用于所有的可迭代对象，包括那些事先无法确定大小的对象也是如此。这包括生成器、文件以及
        # 类似的对象。
        pass
    pass



''' 4.9: 迭代所有可能的组合或排列 '''
def node4_9():
    def question():
        '''
        问题: 我们想对一些列元素所有可能的组合或排列进行迭代。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 为了解决这个问题，itertools模块中提供给了3个函数。第一个是itertools.permutations()--它接受一个元素集合，将其中所有的
        # 元素重排列为所有可能的情况，并以元组序列的形式返回（即，将元素之间的顺序打乱成所有可能的情况）。示例如下:
        items = ['a', 'b', 'c']
        from itertools import permutations
        for permutation in permutations(items):
            print(permutation)
        # 输出:
        # ('a', 'b', 'c')
        # ('a', 'c', 'b')
        # ('b', 'a', 'c')
        # ('b', 'c', 'a')
        # ('c', 'a', 'b')
        # ('c', 'b', 'a')

        # 如果想要得到较短长度的所有全排列，可以提供一个可选的长度参数。示例如下:
        for permutation in permutations(items, 2):
            print(permutation)
        # 输出:
        # ('a', 'b')
        # ('a', 'c')
        # ('b', 'a')
        # ('b', 'c')
        # ('c', 'a')
        # ('c', 'b')
        pass

    def discuss():
        '''
        讨论
        '''
        pass

    pass



''' 4.10: 以索引值对的形式迭代序列 '''
def node4_10():
    def question():
        '''
        问题: 我们想迭代一个序列，但是又想记录下序列中当前处理到的元素索引。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 內建的enumerate()函数可以非常漂亮的解决这个问题:
        my_list = ['a', 'b', 'c']
        for idx, val in enumerate(my_list):
            print(idx, val)
        # 输出:
        # 0 a
        # 1 b
        # 2 c

        # 如果要打印出规范的行号（这种情况下一般是从1开始而不是0），可以传入一个start参数作为起始索引:
        for idx, val in enumerate(my_list, 1):
            print(idx, val)
        # 输出:
        # 1 a
        # 2 b
        # 3 c

        # 这种情况特别适合用于跟踪记录文件中的行号，当想在错误信息中加上行号时就特别有用了。示例如下:
        def parse_data(filename):
            with open(filename, 'rt') as f:
                for lineno, line in enumerate(f, 1):
                    fields = line.split()
                    try:
                        count = int(fields[1])
                        # ...
                    except ValueError as e:
                        print('Line {}: Parse error: {}'.format(lineno, e))

        # enumerate()可以很方便的用来跟踪记录特定的值出现在列表中的偏移位置。比如想将文件中的单词和他们所出现的行之间建立映射关系，则可以通过
        # enumerate()来将每个单词映射到文件相应的偏移位置来实现。示例如下:
        from collections import defaultdict
        word_summary = defaultdict(list)
        with open('myfile.txt', 'r') as f:
            lines = f.readlines()
        for idx, line in enumerate(lines):
            words = [w.strip().lower() for w in line.split()]
            for word in words:
                word_summary[word].append(idx)

        # 处理完文件之后，如果打印word_summary,将得到一个字典（准确的说应该是一个defaultdict）而且每个单词都是字典的键。每个单词键所对应的值
        # 就是由行号组成的列表，表示这个单词曾出现过的所有行。如果单词在一行中出现过2次，那么这个行号就会记录两次，这使得我们可以识别出文本中各种
        # 简单的韵律。
        pass

    def discuss():
        '''
        讨论
        '''
        # 对于那些可能想自己保存一个计数器的场景，enumerate()函数是个不错的选择，而且更加便捷。我们可以像这样编写代码:
        # lineno = 1
        # for line in f:
        #     # Process line
        # ...
        # lineno += 1

        # 但是，通常更优雅的做法是使用enumerate():
        # for lineno, line in enumerate(f):
        #     # Process line
        # ...

        # enumerate()返回值是一个enumerate()对象实例，它是一个迭代器，可返回连续的元组。元组由一个索引值和对传入的序列调用next()而得到的值组
        # 成。

        # 尽管只是个很小的问题，这里还是值得提一下。有时候当在元组序列上应用enumerate()时，如果元组本身也本分解展开的话就会出错。要正确处理元组序
        # 列，必须像这样编写代码:
        data = [(1, 2), (3, 4), (5, 6), (7, 8)]

        # Correct!
        for n, (x, y) in enumerate(data):
            print(n, x, y)

        # Error!
        for n, x, y in enumerate(data):
            print(n, x, y)
        # ValueError: not enough values to unpack (expected 3, got 2)

        pass
    pass



''' 4.11: 同时迭代多个序列 '''
def node4_11():
    def question():
        '''
        问题: 我们想要迭代的元素包含在多个序列中，我们想同时对它们进行迭代。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 可以使用zip()函数来同时迭代多个序列。示例如下:
        xpts = [1, 5, 4, 2, 10, 7]
        ypts = [101, 78, 37, 15, 62, 99]
        for x, y in zip(xpts, ypts):
            print(x, y)
        # 输出:
        # 1 101
        # 5 78
        # 4 37
        # 2 15
        # 10 62
        # 7 99

        # zip(a, b)的工作原理是创建出一个迭代器，该迭代器可产生出元组(x, y)，这里的x取自a，y取自序列b。当其中某个元素可以继续迭代时，整个迭代过
        # 程结束。因此，整个迭代的长度和其中最短的输入序列长度相同。示例如下:
        a = [1, 2, 3]
        b = ['w', 'x', 'y', 'z']
        for i in zip(a, b):
            print(i)
        # 输出:
        # (1, 'w')
        # (2, 'x')
        # (3, 'y')

        # 如果这种行为不是所需要的，可以使用itertools.zip_longest()来替代。示例如下:
        from itertools import zip_longest
        for i in zip_longest(a, b):
            print(i)
        # 输出:
        # (1, 'w')
        # (2, 'x')
        # (3, 'y')
        # (None, 'z')

        for i in zip_longest(a, b, fillvalue=0):
            print(i)
        # 输出:
        # (1, 'w')
        # (2, 'x')
        # (3, 'y')
        # (0, 'z')
        pass


    def discuss():
        '''
        讨论
        '''
        # zip()通常在需要将不同的数据配对在一起时。例如，假设有一列标题和一列对应的值，示例如下:
        headers = ['name', 'shares', 'price']
        values = ['ACME', '100', '490.1']

        # 使用zip()，可以将这些值配对在一起来构建一个字典，就像这样:
        s = dict(zip(headers, values))
        print(s)
        # 输出: {'name': 'ACME', 'shares': '100', 'price': '490.1'}

        # 此外，如果试着产生输出的话，可以编写这样的代码:
        for name, val in zip(headers, values):
            print(name, '=', val)
        # 输出:
        # name = ACME
        # shares = 100
        # price = 490.1

        # 尽管不常见，但是zip()可以接受多于2个序列座位输入。在这种情况下，得到的结果元组离得元素数量和输入序列的数量相同。示例如下:
        a = [1, 2, 3]
        b = [10, 11, 12]
        c = ['x', 'y', 'z']
        for i in zip(a, b, c):
            print(i)
        # 输出:
        # (1, 10, 'x')
        # (2, 11, 'y')
        # (3, 12, 'z')

        # 最后需要强调的是，zip()创建出的结果只是一个迭代器。如果需要将配对的数据保存为列表，那么请使用list函数。示例如下:
        print(zip(a, b))
        # 输出: <zip object at 0x10a34ebc8>
        print(list(zip(a, b)))
        # 输出: [(1, 10), (2, 11), (3, 12)]
        pass
    pass



''' 4.12: 在不同的容器中进行迭代 '''
def node4_12():
    def question():
        '''
        问题: 我们需要对许多对象执行相同的操作，但是这些对象包含在不同的容器内，而我们可以避免写出嵌套的循环处理，保持代码的可读性。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # itertools.chain()方法可以用来简化这个任务。它接受一系列可迭代对象作为输入并返回一个迭代器，这个迭代器能够有效的掩盖一个事实————你实
        # 际上是在对多个容器进行迭代。为了说明清楚，请考虑下面这个例子:
        from itertools import chain
        a = [1, 2, 3, 4]
        b = ['x', 'y', 'z']
        for x in chain(a, b):
            print(x)
        # 输出:
        # 1
        # 2
        # 3
        # 4
        # x
        # y
        # z

        # 在程序中，chain()常见的用途是想一次性对所有的元素执行某项特定的操作，但是这些元素分散在不同的集合中。比如:

        # # Various working sets of items
        # active_items = set()
        # inactive_item = set()
        #
        # # Iterate over all items
        # for item in chain(active_items, inactive_item):
        #     # Process item
        #     # ...

        # 采用chain()的解决方案要比下面这种写两个单独的循环要优雅的多:
        # for item in active_items:
        #     # Process item
        #     # ...
        # for item in inactive_item:
        #     # Process item
        #     # ...
        pass

    def discuss():
        '''
        讨论
        '''
        # itertools.chain()可接受一个或多个可迭代对象作为参数，然后它会创建一个迭代器，该迭代器可连续访问并返回你提供的每个可迭代对象中的元素。
        # 尽管区别很小，但是chain()比首先将各个序列合并在一起然后再迭代要更加高效。实例如下:
        # Inefficent
        # for x in a + b:
        #     ...

        # Better
        # for x in chain(a, b):
        #     ...

        # 第一种情况中a+b产生了一个全新的序列，此外还要求a和b是同一种类型，chain()并不会做这样的操作，因此如果输出序列很庞大的话，在内存的使用上
        # 使用chain()就会高效的多，而且当可迭代对象不是同一种类型时也可以轻松的使用。
        pass
    pass



''' 4.13: 创建处理数据的管道 '''
def node4_13():
    def question():
        '''
        问题: 我们想以流水线的形式对数据进行迭代处理（类似UNIX下的管道）比方说我们有海量的数据需要处理，但是没法将数据全部加在到内存中去。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 生成器函数是一种实现管道机制的好方法。为了说明，假设我们有一个超大的目录，其中都是想要处理的日志文件:
        # foo/
        #   access-log-012007.gz
        #   access-log-022007.gz
        #   access-log-032007.gz
        #   ...
        #   access-log-012008

        # bar/
        #   access-log-092007.bz2
        #   ...
        #   access-log-022008

        # 假设每个文件都包含如下形式的数据行:
        # 124.115.6.12 - - [10/Jul/2012:00:18:50 -0500] "GET /robots.txt" 200 71
        # 210.212.209.67 - - [10/Jul/2012:00:18:51 -0500] "GET /ply/ ..." 200 11875
        # 210.212.209.67 - - [10/Jul/2012:00:18:51 -0500] "GET /robots.txt" 404 369
        # 61.135.216.105 - - [10/Jul/2012:00:20:04 -0500] "GET /robots.txt" 304 -
        # ...

        # 要处理这些文件。可以定义一系列小型的生成器函数，每个函数执行特定的独立任务。示例如下:
        import os
        import fnmatch
        import gzip
        import bz2
        import re

        def gen_find(filepat, top):
            '''
            Find all filenames in a directory tree that match a shell wildcard pattern
            '''
            for path, dirlist, filelist in os.walk(top):
                for name in fnmatch.filter(filelist, filepat):
                    yield os.path.join(path, name)

        def gen_opener(filenames):
            '''
            Open a sequence of fileames one at a time producing a file object.
            The file is closed immediately when proceeding to the next iteration.
            '''
            for filename in filenames:
                if filename.endwith('.gz'):
                    f = gzip.open(filename, 'rt')
                elif filename.endwith('.bz2'):
                    f = bz2.open(filename, 'rt')
                else:
                    f = open(filename, 'rt')
                yield f
                f.close()

        def gen_concatenate(iterators):
            '''
            Chain a sequence of iterators together into a single sequence
            '''
            for it in iterators:
                yield from it

        def gen_grep(pattern, lines):
            '''
            Look for a regex pattern in a sequence of lines
            '''
            pat = re.compile(pattern)
            for line in lines:
                if pat.search(line):
                    yield line

        # 现在可以简单的将这些函数堆叠起来形成一个数据处理的管道。例如，要找出所有包含关键字python的日志行，只需要这么做:
        lognames = gen_find('access-log', 'www')
        files = gen_opener(lognames)
        lines = gen_concatenate(files)
        pylines = gen_grep('(?i)python', lines)
        for line in pylines:
            print(line)

        # 如果稍后想对管道进行扩展，甚至可以再生成器表达式中填充数据。比如下面这个版本可以找出传送的字节数并统计总字节量:
        lognames = gen_find('access-log*', 'www')
        files = gen_opener(lognames)
        lines = gen_concatenate(files)
        pylines = gen_grep('(?i)python', lines)
        bytecolumn = (line.rsplit(None, 1)[1] for line in pylines)
        bytes = (int(x) for x in bytecolumn if x != '-')
        print('Total', sum(bytes))
        pass


    def discuss():
        '''
        讨论
        '''
        # 将数据以管道的形式进行处理可以很好的适用于其他广泛的问题，包括解析、读取实时的数据源、定期轮询等。
        # 要理解这些代码，很重要的一点是领会yield语句的含义。在这里yield语句表现为数据的产生者，而for循环表现为数据的消费者。当生成器被串联起来
        # 时，在迭代中每个yield语句都为管道中下个阶段的处理过程产生出数据。在最后的那个例子中，sum()函数实际上在驱动这整个程序，每次都从生成器管
        # 道中取出一份数据。

        # 这种方法的一个优点在于每个生成器函数都比较短小而且功能独立，正因为如此，编写和维护都比较容易。在许多情况下，由于他们是如此的通用，因此可
        # 以在其他上下文中得到重用。最终，将这些组件粘合在一起的代码读起来就像一份食谱一样简单，一次更容易理解。

        # 这种方法在内存使用的高效性上也同样值得夸耀。如果目录中有着海联的文件要处理，上述展示的代码仍然可以正常工作。实际上，由于处理过程的迭代特
        # 性这里只会用到非常少的内存。

        # 关于gen_concatenate()函数还有一些非常微妙的地方需要说明。这个函数的目的是将输入序列连接为一个长序列行。itertools.chain()函数可以
        # 实现类似的功能，但是这需要将所有的可迭代对象指定它的参数才行。在这个特定的例子中，这么做将涉及一行这样的代码:
        # lines = itertools.chain(*files)，这回导致gen_opener()生成器被完全耗尽。由于这个生成器产生的打开文件的序列，它们在下一个迭代步骤
        # 中会被立刻关闭，因此这里不能用chain()。我们展示的解决方案避免了这个问题。

        # 此外，gen_concatenate()函数中出现了实现为委托给一个子生成器的yield from 语句。语句yield from it 简单的使用gen_concatenate()
        # 函数发射出所有由生成器it产生的值。这一点将在4.14节中做进一步描述。

        # 最后但同样重要的是，应该指出管道方法并不会总是适用于每一个数据处理问题。有时候我们需要马上处理所有数据。但是，就算是这种情况，使用生成器
        # 管道可以在逻辑上将问题分解成一种工作流程。

        # David Beazley在他的"针对系统程序员值生成器技巧"教程报告（http://www.dabeaz.com/generators）中已经对这些技术做了广泛的讨论。可
        # 以参阅他的教程以获得更多的示例。
        pass
    pass



''' 4.14: 扁平化处理嵌套型的序列 '''
def node4_14():
    def question():
        '''
        问题: 我们有一个嵌套型的序列，想将它扁平化处理为一列单独的值。
        '''
        pass
    
    
    def scheme():
        '''
        方案 
        '''
        # 这个问题可以很容易地通过写一个带有yield from语句的递归生成器函数来解决。示例如下:
        from collections import Iterable
        def flatten(items, ignore_types=(str, bytes)):
            for x in items:
                if isinstance(x, Iterable) and not isinstance(x, ignore_types):
                    yield from flatten(x)
                else:
                    yield x

        items =  [1, 2, [3, 4, [5, 6], 7], 8]
        for x in flatten(items):
            print(x)
        # 输出:
        # 1
        # 2
        # 3
        # 4
        # 5
        # 6
        # 7
        # 8

        # 在上述代码中，isinstance(x, Iterable)简单地检查是否有某个元素是否是可迭代的。如果确实有，那么就用yield from将这个可迭代对象作为一
        # 种子例程进行递归，将它所有的值都产生出来。最后得到的结果就是一个没有嵌套的单值序列。

        # 代码中额外的参数ignore_types和对not isinstance(x, ignore_types)的检查是为了避免将字符串和字节串解释为可迭代对象。进而将它们展开
        # 为单独的一个字符。这使得嵌套型的字符串列表能以大多数人所期望的方式工作。示例如下:
        items = ['Dave', 'Paula', ['Thomas', 'Lewis']]
        for x in flatten(items):
            print(x)
        # 输出:
        # Dave
        # Paula
        # Thomas
        # Lewis
        pass
    
    def discuss():
        '''
        讨论
        '''
        # 如果想编写生成器来把其他的生成器当做子例程调用，yield from是个不错的快捷方式。如果不这么用，就需要编写额外for循环的代码，比如这样:
        from collections import Iterable
        def flatten(items, ignore_types=(str, bytes)):
            for x in items:
                if isinstance(x, Iterable) and not isinstance(x, ignore_types):
                    for i in flatten(x):
                        yield i
                else:
                    yield x

        # 尽管只是个小小的改变，但是使用yield from语句感觉更好，也使得代码变得更加清晰。前面提到，对字符串和字节串的额外检查是为了将这些类型的对
        # 象展开为单独的字符。如果还有其他类型是不想要展开的，可以为ignore_types参数提供不同的值来确定。

        # 最后应该要提到的是，yield from在涉及到协程（coroutine）和基于生成器的并发型高级程序中有着更加重要的作用。请参见12.12节中的另一个示
        # 例。
        pass
    pass



''' 4.15: 合并多个有序序列，再对整个有序序列进行迭代 '''
def node4_15():
    def question():
        '''
        问题: 我们有一组有序序列，想对它们合并在一起之后的有序序列进行迭代。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 对于这个问题，heapq.merge()函数正式我们所需要的。示例如下:
        import heapq
        a = [1, 4, 7, 10]
        b = [2, 5, 6, 11]
        for c in heapq.merge(a, b):
            print(c)
        # 输出:
        # 1
        # 2
        # 4
        # 5
        # 6
        # 7
        # 10
        # 11
        pass

    def discuss():
        '''
        讨论
        '''
        # heapq.merge的迭代性质意味着它对所有提供的序列都不会做一次性读取。这以为着可以利用它处理非常长的序列，而开销却非常小。例如，下面这个例子
        # 告诉我们如何合并两个有序的文件:
        import heapq
        with open('sorted_file_1', 'rt') as file1, \
             open('sorted_file_2', 'rt') as file2, \
             open('merged_file', 'wt') as outf:
            for line in heapq.merge(file1, file2):
                outf.write(line)

        # 需要重点强调的是，heapq.merge()要求所有的输入序列都是有序的。特别是它不会首先将所有的数据读取到堆中，或者预先做任何的排序操作。它也不
        # 会对输入做任何验证。以检查它们是否满足有序的要求。相反，它只是简单的检查每个输入序列中的第一个元素，将最小的那个发送出去。然后再从之前的
        # 选择序列中读取一个新的元素，再重复执行这个步骤，直到所有的输入序列都耗尽为止，
        pass
    pass



''' 4.16: 用迭代器取代while循环 '''
def node4_16():
    def question():
        '''
        问题: 我们得代码采用while循环来迭代处理数据，因为这其中涉及调用某个函数或有某种不常见的测试条件，而这些东西没法归类为常见的迭代模式。
        '''
        pass


    def scheme():
        '''
        方案
        '''
        # 在涉及I/O处理的程序中，编写这样的代码是很常见的:
        CHUNKSIZE = 8192
        def reader(s):
            while True:
                data = s.recv(CHUNKSIZE)
                if data == b'':
                    break
                #process_data(data)

        # 这样的代码常常可以用iter()来替换，比如:
        def reader(s):
            for chunk in iter(lambda: s.recv(CHUNKSIZE), b''):
                pass
                #process_data(data)

        # 如果对这样的代码能否正常工作持有怀疑态度。可以用一个有关文件处理的类似例子试验一下:
        import sys
        f = open('/etc/passwd')
        for chunk in iter(lambda: f.read(10), ''):
            n = sys.stdout.write(chunk)
            print(n)
        pass


    def discuss():
        '''
        讨论
        '''
        # 关于內建函数iter()，一个少有人知的特性是它可以选择性接受一个无参的可调用对象以及一个哨兵（结束）值作为输入。当以这种方式使用时，iter()
        # 会创建一个迭代器，然后重复调用用户提供的可调用对象，直到它返回哨兵值为止。

        # 这种特定的方式对于需要重复调用函数的情况，比如这些涉及I/O的问题，有很好的效果。比如，如果想从socket或文件中按块读取数据，通常会重复调用
        # read()或者recv()，然后紧跟着检查时候到达文件结尾。而我们给出的解决方案简单地将这两个功能合并为一个单独的iter()调用。解决方案中对
        # lambda的使用是为了创建一个不带参数的可调用对象，但是还是可以对recv()或read()提供所需要的参数。
        pass

    pass