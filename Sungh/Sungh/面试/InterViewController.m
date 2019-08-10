//
//  InterViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2019/8/8.
//  Copyright © 2019 yonyouqiche. All rights reserved.
//

#import "InterViewController.h"
#import "STool.h"
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
     */
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 111; i++) {
        @autoreleasepool {
            NSString *str = @"1";
            [arr addObject:str];
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
     
     * 栈区<运行时分配>:
     特点:由编译器自动完成分配和释放,不需要程序员手动管理,主要存储了函数的参数和局部变量值
     存放:局部变量和方法实参
     
     * 堆区<运行时分配>:
     特点:需要程序员手动开辟并管理内存.(OC有ARC,OC对那个同城不需要程序员考虑释放,但是CF类还有C类型的需要考虑)
     存放:OC通过new alloc方法创建的对象;C通过malloc等
     
     * BSS段(全局区)(静态区)<编译时分配>
     特点:程序运行过程内存的数据一直存在,程序结束后由系统释放
     存放:未初始化的全局变量个静态变量
     
     * 常量区(数据段)<编译时分配>:
     特点:专门用于存放常量,程序结束后有系统释放
     存放:以初始化的全局变量个静态变量

     * 程序代码区<编译时分配>
     特点:用于存放程序运行时的代码,代码会被编译成二进制存进内存的程序代码区
     存放:程序的代码(被编译成二进制)

     
     *
    */

    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_queue_t queue = dispatch_queue_create("sun_com", nil);
    dispatch_async(queue, ^{
    });
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
