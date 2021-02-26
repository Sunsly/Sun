//
//  MethodTrans.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/25.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "MethodTrans.h"

@implementation MethodTrans
//+(BOOL)resolveInstanceMethod:(SEL)sel{
//    NSLog(@" ---- %s",__func__);
//
//
////    if ([super resolveInstanceMethod:sel]) {
//        return [super resolveInstanceMethod:sel];
//
////    }
//}
id protect_method_implementation(id self, SEL _cmd){
    
    
    return [NSNull null];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    //消息会转发到这里来，动态的给Sel提供一个方法的实现就👌了
    class_addMethod([self class], sel, (IMP)protect_method_implementation, "@@:");
    NSLog(@"捕获到一个unRecognized Selector = %@ 崩溃信息",NSStringFromSelector(sel));
    return YES;
}
@end
