//
//  FSViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/4/13.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "FSViewController.h"
#import "Masonry.h"
@interface FSViewController ()
@end

@implementation FSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            
        }
    }];
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
