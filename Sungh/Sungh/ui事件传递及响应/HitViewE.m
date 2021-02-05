//
//  HitViewE.m
//  Sungh
//
//  Created by yonyouqiche on 2021/1/29.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "HitViewE.h"

@implementation HitViewE

//
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"EEE ************  %s",__func__);
    return  [super hitTest:point withEvent:event];

    if (self.userInteractionEnabled == NO || self.alpha < 0.05 || self.hidden == YES)
    {
        return nil;
    }
    
    // 如果 touch 的point 在 self 的bounds 内
    if ([self pointInside:point withEvent:event])
    {
        
        for (UIView *subView in self.subviews)
        {
            
            NSLog(@" ----- %@",subView);
            //进行坐标转化
            CGPoint coverPoint = [subView convertPoint:point fromView:self];
            
            // 调用子视图的 hitTest 重复上面的步骤。找到了，返回hitTest view ,没找到返回有自身处理
            UIView *hitTestView = [subView hitTest:coverPoint withEvent:event];
            
            if (hitTestView)
            {
                
                return hitTestView;
            }
        }
        
        return self;
        
        
    }
    
    return nil;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSLog(@"EEE ************  %s",__func__);

}
@end
