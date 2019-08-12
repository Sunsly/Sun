//
//  InterViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2019/8/8.
//  Copyright © 2019 yonyouqiche. All rights reserved.
//

#import "InterViewController.h"
#import "STool.h"
#import <CoreFoundation/CoreFoundation.h>
@interface InterViewController  ()
@property (nonatomic,copy,readwrite)NSString *nameStr;
@end

@implementation InterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.nameStr = @"背景";
    [self runloopExample];
    [self propertyExample];
    UIScrollView *scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    scro.contentSize = CGSizeMake(100, 200);
    scro.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scro];
    // Do any additional setup after loading the view.
}
//FIXME:1 autoreleasepool 自动释放池
- (void)autoreleasepoolExample{
    /*
     1.什么是@autoreleasepool?
     2.里面对象的内存什么时候释放?
     3.什么时候要用@autoreleasepool?
     4.Autoreleasepool 与 Runloop 的关系
     5.ARC 下什么样的对象由 Autoreleasepool 管理
     6.子线程默认不会开启 Runloop，那出现 Autorelease 对象如何处理？不手动处理会内存泄漏吗？
     **答：
     1.自动释放池 用来管理内存
     2.当sutoreleasepool 结束的时候会释放内存
     3.如下
     4.每一个主线程默认都会开启一个runloop 并且 创建autoreleasepool 进行 push pop 来进行内存管理
     
     使用： 循环创建临时变量的时候可以 用于释放
     ***什么样的对象会加入到autoreleaseloop

     */
    NSNumber *num = nil;
    NSString *str = nil;
    for (int i = 0; i < kIterationCount; i++) {
        @autoreleasepool {
            num = [NSNumber numberWithInt:i];
            str = [NSString stringWithFormat:@"打哈萨克的哈克实打实的哈克时间的话大声疾呼多阿萨德爱仕达按时 "];
            
            //Use num and str...whatever...
            [NSString stringWithFormat:@"%@%@", num, str];
            
            if (i % kStep == 0) {
                double ff  =   [STool usedMemory];
                NSLog(@"%f",ff);
            }
        }
    }
    
}
static const int kStep = 50000;
static const int kIterationCount = 10 * kStep;
//FIXME:2 runloop
- (void)runloopExample{
    /*
     App 启动的时候 ,主线程的runloop 会注册两个e观察者 observer  其回调d都是 _wrapRunLoopWithAutoreleasePoolHandler()
     第一个 observer 监视的事件 是entry（即将进入loop）其回调内会调用 _objc_autoreleasePoolPush() 创建自动释放池
     第二个 Observer 监视了两个事件： BeforeWaiting(准备进入休眠) 时调用_objc_autoreleasePoolPop() 和 _objc_autoreleasePoolPush() 释放旧的池并创建新池；Exit(即将退出Loop) 时调用 _objc_autoreleasePoolPop() 来释放自动释放池。这个 Observer 的 order 是 2147483647，优先级最低，保证其释放池子发生在其他所有回调之后。
     对与每一个runloop运行循环  都会隐式的创建一个autoreleasepool对象，
     当Runloop执行完一系列动作没有更多事情要它做时，它会进入休眠状态，避免一直占用大量系统资源，或者Runloop要退出时会触发执行_objc_autoreleasePoolPop()方法相当于让Autoreleasepool对象执行一次drain方法，Autoreleasepool对象会对自动释放池中所有的对象依次执行依次release操作
     
     runloop保证线程不会被销毁 保证了程序的运行
    用DefaultMode启动
    void CFRunLoopRun(void) {
    int32_t result;
    do {
        result = CFRunLoopRunSpecific(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, 1.0e10, false);
        CHECK_FOR_FORK();
     } while (kCFRunLoopRunStopped != result && kCFRunLoopRunFinished != result);
     }
     **
     Fundation框架 （基于CFRunLoopRef的封装）
     NSRunLoop对象
     
     
     每条线程都有唯一的一个与之对应的RunLoop对象
     RunLoop保存在一个全局的Dictionary里，线程作为key,RunLoop作为value
     主线程的RunLoop已经自动创建好了，子线程的RunLoop需要主动创建
     RunLoop在第一次获取时创建，在线程结束时销毁
     
     
     **    CFRunLoopGetMain();
           CFRunLoopGetCurrent();
     CFMutableSetRef _sources0;
     CFMutableSetRef _sources1;
     CFMutableArrayRef _observers;
     CFMutableArrayRef _timers;
     
     CFRunLoopModeRef代表RunLoop的运行模式，一个RunLoop包含若干个Mode，每个Mode又包含若干个Source0/Source1/Timer/Observer，而RunLoop启动时只能选择其中一个Mode作为currentMode。
     */

    /*
     Source1/Source0/Timers/Observer分别代表什么
     
        source1：基于port 的线程通信
        source0：触摸事件 PerformSelectors
        bt”指令打印完整的堆栈信息
     
      Observer : 监听器，用于监听RunLoop的状态
     
   一种Mode中可以有多个  Source(事件源，输入源，基于端口事件源例键盘触摸等) Observer(观察者，观察当前RunLoop运行状态) 和Timer(定时器事件源)。但是必须至少有一个Source或者Timer，因为如果Mode为空，RunLoop运行到空模式不会进行空转，就会立刻退出。
     
     1. kCFRunLoopDefaultMode：App的默认Mode，通常主线程是在这个Mode下运行
     2. UITrackingRunLoopMode：界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响
     3. UIInitializationRunLoopMode: 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用，会切换到kCFRunLoopDefaultMode
     4. GSEventReceiveRunLoopMode: 接受系统事件的内部 Mode，通常用不到
     5. kCFRunLoopCommonModes: 这是一个占位用的Mode，作为标记kCFRunLoopDefaultMode和UITrackingRunLoopMode用，并不是一种真正的Mode
     */
//
//    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//        switch (activity) {
//            case kCFRunLoopEntry:
//                NSLog(@"RunLoop进入");
//                break;
//            case kCFRunLoopBeforeTimers:
//                NSLog(@"RunLoop要处理Timers了");
//                break;
//            case kCFRunLoopBeforeSources:
//                NSLog(@"RunLoop要处理Sources了");
//                break;
//            case kCFRunLoopBeforeWaiting:
//                NSLog(@"RunLoop要休息了");
//                break;
//            case kCFRunLoopAfterWaiting:
//                NSLog(@"RunLoop醒来了");
//                break;
//            case kCFRunLoopExit:
//                NSLog(@"RunLoop退出了");
//                break;
//
//            default:
//                break;
//        }
//    });
    
    // 给RunLoop添加监听者
    /*
     第一个参数 CFRunLoopRef rl：要监听哪个RunLoop,这里监听的是主线程的RunLoop
     第二个参数 CFRunLoopObserverRef observer 监听者
     第三个参数 CFStringRef mode 要监听RunLoop在哪种运行模式下的状态
     */
   // CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    /*
     CF的内存管理（Core Foundation）
     凡是带有Create、Copy、Retain等字眼的函数，创建出来的对象，都需要在最后做一次release
     GCD本来在iOS6.0之前也是需要我们释放的，6.0之后GCD已经纳入到了ARC中，所以我们不需要管了
     */
   // CFRelease(observer);
    // 创建子线程并开启
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(show) object:nil];
    //    self.thread = thread;
    [thread start];
}
-(void)show
{
    // 注意：打印方法一定要在RunLoop创建开始运行之前，如果在RunLoop跑起来之后打印，RunLoop先运行起来，已经在跑圈了就出不来了，进入死循环也就无法执行后面的操作了。
    // 但是此时点击Button还是有操作的，因为Button是在RunLoop跑起来之后加入到子线程的，当Button加入到子线程RunLoop就会跑起来
    NSLog(@"%s",__func__);
    // 1.创建子线程相关的RunLoop，在子线程中创建即可，并且RunLoop中要至少有一个Timer 或 一个Source 保证RunLoop不会因为空转而退出，因此在创建的时候直接加入
    // 添加Source [NSMachPort port] 添加一个端口
    [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    // 添加一个Timer
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //创建监听者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
                
            default:
                break;
        }
    });
    // 给RunLoop添加监听者
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    // 2.子线程需要开启RunLoop
    [[NSRunLoop currentRunLoop]run];
    CFRelease(observer);
}
-(void)test
{
    NSLog(@"%@",[NSThread currentThread]);
}

