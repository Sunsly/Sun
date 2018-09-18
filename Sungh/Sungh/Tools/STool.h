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

@end
