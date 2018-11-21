//
//  UITextView+placeHolder.m
//  Sungh
//
//  Created by yonyouqiche on 2018/11/7.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "UITextView+placeHolder.h"

@implementation UITextView (placeHolder)

-(void)setPlaceHoder:(NSString *)placeHoder
{
    UILabel *placeHolderStr = [[UILabel alloc] init];
    placeHolderStr.text = placeHoder;
    placeHolderStr.numberOfLines = 0;
    placeHolderStr.textColor = [UIColor purpleColor];
    [placeHolderStr sizeToFit];
    [self addSubview:placeHolderStr];
    placeHolderStr.font = self.font;
    [self setValue:placeHolderStr forKey:@"_placeholderLabel"];
    
}
@end
