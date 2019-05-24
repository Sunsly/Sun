//
//  RACTwoViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2019/4/19.
//  Copyright © 2019年 yonyouqiche. All rights reserved.
//

#import "RACTwoViewController.h"

@interface RACTwoViewController ()

@end

@implementation RACTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< Updated upstream
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.delegateSub) {
        [self.delegateSub sendNext:@"代替代理"];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
=======
    // Do any additional setup after loading the view.
}

>>>>>>> Stashed changes
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
