#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'文档注释'

__author__ = 'Cocoa.'


import math
import os
import stat
# print("Hello World")


# classmates = ["Michael", "Bob", "Tracy"]
# x = classmates.pop()
# print(x)
# print(" =============")
# print(classmates)


# age = 3
# if age >= 18:
#     print("你以成年")
# else:
#     print("未成年")

# names = ["Michael", "Bob", "Tracy"]
# for name in names:
#     print(name)
#     print("=========")

# sum = 0
# for x in range(2,101,3):
#     sum += x
# print(sum)
# range(1)



# dict 和 set
# names = {"Michael": 95,
#          "Bob": 70,
#          "Tracy": 78}
# if "a" in names:
#     print(names["a"])
# else:
#     print("names字典中中部存在a这个key")




# Function
# def my_abs(x):
#     if not isinstance(x, (int, float)):
#         raise TypeError("bad operand type")
#     if x >= 0:
#         return x
#     else:
#         return -x
#
# print(my_abs(-15.000000000000000000001))
#
# # 返回多个值,实际上是返回一个元组，这一点swift同样
# def move(x, y, step, angle=0):
#     nx = x + step * math.cos(angle)
#     ny = y - step * math.cos(angle)
#     return nx, ny
#
# x, y = move(100, 100, 60, math.pi / 6)
# print(x)
# print(y)

# 可变参数
# def calculateSum(*args):
#     sum = 0
#     for n in args:
#         sum += n
#     return sum
#
# print(calculateSum(1, 2, 3))

# 关键字参数
# 可以扩展函数的功能，如果做一个用户注册的功能，除了用户名和年龄必须，其他都是选填项，用关键字参数这个函数就能满足注册的功能
# def person(name, age, **kw):
#     print(" name:", name, "\n", "age:", age, "\n", "other:", kw)
# print(person("王小二", 16, city="北京", job="程序员"))


# 比较有意思的一点，虽然很灵活，但容易造成混乱
# 任何函数都可以通过类似func(*args, **kw)的形式调用它。无论参数是如何定义的
# def func(a, b, c=0, *args, **kw):
#     print('a =', a, 'b =', b, 'c =', c, 'args =', args, 'kw =', kw)
#
# args = (1, 2, 3, 4)
# kw = {"x": 99}
# func(*args, **kw) #a = 1 b = 2 c = 3 args = (4,) kw = {'x': 99}

# 注意点:::::::::::
# 默认参数一定要是用不可变对象，如果是可变对象，运行会出现逻辑错误！
# 使用 [*args] 和 [**kw]是python的习惯写法，当然也可以用其他的参数名，但最好使用习惯用法


# 递归函数
# 递归函数可能会造成栈溢出: 函数的调用是通过栈这种数据结构实现的，每单进入一个函数调用，栈加一层，函数return栈减一层。由于栈的大小不是无限的， 所以，递归调用次数过多会引起栈溢出
# 解决这种问题得办法就是通过尾递归
# 可惜的是，大多数编程语言没有针对为递归做优化，Python解释器也没有做优化，即使改用尾递归的方式调用，依然会导致栈溢出。

# 正常版本:
# def fact(n):
#     if n==1:
#         return 1
#     return n * fact(n - 1)
# print(fact(100))

# 尾递归版本
# def fact(n):
#     return fact_iter(n, 1)
#
# def fact_iter(num, product):
#     if num == 1:
#         return 1
#     return fact_iter(num - 1, num * product)
#
# fact(1000)




# 高级特性

# 切片,List,元组,字符串都可以进行切片操作
# L = ['Michael', 'Sarah', 'Tracy', 'Bob', 'Jack']
# print(L[5:3])


# # 迭代
# from collections import Iterable
#
# d = {"a": 1,
#      "b": 2,
#      "c": 3}
#
# for key in d:
#     print(key)
#
#
# print(isinstance("abc", Iterable))
#
# for x, (y, z) in enumerate([(1, 1), (2, 4), (3, 9)]):
#     print(x, y, z)


# # 列表生成式
# a = [x for x in range(1, 11)]
#
# print(a)
# if isinstance(a, list):
#     print("是列表")
#
# # 可以进行判断
# print([x * x for x in range(1, 11) if x % 2 == 0])
#
# # 两层循环进行全排列
# print([m+n for m in "ABC" for n in "XYZ"])
#
# # 列出文件
# import os
# print([d for d in os.listdir(".")])

# d = {"a": 0,
#      "b": 1,
#      "c": 2}
# for k, v in d.items():
#     print(k, "=", v)
#
# l = ["Hello", "World", "IBM", "Apple"]
# print(' '.join([x.lower() for x in l]))



# 生成器Generator: list保存的是元素，generator保存的是算法，这样可以节省很多的空间
# g = (x * x for x in range(1, 10))
# for n in g:
#     print(n)

# 斐波拉契数列
# def fib(max):
#     n, a, b = 0, 0, 1
#     while n < max:
#         yield b
#         a, b = b, a+b
#         n += 1
#
# print([x for x in fib(100)])



# 函数式编程

# 高阶函数
from functools import reduce


# def add(x, y, f):
#     return f(x) + f(y)
# print(add(-5, -6, abs))
#
#
# def f(x):
#     return str(x)
# a = map(f, [1,2,3,4,5,6,7,8,'9'])
# print([x for x in a])
#
#
# def fn(x, y):
#     return x * 10 + y
# b = reduce(fn, [1, 3, 5, 7, 9])
# print(b)

# 将str转换为int
# def str2int(s):
#     def fn(x, y):
#         return x * 10 + y
#     def char2num(s):
#         return {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4,
#                 '5': 5, '6': 6, '7': 7, '8': 8, '9': 9}[s]
#     return reduce(fn, map(char2num, s))
#
# print(str2int("783"))


# def is_odd(n):
#     return n % 2 == 1
# a = list(filter(is_odd, [1, 2, 3, 4, 5, 6, 7, 8, 9]))
# print(a)


# 素数
# def _odd_iter():
#     n = 1
#     while True:
#         n = n + 2
#         yield n
#
# def _not_divisible(n):
#     a = lambda x: x % n > 0
#     return a
#
# def primes():
#     yield 2
#     it = _odd_iter()
#     while True:
#         n = next(it)
#         yield n
#         it = filter(_not_divisible(n), it)
#
# for n in primes():
#     if n < 1000:
#         # print(n)
#         pass
#     else:
#         break


# a = "123abc"
# b = a.strip("626")
# print(b)


# L = [('Bob', 75), ('Adam', 92), ('Bart', 66), ('Lisa', 88)]
# def by_name(t):
#     if isinstance(t, tuple):
#         return str(t[0]).lower()
#     else:
#         print("类型不正确")
#
# print(sorted(L, key=by_name, reverse=True))
# print(sorted(L, key=lambda t: str(t[0]).lower(), reverse=False))


# 返回函数
# def lazy_sum(*args):
#     def sum():
#         x = 0
#         for n in args:
#             x += n
#         return x
#     return sum
#
# print(lazy_sum(1, 2, 3, 4, 5)())


# 闭包

# 错误的做法
# def count():
#     fs = []
#     for i in range(1, 4):
#         def f():
#             return i * i
#         fs.append(f)
#     return fs
#
# f1, f2, f3 = count()
# print(f1(), f2(), f3()) # 9 9 9

# 正确的做法
# def count():
#     def f(s):
#         def g():
#             return s * s
#         return g
#
#     fs = []
#     for i in range(1, 4):
#         fs.append(f(i))
#     return fs
#
# f1, f2, f3 = count()
# print(f1(), f2(), f3()) # 1 4 9




# 匿名函数
# 在Python中对匿名函数提供有限的支持。使用lambda关键字定义一个匿名函数
# a = list(map(lambda x: x * x, [1, 2, 3, 4, 5, 6, 7, 8, 9]))
# print(a)



# 装饰器
# 由于函数也是一个对象，而且函数对象可以被赋值给变量，所以，通过变量也能调用该函数。
# 现在，假设我们要增强now()函数的功能，比如在函数调用前后自动打印日志，但又不希望修改now()函数的定义，这种在代码运行期动态增加功能的方式，称之为"装饰器（Decorator）"
# 本质上Decorator就是一个返回函数的高阶函数。所以，我们要定义一个能打印日志的decorator可以定义如下:
# def log(func):
#     def wrapper(*args, **kw):
#         print('call %s():' % func.__name__)
#         return func(*args, **kw)
#     return wrapper
#
# @log
# def now():
#     print("2017-6-13")
# now()

# 如果decorator本身也需要传入参数，那么就编写一个返回decorator的高阶函数

# import functools
# import types
# def log(text):
#
#     if isinstance(text, str):
#
#         def decorator(func):
#             @functools.wraps(func)
#             def wrapper(*args, **kwargs):
#                 param = (text, func.__name__)
#                 print('BEGIN... %s %s()' % param)
#                 func(*args, **kwargs)
#                 print('END... %s %s()' % param)
#             return wrapper
#         return decorator
#
#     elif isinstance(text, types.FunctionType):
#         @functools.wraps(text)
#         def wrapper(*args, **kwargs):
#             fun_name = text.__name__
#             print('BEGIN... %s()' % fun_name)
#             text(*args, **kwargs)
#             print('END... %s()' % fun_name)
#         return wrapper
#
#     else:
#         raise ValueError
#         def decorator(func):
#             @functools.wraps(func)
#             def wrapper(*args, **kwargs):
#                 fun_name = func.__name__
#                 print('BEGIN... %s()' % fun_name)
#                 func(*args, **kwargs)
#                 print('END... %s()' % fun_name)
#             return wrapper
#         return decorator
#
#
# try:
#     @log(1)
#     def f(a, b, c):
#         print(a + b + c)
# except ValueError:
#     def f(a, b, c):
#         print(a + b + c)
#     print("捕获成功")
#
# f(1, 2, 3)



# 模块
import sys

# def test():
#     args = sys.argv
#     if len(args) == 1:
#         print("Hello World")
#     elif len(args) == 2:
#         print("Hello, %s" % args[1])
#     else:
#         print("Too many arguments")
#
# # 当我们在命令行运行这个模块文件时，Python解释器把一个特殊变量__name__置为__main__，而如果在其他地方导入该模块，if判断将失败
# # 因此，这种if测试可以让一个模块通过命令行运行一些额外的代码，最常见的就是运行测试
# if __name__ == '__main__':
#     test()

# print(sys.path)




# 面向对象编程

# 封装
# 对于面向对象来说本身就是一层封装

# class Student(object):
#     def __init__(self, name, score):
#         self.name = name
#         self.score = score
#
#     def printScore(self):
#         print('%s: %s' % (self.name, self.score))
#
# bart = Student('Bart Simpson', 59)
# lisa = Student('Lisa Simpson', 89)
# bart.printScore()
# lisa.printScore()

# 继承
# class Animal:
#     def run(self):
#         print('Animal is running')
#
# class Dog(Animal):
#     def wangwang(self):
#         print('Wang...Wang...')
#
# class Cat(Animal):
#     def miao(self):
#         print('miao.......')
#
# dog = Dog()
# dog.run()
# dog.wangwang()

# 多态
# 当父类的方法不能满足子类的需求时，可以override父类方法，在代码运行时，总会调用子类的方法
# class Animal:
#     def run(self):
#         print('Animal is running')
#
# class Dog(Animal):
#     def run(self):
#         print('Dog is running')
#
#     def wangwang(self):
#         print('Wang...Wang...')
#
# class Cat(Animal):
#     def run(self):
#         print('Dog is running')
#
#     def miao(self):
#         print('miao.......')




# 使用__slots__
# 如果想限制一个类的实例属性怎么办？比如只允许对Student实例添加name和age属性
# 为了达到限制目的，Python允许在定义Class的时候，定义一个特殊的__slots__变量，来限制class实例能添加的属性
# 使用__slots__定义的属性仅对当前类的实例起作用，对继承的子类是不起作用的：
# class Student:
#
#     @property
#     def score(self):
#         return self._score
#
#     @score.setter
#     def score(self, value):
#         if not isinstance(value, int):
#             raise ValueError('score must be an integer')
#         if value < 0 or value > 100:
#             raise ValueError('score must between 0 ~ 100!')
#         self._score = value
#
# a = Student()
# a.score = 100
# print(a.score)




