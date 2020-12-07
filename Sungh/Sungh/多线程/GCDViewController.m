//
//  GCDViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/5/25.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "GCDViewController.h"
#import "Smodel.h"
@interface GCDViewController ()
@property (nonatomic,weak)Smodel *mod;
@end

@implementation GCDViewController
-(void)dealloc{
    
    NSLog(@"delca --- %@",self.mod);
}
- (void)ces{
    NSLog(@" ces----- %@",self.mod);

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *mus = [[NSMutableArray alloc]init];
    Smodel *model = [[Smodel alloc]init];
    model.age2 = 10;
    [mus addObject:model];
    
    NSArray *arr = [mus mutableCopy];
    
    Smodel *model2 = arr[0];
//    model2.age = @"120";
    model2.age2 = 100;
    NSLog(@" ---- %@ %d ---- %@ %d",model,model.age2,model2,model2.age2);
    
    self.mod.age = @"1111";
    [self performSelector:@selector(ces) withObject:nil afterDelay:5];
    /*
     队列 - > 数据结构 FIFO(先进先出)
     先添加先执行？（不一定  看任务耗时操作、并发，优先级,依赖，线程状态）
     */
    
//    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
//    NSLog(@"1");
//    dispatch_async(queue, ^{
//       NSLog(@"2");
//
//        dispatch_sync(queue, ^{
//            NSLog(@"3");
//
//        });
//        NSLog(@"4");
//
//    });
//    NSLog(@"5");
    //15234
//    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"1");
//    dispatch_async(queue, ^{
//       NSLog(@"2");
//
////        dispatch_sync(queue, ^{
////            NSLog(@"3");
////
////        });
////        NSLog(@"4");
//
//    });
//    NSLog(@"5");
    //152
    
    
//    dispatch_group_t g1 = dispatch_group_create();
//    dispatch_group_t g2 = dispatch_group_create();
//    dispatch_group_t g3 = dispatch_group_create();
//
//    dispatch_group_enter(g1);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        for (int i = 0; i < 3; i++) {
//            NSLog(@" --- AA");
//        }
//        dispatch_group_leave(g1);
//    });
//    dispatch_group_enter(g1);
//    dispatch_group_enter(g2);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        for (int i = 0; i < 3; i++) {
//            NSLog(@" --- BB");
//        }
//        dispatch_group_leave(g1);
//        dispatch_group_leave(g2);
//
//    });
//    dispatch_group_enter(g2);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        for (int i = 0; i < 3; i++) {
//            NSLog(@" --- CC");
//        }
//        dispatch_group_leave(g2);
//
//    });
//    dispatch_group_enter(g3);
//    dispatch_group_notify(g1, dispatch_get_global_queue(0, 0), ^{
//        for (int i = 0; i < 3; i++) {
//                   NSLog(@" --- DD");
//               }
//               dispatch_group_leave(g3);
//    });
//    dispatch_group_enter(g3);
//    dispatch_group_notify(g2, dispatch_get_global_queue(0, 0), ^{
//        for (int i = 0; i < 3; i++) {
//                   NSLog(@" --- EE");
//               }
//               dispatch_group_leave(g3);
//    });
//
//    dispatch_group_notify(g3, dispatch_get_global_queue(0, 0), ^{
//        for (int i = 0; i < 3; i++) {
//                   NSLog(@" --- FF");
//               }
//    });
//
//    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_async(queue, ^{
//        // 追加任务 1
//        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//    });
//    dispatch_async(queue, ^{
//        // 追加任务 2
//        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//    });
//    dispatch_async(queue, ^{
//        // 追加任务 3
//        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
//    });
//
//
//
//
//
//    dispatch_group_t qus = dispatch_group_create();
//    dispatch_group_t qus1 = dispatch_group_create();
//
//    dispatch_group_enter(qus1);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
////        sleep(2);
//        NSLog(@"---- 1");
//        dispatch_group_leave(qus1);
//    });
//
//    dispatch_group_enter(qus);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"---- 2");
//        dispatch_group_leave(qus);
//       });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//              NSLog(@"---- 3");
//    });
//
//    dispatch_group_notify(qus1, dispatch_get_global_queue(0, 0), ^{
////
//        dispatch_group_notify(qus, dispatch_get_global_queue(0, 0), ^{
//            NSLog(@" -- -- sungh");
//        });
//
//    });
    
    
//    sleep(5);
//

    
//    [self xinhaoliang];
    
//    [self enterGroup];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.view.backgroundColor = [UIColor orangeColor];
    });
    [self zlgcd];
}
//栅栏
- (void)zlgcd{
        dispatch_queue_t ques1 = dispatch_queue_create("synl.com.quesu", DISPATCH_QUEUE_CONCURRENT);
        dispatch_queue_t ques2 = dispatch_queue_create("synl.com.quesu2", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(ques1, ^{
//            dispatch_async(ques2, ^{
                NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//            });
    
        });
    
        dispatch_async(ques1, ^{
               // 追加任务 2
//            dispatch_async(ques2, ^{
                        [NSThread sleepForTimeInterval:5];              // 模拟耗时操作
                        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//                     });
    
           });
    
        dispatch_barrier_async(ques1, ^{
               // 追加任务 barrier
               [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
               NSLog(@"barrier---%@",[NSThread currentThread]);// 打印当前线程
        });
    
    NSLog(@" --------- ---------------------");
        dispatch_async(ques1, ^{
               // 追加任务 3
               [NSThread sleepForTimeInterval:0];              // 模拟耗时操作
               NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        });
        dispatch_async(ques1, ^{
               // 追加任务 4
               [NSThread sleepForTimeInterval:0];              // 模拟耗时操作
               NSLog(@"4---%@",[NSThread currentThread]);      // 打印当前线程
        });
}
//信号量  等所有接口回调之后刷新ui
- (void)xinhaoliang{
    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);//
    
    dispatch_async(queue, ^{
        dispatch_async(dispatch_queue_create("l", DISPATCH_QUEUE_CONCURRENT), ^{
            sleep(2);
            NSLog(@"网络请求1");
            dispatch_semaphore_signal(semaphore);
            
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_async(dispatch_queue_create("l", DISPATCH_QUEUE_CONCURRENT), ^{
            NSLog(@"网络请求2");
            dispatch_semaphore_signal(semaphore);
            
        });
    });
    dispatch_async(queue, ^{
        dispatch_async(dispatch_queue_create("l", DISPATCH_QUEUE_CONCURRENT), ^{
            NSLog(@"网络请求3");
            dispatch_semaphore_signal(semaphore);
            
        });
    });
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"更新UI");
            self.view.backgroundColor = [UIColor redColor];
            
        });
    });

}


