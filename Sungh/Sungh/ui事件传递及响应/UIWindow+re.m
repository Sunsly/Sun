//
//  UIWindow+re.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/1.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "UIWindow+re.h"

@implementation UIWindow (re)


//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@" uiwindow -------------- ");
    return [super hitTest:point withEvent:event];
}
@end
