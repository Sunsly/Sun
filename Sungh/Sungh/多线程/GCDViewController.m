//
//  GCDViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/5/25.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
//    dispatch_queue_t ques1 = dispatch_queue_create("synl.com.quesu", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t ques2 = dispatch_queue_create("synl.com.quesu2", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_async(ques1, ^{
//        dispatch_async(ques2, ^{
//            [NSThread sleepForTimeInterval:5];              // 模拟耗时操作
//                   NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//        });
//
//    });
//
//
//    dispatch_async(ques1, ^{
//           // 追加任务 2
//        dispatch_async(ques2, ^{
//                    [NSThread sleepForTimeInterval:5];              // 模拟耗时操作
//                            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//                 });
//
//       });
//
//    dispatch_barrier_async(ques1, ^{
//           // 追加任务 barrier
//           [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//           NSLog(@"barrier---%@",[NSThread currentThread]);// 打印当前线程
//    });
//
//    dispatch_async(ques1, ^{
//           // 追加任务 3
//           [NSThread sleepForTimeInterval:0];              // 模拟耗时操作
//           NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
//    });
//    dispatch_async(ques1, ^{
//           // 追加任务 4
//           [NSThread sleepForTimeInterval:0];              // 模拟耗时操作
//           NSLog(@"4---%@",[NSThread currentThread]);      // 打印当前线程
//    });
    
//    [self xinhaoliang];
    
    [self enterGroup];
    dispatch_async(dispatch_queue_create("lp", DISPATCH_QUEUE_CONCURRENT), ^{
        [self enterGroup];
    });
}

//信号量  等所有接口回调之后刷新ui
- (void)xinhaoliang{
    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
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

        });
    });

}


- (void)enterGroup{
    dispatch_group_t gropu = dispatch_group_create();
    
    dispatch_group_enter(gropu);
    dispatch_async(dispatch_queue_create("pllll", DISPATCH_QUEUE_CONCURRENT), ^{
        sleep(2);
           NSLog(@"leave1");

        dispatch_group_leave(gropu);
    });
    
    dispatch_group_enter(gropu);
    dispatch_async(dispatch_queue_create("pllll", DISPATCH_QUEUE_CONCURRENT), ^{
        sleep(2);

        dispatch_group_leave(gropu);
           NSLog(@"leave2");

    });
    
    dispatch_group_enter(gropu);
    dispatch_async(dispatch_queue_create("pllll", DISPATCH_QUEUE_CONCURRENT), ^{
        dispatch_group_leave(gropu);
           NSLog(@"leave3");

    });
    
    dispatch_group_wait(gropu, DISPATCH_TIME_FOREVER);
    dispatch_group_enter(gropu);
    
    dispatch_async(dispatch_get_main_queue(), ^{
           NSLog(@"leave4");

        self.view.backgroundColor = [UIColor redColor];
    });
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