# class Fib:
#     def __init__(self):
#         self.a = 0
#         self.b = 1
#
#     def __str__(self):
#         return 'Fib a = %s, b = %s' % (self.a, self.b)
#
#     def __iter__(self):
#         return self
#
#     def __next__(self):
#         self.a, self.b = self.b, self.a + self.b
#         if self.a > 100000:
#             raise StopIteration()
#         return self.a
#
#     def __getitem__(self, item):
#         # item是个索引
#         if isinstance(item, int):
#             a, b = 1, 1
#             for x in range(item):
#                 a, b = b, a + b
#             return a
#
#         # item是切片
#         if isinstance(item, slice):
#             start = item.start
#             stop = item.stop
#             if start is None:
#                 start = 0
#             a, b = 1, 1
#             L = []
#             for x in range(stop):
#                 if x >= start:
#                     L.append(a)
#                 a, b = b, a + b
#             return L
#
# f = Fib()
# print(f[10:15])
#
# for n in Fib():
#     print(n)


# class Chain:
#
#     def __init__(self, path=''):
#         self._path = path
#
#     def __getattr__(self, item):
#         return Chain('%s/%s' % (self._path, item))
#
#     def __str__(self):
#         return self._path
#
#     # 实例本身上调用方法
#     def __call__(self, *args, **kwargs):
#         print("这是一个实例本身的方法")
#         return 'Call'
#
#     __repr__ = __str__
#
# print(Chain().status.user.timeline.list)
# print(Chain()())


######################################################
# 枚举
######################################################
# from enum import Enum
# Month = Enum('Month', ('Jan',
#                        'Feb',
#                        'Mar',
#                        'Apr',
#                        'May',
#                        'Jun',
#                        'Jul',
#                        'Aug',
#                        'Sep',
#                        'Oct',
#                        'Nov',
#                        'Dec'))
#
# for name, member in Month.__members__.items():
#     print(name, '=>', member, ',', member.value)

# # 如果需要更精确地控制枚举类型，可以从Enum派生出自定义的类
# from enum import Enum, unique
#
# @unique #unique装饰器可以保重没有重复的值
# class Weekday(Enum):
#     Sun = 0
#     Mon = 1
#     Tue = 2
#     Wed = 3
#     Thu = 4
#     Fri = 5
#     Sat = 6
# day1 = Weekday.Mon
# print(day1)
# print(Weekday(3))




######################################################
# 元类
######################################################
# 动态的创建一个类使用type()函数
# type参数1: class的名称
#     参数2: 继承的父类集合，Python支持多重继承，如果只有一个父类，注意tuple的单元素写法
#     参数3: class的方法名称与函数绑定，这里我们把函数fn绑定到hello上fn1绑定到hi上

# def fn(self, name='world'):
#     print('Hello, ', name)
#
# def fn1(self, name='python'):
#     print('你好, ', name)
#
# Hello = type('Hello', (object,), dict(hello=fn, hi=fn1))
# h = Hello()
# print(h.hi())


# metaclass有部分类似于swift或oc中的分类
# metaclass元类,先定义metaclass就可以创建类，最后创建实例
# metaclass允许你创建类或修改类。可以把类看成是metaclass创建出来的实例
# metaclass是类的模板，所以必须从'type'类型派生
# class ListMetaclass(type):
#     def __new__(cls, name, bases, attrs):
#
#         def add(self, value):
#             self.append(value)
#             return self
#         attrs['add'] = add
#
#         return type.__new__(cls, name, bases, attrs)
#
# class MyList(list, metaclass=ListMetaclass):
#     pass
#
# L = MyList()
# print(L.add(1))



# # 元类的使用实例：ORM: "Object Relational Mapping"（对象-关系映射）
# # 类似swift中的'''ObjectMapper'''
# class Field:
#     def __init__(self, name, column_type):
#         self.name = name
#         self.column_type = column_type
#
#     def __str__(self):
#         return '<%s:%s>' % (self.__class__.__name__, self.name)
#
# # 在Field的基础上，进一步定义各种类型的Field
# class StringField(Field):
#     def __init__(self, name):
#         super(StringField, self).__init__(name, 'varchar(100)')
#
# class IntegerField(Field):
#     def __init__(self, name):
#         super(IntegerField, self).__init__(name, 'bigint')
#
# # ModelMetaclass
# class ModelMetaclass(type):
#     def __new__(cls, name, bases, attrs):
#
#         if name=='Model':
#             return type.__new__(cls, name, bases, attrs)
#         print('Found model: %s' % name)
#         mappings = dict()
#         for key, value in attrs.items():
#             if isinstance(value, Field):
#                 print('Found mapping: %s ==> %s' % (key, value))
#                 mappings[key] = value
#
#         for key in mappings.keys():
#             attrs.pop(key)
#
#         attrs['__mappings__'] = mappings # 保存属性和列的映射关系
#         attrs['__table__'] = name
#         return type.__new__(cls, name, bases, attrs)
#
# # 基类Model
# class Model(dict, metaclass=ModelMetaclass):
#     def __init__(self, **kw):
#         super(Model, self).__init__(**kw)
#
#     def __getattr__(self, item):
#         try:
#             return self[item]
#         except KeyError:
#             raise AttributeError("'Model' object has no attribute '%s'" % item)
#
#     def __setattr__(self, key, value):
#         self[key] = value
#
#     def save(self):
#         fields = []
#         params = []
#         args = []
#         for k, v in self.__mappings__.items():
#             fields.append(v.name)
#             params.append('?')
#             args.append(getattr(self, k, None))
#         sql = 'INSERT INTO %s (%s) VALUES (%s)' % (self.__table__, ','.join(fields), ','.join(params))
#         print('SQL: %s' % sql)
#         print('ARGS: %s' % str(args))
#
# # 当用户定义一个class User(Model)时，python解释器首先在当前类User的定义中查找metaclass，如果没有找到
# # 就继续在父类Model中查找metaclass，找到了，就使用Model中定义的metaclass的ModelMetaclass来创建User
# # 也就是说metaclass可以隐式的继承到子类中去，但子类自己却感觉不到
#
# # 在ModelMetaclass中，一共做了几件事情：
# # 1.排除掉Model类的修改
# # 2.在当前类中查找定义的类的所有属性，如果找到一个Field属性就把它保存到一个__mappings__的dict中。同时从头属性列表中删除该Field属性，否则容易造成运行时错误。
# # 3.把表明保存到__table__中，这里简化表名默认为类名
#
# # 在Model类中定义了一个save方法。自然就可以定义数据的其他操作方法比如delete(),find(),update()等
#
#
# class User(Model):
#     id = IntegerField('id')
#     name = StringField('name')
#     email = StringField('email')
#     password = StringField('password')
#
# u = User(id=123, name='Lucy', email='test@wannar.com', password='my-pwd')
# u.save()



################################################################
# 错误、调试、测试
################################################################
# try:
#     print('try....')
#     r = 10 / int('a')
#     print('result: ', r)
# except ZeroDivisionError as e:
#     print('except:', e)
# except ValueError as e:
#     print('except:', e)
# finally:
#     print('finallay....')
# print('END')

# 使用try...except捕获错误还有一个好处就是可以跨层捕获。比如main()调用foo()，foo()调用bar()，结果 bar()出错了，这时只要main()捕获到，就可以处理
# 不需要再每个可能出错的地方去捕获错误，只要在合适的层去捕获错误就可以
# 问题：怎么知道这个方法可能出错？

# 错误记录使用logging模块
# import logging
# def foo(s):
#     return 10 / int(s)
#
# def bar(s):
#     return foo(s) * 2
#
# def main():
#     try:
#         bar('0')
#     except Exception as e:
#         logging.exception(e)
#         print('Error: ', e)
#     finally:
#         print('Finally...')
# main()


# 抛出错误
# 因为错误时class，捕获一个错误就是捕获一个class实例。因此，错误并不是凭空产生的，而是有意抛出的。我们自己编写的函数也可以抛出错误
# class FooError(ValueError):
#     pass
#
# def foo(s):
#     n = int(s)
#     if n == 0:
#         raise FooError('invalid value: %s' % s)
#     return 10 / n
#
# foo(0)


# # 调试：print，assert，logging
# # 调试的一种办法是用print打印信息，但是会产生甚多垃圾信息，日后还需删除
# # 凡是用到print辅助的地方都是可以用assert来替代
# # 程序中到处都是assert也不是太好，启动Python解释器时可以用-o参数来关闭assert [ python3 -o err.py ]
# # 还有一种处理方式是用logging
# import logging
# # 使用logging的好处之一就是可以指定记录信息的级别
# # 级别: debug，info，warning，error。当我们指定level=INFO时，logging.debug就不起作用了。这样一来可以放心输出不同级别的信息。
# logging.basicConfig(level=logging.INFO)
#
# # 使用pdb.set_trace()暂停并进入pdb调试环境，可用用命令p查看变量，或命令c继续运行。
# import pdb
#
# def foo(s):
#     n = int(s)
#     assert n != 0, 'n is zero!'
#
#     return 10 / n
#
# def main():
#     foo('0')
#
# main()


# # 单元测试
# class Dict(dict):
#     def __init__(self, **kwargs):
#         super().__init__(**kwargs)
#
#     def __getattr__(self, item):
#         try:
#             return self[key]
#         except KeyError:
#             raise AttributeError("'Dict' object has no attribute '%s'" % key)
#
#     def __setattr__(self, key, value):
#         self[key] = value
#
# # 为了编写单元测是需要引入unittest模块
# import unittest
# class TestDict(unittest.TestCase):
#
#     def setUp(self):
#         print('开始单元测试')
#
#     def tearDown(self):
#         print('结束单元测试')
#
#     def test_init(self):
#         d = Dict(a=1, b='test')
#         self.assertEqual(d.a, 1)
#         self.assertEqual(d.b, 'test')
#         self.assertTrue(isinstance(d, dict))
#
#     def test_key(self):
#         d = Dict()
#         d['key'] = 'value'
#         self.assertEqual(d.key, 'value')
#
#     def test_arrt(self):
#         d = Dict()
#         d['key'] = 'value'
#         self.assertTrue('key' in d)
#         self.assertEqual(d['key'], 'value')
#
#     def test_keyerror(self):
#         d = Dict()
#         with self.assertRaises(KeyError):
#             value = d['empty']
#with
#     def test_attrerror(self):
#         d = Dict()
#         with self.assertRaises(AttributeError):
#             value = d.empty
#
#     if __name__ == '__main__':
#         unittest.main()

###############################################################################################
# IO编程
###############################################################################################
# 【【【【【 文件读写 】】】】】
# 文件使用结束之后必须调用close()方法关闭文件，因为文件对象会占用操作系统的资源，同一时间打开文件的个数也是有限的
# 读写文件的时候最好使用try...finally形式实现，因为读写过程中很可能发生错误，就不会关闭文件，浪费内存
# 但是每次都这样写太繁琐另一种语法是with语句，可以自动帮我们调用close()方法
# ::::::注意::::::
# read()方法会一次性读取文件的全部内容，如果文件过大，内存会爆掉
# 1. read(size)每次最多读取size个字节的内容
# 2. readline()每次可以读取一行的内容
# 3. readlines()一次读取所有内容并按行返回

# try:
#     path = '/Users/fuguoliang/Desktop/Python/Test.py'
#     if os.path.exists(path) and os.path.isfile(path):
#         f = open('/Users/fuguoliang/Desktop/Python/Test.py', 'r')
#         content = f.read()
#         if isinstance(content, str):
#             print("这是一个字符串")
# finally:
#     f.close()
#
# # @@@
# path = '/Users/fuguoliang/Desktop/Python/Test.py'
# if os.path.exists(path) and os.path.isfile(path):
#     with open('/Users/fuguoliang/Desktop/Python/Test.py', 'r') as f:
#         content = f.read()
#         if isinstance(content, str):
#             print("这是一个文件字符串")


