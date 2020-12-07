//
//  SynchronizedViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2019/6/4.
//  Copyright © 2019年 yonyouqiche. All rights reserved.
//

#import "SynchronizedViewController.h"
#import "SsOperation.h"
#import "GCDViewController.h"
@interface SynchronizedViewController ()
@property (nonatomic, strong) NSThread *thread;//创建一个常驻线程
@property (nonatomic,strong)NSOperationQueue *queueOprtations;
@end

@implementation SynchronizedViewController
- (void)dispatch_semaphore_createaction{
//    异步网络请求  通过信号量 实现同步执行
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//    dispatch_queue_t queu = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    //任务1
//    dispatch_async(queu, ^{
//        NSLog(@" ----1-----");
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//              NSLog(@"run task 1");
//              sleep(1);
//              NSLog(@"complete task 1");
//        dispatch_semaphore_signal(semaphore);
//    });
////    任务2
//    dispatch_async(queu, ^{
//        NSLog(@" ----2-----");
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//              NSLog(@"run task 2");
//              sleep(1);
//              NSLog(@"complete task 2");
//              dispatch_semaphore_signal(semaphore);
//    });
//    dispatch_async(queu, ^{
//        NSLog(@" ----3-----");
//
//           dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//           NSLog(@"run task 3");
//           sleep(1);
//           NSLog(@"complete task 3");
//           dispatch_semaphore_signal(semaphore);
//       });
//    NSLog(@" ------ dispatch_semaphore_signal");
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务1:%@",[NSThread currentThread]);
        dispatch_semaphore_signal(sem);
    });
    NSLog(@" ------ dispatch_semaphore_signal");
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务2:%@",[NSThread currentThread]);
        dispatch_semaphore_signal(sem);
    });
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务3:%@",[NSThread currentThread]);
    });
    
    
//    异步组
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group  =   dispatch_group_create();
//    dispatch_group_async(group, queue, ^{
//           NSLog(@"1");
//       });
//       dispatch_group_async(group, queue, ^{
//           NSLog(@"2");
//       });
//       dispatch_group_async(group, queue, ^{
//           NSLog(@"3");
//       });
//    dispatch_group_notify(group, queue, ^{
//        NSLog(@"done");
//    });
    
    
    
//    有时候我们希望使用异步函数并发执行完任务之后再异步回调到当前线程。当前线程的任务执行完毕后再执行最后的处理。这种异步的异步，只使用dispatch group是不够的，还需要dispatch_semaphore_t（信号量）的加入。
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t semp = dispatch_semaphore_create(0);
    dispatch_group_async(group, queue, ^{
       
        dispatch_async(queue, ^{
                     sleep(2);
            NSLog(@"task1 finish : %@",[NSThread currentThread]);
   
            dispatch_semaphore_signal(semp);
        });
        dispatch_semaphore_wait(semp, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_async(group, queue, ^{
       
        dispatch_async(queue, ^{
           
            NSLog(@"task2 finish : %@",[NSThread currentThread]);
            dispatch_semaphore_signal(semp);
        });
        dispatch_semaphore_wait(semp, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_notify(group, queue, ^{
        
        NSLog(@"refresh UI");

        
    });
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dispatch_semaphore_createaction];
    self.view.backgroundColor = [UIColor whiteColor];
//    NSObject *obj = [[NSObject alloc]init];
//    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
//    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        dispatch_semaphore_wait(signal, overTime);
//        NSLog(@"需要线程同步的操作1 开始");
//        sleep(2);
//        NSLog(@"需要线程同步的操作1 结束");
//        dispatch_semaphore_signal(signal);
//    });
//
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(1);
//        dispatch_semaphore_wait(signal, overTime);
//        NSLog(@"需要线程同步的操作2");
//        dispatch_semaphore_signal(signal);
//    });
//
//
//    [self autoreleasepoolAction];
//    //递归所
//    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        static void (^RecursiveMethod)(int);
//        RecursiveMethod = ^(int value) {
//            [lock lock];
//            value--;
//            if (value > 0) {
////                NSLog(@"value = %d", value);
////                sleep(1);
//                RecursiveMethod(value);
//            }
//            NSLog(@" ---- %d",value+1);
//
//            [lock unlock];
//        };
//
//        RecursiveMethod(5);
//    });
//
////    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////        sleep(2);
////        BOOL flag = [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
////        if (flag) {
////            NSLog(@"lock before date");
////            [lock unlock];
////        } else {
////            NSLog(@"fail to lock before date");
////        }
////    });

}
- (void)async{
    //DISPATCH_QUEUE_CONCURRENT 队里 并行并发队列
    //DISPATCH_QUEUE_SERIAL 队列串行  NULL 同步队列
/*
 队列优先级
 DISPATCH_QUEUE_PRIORITY_HIGH 2 // 高
 DISPATCH_QUEUE_PRIORITY_DEFAULT 0 // 默认（中）
 DISPATCH_QUEUE_PRIORITY_LOW (-2) // 低
 DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN // 后台
 */
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.gcd-group.www", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 1000; i++) {
            if (i == 999) {
                NSLog(@"11111111");
            }
        }
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"22222222");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"33333333");
        dispatch_async(queue, ^{
            for (int i = 0; i < 10000; i++) {
                if (i == 999) {
                    NSLog(@"44444444444");
                }
            }
        });
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"done");
    });
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    NSLog(@"%@",[NSRunLoop mainRunLoop]);
    GCDViewController *vc = [GCDViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)show
{
    NSLog(@"-------");
}
//如何实现两个线程交替执行？
- (void)blockOperation{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [self text_One_Completed:^() {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self text_Two_Completed:^() {
        dispatch_group_leave(group);
    }];
    
    __weak typeof(self) weakSelf = self;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakSelf blockOperation];
    });//执行完之后又开始执行而已
    
}

