//
//  LeakerViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/24.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "LeakerViewController.h"
#import "MallocYHViewController.h"
#import "MallocObject.h"

typedef void(^TestB)(void);
@interface LeakerViewController ()
@property (nonatomic,copy)TestB blocks;
@property (nonatomic,copy)NSString *str;
@end

@implementation LeakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    // Do any additional setup after loading the view.
//
//    NSString *leak;
//    NSArray *arr = [[NSArray alloc]init];
//
//
//    UIImage *image = [UIImage imageNamed:@""];
//    CGRect rect = CGRectMake(0, 0, 100, 100);
//    CGImageRef ref = CGImageCreateWithImageInRect([image CGImage], rect);
    
//    MallocObject *a = [[MallocObject alloc]init];
//    MallocObject *b = [[MallocObject alloc]init];
////    a.objcb = b;
////    b.objca = a;
//    a.objct = a;
//    b.objct = b;
    
    self.blocks = ^{
        self.str = @"1000000";
    };
    self.blocks();
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    MallocYHViewController *vc = [];
}
- (void)dealloc
{
    NSLog(@"malloc ------ %s",__func__);
}
@end