# 二进制文件
# 上面所说为文本文件，并且是UTF-8编码的文本文件。要读取二进制文件，比如图片，视频等。用'rb'模式打开即可
# path = '/Users/fuguoliang/Desktop/7.29.1副本.psd'
# if os.path.exists(path) and os.path.isfile(path):
#     f = open('/Users/fuguoliang/Desktop/7.29.1副本.psd', 'rb')
#     content = f.read()
#     if isinstance(content, str):
#         print("这是一个str类型")
#     elif isinstance(content, bytes):
#         print('这是一个bytes类型')
#         print(content)
#     else:
#         print('类型未处理')


# 创建一个文件
# 使用os.mknod('test.txt') 创建空文件
# fp = open('test.txt', w) 直接打开一个文件, 如果文件不存在则创建文件
# path = '/Users/fuguoliang/Desktop/Python/log.txt'
# with open(path, 'a') as f:
#     for x in range(1, 101):
#         s = ''
#         if x != 100:
#             s = str(x) + ', '
#         else:
#             s = str(x)
#         f.write(s)


# 【【【【【 StringIO 和 BytesIO 】】】】】
# from io import StringIO
# f = StringIO()
# f.write('hello')
# f.write(' ')
# f.write('world!')
# print(f.getvalue())

# f = StringIO('Hello!\nHi!\nGoodbye!')
# while True:
#     s = f.readline()
#     if s == '':
#         break
#     print(s.strip())

# from io import BytesIO
# f = BytesIO()
# f.write('中文'.encode('utf-8'))
# print(f.getvalue())
#
# f = BytesIO(b'\xe4\xb8\xad\xe6\x96\x87')
# print(f.read())

# 【【【【【 操作文件和目录 】】】】】
# 查看操作系统名称可以使用name()
# 查看详细系统信息可以使用uname(),但是在window上不提供这个函数，也就是说os模块的某些函数是跟操作系统相关的
# print(os.name)
# print(os.uname())

# 环境变量
# 在操作系统中定义的环境变量，全部保存在os.environ这个变量中,可以直接查看
# print(os.environ.get('PATH'))

# 操作文件和目录
# 操作文件和目录的函数一部分放在os模块中，一部分放在os.path模块中
# 要使用join函数，这个函数根据不同的操作系统进行不同的操作，Mac.Linux.Unix路径分隔符'/',Windows '\'

# 查看当前目录的局对路径
# print(os.path.abspath('.'))

# 在某个目录下创建一个新的目录，首先把新的目录的完整路径表示出来
# path = os.path.join('/Users/fuguoliang/Desktop/Python', 'log')
# os.mkdir(path)
# os.rmdir(path)

# 拆分,后一部分总是最后级别的目录或文件名
# print(os.path.split('/Users/fuguoliang/Desktop/Python/log.txt'))

# 文件扩展名
# print(os.path.splitext('/Users/fuguoliang/Desktop/Python/log.txt'))

# 文件重命名
# os.rename('log.txt', 'logs.txt')

# 复制文件的函数不在os模块中！原因是复制文件并非操作系统提供的系统调用。理论上讲，我们可以通过读写文件完成复制，但是要多些很多的代码。
# 幸运的是shutil模块中提供了copyfile()函数，还有很多实用的函数也存在这个模块中。可以看成是对os模块的扩展
# path = '/Users/fuguoliang/Desktop'
# l = [x for x in os.listdir(path) if os.path.isdir(os.path.join(path, x))]
# print(l)



# 【【【【【 序列化 】】】】】
# 在程序运行过程中，所有的变量都是存在内存中。比如一个dict，我们可以随时修改变量。
# d = dict(name='Bob', age=20, scroe=88)
# 可以随时修改变量，比如将name变为'Bill'但一旦程序结束，变量回收。所占内存被回收。下次重新运行又变成'Bob'
# 我们把变量从内存中变成可存储的传输过程称之为序列化。在Python中叫pickling。序列化之后就可以将数据写入磁盘或传输到别的机器。
# 反过来，把变量内容从序列化的对象重新读取到内存中称之为反序列化，在Python中叫unpickling。
# :::::: 注意 ::::::
# Pickle的问题和所有其他变成语言特有的序列化问题一样，就是它只能用于Python，并且不同版本的python可能彼此不兼容，因此，只能用Pickle保存那些不重要的数据，不能成功的反序列化也没有关系。

import pickle
# d = dict(name='Bob', age=20, scroe=88)
# print(pickle.dumps(d))
#
# with open('dump.txt', 'wb') as f:
#     pickle.dump(d, f)

# 反序列化
# with open('dump.txt', 'rb') as f:
#     d = pickle.load(f)
#     print(d)


# JSON
import json

# d = dict(name='Bob', age=20, score=88)
# print(json.dumps(d))
#
# json_str = '{"age": 20, "score": 88, "name": "Bob"}'
# print(json.loads(json_str))

# class Student(object):
#     def __init__(self, name, age, score):
#         self.name = name
#         self.age = age
#         self.score = score
#
#
# def student2dict(std):
#     return {
#         'name': std.name,
#         'age': std.age,
#         'score': std.score
#     }
#
# s = Student('Bob', 20, 88)
# print(json.dumps(s, default=student2dict))
# 还可以使用如下方法，把任意class的实例变为dict。因为class的实例都有一个__dict__属性，他就是一个dict，用来存储实例变量。
# 但是也有少数例外，比如定义了__slots__的class
# print(json.dumps(s, default=lambda obj: obj.__dict__))



###############################################################
# 进程和线程
###############################################################
# 【【【【【 多进程 】】】】】
# Unix/Linux操作系统提供了一个fork()系统调用，它非常特殊。普通的函数调用，调用一次，返回一次。而这个函数的调用，调用一次，返回两次。因为操作系统自动把当前进程（父进程）复制一份（子进程），分别在父进程和子进程内返回。
# 子进程永远返回0，而父进程返回子进程的ID。这样做的理由是，一个父进程可以fork出很多子进程，所以父进程要记下每个子进程的ID。而子进程只需调用getppid()函数就可以拿到父进程的ID。
# 由于Windows上没有fork调用，上面代码在Windows上无法运行
# 有了fork调用，一个进程在接到新任务时就可以复制出一个子进程来处理任务。常见的Apache服务器就是由父进程监听端口，每单有新的http请求，就fork出子进程来处理新的http请求。
# print('Process (%s) start...' % os.getpid())
# pid = os.fork()
# if pid == 0:
#     print("I'm child progress (%s) and my parent is (%s)" % (os.getpid(), os.getppid()))
# else:
#     print("I (%s) just created a child progress (%s)" % (os.getpid(), pid))



# 跨平台多进程的支持。multiprocessing是跨平台版本的多进程模块
from multiprocessing import Process
from multiprocessing import Pool
import os, time, random

# 子进程要执行的代码
# 用process创建一个实例，start()方法启动，join()方法可以等待子进程结束后再继续往下运行。通常用于进程间的同步。
# def run_proc(name):
#     print('Run child progress %s (%s)...' % (name, os.getpid()))
#
# if __name__ == '__main__':
#     print('Parent progress %s.' % os.getpid())
#     p = Process(target=run_proc, args=('test',))
#     print('child process will start')
#     p.start()
#     p.join()
#     print('child process end')

# 如果要启动大量的子进程，可以采用进程池的方式批量创建。
# 对Pool对象滴啊用join()方法会等待所有子进程执行完毕，调用join()之前必须调用close()，调用close()之后便不会再继续添加新的Process
# def longTimeTask(name):
#     print('Run task %s (%s)...' % (name, os.getpid()))
#     start = time.time()
#     time.sleep(random.random() * 3)
#     end = time.time()
#     print('Task %s runs %0.2f seconds' % (name, (end - start)))
#
# if __name__ == '__main__':
#     print('Parent process %s' % os.getpid())
#     p = Pool(15) # 不传值应该是可以得到cpu核心数
#     for i in range(15):
#         p.apply_async(longTimeTask, args=(i,))
#     print('Waiting for all subprocess done...')
#     p.close()
#     p.join()
#     print('All subprocesses done')

# 有时候子进程并不是自身，而是一个外部进程。我们创建子进程后，还需控制子进程的输入和输出。
# subprocess模块可以容纳干我们非常方便的启动一个子进程，然后控制输入和输出
# 下面的例子和命令行直接运行的效果是一样的。
import subprocess
# print('$ nslookup www.python.org')
# r = subprocess.call(['nslookup', 'www.python.org'])
# print('Eixt code:', r)

# 如果子进程还需要输入，则可通过communicate()方法输入：
# print('$ nslookup')
# p = subprocess.Popen(['nslookup'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
# ouput, err = p.communicate(b'set q=mx\npython.org\nexit\n')
# print(ouput.decode('utf-8'))
# print('Exit code:', p.returncode)


# 进程之间的通信
# process 之间是需要通信的，操作系统提供了很多机制来实现进程间的通信，Python的multiprocessing模块包装了底层机制，提供了Queue、Pipes等多种方式来交换数据。
# 例子：在父进程中创建两个子进程，一个往Queue里写数据，一个从Queue里读数据
# from multiprocessing import Process, Queue
# import os, time, random
#
# # 写数据进程执行的代码
# def write(q):
#     print('Process to write: %s' % os.getpid())
#     for value in ['A', 'B', 'C']:
#         print('put %s to queue...' % value)
#         q.put(value)
#         time.sleep(random.random())
#
# def read(q):
#     print('Process to read: %s' % os.getpid())
#     while True:
#         value = q.get(True)
#         print('Get %s from queue.' % value)
#
# if __name__ == '__main__':
#     # 父进程创建Queue，并传给各个子进程
#     q = Queue()
#     pw = Process(target=write, args=(q,))
#     pr = Process(target=read, args=(q,))
#     # 启动子进程
#     pw.start()
#     pr.start()
#     # 等待pw结束
#     pw.join()
#     # pr进程是死循环，无法等待结束，只能强行终止
#     pr.terminate()



# 【【【【【 多线程 】】】】】
# 多线程两个模块'_therad' 和 'threading' _therad是低级模块，threading是高级封装
# 新线程执行的代码
# import time, threading
#
# def loop():
#     print('thread %s is running...' % threading.current_thread().name)
#     n = 0
#     while n < 5:
#         n = n + 1
#         print('thread %s >>> %s' % (threading.current_thread().name, n))
#         time.sleep(1)
#     print('thread %s ended' % threading.current_thread().name)
#
# print('thread %s is running...' % threading.current_thread().name)
# t = threading.Thread(target=loop, name='LoopThread')
# t.start()
# t.join()
# print('thread %s ended' % threading.current_thread().name)


# Lock
# balance = balance + n在cpu执行的时候也是分成多条语句
# 1.计算balance + n 存入临时变量中
# 2.将临时变量赋值给balance
#   x = balance + n
#   balance = x
# 这样多线程一开启的时候，就容易产生混乱，原因就是修改balance需要多条语句，而执行这几条语句时，线程可能中断，从而导致多个线程把同一个对象给弄乱了。

# import time, threading
#
# balance = 0
# lock = threading.Lock()
# def change_it(n):
#     lock.acquire()
#     try:
#         global balance
#         balance = balance + n
#         balance = balance - n + 1
#     finally:
#         lock.release()
#
# def run_thread(n):
#     for i in range(1000000):
#         change_it(n)
#
# t1 = threading.Thread(target=run_thread, args=(5,))
# t2 = threading.Thread(target=run_thread, args=(8,))
# t1.start()
# t2.start()
# t1.join()
# t2.join()
# print(balance)


# 【【【【【 分布式进程 】】】】】
# 在thread和process中应当优先选用Process，因为Process更稳定，而且Process可以分不到多台机器上，而Thread最多只能分布在一台机器的不同cpu上
# 例：如果我们已经有一个通过Queue通信的多进程程序在同一台机器上运行，现在，由于处理任务的进程任务繁重，希望把发送任务的进程和处理任务的进程分布到两台机器上。
# 原有的Queue可以继续使用，但是通过managers模块把Queue通过网络暴露出去，就可以让其他的机器访问Queue了。
# 服务进程负责启动Queue，把Queue注册到网络上，然后往Queue里面写入任务

