//
//  RunLoopViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/8/13.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "RunLoopViewController.h"
#import "NSArray+Safe.h"
#import "SunThread.h"
#import "SunPerment.h"
@interface RunLoopViewController ()
@property (nonatomic,strong)UITextView *textv;
@property (nonatomic,strong)NSThread *thread;
@property (nonatomic,assign)BOOL isstop;

@property (nonatomic,strong)SunPerment *perment;

@end

@implementation RunLoopViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
#if  0
    self.textv = [[UITextView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    self.textv.text = @"akhdahkalsdladlanldnalnsdlasndlnalndlandlnalndlanlnldnalndlandlndndndndlknasldnlandlasndlnaldnalndlnldnldnlndndndndndnndnddnddnlnlndlndlndndnnddnldnlndndndnndnnddndnd";
    [self.view addSubview:self.textv];
    
//    [self observeFunc];
    
   
//    NSTimer *timer = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@" ---- ");
//    }];
//    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
//    self.thread = [[SunThread alloc]initWithTarget:self selector:@selector(run) object:nil];
 
    self.isstop = NO;
    __weak typeof(self)weakself = self;
    self.thread = [[SunThread alloc]initWithBlock:^{
        
        NSLog(@" ------- %s ---- %@",__func__,[NSThread currentThread]);
        [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop]run];
        
        while (weakself && !weakself.isstop) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
        NSLog(@" ---------end ---%s",__func__);
    }];

    [self.thread start];
    
    
#else
    self.perment = [[SunPerment alloc]init];
    [self.perment run];
#endif
}

/*
 
 ios 有两套api 可以拿到runloop
 
 Foundation：NSRunoop 基于CFRunLoopRef 的一层oc报装对象
 
 Core Foundation CFRunLoopRef
 
 
 
 
 面试1；
 线程与runloop关系
 每一条线程都有唯一一个与之对应的runloop对象
 
 
 runloop 保存在一个全局的字典里，线程作为key，runloop 作为value
 
 runloop 销毁时间是 线程结束的时候就会销毁 ，他与线程一对一
 
CFRunLoopMode;  mode 运行模式  运行的时候只选择一种模式运行
 
CFRunLoopSourceRef
 
CFRunLoopTimerRef
 
CFRunLoopObserverRef
 
 *
 source0 要处理的任务
 source1 基于端口 port 线程间通过port 通信 source1 捕捉事件，交给source1处理
 observe
 自动释放池也是通过它实现的
 ui刷新改变 在runloop休眠之前
 timer
 
 kCFRunLoopDefaultMode;默认的model
 UITrackingRunLoopMode;界面跟踪，mode
 NSRunLoopCommonModes  共有型 Model 含有上面两种Mode模式的意义
 GSEventReceiveRunLoopMode  Connection 系统内核模式，系统调用事件发生会切换到相应模式下，开发者无法操作
 
 UIInitializationRunLoopMode Modal 项目初始化模式，只会走一次
//循环处理 source0 source1 time observe
 1
 
 */

- (void)loop1{
    [NSRunLoop currentRunLoop];
    
    CFRunLoopRef ref = CFRunLoopGetCurrent();
    
}
- (void)observeFunc{
    
////    kCFRunLoopCommonModes  包括两种模式
//    CFRunLoopObserverRef obser =  CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, CFRunLoopObserverCallBack2, NULL);
//    CFRunLoopAddObserver(CFRunLoopGetMain(), obser, kCFRunLoopCommonModes);
//    CFRelease(obser);
    
    CFRunLoopObserverRef obser =   CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@" ------kCFRunLoopEntry");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@" ------kCFRunLoopBeforeTimers");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@" ------kCFRunLoopBeforeSources");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@" ------kCFRunLoopBeforeWaiting");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@" ------kCFRunLoopAfterWaiting");
                break;
            case kCFRunLoopExit:
                NSLog(@" ------kCFRunLoopExit");
                break;
            default:
            break;
                
        }
    });
        CFRunLoopAddObserver(CFRunLoopGetMain(), obser, kCFRunLoopCommonModes);
        CFRelease(obser);
    
    
    
/*
 //runloop初始化
 1.通知observe 即将进入loop
  source0（port） 外部唤醒（
 2.通知observe 将要处理time
 3.通知observe 将要处理source
 4.处理source
 5.如果有source1 跳到9
 6.通知observe 线程即将休眠
 7.休眠 等待唤醒
 8.通知observe 线程被唤醒
 9.处理唤醒时收到的消息，跳转2
 ）
 10.通知observe 即将推出loop
 */
    
}

void CFRunLoopObserverCallBack2(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@" ------kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@" ------kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@" ------kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@" ------kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@" ------kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@" ------kCFRunLoopExit");
            break;
        default:
            break;
    }
   //kCFRunLoopBeforeWaiting 睡眠
// kCFRunLoopAfterWaiting   唤醒
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@" ------- %s",__func__);
    
#if 0
    [self threadTest];
#else
    [self.perment excuteTaskBlock:^{
        NSLog(@" -----------执行任务%@",[NSThread currentThread]);
    }];
#endif
    
}
//线程保活
- (void)threadTest{
//    SunThread *thread = [[SunThread alloc]initWithTarget:self selector:@selector(run) object:nil];
//    [thread start];
    
    //添加source time observe
    
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:YES];
    NSLog(@"test123");
}
- (void)test{
    NSLog(@" -------- %@",[NSThread currentThread]);
}
//  线程保护活跃
- (void)run{
    
    
    NSLog(@" ------- %s ---- %@",__func__,[NSThread currentThread]);
    
    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]run];
    NSLog(@" ---------end ---%s",__func__);

}
- (void)stop{
    self.isstop = YES;

    CFRunLoopStop(CFRunLoopGetCurrent());
    
}



-(void)viewWillDisappear:(BOOL)animated
{
}
-(void)dealloc{
    
//    yes 代表子线程执行完之后 这个方法才会往下走
//    [self performSelector:@selector(stop) onThread:self.thread withObject:nil waitUntilDone:YES];
    
    NSLog(@" -------   %s",__func__);
}

/*
 @autoreleasepool
 
 poolpush
 压栈
 
 poolpop
 出栈
 */


/*
 
 伪代码
 通知observe
 beforcetimer
 beforesource
 
 */
@end