- (void)threadRunloopPoint:(id)__unused object{
    @autoreleasepool {
        [[NSThread currentThread] setName:@"ZFJThread"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        //这里主要是监听某个 port，目的是让这个 Thread 不会回收
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

- (NSThread *)thread{
    if(!_thread){
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRunloopPoint:) object:nil];
        [_thread start];
    }
    return _thread;
    
}
- (void)text_One_Completed:(void(^)(void))completed{
    
    [self performSelector:@selector(text_One) onThread:self.thread withObject:nil waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
    
    if(completed){
        completed();
    }
}

- (void)text_Two_Completed:(void(^)(void))completed{
    
    [self performSelector:@selector(text_Two) onThread:self.thread withObject:nil waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
    
    if(completed){
        completed();
    }
}

- (void)text_One{
    
    NSLog(@"----打印线程1----");
}

- (void)text_Two{
    
    NSLog(@"====打印线程2====");
    
}
#pragma mark - Navigation

//123:asds
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
__weak id  reference = nil;

-(void)autoreleasepoolAction{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < 10000; i++) {
        @autoreleasepool {
            NSString *str = @"1";
            [arr addObject:str];
       }
       
    }
//    NSObject *obj = [NSObject new];
    // NSString *str = @"111"; 字面意思的字符串是放在常量区的对其retain或者release不影响它的引用计数，程序结束后释放。用字面量语法创建出来的string就是这种
    
    @autoreleasepool {
        NSString *str = [NSString stringWithFormat:@"12892391191121"];
        NSString *s  = [str mutableCopy];
        reference = s;
        NSLog(@" --- -%@",reference);
    }


}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@" --- -%@",reference);
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@" --- -%@",reference);

}
/*
 其中就引用了一个自动释放池。其实，自动释放池@autoreleasepool{}在系统中所编译的代码为：1.void *ctx = objc_autoreleasepoolPush();     //创建一个无类型指针的哨兵对象2.执行@autoreleasepool{}中对应{}里所书写的代码3.执行objc_autoreleasepool(ctx);//释放哨兵对象所分隔区域内所有对象的引用计数
 
 AutoreleasePool被称为自动释放池，在释放池中的调用了autorelease方法的对象都会被压在该池的顶部（以栈的形式管理对象）
 
 App启动后，系统在主线程RunLoop 里注册两个Observser,其回调都是_wrapRunLoopWithAutoreleasePoolHandler()。
 
 第一个 Observer 监视的事件
 是 Entry(即将进入Loop)，其回调内会调用 _objc_autoreleasePoolPush() 创建自动释放池。其优先级最高，保证创建释放池发生在其他所有回调之前。
 
 第二个 Observer 监视了两个事件
 
 _BeforeWaiting(准备进入休眠) 时 _
 调用_objc_autoreleasePoolPop() 和 _objc_autoreleasePoolPush() 释放旧的池并创建新池；
 
 _Exit(即将退出Loop) 时 _
 调用 _objc_autoreleasePoolPop() 来释放自动释放池。这个 Observer 优先级最低，保证其释放池子发生在其他所有回调之后。
 讲讲 RunLoop，项目中有用到吗？
 RunLoop内部实现逻辑？
 Runloop和线程的关系？
 timer 与 Runloop 的关系？
 程序中添加每3秒响应一次的NSTimer，当拖动tableview时timer可能无法响应要怎么解决？
 Runloop 是怎么响应用户操作的， 具体流程是什么样的？
 说说RunLoop的几种状态？
 Runloop的mode作用是什么？
 */