# import random, time, queue, sys
# from multiprocessing.managers import BaseManager
#
# # 发送任务的队列
# task_queue = queue.Queue()
# # 接受结果的队列
# result_queue = queue.Queue()
#
# # 从BaseManager继承的QueueManager:
# class QueueManager(BaseManager):
#     pass
#
# # 将两个Queue都注册到网络上，callable参数关联了Queue对象
# QueueManager.register('get_task_queue', callable=lambda: task_queue)
# QueueManager.register('get_result_queue', callable=lambda: result_queue)
#
# # 绑定端口，设置验证码
# manager = QueueManager(address=('127.0.0.1', 5000), authkey=b'abc')
# manager.start()
#
# # 获得通过网络访问的Queue对象
# task = manager.get_task_queue()
# result = manager.get_result_queue()
#
# # 放几个任务进去
# for i in range(10):
#     n = random.randint(0, 10000)
#     print('Put task %d...' % n)
#     task.put(n)
#
#
#
#
#
#
# # 接受结果的队列
# QueueManager.register('get_task_queue')
# QueueManager.register('get_result_queue')
#
# # 连接到服务器，也就是运行task_master.py的机器
# server_addr = '127.0.0.1'
# print('Connect to server %s ...' % server_addr)
# m = QueueManager(address=(server_addr, 5000), authkey=b'abc')
#
# # 从网络连接
# m.connect()
#
# # 获取Queue对象
# ta = manager.get_task_queue()
# re = manager.get_result_queue()
#
# # 从task队列取任务，并把结果写入result队列
# for i in range(10):
#     try:
#         n = ta.get(timeout=1)
#         print('Run task %d * %d' % (n, n))
#         r = '%d * %d = %d' % (n, n, n * n)
#         time.sleep(1)
#         re.put(r)
#     except queue.Empty:
#         print('task queue is empty')
#
# # 处理结束
# print('worker exit')
#
#
#
# # --------------------------------------------------
# # 从rusult队列中读取结果
# print('Try get result...')
# for i in range(10):
#     r = result.get(timeout=10)
#     print('Result: %s' % r)
#
# # 关闭:
# manager.shutdown()
# print('master exit')
# # ---------------------------------------------------


# ####################################################################################
# 常用内建模块
# ####################################################################################
# 【【【【【 collections 】】】】】

# nameedtuple
# 有点类似结构体的功能，给元组增加别名，方便阅读与使用
# 这个在swift中也有实现, 算是一种语法糖
from collections import namedtuple
# Point = namedtuple('Point', ['x_pox', 'y_pox'])
# p = Point(1, 2)
# print(p.x_pox)

# deque
# 使用list存储数据时，按索引访问元素很快，但是如果要执行插入和删除元素就很慢了，因为list是线性存储，当数据量大的时候，插入和删除操作效率很低
# deque是为了高效实现插入和删除操作的双向列表，适合用于队列和栈
# from collections import deque
# q = deque(['a', 'b', 'c'])
# q.append('x')
# q.appendleft('y')
# print(q)

# defaultdict
# 在使用dict时，如果引用的Key不存在就会抛出KeyError。如果希望key不存在时返回一个默认值，就使用它
# from collections import defaultdict
# dd = defaultdict(lambda : 'N/A')
# dd['key1'] = 'abc'
# print(dd['key1'])
# print(dd['key2'])

# OrderedDict
# 在使用dict时，Key是无序的。在对dict做迭代的时候，我们无法确定key的顺序
# 如果要保持Key的顺序可以使用OrderedDict
# 这个顺序是插入的顺序，而不是按照key的本身进行排序
# from collections import OrderedDict
# d = OrderedDict([('a', 1), ('c', 3), ('b', 2)])
# print(d)

# Counter
# Counter是一个简单的计数器，例如，统计字符出现的个数:
# 这个东西的本质就是一个字典，将字典的值设置为出现的次数
# from collections import Counter
# c = Counter()
# for ch in 'programming':
#     c[ch] = c[ch] + 1
# print(c)

# 使用字典实现,之后再进行排序。如上OrderDict
# d = dict()
# for ch in 'programming':
#     if ch in d:
#         d[ch] = d[ch] + 1
#     else:
#         d[ch] = 1
# print(d)


# 【【【【【 struct 】】】】】
# Python没有专门处理字节的数据类型。struct是用来处理字节数据类型的扩展
# >表示字节顺序是big-endian，也就是网络序，I表示4字节无符号整数。后面的参数个数要和处理指令一致。
# import struct
# a = struct.pack('>I', 10230099)
# print(a)

# unpack把bytes变成相应的数据类型
# b = struct.unpack('>IH', b'\xf0\xf0\xf0\xf0\x80\x80')
# print(b)


# 【【【【【 hashlib 】】】】】
# 摘要算法，MD5,SHA1等是摘要算法。摘要算法又称哈希算法、散列算法。它通过一个函数把任意长度的数据类型转换为一个长度固定的数据串（通常用16进制的字符串表示）
# md5是最常见的摘要算法，速度很快，生成结果是固定的128bit字节，通常用一个32位的16制字符串表示。
# 另一个常见的摘要算法是SHA1，调用SHA1和调用MD5完全类似。SHA1的结果是160bit字节，通常用40位的16进制字符串表示。
# 比SHA1算法更安全的是SHA256和SHA512.但是越安全的算法速度越慢，而且字符长度越长
# import hashlib
# from hashlib import md5
# from hashlib import sha1
#
# md51 = hashlib.md5()
# md51.update('how to use md5 in python hashlib?'.encode('utf-8'))
# print(md51.hexdigest())
#
# # 如果数据量很大，可以分块多次调用update(),计算的结果是一样的：
# md5 = hashlib.md5()
# md5.update('how to use md5 in '.encode('utf-8'))
# md5.update('python hashlib?'.encode('utf-8'))
# print(md5.hexdigest())
#
# sha1 = hashlib.sha1()
# sha1.update('how to use sha1 in '.encode('utf-8'))
# sha1.update('python hashlib?'.encode('utf-8'))
# print(sha1.hexdigest())

# 【【【【【 itertools 】】】】】
# Python的内建模块itertools提供了非常有用的用于操作迭代的对象。一下是itertools提供的几个无限迭代器：
# import itertools

# natuals = itertools.count(1)
# for n in natuals:
#     if n > 100:
#         break
#     print(n)


# cycle()会把传入的一个序列无限重复下去：
# cs = itertools.cycle('ABCDEFG')
# cycle_count = 0
# for c in cs:
#     if c == 'A':
#         cycle_count += 1
#
#     if cycle_count <= 3:
#         print(c)


# repeat()负责把一个元素无限重复下去，不过如果提供第二个参数就可以限定重复次数。
# ns = itertools.repeat('A', 3)
# for n in ns:
#     print(n)

# 无限序列虽然可以无限迭代下去，但是通常我们会通过takewhile()等函数根据条件判断来截取一个有限序列
# natuals = itertools.count(1)
# ns = itertools.takewhile(lambda x: x <= 10, natuals)
# print(list(ns))

# chain()可以把一组迭代对象串联起来，形成一个更大的迭代器
# for c in itertools.chain('ABC', 'XYZ'):
#     print(c)

# groupby()把迭代器中相邻的重复元素挑出来放在一起：
# for key, group in itertools.groupby('AaaBBCCCCCDAAAA', lambda c: c.upper()):
#     print(key, list(group))


# 【【【【【 contextlib 】】】】】
# 并不是只有open()函数返回的fp对象才能使用with语句。实际上，任何对象，只要正确的实现了上下文管理，就可以用with语句
# 实现上下文管理是通过__enter__和__exit__这两个方法实现的。例如，下面的class实现了这两个方法。
# class Query:
#     def __init__(self, name):
#         self.name = name
#
#     def __enter__(self):
#         print('Enter')
#         return self
#
#     def __exit__(self, exc_type, exc_val, exc_tb):
#         if exc_type:
#             print('Error')
#         else:
#             print('Exit')
#
#     def query(self):
#         print('Query info about %s ...' % self.name)
#
# # 这样我们就可以把我们自己写的资源对象用于with语句：
# with Query('Bob') as q:
#     q.query()

# @contextmanager
# 编写__enter__、__exit__仍然很繁琐，因此python的标准库contextlib提供了更简单的写法，上面的代码可以改写如下：
# from contextlib import contextmanager
#
# class Query:
#     def __init__(self, name):
#         self.name = name
#
#     def query(self):
#         print('Query info about %s ...' % self.name)
#
#
# @contextmanager
# def creat_query(name):
#     print('Begin')
#     q = Query(name)
#     yield q
#     print('End')
#
# with creat_query('Bob') as q:
#     q.query()

# 有时候我们希望在某段代码执行前后自动执行特定的代码，也可以用@contextmanager实现。
# 这个做打印函数的时候很是不错
# @contextmanager
# def wn_print_temp():
#     print("\n======================================")
#     yield
#     print("======================================\n")
#
# def wn_print(content):
#     with wn_print_temp():
#         print(content)
#
# a = [1, 2, 3]
# wn_print(a)

# @closing
# 如果一个对象没有实现上下文，我们就不能把它用于with语句，这个时候，可以用closing()来把该对象变为上下文对象。例如用with语句使用urlopen（）
# from contextlib import closing
# from urllib.request import urlopen
# from contextlib import contextmanager
#
# with closing(urlopen('https://www.python.org')) as page:
#     for line in page:
#         print(line)

# closing也是一个经过@contextmanager装饰的generator，这个generator编写起来非常简单,他的作用就是吧任意对象变为上下文对象，并支持with语句
# @contextmanager
# def closing(thing):
#     try:
#         yield thing
#     finally:
#         thing.close()


# 【【【【【 XML 】】】】】
# 操作XML有两种方式
# 1.DOM: 把整个XML读入到内存，解析为树。因此占用内存大，解析慢，优点是可以任意遍历树的节点。
# 2.SAX: 是流模式，边读边解析，占用内存小，解析快，缺点是我们需要自己处理事件。
#
# 在Python中使用SAX解析XML非常简洁，通常关心的事件是start_element、end_element、char_data准备好这三个函数就可以解析XML了

# from xml.parsers.expat import ParserCreate
# class DefaultSaxHandle:
#     def start_element(self, name, attrs):
#         print('sax: start_element: %s, attrs: %s' % (name, str(attrs)))
#
#     def end_element(self, name):
#         print('Sax: end_element: %s' % name)
#
#     def char_data(self, text):
#         print('Sax: char_data: %s', text)
#
# xml = r'''<?xml version="1.0"?>
# <ol>
#     <li><a href="/python">Python</a></li>
#     <li><a href="/ruby">Ruby</a></li>
# </ol>
# '''
#
# handler = DefaultSaxHandle()
# parser = ParserCreate()
# parser.StartElementHandler = handler.start_element
# parser.EndElementHandler = handler.end_element
# parser.CharacterDataHandler = handler.char_data
# parser.Parse(xml)


# 【【【【【 HTMLParser 】】】】】
# 编写一个搜索引擎，第一步是用爬虫把目标网站页面抓下来，第二步就是解析该HTML页面，看看里面的内容到底是新闻图片还是视频。
# Python提供了HTMLParser来非常方便的解析HTML，只需简单几行代码
# 特殊字符有两种，一种是英文表示的&nbsp，一种是数字表示的&#1234
# from html.parser import HTMLParser
# from html.entities import name2codepoint
#
# class MyHTMLParser(HTMLParser):
#     def handle_starttag(self, tag, attrs):
#         print('<%s>' % tag)
#
#     def handle_endtag(self, tag):
#         print('<%s>' % tag)
#
#     def handle_startendtag(self, tag, attrs):
#         print('<%s>' % tag)
#
#     def handle_data(self, data):
#         print(data)
#
#     def handle_comment(self, data):
#         print('<!--', data, '-->')
#
#     def handle_entityref(self, name):
#         print('&%s;' % name)
#
#     def handle_charref(self, name):
#         print('&#%s;' % name)
#
# parser = MyHTMLParser()
# parser.feed('''<html>
# <head></head>
# <body>
# <!-- test html parser -->
#     <p>Some <a href=\"#\">html</a> HTML&nbsp;shici...<br>END</p>
# </body></html>''')


