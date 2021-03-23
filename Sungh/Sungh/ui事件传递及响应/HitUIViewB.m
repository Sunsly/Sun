//
//  HitUIViewB.m
//  Sungh
//
//  Created by yonyouqiche on 2021/1/29.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "HitUIViewB.h"
#import "HitViewD.h"
#import "HitViewE.h"




@implementation HitUIViewB

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        HitViewD *vcd = [[HitViewD alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
//        vcd.backgroundColor = [UIColor whiteColor];
//        [self addSubview:vcd];
//
//        HitViewE *vce = [[HitViewE alloc]initWithFrame:CGRectMake(0, 60, 30, 30)];
//        vce.backgroundColor = [UIColor blackColor];
//        [self addSubview:vce];
        
    }
    return self;;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    BOOL is = [super pointInside:point withEvent:event];
    
    if (is) {
        NSLog(@" b--------yes");
    }else{
        NSLog(@" b--------NO");

    }
    
    return is;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"BBB ************  %s",__func__);
    return  [super hitTest:point withEvent:event];
//
//    if (self.userInteractionEnabled == NO || self.alpha < 0.05 || self.hidden == YES)
//    {
//        return nil;
//    }
//    BOOL isflag = [self pointInside:point withEvent:event];
//    // 如果 touch 的point 在 self 的bounds 内
//    if (isflag)
//    {
//        for (UIView *subView in self.subviews)
//        {
//            NSLog(@" ----- %@",subView);
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
//        return self;
//
//
//    }
//
//    return nil;
}
//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
////    返回yes 证明 触摸点在当前view
//    return YES;
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"BBB ************  %s",__func__);

}

@end
