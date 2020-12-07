//
//  SUOViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/12/7.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "SUOViewController.h"
#import <Foundation/Foundation.h>
//#import <objc/runtime.h>
#import <libkern/OSAtomic.h>
@interface SUOViewController ()
{
    OSSpinLock lock;
    NSInteger ticketsCount;
    NSCondition *xwCondition;
    NSMutableArray *conditionArray;
}
@end

@implementation SUOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"锁";
    self.view.backgroundColor = [UIColor whiteColor];
    lock = OS_SPINLOCK_INIT;
    ticketsCount = 100;
    // Do any additional setup after loading the view.
}
/*
 锁分为自旋锁和h互斥锁
 自旋锁：
 atomic、OSSpinLock、dispatch_semaphore_t
 自旋锁 尝试 获取锁时，以忙等待的形式不断循环检查是否可用
 当一个线程的任务没有执行完毕的时候。那么下一个线程会一直等待（不会休眠）
 当上一个线程结束的时候，会执行下一个。使用自旋锁代替一般的互斥锁往往能够提高程序的性能。
 
 
 互斥锁：
 当上一个线程的任务没有执行完毕的时候，下一个线程会进入休眠等待
 当任务完成后，下一个线程会自动唤醒执行任务
 pthread_mutex、@ synchronized、NSLock、NSConditionLock 、NSCondition、NSRecursiveLock
 
 //总结：
 自旋锁会忙等: 所谓忙等，即在访问被锁资源时，调用者线程不会休眠，而是不停循环在那里，直到被锁资源释放锁。
 　　互斥锁会休眠: 所谓休眠，即在访问被锁资源时，调用者线程会休眠，此时cpu可以调度其他线程工作。直到被锁资源释放锁。此时会唤醒休眠线程。
 
 优缺点：

 自旋锁的优点在于，因为自旋锁不会引起调用者睡眠，所以不会进行线程调度，CPU时间片轮转等耗时操作。所有如果能在很短的时间内获得锁，自旋锁的效率远高于互斥锁。

 缺点在于，自旋锁一直占用CPU，他在未获得锁的情况下，一直运行－－自旋，所以占用着CPU，如果不能在很短的时 间内获得锁，这无疑会使CPU效率降低。自旋锁不能实现递归调用。
 　
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self zxs];
//    [self ticket:100];
//    [self lock5];
//    [self lock4];
    [self lock3];
}
//自旋锁
- (void)zxs{
//    初始化
    OSSpinLock spinlock = OS_SPINLOCK_INIT;

//    尝试加锁  （如果需要等地啊就不加锁 ，如果不需要等待就加锁）
//    BOOL result = OSSpinLockTry(&spinlock);
    
    double lastTime = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 1000; i++) {
        OSSpinLockLock(&spinlock);
        OSSpinLockUnlock(&spinlock);
        
    }
    double_t curTime =  CFAbsoluteTimeGetCurrent();

    NSLog(@"OSSpinLock:%f ms",(curTime - lastTime) * 1000);
    
    
    //同步

       id obj = [NSObject new];
       lastTime = CFAbsoluteTimeGetCurrent();
       for (NSInteger i = 0; i < 1000; i++) {
           @synchronized (obj) {
           }

       }
       curTime = CFAbsoluteTimeGetCurrent();

       NSLog(@"synchroniz:%f ms",(curTime - lastTime) * 1000);
}

- (void)ticket:(NSInteger)ticketCount{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {

                 [self saleTicket];

                 NSLog(@"我是第一个");

        }
    });
    dispatch_async(queue, ^{

        for (int i = 0; i < 5; i++) {

            [self saleTicket];

            NSLog(@"我是第二个");

        }

    });

    

    dispatch_async(queue, ^{

        for (int i = 0; i < 5; i++) {

            [self saleTicket];

            NSLog(@"我是第三个");

        }

    });
}

- (void)saleTicket{
//    访问数据的时候加锁
    
//    OSSpinLock lock  = OS_SPINLOCK_INIT;
    OSSpinLockLock(&lock);
    NSInteger oldTicketCount = ticketsCount;
    
    sleep(2);
    oldTicketCount--;
    
    ticketsCount = oldTicketCount;
    
    NSLog(@"剩余 %ld票,----%@----",(long)oldTicketCount,[NSThread currentThread]);

    OSSpinLockUnlock(&lock);
    
}
- (void)lock5 {
    NSLock *commonLock = [[NSLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^XWRecursiveBlock)(int);
        XWRecursiveBlock = ^(int  value) {
            [commonLock lock];
            if (value > 0) {
                NSLog(@"加锁层数: %d",value);
                sleep(1);
                XWRecursiveBlock(--value);
            }
            NSLog(@"程序退出!");
            [commonLock unlock];
        };
        XWRecursiveBlock(3);
    });
}
- (void)lock4{
    NSRecursiveLock *rec = [[NSRecursiveLock alloc]init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        static void (^RecursiveLockBlock)(int);
        RecursiveLockBlock = ^(int value){
            [rec lock];
            if (value >0) {
                NSLog(@"加锁层数: %d",value);
                sleep(1);
                RecursiveLockBlock(--value);
            }else{
                NSLog(@"程序退出!");
                [rec unlock];
            }
        };
        RecursiveLockBlock(3);
    });
}
- (void)lock3{
//    NSCondtionlock 可以给每个x线程 加锁 ，不影响其他线程进入临界区
    conditionArray = [NSMutableArray array];
    xwCondition = [[NSCondition alloc] init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [xwCondition lock];
        if (conditionArray.count == 0) {
            NSLog(@"等待制作数组");
            sleep(3);
            [xwCondition wait];
        }else{
            id obj = conditionArray[0];
            NSLog(@"获取对象进行操作:%@",obj);
            [xwCondition unlock];
        }
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
           [xwCondition lock];
           id obj = @"极客学伟";
           [conditionArray addObject:obj];
           NSLog(@"创建了一个对象:%@",obj);
           [xwCondition signal];
           [xwCondition unlock];
    });
    
}
-(void)dealloc{
    NSLog(@"%s",__func__);
    
    
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