# 【【【【【 urllib 】】】】】
# urllib提供了一系列用于操作URL的功能

# GET
# urllib的request模块可以非常方便的抓取URL内容，也就是发送一个GET请求到一个页面，然后返回HTTP响应
# 例如，对豆瓣的一个URL：https://api.douban.com/v2/book/2129650进行抓取，并返回响应
# from urllib import request
# with request.urlopen('https://api.douban.com/v2/book/2129650') as f:
#     data = f.read()
#     print('Status:', f.status, f.reason)
#     for k, v in f.getheaders():
#         print('%s: %s' %(k, v))
#     print('Data:', data.decode('utf-8'))

# 如果我们想要模拟浏览器发送GET请求，就需要使用Request对象，通过往Request对象添加HTTP头，我们就可以把请求伪装成浏览器，例如去模拟iPhone6去请求豆瓣
# from urllib import request
#
# req = request.Request('http://www.douban.com/')
# req.add_header('User-Agent', 'Mozilla/6.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/8.0 Mobile/10A5376e Safari/8536.25')
# with request.urlopen(req) as f:
#     print('Status:', f.status, f.reason)
#     for k, v in f.getheaders():
#         print('%s: %s' % (k, v))
#     print('Data: ', f.read().decode('utf-8'))


# POST
# 如果要以POST发送一个请求，只需要把参数data以bytes形式传入
# 我们模拟一个微博登录，先读取登录的邮箱口令，然后按照weibo.cn的登录页格式以username=xxx&password=xxx的编码传入
# from urllib import request, parse
# print('Login to weibo.cn...')
# email = input('Email:')
# passwd = input('Password:')
# login_data = parse.urlencode([
#     ('username', email),
#     ('password', passwd),
#     ('entry', 'mweibo'),
#     ('client_id', ''),
#     ('savestate', '1'),
#     ('ec', ''),
#     ('pagerefer', 'http://passport.weibo.cn/signin/welcome?entry=mweibo&r=http%3A%2F%2Fm.weibo.cn%2F')
# ])
# req = request.Request('https://passport.weibo.cn/sso/login')
# req.add_header('Origin', 'https://passport.weibo.cn')
# req.add_header('User-Agent', 'Mozilla/6.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/8.0 Mobile/10A5376e Safari/8536.25')
# req.add_header('Referer', 'https://passport.weibo.cn/signin/login?entry=mweibo&res=wel&wm=3349&r=http%3A%2F%2Fm.weibo.cn%2F')
#
# with request.urlopen(req, data=login_data.encode('utf-8')) as f:
#     print('Status:', f.status, f.reason)
#     for k, v in f.getheaders():
#         print('%s: %s' % (k, v))
#     print('Data:', f.read().decode('utf-8'))


# Handler
# 如果还需要更复杂的控制，比如通过一个proxy去访问网站，我们需要利用proxyHandler来处理，示例代码：
# proxy_handler = urllib.request.ProxyHandler({'http': 'http://www.example.com:3128/'})
# proxy_auth_handler = urllib.request.ProxyBasicAuthHandler()
# proxy_auth_handler.add_password('realm', 'host', 'username', 'password')
# opener = urllib.request.build_opener(proxy_handler, proxy_auth_handler)
# with opener.open('http://www.example.com/login.html') as f:
#     pass


# ######################################################
# 常用第三方库 PIL
# ######################################################
# from PIL import Image, ImageFilter
# im = Image.open('test.jpg')
# # 获取尺寸
# w, h = im.size
# print('original image size: %s x %s' % (w, h))
# # 缩放到%50
# im.thumbnail((w/2.0, h/2.0))
# print('Resize image to: %s x %s' % (w/2.0, h/2.0))
# # 把缩放后的图像用jpeg格式进行保存
# im.save('thumbnail.jpg', 'jpeg')

# 其它功能如切片、旋转、滤镜、输出文字、调色板等一应俱全。
# 比如模糊效果
# class WNGaussianBlur(ImageFilter.Filter):
#     name = 'GaussianBlur'
#
#     def __init__(self, radius=2, bounds=None):
#         self.radius = radius
#         self.bounds = bounds
#
#     def filter(self, image):
#         if self.bounds:
#             clips = image.crop(self.bounds).gaussian_blur(self.bounds)
#             image.paste(clips, self.bounds)
#             return image
#         else:
#             return image.gaussian_blur(self.radius)
#
# im = Image.open('test.jpg')
# im2 = im.filter(WNGaussianBlur(radius=1))
# im2.save('blur.jpg', 'jpeg')
# im2.show()

# 生成字母校验码图片
# from PIL import Image, ImageDraw, ImageFont, ImageFilter
# import random
#
# # 随机字母
# def rndChar():
#     return chr(random.randint(65, 90))
#
# # 随机颜色1
# def rndColor():
#     return (random.randint(64, 255), random.randint(64, 255), random.randint(64, 255))
#
# # 随机颜色2
# def rndColor1():
#     return (random.randint(32, 127), random.randint(32, 127), random.randint(32, 127))
#
# # 尺寸
# width = 60 * 4
# height = 60
# image = Image.new('RGB', (width, height), (255, 255, 255))
#
# # 创建Font对象
# font = ImageFont.truetype('Arial.ttf', 36)
#
# # 创建Draw对象
# draw = ImageDraw.Draw(image)
#
# # 填充每个像素
# for x in range(width):
#     for y in range(height):
#         draw.point((x, y), fill=rndColor())
#
# # 输出文字
# for t in range(4):
#     draw.text((60 * t + 10, 10), rndChar(), font=font, fill=rndColor1())
#
# # 模糊
# image = image.filter(ImageFilter.BLUR)
# image.save('code.jpg', 'jpeg')
# image.show()


# ######################################################
# 图形界面
# ######################################################
# from tkinter import *
# import tkinter.messagebox as messagebox
#
# # 从Frame派生一个Application类，这是所有Widget的父容器
# class Application(Frame):
#     def __init__(self, master=None):
#         Frame.__init__(self, master)
#         self.pack()
#         self.creatWidgets()
#
#     def creatWidgets(self):
#         # self.helloLabel = Label(self, text='Hello, world!')
#         # self.helloLabel.pack()
#         # self.quitButton = Button(self, text='Quit', command=self.quit)
#         # self.quitButton.pack()
#         self.nameInput = Entry(self)
#         self.nameInput.pack()
#         self.alertButton = Button(self, text='Hello', command=self.hello)
#         self.alertButton.pack()
#
#     def hello(self):
#         name = self.nameInput.get() or 'world'
#         messagebox.showinfo('Message', 'Hello, %s' % name)
#
# # 在GUI中，每个Button、Label、输入框等，都是一个Widget。Frame则是可以容纳其它Widget的Widget，所有Widget组合起来就是一棵树
# app = Application()
# app.master.title('Hello World')
# app.mainloop()


# ######################################################
# 网络编程
# ######################################################
# 创建一个socket时，AF_INET指定使用IPV4，如果要使用IPV6，就指定AF_INET6.SOCK_STREAM指定使用面向流的TCP协议，这样一个Socket对象就创建成功，但是还没有建立连接
# 客户端要是主动发起连接，必须知道服务器的IP地址和端口号。IP地址可以用域名进行自动转换，但是怎么才能知道服务器的端口号呢？
# 答案是作为服务器，提供什么样子的服务，端口号就必须固定下来。由于我们想要访问网页，因此网页服务器必须把端口号固定在80
# 因为80是Web服务的标准端口。SMTP是25，FTP是21.端口号小于1024的是Internet标准服务的端口，端口号大于1024的，可以任意使用。
# TCP连接创建的是双向通道，双方都可以同时给对方发送数据。但是谁先谁后，怎么协调，要根据具体的协议来决定。例如，HTTP协议规定客户端必须先发请求给服务器，服务器收到后才发送数据给客户端
import socket

# # 创建一个socket
# s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# # 建立连接
# s.connect(('www.python.org', 80))
# # 发送数据
# s.send(b'GET / HTTPS/1.1\r\nHost: www.python.org\r\nConnection: close\r\n\r\n')

# 接受数据
# buffer = []
# while True:
#     # 每次最多接受1k字节
#     d = s.recv(1024)
#     if d:
#         buffer.append(d)
#     else:
#         break
# data = b''.join(buffer)
#
# # 关闭连接
# s.close()
# # 接收到的数据包括HTTP头和网页本身，我们只需要把HTTP头和网页分离，把HTTP头打印出来，网页内容保存到文件
# print(data.decode('utf-8'))
#
# header, html = data.split(b'\r\n\r\n', 1)
# print(header.decode('utf-8'))
# # 把接收到的数据写入文件：
# with open('wannar.html', 'wb') as f:
#     f.write(html)

# 服务器
# 和客户端相比，服务器编程要复杂一些，服务器进程首先要绑定一个端口来监听来自其他客户端的连接，如果某个客户端连接过来，服务器就与该客户端建立Scoket连接，随后的通信就靠这个Socket连接。
# 所以，服务器会打开固定端口监听每来一个客户端连接，就创建socket连接。由于服务器会有大量的来自客户端的连接，所以，服务器要能够区分一个socket连接是和那个客户端绑定的买一个socket一来4项：服务器地址、服务器端口、客户端地址、客户端端口来唯一确定一个Socket。
# 但是服务器还需要同事响应多个客户端的请求。所以每个连接都需要一个新的进程或者线程来处理。否则服务器就只能服务一个客户端了。


# ################################################################
# Email
# ################################################################
# SMTP发送邮件

# from email.mime.text import MIMEText
# msg = MIMEText("Hello, send by python...", 'plain', 'utf-8')
# user_name = input('From: ')
# password = input('Password: ')
# # 收件人地址
# to_address = input('To: ')
# # 输入SMTP服务器地址
# smtp_server = input('SMTP Server: ')
#
# import smtplib
# # SMTP协议默认端口号是25
# server = smtplib.SMTP(smtp_server, 25)
# server.set_debuglevel(1)
# server.login(user_name, password)
# server.sendmail(user_name, [to_address], msg.as_string())
# server.quit()




# ################################################################
# 数据库
# ################################################################
##### 使用SQLite #####
import sqlite3

# 连接到SQLite数据库
# 数据库文件是test.db
# 如果文件不存在，会自动在当前目录创建
# conn = sqlite3.connect('test.db')
# # 创建一个Cursor
# cursor = conn.cursor()
# # 执行一条SQL语句，创建一个user表
# # cursor.execute('CREATE table user (id varchar(20) primary key, name varchar(20))')
# # 继续执行一条SQL语句，插入一条记录
# cursor.execute('insert into USER (id , name ) VALUES (\'3\', \'Michael\')')
# # 通过rowcount获得插入的行数
# print('插入的行数' + str(cursor.rowcount))
# # 关闭Cursor
# cursor.close()
# # 提交事务
# conn.commit()
# # 关闭Connection
# conn.close()

# # 查询记录
# conn1 = sqlite3.connect('test.db')
# cursor1 = conn1.cursor()
# data = {'1':'张三1',
#         '2':'李四1',
#         '3':'王二1'}
#
# for k, v in data.items():
#     sql = "UPDATE user SET name='%s' WHERE id='%s'" % (v, k)
#     print(sql)
#     cursor1.execute(sql)
#
# cursor1.execute('SELECT * FROM user WHERE id IN (\'1\', \'2\', \'3\')')
# value = cursor1.fetchall()
# print(value)
# cursor1.close()
# conn1.commit()
# conn1.close()

##### 使用MySQL #####
# 与SQLite对不
# MySQL是Web世界中使用最广泛的数据库服务器。SQLite的特点是轻量级、可嵌入，但是不能承受高并发的访问，适合桌面和移动应用。
# MySQL是为服务器端设计的数据库，能承受高并发访问，同时占有的内存也远远大于SQLite
# MySQL内部有很多数据库引擎，最常用的引擎是支持数据库事务的InnoDB


