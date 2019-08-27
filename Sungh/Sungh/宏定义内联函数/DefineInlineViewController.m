//
//  DefineInlineViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2019/8/27.
//  Copyright © 2019 yonyouqiche. All rights reserved.
//

#import "DefineInlineViewController.h"


/*
 1 预处理
 如果有定义了MP宏定义  打印MS为1  如果没定义打印MS为2
 */
#define MP 3
#ifdef MP
#define MS 1
#else
#define MS 2
#endif




@interface DefineInlineViewController ()

@end

@implementation DefineInlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@" --- %d",MS);
}



@end
