//
//  UIView+Extend.h
//  library
//
//  Created by yy on 2020-02-2.
//  Copyright (c) 2020年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Extend)


@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@end
