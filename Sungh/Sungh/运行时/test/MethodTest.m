//
//  MethodTest.m
//  iOS-LockDemo
//
//  Created by yonyouqiche on 2021/1/27.
//  Copyright © 2021 yongzhen. All rights reserved.
//

#import "MethodTest.h"
#import "DogTest.h"
@implementation MethodTest
//-(void)test{
//    NSLog(@" ---- %s",__func__);
//}
//动态方法解析
+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@" ---- %s",__func__);


    if ([super resolveInstanceMethod:sel]) {
        return [super resolveInstanceMethod:sel];

    }else{
        if (sel == @selector(eats)) {
            class_addMethod(self, sel, (IMP)testf2, "v@:");
            return YES;
        }else{
            class_addMethod(self, sel, (IMP)testf, "v@:");
            return YES;
        }

    }
//    如果自己实现不了，可以让别的类实现
}
void testf(){
    NSLog(@"Dog test Fun");
}
void testf2(){
    NSLog(@"Dog test Fun22222");
}
//
//+ (BOOL)resolveClassMethod:(SEL)sel{
//    NSLog(@" ---- %s",__func__);
//
//    return [super resolveClassMethod:sel];;
//}
//
////快速转发
//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    NSLog(@" ---- %s",__func__);
////    DogTest *dtest  = [[DogTest alloc]init];
////    if ([dtest respondsToSelector:aSelector]) {
////        return dtest;
////    }
//    return [super forwardingTargetForSelector:aSelector];
//}
////签名  消息转发
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
//    NSLog(@" ---- %s",__func__);
//
//    if (![super methodSignatureForSelector:aSelector]) {
//        NSMethodSignature *sign = [NSMethodSignature signatureWithObjCTypes:"v@:"];
//        return sign;
//    }
//    return  [super methodSignatureForSelector:aSelector];
//}
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    NSLog(@" ---- %s ------  %@",__func__,anInvocation);
//
//    [anInvocation invokeWithTarget:self.target];
//
//    DogTest *dtest  = [[DogTest alloc]init];
//    SEL sel = anInvocation.selector;
//
//
//
//}
//- (void)doesNotRecognizeSelector:(SEL)aSelector{
//    NSLog(@" ---- %s",__func__);
//
//    [self.target doesNotRecognizeSelector:aSelector];
//}
@end
