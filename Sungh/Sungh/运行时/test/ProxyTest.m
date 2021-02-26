//
//  ProxyTest.m
//  iOS-LockDemo
//
//  Created by yonyouqiche on 2021/1/26.
//  Copyright © 2021 yongzhen. All rights reserved.
//

#import "ProxyTest.h"

@implementation ProxyTest
+(id)propx:(id)target{
    ProxyTest *test = [ProxyTest alloc];
    test.target = target;
    return test;
}
//为另一个类实现消息创建有效的方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{

    return [self.target methodSignatureForSelector:sel];
}
////将选择器转发给一个真正实现了该消息的对象
- (void)forwardInvocation:(NSInvocation *)invocation{
    [invocation invokeWithTarget:self.target];
}
- (void)doesNotRecognizeSelector:(SEL)aSelector{
    
    [self.target doesNotRecognizeSelector:aSelector];
}
@end
