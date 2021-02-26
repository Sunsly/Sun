//
//  NSProx.m
//  iOS-LockDemo
//
//  Created by yonyouqiche on 2021/1/26.
//  Copyright © 2021 yongzhen. All rights reserved.
//

#import "NSProx.h"

@implementation NSProx

+(id)prox:(id)target{
    NSProx *prox = [[NSProx alloc]init];
    prox.target = target;
    return prox;
}
//动态解析
+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@" ------- %s",__func__);
    return [super resolveInstanceMethod:sel];
}
+ (BOOL)resolveClassMethod:(SEL)sel{
    NSLog(@" ------- %s",__func__);
    return  [super resolveClassMethod:sel];
}

  //消息转发
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@" ------- %s",__func__);
    if ([self.target respondsToSelector:aSelector]) {
        return self.target;;
    }
    return nil;
}



@end
