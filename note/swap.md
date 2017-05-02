# swap(a, b)的几种实现

### 1.临时变量
`
func swap(a: Int, b: Int) -> Void{  
    int temp = 0  
    temp = b  
    b = a  
    a = temp  
}  
`
### 2.加法
`
func swap(a: Int, b: Int) -> Void {  
    a = a + b  
    b = a - b  
    a = a - b  
}
或
func swap(a: Int, b: Int) -> Void {  
    a = a + b - (b = a)  
}
`

### 3.异或
`
func swap(a: Int, b: Int) -> Void {  
    a = a ^ b  
    b = a ^ b  
    a = a ^ b  
}  
或  
func swap(a: Int, b: Int) -> Void {  
    a ^= b ^= a ^= b  
}  
`
Note: 
什么样的运算才能保证把两段信息放到一个变量中，知道一段信息就可以分离出另一段信息呢？  
最容易想到的是位运算  
&：均为1，值为1  
|：一个为1，值为1  
^：均为0，值为0  
~：取反操作  
很容易看出：  
与运算的一个操作数为0时，结果永远为0，另一个操作数信息丢失  
或运算其中一个操作数为1时，也可能或丢失另一个操作数  
非运算是单目运算符  
2000年异或这个性质在通信领域带来了有影响力的的理论，[网络编码](https://zh.wikipedia.org/wiki/%E7%BD%91%E7%BB%9C%E7%BC%96%E7%A0%81)  
学过数字电路的同学肯定对下面的实现有印象，异或是可以用与、或进行实现的  
`a ^ b = (a | b) & (~(a & b))`  
这样就可以使用与或得到相同的结果。不过需要注意的是：如果a=b，那么这种解法就失效了。  
