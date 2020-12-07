//
//  NSArray+Safe.m
//  Sungh
//
//  Created by yonyouqiche on 2020/12/1.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "NSArray+Safe.h"
#import <objc/runtime.h>



@implementation NSArray (Safe)
// Swizzling核心代码
// 需要注意的是，好多同学反馈下面代码不起作用，造成这个问题的原因大多都是其调用了super load方法。在下面的load方法中，不应该调用父类的load方法。
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(xd_objectAtIndex:));
        method_exchangeImplementations(fromMethod, toMethod);
    });
}

// 为了避免和系统的方法冲突，我一般都会在swizzling方法前面加前缀
- (id)xd_objectAtIndex:(NSUInteger)index {
    // 判断下标是否越界，如果越界就进入异常拦截
    if (self.count-1 < index) {
#ifdef DEBUG  // 调试阶段
        return [self xd_objectAtIndex:index];
#else // 发布阶段
        @try {
            return [self xd_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息。如果是线上，可以在这里将崩溃信息发送到服务器
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
#endif
    } // 如果没有问题，则正常进行方法调用
    else {
        return [self xd_objectAtIndex:index];
    }
}

@end
