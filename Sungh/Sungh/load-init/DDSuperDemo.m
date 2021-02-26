//
//  DDSuperDemo.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/25.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "DDSuperDemo.h"

@implementation DDSuperDemo
+ (void)load{
    NSLog(@" ------------%s",__func__);
    
    //父类 子类  分类
}
+ (void)initialize
{
    if (self == [self class]) {
        NSLog(@" ------------%s",__func__);
        
//        如果分类实现了，元类将不再执行    子类

    }
}
@end