##### SQLAlchemy #####
# 数据库是一个二维表，包含多行多列。把一个表的内容用Python的数据结构百试出来的话，可以用一个list表示多行，list的每一个元素是tuple，表示一行记录，比如，包含id和name的user表：
# [
#     ('1', 'Michael'),
#     ('2', 'Bob'),
#     ('3', 'Adam')
# ]
# 但是用tuple表示一行很难看出表的结构。如果把一个tuple用class实例来表示。就可以很容易看出表的结构
# 这就是传说中的ORM技术：Object-Relational Mapping 把关系数据库的表结构映射到对象上。
# 所以ORM框架应运而生，在Python中最出名的框架是SQLAlcemy。
# class User:
#     def __init__(self, id, name):
#         self.id = id
#         self.name = name
# a = [User('1', 'Michael'),
#      User('1', 'Michael'),
#      User('1', 'Michael')]


# # 导入:
# from sqlalchemy import Column, String, create_engine
# from sqlalchemy.orm import sessionmaker
# from sqlalchemy.ext.declarative import declarative_base
#
# # 创建对象的基类:
# Base = declarative_base()
#
# # 定义User对象:
# class User(Base):
#     # 表的名字:
#     __tablename__ = 'user'
#
#     # 表的结构:
#     id = Column(String(20), primary_key=True)
#     name = Column(String(20))
#
# # 初始化数据库连接:
# engine = create_engine('mysql+mysqlconnector://root:password@localhost:3306/test')
# # 创建DBSession类型:
# DBSession = sessionmaker(bind=engine)
#
# # 添加 #
# # 创建session对象:
# session = DBSession()
# # 创建新User对象:
# new_user = User(id='5', name='Bob')
# # 添加到session:
# session.add(new_user)
# # 提交即保存到数据库:
# session.commit()
# # 关闭session:
# session.close()
#
# # 读取 #
# # 创建Session:
# session = DBSession()
# # 创建Query查询，filter是where条件，最后调用one()返回唯一行，如果调用all()则返回所有行:
# user = session.query(User).filter(User.id=='5').one()
# # 打印类型和对象的name属性:
# print('type:', type(user))
# print('name:', user.name)
# # 关闭Session:
# session.close()



# ################################################################
# Web开发
# ################################################################
# 名词解释：
# CS：client-server（客户端-服务器）模式
# BS：browser-server（浏览器-服务器）模式
# Web开发几个阶段
# 1.静态Web页面：由文本编辑器直接编辑并生成静态的HTML页面，如果要修改web页面的内容，就需要再次编辑HTML源文件，再起的互联网Web页面就是静态的。
# 2.CGI：Common Gateway Interface公共网关接口，由于静态页面无法与用户交互，比如用户填写一个注册表单，静态Web页面就无法处理。这个的出现是为了处理用户发送的动态数据。
# 3.ASP/JSP/PHP：由于Web应用的特点是频繁修改，用C/C++这样的低级语言非常不适合Web开发，而脚本语言由于开发效率高，与HTML结合紧密，因此，迅速取代了CGI模式。ASP是微软退出的用VBScript脚本编程的Web开发技术，JSP使用Java编写脚本，PHP本身则是开源的脚本语言。
# 4.MVC：为了解决直接用脚本语言嵌入HTML导致的可维护性差的问题，Web引用也引入了Model-View-Controller的模式，来简化Web开发。ASP发展成了ASP.Net，JSP和PHP也有一堆的MVC框架。

##### HTTP协议简介 #####
# 在Web应用中，服务器把网页传给浏览器，实际上就是把网页的HTML代码发送给浏览器，让浏览器显示出来。而浏览器和服务器之间的传输协议是HTTP，所以：
# 1.HTML是一种定义网页的文本，会HTML就能编写网页。
# 2.HTTP是在网络上传输HTML的协议，用于浏览器和服务器的通讯。

# http请求的流程
# 1.浏览器想服务器发送HTTP请求，请求包括：
#   [方法]：GET.仅请求资源，POST.会附带用户数据
#   [路径]：/full/url/path;
#   [域名]：由Host头指定，Host：www.sina.com.cn
#   以及其他相关的Header
#   如果是POST，那么请求还包括一个Body，包含用户数据
# 2.服务器向浏览器返回HTTP响应，响应包括：
#   [响应代码]: 200表示成功，3xx表示重定向，4xx表示客户端发送的请求有误，5xx表示服务器端处理时发生错误。
#   [响应类型]: 由Content-Type指定
#   以及其他相关的Header
#   通常服务器的HTTP响应会携带内容，也就是一个body，包含响应的内容，网页的HTML源码就在Body中
# 3.如果浏览器还需要继续想服务器请求其他的资源，比如图片，就再次发送HTTP请求，重复1.2

# Web采用的HTTP协议是非常简单的请求-响应模式，从而大大简化了开发，当我们编写一个页面时，我们只需要在HTTP请求中把HTML发送出去，不需要考虑如何附带图片、视频等，浏览器如果需要请求图片和视频，它会发送另一个HTTP请求，因此，一个HTTP请求只处理一个资源。
# HTTP协议同事具备极强的扩展性，虽然浏览器请求的是http://www.sina.com.cn/的首页，但是只要新浪在HTML中链入其他服务器的资源，比如<img src="http://i1.sinaimg.cn/home/2013/1008/U8455P30DT2013008135420.png>,从而将请求压力分散到各个服务器，并且买一个站点可以链入到其他的站点，无数个站点之间的相互链接，就形成了World Wide Web，简称WWW。
# 当存在Content-Encoding时，Body的数据是被压缩的，最常见的压缩方式是gzip，所以，看到Content-Encoding: gzip时，需要将Body数据线解压缩，才能得到真正的数据，压缩的目的是减少Body的大小，加快网络的传输。


##### WSGI接口 ##### Python3中这个有问题
# Web Server Gateway Interface
# WSGI接口定义非常简单，它只要Web开发者实现一个函数，就可以相应HTTP请求。我们来看一个最简单的Web版本的HelloWorld

# 第一个参数：包含所有HTTP请求信息的dict对象
# 第二个参数：一个发送HTTP响应的函数
# def application(env, start_response):
#     start_response("200 OK", [("Content-Type, text/html")])
#     return ['<h1>Hello, Web!</h1>']
#
# # 这个函数这么调用？如果我们自己调用，两个参数environ和start_response我们没法提供，返回的bytes也没法发送给浏览器
# # 所以application函数必须由WSGI服务器来调用，有很多符合WSGI规范的服务器，我们可以挑选一个来用，但是现在，我们只想尽快测试一下我们写的application()函数是否真的可以把HTML输出到浏览器，所有我们要赶紧找到一个最简单的WSGI服务器。
# # 好消息是，Python内置了WSGI服务器，这个模块叫wsgiref，它是用纯的Python编写的WSGI服务器的参考实现。所谓的参考实现市值该实现完全符合WSGI标准，但是不考虑任何运行效率，仅供开发和测试使用。
# from wsgiref.simple_server import make_server
#
# httpd = make_server('', 8786, application)
# print('Serving HTTP on port 8786...')
# httpd.handle_request()


###### Flask #####
# Web处理框架
# from flask import Flask
# from flask import request
#
# app = Flask(__name__)
# @app.route('/', methods=['GET', 'POST'])
# def home():
#     return '<h1>Home</h1>'
#
# @app.route('/signin', methods=['GET'])
# def signin_form():
#     return '''<form action="/signin" method="post">
#               <p><input name="username"></p>
#               <p><input name="password" type="password"></p>
#               <p><button type="submit">Sign In</button></p>
#               </form>'''
#
# @app.route('/signin', methods=['POST'])
# def signin():
#     # 需要从request对象读取表单内容：
#     if request.form['username']=='admin' and request.form['password']=='password':
#         return '<h3>Hello, admin!</h3>'
#     return '<h3>Bad username or password!</h3>'
#
# if __name__ == '__main__':
#     app.run()


# 实际的WebApp应该拿到用户名和口令后，再去数据库查询再对比，来判断用户是否能登录成功
# 除了Flask，常见的Python Web框架还有：
# 1.Diango: 全能型Web框架
# 2.web.py: 一个小巧的Web框架
# 3.Bottle: 和Flask类似的Web框架
# 4.Tornado: Facebook的开源异步Web框架

# 有了Web框架，我们在编写Web应用时，注意力从WSGI处理函数转义到URL+对应的处理函数，这样，编写WebApp就更加简单。
# 在编写URL处理函数时，除了配置URL外，从HTTP请求拿到用户数据也非常重要。Web框架提供自己的API来实现这些功能。Flask通过request.form['key']来获取表单的内容。


##### 使用模板 #####
# Web框架把我们从WSGI中拯救出来。现在我们只需要不断的编写函数，带上URL，就可以继续编写WebApp的开发了。
# 但是，WebApp不仅仅是处理逻辑，展示给用户的页面也非常重要。在函数中返回一个包含HTM的字符串，简单的页面还可以，但是复杂的页面就崩溃了。
# 使用MVC实现上例：
# from flask import Flask, request, render_template
#
# app = Flask(__name__)
#
# @app.route('/', methods=['GET', 'POST'])
# def home_form():
#     return render_template('home.html')
#
# @app.route('/signin', methods=['GET'])
# def signin_form():
#     return render_template('form.html')
#
#
# @app.route('/signin', methods=['POST'])
# def signin():
#     username = request.form['username']
#     password = request.form['password']
#     if username == 'admin' and password == 'password':
#         return render_template('signin-ok.html', username=username)
#     return render_template('form.html', message='Bad username or password', username=username)
#
# if __name__ == '__main__':
#     app.run()

# HTML模板，Flask通过render_remplate()函数来实现模板的渲染。和Web框架类似，Python的模板也有很多种，Flask默认支持的模板是jinja2



# ########################################################################
# 异步IO
# ########################################################################
# 解决多个IO问题的方法就是异步IO，当代码需要执行一个耗时的IO操作时，它值发出IO指令，并不等来IO结果，然后就去执行其它代码。一段时间后，当IO返回结果时，再通知CPU进行处理。
# 可以想象如果按普通顺序写出的代码实际上是没法完成异步IO的
# do_some_code()
# f = open('/path/to/file', 'r')
# r = f.read() # 线程停止在此等候IO操作结果
# IO操作完成后线程才能继续执行
# do_some_code(r)

# 所以同步IO模型的代码是无法实现异步IO模型的
# 异步IO模型需要一个消息循环，在消息循环中，主线程不断地的重复'读取消息-处理消息'这一过程
# loop = get_event_loop()
# while True:
#     event = loop.get_event()
#     process_event(event)

# 消息模型其实很早就应用在桌面程序中了。一个GUI程序的主线程就负责不停的读取消息并处理消息。所有的键盘、鼠标等消息都被发送到GUI程序的消息队列中，然后由GUI程序的主线程处理。
# 由于GUI线程处理键盘、鼠标等消息的速度非常快，所以用户感觉不到延迟。某些时候，GUI线程在一个消息处理的过程中遇到的问题导致一次消息处理时间过长，此时，用户就会感觉到整个GUI程序都停止响应了，敲击键盘、点击鼠标等操作都没有反应。这种情况说明在消息模型中，处理一个消息必须非常迅速，否则，主线程将无法及时处理消息队列中的其他消息，导致程序看上去停止响应。
# 消息模型是如何结果同步IO必须等待IO操作这一问题呢？当遇到IO操作，代码值负责发出IO请求，不等待IO结果，然后直接结束本轮消息处理，进入下一轮消息处理过程。当IO操作完成后，将受到一条IO完成的消息，处理该消息时就可以直接过去IO操作结果。
# 在发出IO请求到受到IO完成这段时间里，同步IO模型，主线程只能挂起，但异步IO模型下，主线程并没有休息，而是在消息循环中继续处理其他消息。这样，在异步IO模型下，一个县城就可以同时处理多个IO请求，并没有切换线程的操作。对于大多数IO密集型的应用程序，使用异步IO将大大提升系统的多任务处理能力。


