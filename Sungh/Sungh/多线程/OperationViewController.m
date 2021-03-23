//
//  OperationViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/3/15.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "OperationViewController.h"

@interface OperationViewController ()

@end

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self operation];
}
- (void)operation{
    
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(test1) object:nil];
    [operation1 start];
}
- (void)test1{
    
    
    for (int i = 0; i < 2;i++) {
        [NSThread sleepForTimeInterval:1];
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程

    }
    
}



@end
