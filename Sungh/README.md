#  <#Title#>
https://juejin.im/post/5b56155e6fb9a04f8b78619b
6.反射是什么？可以举出几个应用场景么？
    就是将两个对象的所有属性，用动态的方式取出来，并根据属性名，自动绑值
    注意：对象的类，如果是派生类，就得靠其他方式来实现了，因为得到不该基类的属性。）
      运行时选择创建哪个实例，并动态选择调用哪个方法
      
      ** 优点   松耦合，类与类之间不需要太多依赖  构建灵活
      ** 缺点  不利于维护。使用反射模糊了程序内部实际发生的事情，隐藏了程序的逻辑。这种绕过源码的方式比直接代码更为复杂，增加了维护成本。性能较差。使用反射匹配字符串间接命中内存比直接命中内存的方式要慢
      
7.AppDelegate如何瘦身？
    ** 给appdelegate 创建类别
    ** 组件化设计 (SOA面向服务的架构)

8：对一个数组去重有哪些方法？

数据循环比较去重
通过集合NSSet去重
通过字典NSDictionary去重
利用keyValue去重
9：UITableView的优化机制有哪些 ？

tableView的优化主要涉及的是cell的重用机制，视图渲染原理及CPU和GPU的工作原理。

10：本地化数据存储你用过哪些？查询两个表的同一个字段的数据Sql怎么写？去重的sql怎么写？

11：如何在block内部修改外部局部变量的值？为什么？

12：在滑动页面时，定时器卡顿如何解决？

13：KVO是什么？

14：页面卡顿原理是什么？如何解决？

15：在C语言中如何定义一个类？OC语言是如何转化为C语言的面向过程的呢？

16：iOS11有哪些特性？

17：你是怎么理解HTTPS的？延伸到对称加密和非对称加密，建立连接过程和数据请求部分。

18：NSOperationQueue实现了什么？和GCD的区别。

19：__weak和__block有什么区别？

20：[[[objc method1] method2] method3：[objc method4]]这些方法的调用顺序是怎样的？

21: NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1 target:self selector:@selector(fireTimer) userInfo:nil repeats:NO];
                [timer fire];
                                    timer为什么无效？
                                                                
  22: [UIImage imageNamed:@""];
     [UIImage imageWithContentsOfFile:@""];
    这两个方法有什么区别？
  23：OC中有私有方法和私有变量吗？
                                                                                                                                                                                                                                                                                                                                                                                                                                        