##### 协程 #####
# 协程又称微线程，纤程，英文名Coroutine
# 子程序，也可以叫做函数，在所有的语言中都是层级调用，比如A调用B，B在执行过程中调用了C，C执行完毕返回，B执行完毕返回，最后是A执行完毕。所以子程序调用是通过栈实现的，一个线程就是执行一个子程序。子程序调用总是一个入口，一次返回，调用顺序是明确的。
# 协程的调用和子程序不同。
# 协程看上去也是子程序，但执行过程中，在子程序内部可以中断，然后转而执行别的子程序，在适当的时候在返回来接着执行。
# ::::::::::注意:::::::::
# 在一个子程序中中断，去执行其他子程序，不是函数调用，有点类似CPU的中断。
# def A():
#     print('1')
#     print('2')
#     print('3')
#
# def B():
#     print('x')
#     print('y')
#     print('z')
# 假设由协程执行，在执行A的过程中，可以随时中断，去执行B，B也可能在执行过程中中断再去执行A，结果可能是：
# 1，2，x，y，3，z
# 但是在A中没有调用B，所以协程的调用比函数的调用理解起来更难一些。
# 看起来有点像多线程，但是协程的特点是在一个线程中执行，那和多线程相比，协程有何优势？
# 1.极高的执行效率，因为子程序切换不是线程切换，而是由程序自身控制，因此，没有线程切换的开销，和独显策划给你比，线程数量越多，协程的性能优势越明显。
# 2.不需要多线程的锁机制，因为只有一个线程，也不存在同时写变量冲突，在协程中控制共享资源不加锁，只需要判断状态就好了，所以执行效率比多线程要高。

# 如何利用多核CPU？多进程+协程，既充分利用多核又充分发挥协程高效率。
# Python对协程的支持是通过generator实现的
# 在generator中，我们不能刻意通过for循环来进行迭代，还可以不断调用next()函数获取由yeild语句返回的下一个值
# 但是Python中的yield不但刻意返回一个值，他还刻意接受调用者发出来的参数。

# 传统的生产者-消费者模型是一个线程写消息，一个线程取消息，通过锁机制控制对垒和等待，但是一不小心就可能思索。
# 如果使用协程来实现，生产者生产消息之后，直接通过yield语句跳转到消费者开始执行，等待消费者执行完毕，切换会生产者继续生产，效率很高。
# def consumer():
#     r = ''
#     while True:
#         n = yield r
#         if not n:
#             return
#         print('[CONSUMER] Consuming %s' % n)
#         r = '200 OK'
#
# def produce(c):
#     c.send(None)
#     n = 0
#     while n < 5:
#         n = n + 1
#         print('[PRODUCER] Producing %s' % n)
#         r = c.send(n)
#         print('[PRODUCER] Consumer return: %s' % r)
#     c.close()
#
# c = consumer()
# produce(c)

# consumer函数是一个generator，把一个consumer传入produce后
# 1.首先调用c.send(None)启动一个生成器
# 2.开始进行生产，通过c.send(n)切换到consumer执行
# 3.consumer通过yield拿到消息，进行处理，又通过yield把结果返回。
# 4.produce拿到consumer处理结果，继续生产下一条消息
# 5.produce决定不生产了，通过close()关闭整个consumer，整个过程结束。

# 整个流程无锁，由一个线程执行，produce和consumer协作完成任务，所以称为'协程'，而非线程的抢占式多任务。
# Donald Knuth -> "子程序就是协程的一种特例"


##### asyncio #####
# asyncio是Python3.4引入的标准库，内置了对异步io的支持
# asyncio的编程模型就是一个消息循环。我们从asyncio模块中直接获取EventLoop的引用，然后把需要执行的协程扔到EventLoop中执行就实现了异步IO

# hello()会首先打印出Hello world!，然后，yield from语法可以让我们方便地调用另一个generator。
# 由于asyncio.sleep()也是一个coroutine，所以线程不会等待asyncio.sleep()，而是直接中断并执行下一个消息循环。
# 当asyncio.sleep()返回时，线程就可以从yield from拿到返回值（此处是None），然后接着执行下一行语句。
# 把asyncio.sleep(1)看成是一个耗时1秒的IO操作，
# 在此期间，主线程并未等待，而是去执行EventLoop中其他可以执行的coroutine了，因此可以实现并发执行。
# import asyncio
# @asyncio.coroutine # 把一个generator标记为coroutine
# def hello():
#     print('Hello World!!!')
#     # 异步调用asyncio.sleep(1)
#     r = yield from asyncio.sleep(1)
#     print('Hello Again!')
#
# # 获取EventLoop:
# loop = asyncio.get_event_loop()
# # 执行coroutine
# loop.run_until_complete(hello())
# loop.close()


# import threading
# import asyncio
# @asyncio.coroutine
# def hello():
#     print('Hello World! (%s)' % threading.current_thread())
#     yield from asyncio.sleep(1)
#     print('Hello again! (%s)' % threading.current_thread())
#
# loop = asyncio.get_event_loop()
# tasks = [hello(), hello()]
# loop.run_until_complete(asyncio.wait(tasks))
# loop.close()


# 使用asyncio的异步网络连接来获取sina.sohu.163的网站首页
# import asyncio
# @asyncio.coroutine
# def wget(host):
#     print('wget %s...' % host)
#     connect = asyncio.open_connection(host, 80)
#     reader, writer = yield from connect
#     header = 'GET / HTTP/1.0\r\nHost: %s\r\n\r\n' % host
#     writer.write(header.encode('utf-8'))
#     yield from writer.drain()
#     while True:
#         line = yield from reader.readline()
#         if line == b'\r\n':
#             break
#         print('%s header > %s' % (host, line.decode('utf-8').rstrip()))
#     writer.close()
#
# loop = asyncio.get_event_loop()
# tasks = [wget(host) for host in ['www.sina.com.cn', 'www.souhu.com', 'www.163.com']]
# loop.run_until_complete(asyncio.wait(tasks))
# loop.close()


##### async/await #####
# 用asyncio提供的@asyncio.coroutine可以把一个generator标记为coroutine类型，然后在coroutine内部使用yield from调用另一个coroutine实现异步操作
# 为了简化并更好的标志异步IO，从Python3.5开始引入了新的语法，值需要做两部简单的替换
# 请注意async和await是针对coroutine的新语法
# 1.把@asyncio.coroutine替换为async
# 2.把yield from替换为await

# import asyncio
# async def hello():
#     print('Hello World')
#     r = await asyncio.sleep(1)
#     print('Hello Again')
# loop = asyncio.get_event_loop()
# loop.run_until_complete(hello())
# loop.close()


##### aiohttp #####
# asyncio可以实现单线程的并发IO操作，如果仅在客户端，发挥的威力不大。如果把asyncio用在服务器端，例如Web服务器，由于HTTP连接就是IO操作，因此可以用单线程+coroutine实现用户的高并发支持
# asyncio实现了TCP、UDP、SSL等协议。aiohttp则是基于asyncio实现的HTTP框架
# 编写一个HTTP服务器，分别处理以下URL：
# >> / - 首页返回 b'<h1>Index</h1>'
# >> /hello/{name} - 根据url参数返回文本hello, %s!

# import asyncio
# from aiohttp import web
#
# async def index(request):
#     await asyncio.sleep(0.5)
#     return web.Response(body=b'<h1>Index</h1>')
#
# async def hello(request):
#     await asyncio.sleep(0.5)
#     text = '<h1>hello, %s!</h1>' % request.match_info['name']
#     return web.Response(body=text.encode('utf-8'))
#
# async def init(loop):
#     app = web.Application(loop=loop)
#     app.router.add_route('GET', '/', index)
#     app.router.add_route('GET', '/hello/{name}', hello)
#     srv = await loop.create_server(app.make_handler(), '127.0.0.1', 8000)
#     print('Server started at http://127.0.0.1:8000...')
#     return srv
#
# loop = asyncio.get_event_loop()
# loop.run_until_complete(init(loop))
# loop.run_forever()



# def creatDataFrame():
#     '''
#     创建DataFrame
#     '''
#     datas = []
#     for i in range(_ProcessCount):
#         path = _Path2 + 'data' + str(i) + '.txt'
#         with open(path, 'r') as f:
#             for line in f.readlines():
#                 a = line.replace(os.linesep, '').split('|||')
#                 datas.append(a)
#
#     indexs = []
#     for i in range(1, len(datas) + 1):
#         indexs.append(str(i))
#     columns = ['编号', '价格', '折扣', '已售', '促销', '特殊', '秒杀', '天数', '出发', '结束', '标题']
#     panda = pd.DataFrame(datas, index=indexs, columns=columns)
#     return panda
#
#
# def creatHtmlFile(p):
#     '''
#     创建存储数据文件并生成HTML代码
#     :return 文件路径
#     '''
#     t = time.strftime('%Y-%m-%d', time.localtime())
#     path = '%s%s.html' % (_Path2, t)
#     open(path, 'w')
#     p.to_html(path, border=1.0, col_space=2)
#     wn_print('结果文件路径: %s' % path)
#     return path
#
#
# def addUrlLink(path):
#     '''
#     给表格中的URL加上超链接
#     '''
#     with open(path, 'r') as f:
#         htmlIndex = 1
#         while True:
#             line = f.readline()
#             if line == '':
#                 break
#             else:
#                 if '<td>https://app.toursforfun.com/product' in line:
#                     id = re.sub("\D", "", line)
#                     u = line.replace('<td>', '').replace('</td>', '').replace(os.linesep, '').replace(' ', '')
#                     new = '<td><a href="http://www.toursforfun.com/advanced_search_result.php?w=%s">%s</a></td>' % (
#                         id, u)
#                     old = line.replace(os.linesep, '').replace(' ', '')
#                     sed = "sed -i '' '%ss*%s*%s*' %s" % (htmlIndex, old, new, path)
#                     os.system(sed)
#             htmlIndex += 1


from Print import wn_print
import builtins

# # # # # # # # # # # # # # # # # # # # # # # # # # #
#               Python 奇淫巧技
# # # # # # # # # # # # # # # # # # # # # # # # # # #


# --------------------------------------------
# 强大的zip()
# a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
# b = list(zip(*a))
# wn_print(b)

# a = {'a': 1, 'b': 2, 'c': 3}
# def reverse_dict(dic):
#     k = dic.keys()
#     v = dic.values()
#     return dict(zip(v, k))
# wn_print(reverse_dict(a))

# a = [1, 2, 3, 4, 5, 6]
# wn_print(list(zip(a[::2], a[1::2])))


# --------------------------------------------
# 再循环中获取索引
# a = [1, 2, 3, 4, 5, 6]
# for i, v in enumerate(a):
#     print(i, v)


# --------------------------------------------
# 将列表分割为同样大小的块
# a = [1, 2, 3, 4, 5, 6, 7]
# wn_print(list(zip(*[iter(a)]*3)))


# --------------------------------------------
# 查找某个元素的下标
# a = ['a', 'b', 'c', 'd', 'e', 'a']
# wn_print(a.index('a'))


# --------------------------------------------
# 快速翻转字符串
# a = 'Python is a powerful languange.'
# wn_print(a[::-1])


# --------------------------------------------
# 和你的内存说再见
# crash = dict(zip(range(10 **0xA), range(10 **0xA)))


# --------------------------------------------
# 返回一个类，链式走起
# def add(x):
#     class AddNum(int):
#         def __call__(self, x):
#             return AddNum(self.numerator + x)
#     return AddNum(x)
# wn_print(add(2)(3)(5))


# --------------------------------------------
# 来个生成器, yield的作用是把一个函数变为一个生成器函数
# g = (i for i in range(10))
# for x in g:
#     print(x, end='-')
# print()

# def odd():
#     n = 1
#     while True:
#         yield n
#         n += 2
# i = 0
# for o in odd():
#     if i >= 5:
#         break
#     print(o)
#     i += 1


