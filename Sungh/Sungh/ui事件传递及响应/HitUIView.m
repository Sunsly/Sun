//
//  HitUIView.m
//  Sungh
//
//  Created by yonyouqiche on 2020/5/11.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "HitUIView.h"

@implementation HitUIView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return self;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return YES;
}
@end
