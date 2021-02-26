//
//  LeakerViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/24.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "LeakerViewController.h"

@interface LeakerViewController ()

@end

@implementation LeakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    NSString *leak;
    NSArray *arr = [[NSArray alloc]init];

    
    UIImage *image = [UIImage imageNamed:@""];
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGImageRef ref = CGImageCreateWithImageInRect([image CGImage], rect);
    
}


@end
