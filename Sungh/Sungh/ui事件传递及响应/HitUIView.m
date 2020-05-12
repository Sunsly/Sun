//
//  HitUIView.m
//  Sungh
//
//  Created by yonyouqiche on 2020/5/11.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "HitUIView.h"

@implementation UISecondView : UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@" -- -- -second  %@",self);
    
    UIView *vc =   [super hitTest:point withEvent:event];

//    NSLog(@" -- -- -second  %@",vc);
    
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@" ---- touch ");
}
@end
@implementation HitUIView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       vcs = [[UISecondView alloc]initWithFrame:CGRectMake(-100, -100, 100, 100)];
        vcs.backgroundColor = [UIColor orangeColor];
        [self addSubview:vcs];
    }
    return self;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    [super hitTest:point withEvent:event];
    CGPoint tempPoint = [vcs convertPoint:point fromView:self];//超出父类事件获取
    if ([vcs pointInside:tempPoint withEvent:event]) {
        return vcs;
    }
    
    return self;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@" ----super  touch ");
}

@end
/*
 hitTest 调用顺序   hitview  - > secondview
 
 返回顺序   second - > hit
 */

