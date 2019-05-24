//
//  RACViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2019/4/17.
//  Copyright © 2019年 yonyouqiche. All rights reserved.
//

#import "RACViewController.h"
#import "RACView.h"
#import "RACTwoViewController.h"

@interface RACViewController ()

@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i = 0;i<10;i++) {
    }
    
   // 创建信号 - 订阅信号 - 发送信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"发送"];
        return nil;
    }];
    
    RACDisposable *dis = [signal  subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [dis dispose];//取消订阅
    RACView *views = [[RACView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:views];
  
    [views.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@" --- %@",x);
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    RACTwoViewController *vc = [RACTwoViewController new];
    vc.delegateSub = [RACSubject subject];
    [vc.delegateSub subscribeNext:^(id  _Nullable x) {
        NSLog(@"---- %@",x);
    }];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
