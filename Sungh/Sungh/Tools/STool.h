//
//  STool.h
//  Sungh
//
//  Created by yonyouqiche on 2018/9/17.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface STool : NSObject

/**
 字符串中是否含有中文

 @param string <#string description#>
 @return <#return value description#>
 */
+ (BOOL)checkIsChinese:(NSString *)string;

/**
 检测 Wifi 的开关是否打开的

 @return <#return value description#>
 */
+ (BOOL) isWiFiEnabled;

/**
 计算文字高度

 @param text 文本
 @return a返回高度
 */
- (CGFloat)getTextHeight:(NSString *)text;

/**
 获取可用内存

 @return <#return value description#>
 */
+ (double)availableMemory;

/**
 获取当前占用内存

 @return <#return value description#>
 */
+(double)usedMemory;

/// 移除当前controller
/// @param controller controller
+ (void)removeCurrentController:(UIViewController *)controller;

/// //加载gif
/// @param data gif图数据
+ (UIImage *)getGitImageWithData:(NSData* )data;

@end
