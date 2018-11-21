//
//  STool.h
//  Sungh
//
//  Created by yonyouqiche on 2018/9/17.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@end