//FIXME:3 多线程
- (void)xianchengExample{
    
}

//FIXME:4 属性  修饰符  引用计数
- (void)propertyExample{
    /*
     copy
     assign
     retain
     strong
     weak
     readwrite/readonly (读写策略、访问权限)
     nonatomic/atomic (安全策略)
     
     1. MRC: assign/ retain/ copy/  readwrite、readonly/ nonatomic、atomic  等。
     2. ARC: assign/ strong/ weak/ copy/ readwrite、readonly/ nonatomic、atomic  等。
     
     //TODO:1. copy 一般修饰不可变 NSArray /NSDictionary/NSString， 也可以用来修饰block
     例： @property (nonatomic, copy) NSString* name;
         @property (nonatomic, copy) void(^typeBlock)(BOOL selected);
         @property (nonatomic, copy) void(^cancelBlock)();
    **warming：
     用copy修饰block时在MRC和ARC下的区别
     
     MRC环境下
     （1）block访问外部局部变量，block存放在栈里面。
     （2）只要block访问整个app都存在的变量，那么肯定是在全局区。
     （3）不能使用retain引用block，因为block不在堆区里面，只有使用copy才会把block放在堆区里面。
     ARC环境下
     （1）只要block访问外部局部变量，block就会存放在堆区。
     （2）可以使用strong去引用，因为本身就已经存放在堆区了。
     （3）也可以使用copy进行修饰，但是strong性能更好
     
     **注：用copy修饰一种情况下的NSString-->不确定赋值过程中用的是可变还是不可变字符串
     
     //TODO:2. assign 一般用来修饰基础数据类型(NSInteger, CGFloat) 和 C数据类型(int ,float, double)等。它的setter方法直接赋值，不进行任何引用计数操作  基本数据类型、枚举、结构体(非OC对象)
     例子：@property (nonatomic, assign) NSInteger  studentNum;
          @property (nonatomic, assign) CGFloat  cellHeight;
     
     //TODO:3. strong strong表示对对象的强引用。
       ARC下也可以用来修饰block，strong 和 weak两个修饰符默认是strong。
       用于指针变量，setter方法对参数进行release旧值再retain新值。
     
     例：@property (nonatomic, strong) NSArray  *dataArr;
        @property (nonatomic, strong) NSMutableArray *btnArray;
        @property (nonatomic, strong) UILabel *descLabel;
        对于控件也可以用weak，因为controller已经对root view有一个强引用，view addSubview 子控件，所以即使用weak也不会提前释放。
        @property (nonatomic, strong) CompleteDatePicker *preciseDatePicker;
         CompleteDatePicker在这里是自定义类。
        @property (nonatomic ,strong) NSString *signupId;
        字符串除了用copy，用strong也是可以的。
     warminn：strong修饰的属性，对属性进行的是强引用，对象的引用计数retainCount + 1；
             注意两个对象之间相互强引用造成循环引用，内存泄漏
     
     //TODO:4. weak weak表示对对象的弱引用。weak 表示对对象的弱引用，被weak修饰的对象随时可被系统销毁和回收。
       weak比较常用的地方就是delegate属性的设置。
     
      用weak修饰弱引用，不会使传入对象的引用计数加1
     
     warming：
     ** assign和weak的区别：当它们指向的对象释放以后，weak会被自动设置为nil，而assign不会，所以会导致野指针的出现，可能会导致crash。
     对象所占内存总是分配在“堆空间”，并且堆内存是由程序员自己释放的，不释放，则可能会引起内存泄漏。
     注 堆和数据结构中的堆栈不一样，其类似于链表
     
     weak只可以修饰对象。如果修饰基本数据类型，编译器会报错-“Property with ‘weak’ attribute must be of object type”。
     assign可修饰对象，和基本数据类型。当需要修饰对象类型时，MRC时代使用unsafe_unretained。当然，unsafe_unretained也可能产生野指针，所以它名字是"unsafe_”。
     
     weak不会产生野指针问题。因为weak修饰的对象释放后（引用计数器值为0），指针会自动被置nil，之后再向该对象发消息也不会崩溃。 weak是安全的。
     assign如果修饰对象，会产生野指针问题；如果修饰基本数据类型则是安全的。修饰的对象释放后，指针不会自动被置空，此时向对象发消息会崩溃。
     
     总结：
        assign适用于基本数据类型如int,float,struct等值类型，不适用于修饰对象（会产生野指指针）。
        weak适用于delegate和block等引用类型，不会导致野指针问题，也不会循环引用，非常安全。
     ** strong和weak的区别：
     
     strong ：表明是一个强引用，相当于MRC下的retain，只要被strong引用的对象就不会被销毁，当所有的强引用消除时，对象的引用计数为0时，对象才会被销毁。
     weak ： 表明是一个弱引用，相当于MRC下的assign，不会使对象的引用计数+1。
     
     两个不同对象相互strong引用对象，会导致循环引用造成对象不能释放，造成内存泄漏。
     
     //TODO:5. readwrite/readonly
        当我们用readwrite修饰的时候表示该属性可读可改，用readonly修饰的时候表示这个属性只可以读取，不可以修改，一般常用在我们不希望外界改变只希望外界读取这种情况。
        readwrite 程序自动创建setter/getter方法，readonly 程序创建getter方法。此外还可以自定义setter/getter方法。
        系统默认的情况就是 readwrite。
     
     //TODO:6. nonatomic/atomic
        1. nonatomic 非原子属性。它的特点是多线程并发访问性能高，但是访问不安全；与之相对的就是atomic，特点就是安全但是是以耗费系统资源为代价，所以一般在工程开发中用nonatomic的时候比较多。
        2. 系统默认的是atomic，为setter方法加锁，而nonatomic 不为setter方法加锁。
        3. 如1所述，使用nonatomic要注意多线程间通信的线程安全。
     
            为什么nonatomic要比atomic快。原因是：它直接访问内存中的地址，不关心其他线程是否在改变这个值，并且中间没有死锁保护，它只需直接从内存中访问到当前内存地址中能用到的数据即可（可以理解为getter方法一直可以返回数值，尽管这个数值在cpu中可能正在修改中）
        4. 不要误认为多线程下加atomic是安全的，这样理解是不正确的，说明理解的不够深入。atomic的安全只是在getter和setter方法的时候是原子操作，是安全的。但是其他方面是不在atomic管理范围之内的，例如变量cnt的++运算。这个时候不能保证安全。
     
     
     

     */
}
//FIXME:5 算法
-(void)suanfaExample{
    
}
//FIXME:6 堆、栈区 全局区（静态存储区） 常量区
-(void)dzZone{
    /*
     //TODO:1 栈 stack
        栈区（stack）由编译器自动分配释放，存放函数的参数值，局部变量等值。其操作方式类似于数据结构中的栈。栈是一个用来存储局部和临时变量的存储空间。在现代操作系统中,一个线程会分配一个栈. 当一个函数被调用,一个stack frame(栈帧)就会被压到stack里。里面包含这个函数涉及的参数,局部变量,返回地址等相关信息。当函数返回后,这个栈帧就会被销毁。而这一切都是自动的,由系统帮我们进行分配与销毁。对于程序员来说，我们无须自己调度。
     栈对象
            优点：1.高速，在栈上分配内存是非常快的。2.简单，栈对象有自己的生命周期，你永远不可能发生内存泄露。因为他总是在超出他的作用域时被自动销毁了
     
            缺点:1栈对象严格的定义了生命周期也是其主要的缺点,栈对象的生命周期不适于Objective-C的引用计数内存管理方法。在objective-c中只支持一个类型对象：blocks。关于在block中的对象的生命周期问题。出现这问题的原因是，block是新的对象，当你使用block时候，如果你想对其保持引用，你需要对其进行copy操作，（从栈上copy到堆中，并返回一个指向他的指针），而不是对其进行retain操作
     
     //TODO:2 堆 heap
        堆区 （heap）一般由程序员分配释放，若程序员不释放，则可能会引起内存泄漏。注 堆和数据结构中的堆栈不一样，其类似于链表。堆从本质上来说，程序中所有的一切都在内存中（有些东西是不在堆栈中的，但在这篇文章中我们不作讨论）。在堆上，我们可以任何时候分配内存空间以及释放销毁它。你必须显示的请求在堆上分配内存空间，如果你不使用垃圾回收机制，你必须显示的去释放它。这就是在你的函数调用前需要完成的事情。简单来说，就是malloc与free。
     
            优点：可以自己控制对象的生命周期。
            缺点：需要程序员手动释放，容易造成内存泄漏。首先我们需要明确,对象的内存一般被分配到堆上，基本数据类型和oc数据类型的内存一般被分配在栈上。如果用assign修饰对象，当对象被释放后，指针的地址还是存在的，也就是说指针并没有被置为nil，从而造成了野指针。因为对象是分配在堆上的，堆上的内存由程序员分配释放。而因为指针没有被置为nil,如果后续的内存分配中，刚好分配到了这块内存，就会造成崩溃。而assign修饰基本数据类型或oc数据类型，因为基本数据类型是分配在栈上的，由系统分配和释放，所以不会造成野指针。

     //TODO:3 全局区 全局变量和静态变量的存储是放在一块区域 ，程序退出后自动释放 。全局区又分为全局初始化区和全局未初始化区。初始化的全局变量和静态变量存放在全局初始化区，未初始化的全局变量和未初始化的静态变量存放在相邻的另一块区域。
     //TODO:4  专门放数字/字符常量的地方， 程序退出后自动释放
     
     iOS 内存五大区
     
     * 栈区<运行时分配>: 先进后出 (分为静态分配 和动态分配)
     特点:由编译器自动完成分配和释放,不需要程序员手动管理,主要存储了函数的参数和局部变量值
     存放:局部变量和方法实参
     
     * 堆区<运行时分配>:
     特点:需要程序员手动开辟并管理内存.(OC有ARC,OC对那个同城不需要程序员考虑释放,但是CF类还有C类型的需要考虑)
     存放:OC通过new alloc方法创建的对象;C通过malloc等
     
     * (全局区)(静态区)<编译时分配>
     特点:程序运行过程内存的数据一直存在,程序结束后由系统释放
     存放:未初始化的全局变量个静态变量
     全局变量  一个全局变量在整个程序中是唯一的
     静态变量  分为全局静态变量和局部静态变量，但是不论是局部的还是全局的静态变量，它的生命周期也是存在于整个程序中的，它会被存储在全局数据区（有些书上也叫静态数据区），只会被初始化一次；
     
     
     * 常量区(数据段)<编译时分配>:
     特点:专门用于存放常量,程序结束后有系统释放
     存放:以初始化的全局变量个静态变量

     * 程序代码区<编译时分配>
     特点:用于存放程序运行时的代码,代码会被编译成二进制存进内存的程序代码区
     存放:程序的代码(被编译成二进制)

     
 
     
     *
    */

    
}
//FIXME:7      OC语言中BOOL 和 bool 区别
- (void)boolExample{
    /*
     OC语言中BOOL 和 bool 区别
     1、类型不同
     bool为布尔型；
     BOOL为int型；
     2、长度不同
     bool只有一个字节；
     BOOL长度视实际环境来定，一般可认为是4个字节；
     3、bool是标准C++数据类型,可取值true和false。单独占一个字节,
     如果数个bool对象列在一起,可能会各占一个bit,这取决于编译器。
     BOOL是微软定义的typedef int BOOL。与bool不同,它是一个三值逻辑,
     TRUE/FALSE/ERROR,返回值为>0的整数为TRUE,0为FALSE,-1为ERROR。
     Win32 API中很多返回值为BOOL的函数都是三值逻辑。比如GetMessage().
     4、取值不同
     bool取值false和true，是0和1的区别；
     BOOL取值FALSE和TRUE，是0和非0的区别；
     
     *******现在的bool 和BOOL好像z是一致的
     */
    BOOL b1 =3;
    
    bool b2 =3;
    
    BOOL b3 =256;
    
    bool b4 =256;
    
    NSLog(@"b1=%d",b1 );
    
    NSLog(@"b2=%d",b2 );
    
    NSLog(@"b3=%d",b3 );
    
    NSLog(@"b4=%d",b4 );
}

