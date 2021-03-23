//
//  NSObject+UnrecognizedSelectorProtecter.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/25.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "NSObject+UnrecognizedSelectorProtecter.h"

#import <objc/runtime.h>
#import "MethodTrans.h"

static id protecter = nil;
static NSString *const ClassPrefix = @"LM";

@implementation NSObject (UnrecognizedSelectorProtecter)
//
//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        protecter = [[MethodTrans alloc]init];
//        swizzleMethod([self class], @selector(forwardingTargetForSelector:), @selector(swizzleForwardingTargetForSelector:));
//    });
//}
//
//#pragma mark - instance method
//- (id)swizzleForwardingTargetForSelector:(SEL)aSelector{
//    //先执行原来的逻辑，如果已经外部提供一个对象，则不进行处理
//    id instance = [self swizzleForwardingTargetForSelector:aSelector];
//    if (instance) {
//        return instance;
//    }
//    //判断当前类是否在白名单中
//    BOOL isWhiteList = isWhiteListClass([self class]);
//    if (!isWhiteList) {
//        //如果是系统类则不做处理
//        return nil;
//    }
//    if (!instance) {
//        //将消息转发给procter对象
//        instance = protecter;
//    }
//    return instance;
//}
//
//
//#pragma mark -  private method
//static inline BOOL swizzleMethod(Class aClass,SEL originSelector , SEL swizzleSelector){
//    Method originMethod = class_getInstanceMethod(aClass, originSelector);
//    Method swizzleMethod = class_getInstanceMethod(aClass, swizzleSelector);
//
//    BOOL isAdded = class_addMethod(aClass, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
//
//    if (isAdded) {
//        class_replaceMethod(aClass, swizzleSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
//    }else{
//        method_exchangeImplementations(originMethod, swizzleMethod);
//    }
//    return YES;
//}
//
//static inline BOOL isWhiteListClass(Class aClass){
//    NSString *classStr = NSStringFromClass(aClass);
//    //如果是下划线开头的代表是系统类,不对系统类进行处理
//    if ([classStr hasPrefix:@"_"]) {
//        return NO;
//    }
//    //如果是自己的类或者是NSNULL则进行处理
//    BOOL isNull = [classStr isEqualToString:NSStringFromClass([NSNull class])];
//    BOOL isBusinessCls = YES;
//
//    return isNull | isBusinessCls;
//}

@end
