//
//  DemoVC.m
//  Sungh
//
//  Created by yonyouqiche on 2020/7/21.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "DemoVC.h"

@implementation DemoVC



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIResponder *next = self.nextResponder;
        UIViewController *vc = nil;
        while (next) {
            if ([next isKindOfClass:[UIViewController class]]) {
                vc =  (UIViewController *)next;
                break ;
            }
            next = next.nextResponder;
        }
        NSLog(@" --- %@",vc);
    }
    return self;
}

@end
