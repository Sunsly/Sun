//
//  CurrentSuperViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/4/10.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "CurrentSuperViewController.h"

@interface CurrentSuperViewController ()
//@property (strong, nonatomic) IBOutlet UIScrollView *scr;
@property (nonatomic,copy)NSString *str;
@end

@implementation CurrentSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.scr.contentOffset = CGPointMake(375, 0);
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    self.scr.contentOffset = CGPointMake(375, 0);
}
- (IBAction)click:(id)sender {
    
    
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
