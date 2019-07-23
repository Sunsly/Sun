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
    [self blockOperation];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
