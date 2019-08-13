#  <#Title#>
https://juejin.im/post/5b56155e6fb9a04f8b78619b

2.有哪些情况会导致app卡顿，分别可以用什么方法来避免

    **分cpu卡和gpu卡顿。
    
    一、优化CPU
        *主线程耗时操作   ->可以多线程操作 尽量把耗时的操作放到子线程
        *滑动页面渲染卡顿 （离屛渲染）
        * 线程太多卡死 - > 控制一下线程的最大并发数量
        *不要频繁地调用 UIView的相关属性，比如frame、bounds、transform等属性，尽量减少不必要的修改
        *尽量提前计算好布局，在有需要时一次性调整对应的属性，不要多次修改属性
            Autolayout会比真设置frame消耗更多的CPU资源
        *图片的size最好刚好好UIImageView的size保持一致
     二、优化GPU  
     
        *尽量减少视图数量和层次
        *尽量避免短时间内大量图片的显示，尽可能将多张图片合成一张进行显
        *GPU能处理的最大纹理尺寸是4096*4096，一旦超过这个尺寸，就会占有用CPU资源进行处理，所以纹理尽量不要超过这个尺寸
        *减少透明的视图，不透明的就设置 opaque 为yes
        *尽量避免出现离屏渲染
    三、卡顿检测
    
        卡顿，主要因为在主线程执行了耗时操作
        可以添加Observer到主线程RunLoop中，通过监听RunLoop状态切换的耗时，以达到监控卡顿的目的
        这是一个用来监听卡顿的工具包：
        https://github.com/UIControl/LXDAppFluecyMonitor
        
    四、耗电优化
    
        少用定时器
        优化IO操作
        不要频繁写入小数据，最好批量一次性写入
    
3.你知道有哪些情况会导致app崩溃，分别可以用什么方法拦截并化解？

    **NSInvalidArgumentException 异常
    **SIGSEGV是当SEGV发生的时候，让代码终止的标识。 当去访问没有被开辟的内存或者已经被释放的内存时，就会发生这样的异常。另外，在低内存的时候，也可能会产生这样的异常
    ** NSRangeException 异常
        造成这个异常，就是越界异常了，在iOS中我们经常碰到的越界异常有两种，一种是数组越界，一种字符串截取越界
     ** SIGABRT 异常 这是一个让程序终止的标识，会在断言、app内部、操作系统用终止方法抛出。通常发生在异步执行系统方法的时候。如CoreData、NSUserDefaults等，还有一些其他的系统多线程操作
     
     向容器加入nil，引起的崩溃。hook容器添加方法，进行判断
4.App 启动优化策略？最好结合启动流程来说（main()函数的执行前后都分别说一下,）

    优化pre-mainj阶段 
        1.删除无用代码 （未被调用的静态变量、类和方法）
        （未使用的本地变量、未使用的参数、未使用的值）
        2.抽象重复代码删除
        3.不宜在+load中做f更多的操作
        4.减少不必要的framework 或者优化已有的framework
    main阶段优化
        首次启动渲染的页面优化
        1、不使用xib或者storyboard，直接使用代码；
        2、对于viewDidLoad以及viewWillAppear方法中尽量去尝试少做，晚做，不做，或者采用异步的方式去做；
        3、当首页逻辑比较复杂的时候，建议CD冷却放大招：通过instruments的Time Profiler分析耗时瓶颈。
        
    https://www.jianshu.com/p/0615138f9f19

    
5.有哪些场景是NSOperation比GCD更容易实现的？（或是NSOperation优于GCD的几点

        设置优先级 设置并发数 ，设置任务的依赖关系 面向对象

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
                                                                                                                                                                                                                                                                                                                                                                                                                                        
********************
//安装 fui 工具 在终端中执行命令
sudo gem install fui -n /usr/local/bin

fui usage: https://github.com/dblock/fui

到工程目录下，执行 fui find 命令，可以找出所有的没有用到的class文件
**查找无用图片
https://github.com/tinymind/LSUnusedResources