//FIXME: 8 数据库操作
- (void)sqlExample{
    
}

//FIXME: 9 runtime 运行时
- (void)runtimeExample{
    
}

//FIXME: 反射机制
- (void)fsExample{
   // Class对象其实本质上就是一个结构体，这个结构体中的成员变量还是自己，这种设计方式非常像链表的数据结构。
    /*
     反射方法
     
     系统Foundation框架为我们提供了一些方法反射的API，我们可以通过这些API执行将字符串转为SEL等操作。由于OC语言的动态性，这些操作都是发生在运行时的。
     // SEL和字符串转换
     FOUNDATION_EXPORT NSString *NSStringFromSelector(SEL aSelector);
     FOUNDATION_EXPORT SEL NSSelectorFromString(NSString *aSelectorName);
     // Class和字符串转换
     FOUNDATION_EXPORT NSString *NSStringFromClass(Class aClass);
     FOUNDATION_EXPORT Class __nullable NSClassFromString(NSString *aClassName);
     // Protocol和字符串转换
     FOUNDATION_EXPORT NSString *NSStringFromProtocol(Protocol *proto) NS_AVAILABLE(10_5, 2_0);
     FOUNDATION_EXPORT Protocol * __nullable NSProtocolFromString(NSString *namestr) NS_AVAILABLE(10_5, 2_0);
     
     // 当前对象是否这个类或其子类的实例
     - (BOOL)isKindOfClass:(Class)aClass;
     // 当前对象是否是这个类的实例
     - (BOOL)isMemberOfClass:(Class)aClass;
     // 当前对象是否遵守这个协议
     - (BOOL)conformsToProtocol:(Protocol *)aProtocol;
     // 当前对象是否实现这个方法
     - (BOOL)respondsToSelector:(SEL)aSelector;
     
     遇到这样奇葩的需求，我们当然可以问产品都有哪些情况执行哪些方法，然后写一大堆if else判断或switch判断。
     但是这种方法实现起来太low了，而且不够灵活，假设后续版本需求变了，还要往其他已有页面中跳转，这不就傻眼了吗....
     这种情况反射机制就派上用场了，我们可以用反射机制动态的创建类并执行方法。当然也可以通过runtime来实现这个功能，但是我们当前需求反射机制已经足够满足需求了，如果遇到更加复杂的需求可以考虑用runtime来实现。
     这时候就需要和后台配合了，我们首先需要和后台商量好返回的数据结构，以及数据格式、类型等，返回后我们按照和后台约定的格式，根据后台返回的信息，直接进行反射和调用即可。
     */
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    NSThread *thread = [[NSThread alloc]initWithBlock:^{
//        NSLog(@" -- -- -%@",[NSThread currentThread]);
//
//    }];
//    [thread start];

}



/*
 
 TODO: + 说明：
 如果代码中有该标识，说明在标识处有功能代码待编写，待实现的功能在说明中会简略说明。
 
 FIXME: + 说明：
 如果代码中有该标识，说明标识处代码需要修正，甚至代码是错误的，不能工作，需要修复，如何修正会在说明中简略说明。
 
 XXX: + 说明：
 如果代码中有该标识，说明标识处代码虽然实现了功能，但是实现的方法有待商榷，希望将来能改进，要改进的地方会在说明中简略说明。

 */


@end
