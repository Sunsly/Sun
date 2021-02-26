//
//  DDChildDemo.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/25.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "DDChildDemo.h"

@implementation DDChildDemo

+ (void)load{
    NSLog(@" ------------%s",__func__);
}


//走的是消息发送机制  子类没有实现 回到父类中查找
+ (void)initialize
{
    if (self == [self class]) {
        NSLog(@" ------------%s",__func__);
//
    }
}
@end
