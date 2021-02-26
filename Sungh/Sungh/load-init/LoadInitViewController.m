//
//  LoadInitViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/25.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "LoadInitViewController.h"
#import "DDChildDemo.h"
@interface LoadInitViewController ()

@end

@implementation LoadInitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    DDChildDemo *demo = [[DDChildDemo alloc]init];
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
