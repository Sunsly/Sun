//
//  BXTextField.h
//  BXInsurenceBroker
//
//  Created by JYJ on 16/7/15.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import <UIKit/UIKit.h>
//可不能 用第三方键盘哦 -------否则无效
@interface BXTextField : UITextField
/**
 *  使用了键盘头部工具条，调整了键盘的高度
 */
@property (nonatomic, assign) BOOL adjustTextFeildH;

@end
