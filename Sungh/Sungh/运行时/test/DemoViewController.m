//
//  DemoViewController.m
//  iOS-LockDemo
//
//  Created by yonyouqiche on 2021/1/26.
//  Copyright © 2021 yongzhen. All rights reserved.
//

#import "DemoViewController.h"
#import "NSProx.h"
#import "ProxyTest.h"
#import "TestDemo.h"
@interface DemoViewController ()
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)NSTimer *timer2;
@property (nonatomic,strong)CADisplayLink *disp;
@property (nonatomic,weak)NSString *name;
@property (nonatomic,strong)TestDemo *tesmk;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"demo";
    self.name = @"sun";
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:[NSProx prox:self] selector:@selector(didsel) userInfo:nil repeats:YES];
    
    
//    __weak  typeof(self) weakself = self;
//
//    self.timer2 = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
////        [weakself didsel];
//        self.name = @"1000";
//        NSLog(@"-----%@",self.name);
//    }];
//    [[NSRunLoop currentRunLoop]addTimer:self.timer2 forMode:NSDefaultRunLoopMode];
//    需要自己手动开启
//    [self.timer2 setFireDate:[NSDate date]];
//    [NSTimer ];
//    self.disp = [CADisplayLink displayLinkWithTarget:[ProxyTest propx:self] selector:@selector(didsel)];
//    [self.disp addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    [self performSelector:@selector(tes) withObject:self afterDelay:5];
    self.tesmk = [[TestDemo alloc]init];
    __weak typeof(self)weaksel = self;
    self.tesmk.testBlocl = ^{
        NSLog(@" 0------ %@",weaksel.name);

    };
}

- (void)tes{
    NSLog(@" ---- %s ---- %@",__func__,self.name);
}
- (void)didsel{
    NSLog(@" ---- *********** %@",[NSThread currentThread]);

}
- (void)dealloc
{
//    [self.timer invalidate];
    [self.timer invalidate];
    [self.disp invalidate];
    
    NSLog(@" ---- %s ---- %@",__func__,self.name);
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
