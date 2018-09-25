//
//  UIButton+Position.h
//  Sungh
//
//  Created by yonyouqiche on 2018/9/25.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ButtonImagePosition) {
    
    ButtonImagePositionLeft,
    ButtonImagePositionRight,
    ButtonImagePositionTop,
    ButtonImagePositionBottom
};
@interface UIButton (Position)

- (void)imagePosition:(ButtonImagePosition)position space:(CGFloat)space;

@end
