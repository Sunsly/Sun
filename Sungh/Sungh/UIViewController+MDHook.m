//
//  UIViewController+MDHook.m
//  Sungh
//
//  Created by yonyouqiche on 2019/8/14.
//  Copyright © 2019 yonyouqiche. All rights reserved.
//

#import "UIViewController+MDHook.h"
#import <objc/runtime.h>
@implementation UIViewController (MDHook)
//
//+(void)hookUIViewController{
//
//    Method appearMethod = class_getInstanceMethod([self class], @selector(viewDidAppear:));
//    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_ViewDidAppear:));
//    method_exchangeImplementations(appearMethod, hookMethod);
//}
//- (void)hook_ViewDidAppear:(BOOL)animated
//{
//    NSString *appearDetailInfo = [NSString stringWithFormat:@" %@ - %@", NSStringFromClass([self class]), @"didAppear"];
//    NSLog(@"%@---- -", appearDetailInfo);
//    [self hook_ViewDidAppear:animated];
//}
////@

@end
