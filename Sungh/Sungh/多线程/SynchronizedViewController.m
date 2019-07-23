//
//  SynchronizedViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2019/6/4.
//  Copyright © 2019年 yonyouqiche. All rights reserved.
//

#import "SynchronizedViewController.h"

@interface SynchronizedViewController ()

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