# --------------------------------------------
# for..else.. 不break就执行else
# for i in range(10):
#     if i == 10:
#         break
#     print(i)
# else:
#     print('10不在里面！')


# --------------------------------------------
# 向csv写入文件
# import csv
# with open('data.csv', 'w') as f:
#     writer = csv.writer(f)
#     # 单行写入
#     writer.writerow(['name', 'address', 'age'])
#     data = [('xiaoming', 'china', '10'),
#             ('Lily', 'USA', '12')]
#     # 多行写入
#     writer.writerows(data)


# --------------------------------------------
# 拆分功能、*
# def my_sum(items):
#     head, *tail = items
#     return head + (my_sum(tail) if tail else head)
# items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# wn_print(my_sum(items))



# --------------------------------------------
# 找到最大或者最小的N个元素
# import heapq
# nums = [1, 23, 43, 62, -123, 325, 5, 52, 53, 325]
# nums = sorted(nums, reverse=True)
# wn_print(nums)
# wn_print(heapq.nlargest(3, nums))
# wn_print(heapq.nsmallest(2, nums))
#
# portfolio = [{'name': 'IBM', 'shares': 100, 'price': 91},
#              {'name': 'AAPL', 'shares': 50, 'price': 543.22},
#              {'name': 'FB', 'shares': 200, 'price': 21.09},
#              {'name': 'HPQ', 'shares': 35, 'price': 31.75},
#              {'name': 'YHOO', 'shares': 45, 'price': 16.35},
#              {'name': 'ACME', 'shares': 75, 'price': 115.65}]
# cheap = heapq.nsmallest(2, portfolio, key=lambda s: s['price'])
# expensive = heapq.nlargest(2, portfolio, key=lambda s: s['price'])
# wn_print(cheap)
# wn_print(expensive)


# --------------------------------------------
# 优先级队列
# 我们想要实现一个队列，它能够以给定的优先级来对元素排序，且每次pop操作时都会返回优先级最高的那个元素
# 堆最重要的特新就是heap[0]总是最小的那个元素
# import heapq
# class PriorityQueue:
#     def __init__(self):
#         self._queue = []
#         self._index = 0
#
#     def push(self, item, priority):
#         heapq.heappush(self._queue, (-priority, self._index, item))
#         self._index += 1
#
#     def pop(self):
#         return heapq.heappop(self._queue)[-1]
#
# class Item:
#     def __init__(self, name):
#         self.name = name
#     def __repr__(self):
#         return 'Item({!r})'.format(self.name)
#
# q = PriorityQueue()
# q.push(Item('foo'), 1)
# q.push(Item('bar'), 5)
# q.push(Item('spam'), 4)
# q.push(Item('grok'), 1)
# wn_print(q.pop())


# --------------------------------------------
# 从序列中移除重复元素，且保持剩余元素顺序不变
# def dedupe(items):
#     seen = set()
#     for item in items:
#         if item not in seen:
#             yield item
#             seen.add(item)
#
# a = [1, 5, 2, 1, 9, 1, 5, 10]
# wn_print(dedupe(a))

# 只有当序列中的元素是可哈希的时候才能像上面那样做。如果想在不可哈希的对象序列中去除重复项。需要对代码做如下的修改
# 这里参数key的作用是指定一个函数用来将序列中的元素转换为可哈希的类型，这么做的目的是为了检测重复项。
# def dedupe(items, key=None):
#     seen = set()
#     for item in items:
#         val = item if key is None else key(item)
#         if val not in seen:
#             yield item
#             seen.add(val)
#
# a = [{'x': 1, 'y': 2}, {'x': 1, 'y': 3}, {'x': 1, 'y': 2}, {'x': 2, 'y': 4}]
# wn_print(list(dedupe(a, key=lambda d: (d['x'], d['y']))))
# wn_print(list(dedupe(a, key=lambda d: d['x'])))



# --------------------------------------------
# 对切片命名
# record = '....................100 .......513.25 ..........'
# SHARES = slice(20, 23)
# PRICE = slice(31, 37)
# cost = int(record[SHARES]) * float(record[PRICE])
# wn_print(cost)

# 此外可以通过indices(size)方法将切片映射到特定大小的序列上，这回返回一个(start, top, step)元组，所有的值都已经恰当的限制在边界以内（当做索引操作的时候可以避免IndexError异常）
# a = slice(2, 20, 1)
# s = 'Hello World!'
# t = a.indices(len(s))
# a = slice(t[0], t[1], t[2])
# print(s[a])


# --------------------------------------------
# '''''' 问题 '''''':
# 我们有一个元素序列，想知道序列中出现次数最多的元素是什么

# '''''' 方案 '''''':
# collections模块中的Counter类正式为此类问题设计的。它甚至有一个非常方面的most_common()方法可以直接告诉我们答案。
# 为了说明个用法，假设有一个列表，列表中是一些列的单词，我们想找出哪些单词出现的最为频繁。下面是我们得做法

# from collections import Counter
# words = ['look', 'into', 'my', 'eyes', 'look', 'into', 'my', 'eyes', 'look', 'into', 'look', 'into', 'look', 'into', 'eyes', 'look', 'into', 'eyes', 'look', 'into', 'eyes']
# word_count = Counter(words)
# top_three = word_count.most_common(3)
# wn_print(top_three)

# '''''' 讨论 '''''':
# 可以给Counter对象提供任何可哈希的独享座位序列输入，在底层实现中，Counter是一个字典，在元素和他们出现的次数间做了映射。例如：
# wn_print(word_count['into'])

# 如果想手动增加计数，只需要简单的自增即可
# morewords = ['why', 'are', 'you', 'not', 'looking', 'in', 'my', 'eyes']
# for word in morewords:
#     word_count[word] += 1
# wn_print(word_count['eyes'])

# 更简便的做法是使用update()方法
# word_count.update(morewords)

# 关于Counter对象有一个不为人知的特性，那就是他们可以轻松的同各种数学运算操作结合起来使用（加减可以，乘除不行）
# a = Counter(words)
# b = Counter(morewords)
# c = a + b
# print(c)



# --------------------------------------------
# 通过公共键对字典列表排序
# '''''' 【 问题 】 ''''''
# 我们有一个字典列表，想根据一个或多个字典中的值来对列表排序

# '''''' 【 方案 】 ''''''
# 利用operator模块中的itemgetter函数对这类结构进行排序是非常简单的。假设通过查询数据库表项获取网站上的成员列表，我们得到如下的数据结构
# rows = [{'fname': 'Brian', 'lname': 'Jones', 'uid': 1003},
#         {'fname': 'David', 'lname': 'Beazley', 'uid': 1002},
#         {'fname': 'John', 'lname': 'Cleese', 'uid': 1001},
#         {'fname': 'Big', 'lname': 'Jones', 'uid': 1004}]

from operator import itemgetter
# rows_by_name = sorted(rows, key=itemgetter('fname'))
# wn_print(rows_by_name)

# itemgetter()函数还可以接受多个键
# rows_by_lfname= sorted(rows, key=itemgetter('lname', 'uid'))
# wn_print(rows_by_lfname)

# '''''' 【 讨论 】 ''''''
# 在这个例子中，rows被传递给內建的sorted()函数, 该函数接受一个关键字参数Key，这个参数应该代表一个可调用对象(callable)，该对象从rows中接受一个单独的元素作为输入并返回一个用来做排序依据的值。itemgetter()函数创建的就是这样一个可调用对象
# 函数operator.itemgetter()接受的参数可作为查询的标记，用来从rows的记录中提取出来所需要的值。它可以是字典的键名称、用数字表示的列表元素或者任何可以传给对象的__getitem__()方法的值。如果传多个标记给itemgetter()，那么它产生的可调用对象将返回一个包含所有元素在内的元组，然后sorted()将根据对元组的排序结果来排雷输出结果。如果想同时针对多个字段来做排序，那么这是非常有用的。
# 有时候会用lambda表达式来取代itemgetter()的功能。
# 这种解决方案通常也能正常工作，但是用itemgetter()通常会更快一些，如果考虑到性能的问题，应该使用itemgetter()
# rows_by_lfname = sorted(rows, key=lambda r: (r['lname'], r['fname']))
# wn_print(rows_by_lfname)


# --------------------------------------------
# 筛选序列中的元素
# '''''' 【 问题 】 ''''''
# 序列中含有一些数据，我们需要提取出其中的值或根据某些标准对序列做删减

# '''''' 【 方案 】 ''''''
# 要筛选序列中的数据，通常最简单的方法是使用列表推导式（list comprehension）。
# mylist = [1, 4, -5, 10, -7, 2, 3, -1]
# print([n for n in mylist if n > 0])

# 使用列表推导式的一个潜在缺点是如果原始输入非常大的话，这么做可能会产生一个庞大的结果。如果这是你需要考虑的问题，那么可以使用生成器表达式通过迭代的方式产生筛选结果。
# pos = (n for n in mylist if n > 0)
# wn_print(pos)

# 有时候筛选的标准没法简单的表示在列表推导式或生成器表达式中。比如，假设筛选过程涉及异常处理或者其他一些复杂细节。基于此，可以将处理筛选的逻辑代码放到单独的函数中，然后使用內建的filter()函数处理。
# values = ['1', '2', '-3', '-', 'N/A', '5']
# def is_int(val):
#     try:
#         x = int(val)
#         return True
#     except ValueError:
#         return False
#
# ivals = list(filter(is_int, values))
# wn_print(ivals)

# '''''' 【 讨论 】 ''''''
# 列表推导式和生成器表达式通常是用来筛选数据的最简单和最直接的方式。此外，他们也具有同时对数据做转换的能力。
# import math
# mylist = [1, 4, -5, 10, -7, 2, 3, -1]
# print([math.sqrt(n) for n in mylist if n > 0])

# 关于筛选数据，有一种情况使用新值替换掉不满足标准的值，而不是丢弃他们，例如，除了要找到正整数外，我们也许还希望在指定的范围内不能满足要求的值替换掉。通常，这可以通过将筛选条件移到一个条件表达式中来轻松实现。
# clip = [n if n > 0 else 0 for n in mylist]
# print(clip)

# 另外一个值得一提的工具是itertools.compress()，它接受一个可迭代对象和一个布尔选择器序列作为输入。输出时，它会给出所有在响应的布尔选择器中为True的可迭代对象元素。如果想把一个徐磊的筛选结果施加到另一个相关的序列上时，这就会非常有用。
# address = ['5412 N CLARK',
#            '5148 N CLARK',
#            '5800 E 58TH',
#            '2122 N CLARK',
#            '5645 N RAVENSWOOD',
#            '1060 W ADDISON',
#            '4801 N BROADWAY',
#            '1039 W GRANVILLE']
# counts = [0, 3, 10, 4, 1, 7, 6, 1]
# 现在我们想构建一个地址列表，其中相应的count值要大于5下面是我们可以尝试的方法：
# from itertools import compress
# more5 = [n > 5 for n in counts]
# print(more5)
# wn_print(list(compress(address, more5)))
# 这里的关键是在于首先创建一个布尔序列，用来表示那个元素符合我们得条件，然后使用compress()函数来挑选出满足布尔值为True的相应元素。
# 同filter()函数一样正常情况下compress()回返回一个迭代器。因此，如果需要的话，得使用list()将结果转换为列表。


# --------------------------------------------
# '''''' 【 问题 】 ''''''
# 我们想创建一个字典，其本身是另一个字典的子集

# '''''' 【 方案 】 ''''''
# 利用字典推导式（dictionary comprehension）可以轻松解决。
# prices = {'ACME': 45.23,
#           'APPL': 612.78,
#           'IBM': 205.55,
#           'HPQ': 37.20,
#           'FB': 10.75}
# p1 = {key:value for key, value in prices.items() if value > 200}
# wn_print(p1)

# '''''' 【 讨论 】 ''''''
# 大部分可以使用字典推导式解决的问题也可以通过创建元组序列然后将他们传给dict()函数来完成。
# 但是字典推导式的方式更为清晰，而且实际运行起来也要快的很多
# p2 = dict((key, value) for key, value in prices.items() if value > 200)
# wn_print(p2)
