//FIXME: runloop
- (void)runloopTest{
    
}
/*
 程序一旦开启就会有一个主线程，主线程开启就会跑一个主线程对应的runloop
  runloop 保证主线程不会n被销毁，也就保证了程序可持续的y运行
 节省cpu资源 提高性能 当程序跑起来，没有什么操作的时候，runloop就会告诉cpu
 将其资源释放 出来去做其他事情，当有事情做得时候就会立马处理事情
 */
/*
 Foundation
 [NSRunLoop currentRunLoop]; // 获得当前线程的RunLoop对象
 [NSRunLoop mainRunLoop]; // 获得主线程的RunLoop对象
 
 Core Foundation
 CFRunLoopGetCurrent(); // 获得当前线程的RunLoop对象
 CFRunLoopGetMain(); // 获得主线程的RunLoop对象
 
 **每一条线程y都有一个唯一的与之对应的runloop 对象
 runloop保存到全局的dic 中， 线程作为key，runloop 作为value
 主线程runloop都是自动创建d好的，子线程的runloop 需要主动创建
 runloop 在第一次获取时候创建，在线程结束时销毁
 
 
 CFRunLoopRef - 获得当前RunLoop和主RunLoop
 
CFRunLoopModeRef - RunLoop 运行模式，只能选择一种，在不同模式中做不同的操作
 
 CFRunLoopSourceRef - 事件源，输入源

 CFRunLoopTimerRef - 定时器时间

 CFRunLoopObserverRef - 观察者

 
 1. kCFRunLoopDefaultMode：App的默认Mode，通常主线程是在这个Mode下运行
 2. UITrackingRunLoopMode：界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响
 3. UIInitializationRunLoopMode: 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用，会切换到kCFRunLoopDefaultMode
 4. GSEventReceiveRunLoopMode: 接受系统事件的内部 Mode，通常用不到
 5. kCFRunLoopCommonModes: 这是一个占位用的Mode，作为标记kCFRunLoopDefaultMode和UITrackingRunLoopMode用，并不是一种真正的Mode
 
 
 
通常是写在诸如事件回调、Timer回调内的。这些回调会被 RunLoop 创建好的 AutoreleasePool 环绕着，所以不会出现内存泄漏，开发者也不必显示创建 Pool 了。
 
 AutoreleasePool是在RunLoop即将进入RunLoop和准备进入休眠这两种状态的时候被创建和销毁的。
 
 所以AutoreleasePool的释放有如下两种情况。
 
 一是Autorelease对象是在当前的runloop迭代结束时释放的，而它能够释放的原因是系统在每个runloop迭代中都加入了自动释放池Push和Pop。
 
 二是手动调用AutoreleasePool的释放方法（drain方法）来销毁AutoreleasePool
 
 
 id pool = objc_autoreleasePoolPush();
 id = objc_msgSend(NSObject,@selector(alloc));
 objc_msgSend(obj,@selector(init));
 objc_autorelease(obj);
 objc_autoreleasePoolPop(pool);
 

*/
//自动释放c池原理 一个压栈，一个出栈




