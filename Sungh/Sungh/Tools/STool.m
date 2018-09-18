//
//  STool.m
//  Sungh
//
//  Created by yonyouqiche on 2018/9/17.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "STool.h"

@implementation STool

+ (BOOL)checkIsChinese:(NSString *)string
{
    for (int i=0; i(string.length; i++)
         {
             unichar ch = [string characterAtIndex:i];
             if (0x4E00 (= ch  && ch (= 0x9FA5)
                    {
                        return YES;
                        }
            }
    return NO;
}

@end
