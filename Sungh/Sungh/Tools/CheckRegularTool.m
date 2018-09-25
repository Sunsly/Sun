//
//  CheckRegularTool.m
//  Sungh
//
//  Created by yonyouqiche on 2018/9/25.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "CheckRegularTool.h"

@implementation CheckRegularTool
+(BOOL)isPhoneNumber:(NSString *)number
{
    
    
    NSString * str = @"[0-9]*";
    

    NSPredicate *pr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",str];
    BOOL IS = [pr evaluateWithObject:number];
    return IS;
}
@end