- (void)enterGroup{
    dispatch_group_t gropu = dispatch_group_create();
    dispatch_group_enter(gropu);
    dispatch_async(dispatch_queue_create("pllll", DISPATCH_QUEUE_CONCURRENT), ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"leave1");
        dispatch_group_leave(gropu);
    });
    
    dispatch_group_enter(gropu);
    dispatch_async(dispatch_queue_create("pllll", DISPATCH_QUEUE_CONCURRENT), ^{
        [NSThread sleepForTimeInterval:5];
        dispatch_group_leave(gropu);
        NSLog(@"leave2");

    });
    
    dispatch_group_enter(gropu);
    dispatch_async(dispatch_queue_create("pllll", DISPATCH_QUEUE_CONCURRENT), ^{
        dispatch_group_leave(gropu);
        NSLog(@"leave3");

    });
    dispatch_async(dispatch_queue_create("wait", DISPATCH_QUEUE_CONCURRENT), ^{//
        dispatch_group_wait(gropu, DISPATCH_TIME_FOREVER);//d放到异步中等待
        dispatch_group_enter(gropu);
          dispatch_async(dispatch_get_main_queue(), ^{
              NSLog(@"leave4");
              self.view.backgroundColor = [UIColor redColor];
          });
    });
  
}

 /*
  GCD：
  将任务（block）添加到队列(串行/并发/主队列)，并且指定任务执行的函数(同步/异步)
  GCD是底层的C语言构成的API
  iOS 4.0 推出的，针对多核处理器的并发技术
  在队列中执行的是由 block 构成的任务，这是一个轻量级的数据结构
  要停止已经加入 queue 的 block 需要写复杂的代码
  需要通过 Barrier 或者同步任务设置任务之间的依赖关系
  只能设置队列的优先级
  高级功能：
  一次性 once
  延迟操作 after
  调度组
  
  NSOperation：
  核心概念：把操作(异步)添加到队列(全局的并发队列)
  OC 框架，更加面向对象，是对 GCD 的封装
  iOS 2.0 推出的，苹果推出 GCD 之后，对 NSOperation 的底层全部重写
  Operation作为一个对象，为我们提供了更多的选择
  可以随时取消已经设定要准备执行的任务，已经执行的除外
  可以跨队列设置操作的依赖关系
  可以设置队列中每一个操作的优先级
  高级功能：
  最大操作并发数(GCD不好做)
  继续/暂停/全部取消
  跨队列设置操作的依赖关系
  
  ** 总结  operation 可以设置最大并发数 可以暂停、取消、继续队列 可以简单的设置依赖关系 可以设置每一个任务的优先级  ，是对gcd的更高层的抽象
  gcd 一次性once 可以简单的设置t串行并行等 执行和操作简单高效 可以通过dispatch_barrier_async设置依赖关系，
  */


@end
