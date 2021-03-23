//
//  HitUIView.m
//  Sungh
//
//  Created by yonyouqiche on 2020/5/11.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "HitUIView.h"

@implementation HitUIView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
+ (void)test{
    
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    [[self class] test];
    BOOL is = [super pointInside:point withEvent:event];
    
    if (is) {
        NSLog(@" --------yes");
    }else{
        NSLog(@" --------NO");
        
    }
    
    
    return is;
}
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"AAA ************  %s",__func__);
    return  [super hitTest:point withEvent:event];
//    // 如果交互未打开，或者透明度小于0.05 或者 视图被隐藏
//    if (self.userInteractionEnabled == NO || self.alpha < 0.05 || self.hidden == YES)
//    {
//        return nil;
//    }
//
//    // 如果 touch 的point 在 self 的bounds 内
//    if ([self pointInside:point withEvent:event])
//    {
//
//        for (UIView *subView in self.subviews)
//        {
//
//            NSLog(@"sungh ----- %@",subView);
//            //进行坐标转化
//            CGPoint coverPoint = [subView convertPoint:point fromView:self];
//
//            // 调用子视图的 hitTest 重复上面的步骤。找到了，返回hitTest view ,没找到返回有自身处理
//            UIView *hitTestView = [subView hitTest:coverPoint withEvent:event];
//
//            if (hitTestView)
//            {
//
//                return hitTestView;
//            }
//        }
//
//        return self;
//
//
//    }
//
//    return nil;
//
}


//s
//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//
//    NSLog(@" ************  %s",__func__);
//    return [super pointInside:point withEvent:event];
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"AAA ************  %s",__func__);
}

@end


