//
//  SynchronizedViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2019/6/4.
//  Copyright © 2019年 yonyouqiche. All rights reserved.
//

#import "SynchronizedViewController.h"

@interface SynchronizedViewController ()
@property (nonatomic, strong) NSThread *thread;//创建一个常驻线程

@end

@implementation SynchronizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSObject *obj = [[NSObject alloc]init];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        @synchronized (obj) {
//            NSLog(@" --- -- -- 111111111开始");
//            sleep(3);
//            NSLog(@" -----------222222222结束");
//        }
//    });
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(1);
//        @synchronized (obj) {
//            NSLog(@"-----------需要现场同步的操作2");
//        }
//    });
  
    //******
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(2);
        NSLog(@"需要线程同步的操作1 结束");
        dispatch_semaphore_signal(signal);
    });
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作2");
        dispatch_semaphore_signal(signal);
    });
    
    
    
    
}
- (void)async{
    
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
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    NSLog(@"%@",[NSRunLoop mainRunLoop]);
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

/*
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
 
 
 */
@end