//FIXME: NSOperation
- (void)operationExample{
    /*
     NSOperation是基于GCD更高一层的封装，但是比GCD更简单易用、代码可读性也更高
NSOperation需要配合NSOperationQueue来实现多线程。因为默认情况下，NSOperation单独使用时系统同步执行操作，并没有开辟新线程的能力，只有配合NSOperationQueue才能实现异步执行
     
     1.创建任务：先将需要执行的操作封装到一个NSOperation对象中。
     2 .创建队列：创建NSOperationQueue对象。
     3 .将任务加入到队列中：然后将NSOperation对象添加到NSOperationQueue中。
     之后呢，系统就会自动将NSOperationQueue中的NSOperation取出来，在新线程中执行操作
     
     
     */
    
    //1.创建任务
    /*
     使用子类NSInvocationOperation
     使用子类NSBlockOperation
     定义继承自NSOperation的子类，通过实现内部相应的方法来封装任务。
     */
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operationAction) object:nil];
    [operation1 start];//没有使用队列的时候仍然是主线程，并没有开启新的线程
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        [self operationAction];
    }];
    [operation2 start];//没有开启新的线程
    
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        [self operationAction];
    }];
    //为x任务添加子任务 在子线程执行
    [operation3 addExecutionBlock:^{
        [self operationAction];//开辟了子线程

    }];
    [operation3 addExecutionBlock:^{
        [self operationAction];//开辟了子线程

    }];
    [operation3 addExecutionBlock:^{
        [self operationAction];//开辟了子线程

    }];
    [operation3 start];
    
    //自定义
    SsOperation *operation4 = [[SsOperation alloc]init];
    [operation4 start]; //没有使用队列的情况下，没有开辟新的线程
    
    
    //创建队列
    /*
     和GCD中的并发队列、串行队列略有不同的是
     NSOperationQueue一共有两种队列：主队列、其他队列。其中其他队列同时包含了串行、并发功能。下边是主队列、其他队列的基本创建方法和特点
     */
    NSOperationQueue *queue1 = [NSOperationQueue mainQueue];//主队列
    
    NSOperationQueue *queue2 = [[NSOperationQueue alloc]init];//其他队列 包含了：串行、并发功能
    NSInvocationOperation *operation5 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operationAction2) object:nil];
    
    NSBlockOperation *operation6 = [NSBlockOperation blockOperationWithBlock:^{
        [self operationAction2];
    }];
    //并发进行
    [queue2 addOperation:operation5];
    [queue2 addOperation:operation6];
    [queue2 addOperationWithBlock:^{
        [self operationAction2];   //addOperationWithBlock
    }];
    
    /*
     假溢出：顺序队列因多次入队列和出队列操作后出现的尚有存储空间但不
     能再进行入队列操作的溢出
     真溢出：顺序队列最大存储空间已经存满而又要求进行入队列操作所引起
     的溢出
     解决“假溢出”的办法就是后面满了，从头再开始，将头尾相接的顺序存
     储队列称为循环队列
     */
    
    //控制串行执行和并行执行的关键
    /*先进先出(FIFO
     这里有个关键参数maxConcurrentOperationCount，叫做最大并发数。
     
     最大并发数：maxConcurrentOperationCount
     一定要在操作添加到队列之前设置操作之间的依赖，否则操作已经添加到队列中在设置依赖，依赖不会生效
     maxConcurrentOperationCount默认为-1，代表不限制。
     1 时候 是串行  按照添加顺序 执行
     
     */
 
    
    //操作依赖
    
    NSOperationQueue *queue3 = [[NSOperationQueue alloc]init];
    
    NSBlockOperation *operation7 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@" ----    operation7   --%@",[NSThread currentThread]);
    }];
    NSInvocationOperation *operation8 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operationAction3) object:nil];
    [operation7 addDependency:operation8];//operation7 u依赖于operation8 的执行之后
    [queue3 addOperation:operation7];
    [queue3 addOperation:operation8];
    
    /*
     - (void)cancel;// NSOperation提供的方法，可取消单个操作
     - (void)cancelAllOperations;// NSOperationQueue提供的方法，可以取消队列的所有操作
     - (void)setSuspended:(BOOL)b;// 可设置任务的暂停和恢复，YES代表暂停队列，NO代表恢复队列
     - (BOOL)isSuspended;// 判断暂停状态
     */
    self.queueOprtations = queue3;
    
    
    
    /* NSOperation优先级
     GCD中，任务（block）是没有优先级的，而队列具有优先级。和GCD相反，我们一般考虑 NSOperation 的优先级
     NSOperationQueue 也不能完全保证优先级高的任务一定先执行。
     queuePriority默认值是NSOperationQueuePriorityNormal。根据实际需要我们可以通过调用queuePriority的setter方法修改某个操作的优先级
     */
    
    
    NSBlockOperation *blkop1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"执行blkop1");
    }];
    
    NSBlockOperation *blkop2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"执行blkop2");
    }];
    
    // 设置操作优先级
    blkop1.queuePriority = NSOperationQueuePriorityLow;
    blkop2.queuePriority = NSOperationQueuePriorityVeryHigh;
    
    NSLog(@"blkop1 == %@",blkop1);
    NSLog(@"blkop2 == %@",blkop2);
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 操作添加到队列
    [queue addOperation:blkop1];
    [queue addOperation:blkop2];
    
    NSLog(@"%@",[queue operations]);
    for (NSOperation *op in [queue operations]) {
        NSLog(@"op == %@",op);
    }
    /*
     u有时候先执行 blkop1  再执行 blkop2
     u有时候先执行 blkop2  再执行 blkop1
     所以 优先级高 并不是必须先执行

     优先级高只代表先被执行。不代表操作先被执行完成。执行完成的早晚还取决于操作耗时长短。
     */
    
}
- (void)operationAction{
    NSLog(@"%@",[NSThread currentThread]);//此时仍然是主线程main
}
- (void)operationAction2{
    NSLog(@"2--------        %@",[NSThread currentThread]);//
}
- (void)operationAction3{
    NSLog(@"3--------        %@",[NSThread currentThread]);//
//    [self.queueOprtations cancelAllOperations];//执行完取消操作 ，这时候 不在执行operation7

}


//FIXME: 2 GCD  GCD和nsoperation对比一下
- (void)gcdExample{
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self operationExample];
}

- (void)threadOperationn{
    [NSThread detachNewThreadSelector:@selector(test99) toTarget:self withObject:nil];
    NSThread *th = [[NSThread alloc]initWithTarget:self selector:@selector(test100)  object:nil];
    [th start];
}
- (void)test99{
    NSLog(@" --- test99");
}
- (void)test100{
    NSLog(@" --- test100");

}
@end
