
//
//  AppDelegate+Config.m
//  Sungh
//
//  Created by yonyouqiche on 2019/8/12.
//  Copyright © 2019 yonyouqiche. All rights reserved.
//

#import "AppDelegate+Config.h"
#import <objc/runtime.h>

const char UserInfoKey;
@implementation AppDelegate (Config)
//FIXME: 1 瘦身
/*
    ** 创建类别
 
    ** 组件化设计
        首先创建服务类，服务类是对第三方服务的封装。第三方服务包括推送、支付、统计等
 
        1、服务举例 BaiduPushService 头文件
        新创建的服务类需要添加 <UIApplicationDelegate> 协议，根据需要实现协议中的方法。这里只添加了一个作为演示。
 */

//










/*
 typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy) {
 OBJC_ASSOCIATION_ASSIGN = 0,             //关联对象的属性是弱引用
 OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,   //关联对象的属性是强引用并且关联对象不使用原子性
 OBJC_ASSOCIATION_COPY_NONATOMIC = 3,     //关联对象的属性是copy并且关联对象不使用原子性
 OBJC_ASSOCIATION_RETAIN = 01401,         //关联对象的属性是copy并且关联对象使用原子性
 OBJC_ASSOCIATION_COPY = 01403            //关联对象的属性是copy并且关联对象使用原子性
 };
 */
-(void)setUserInfo:(NSDictionary *)userInfo{
    objc_setAssociatedObject(self, &UserInfoKey, userInfo, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSDictionary *)userInfo{
    if (objc_getAssociatedObject(self, &UserInfoKey)) {
        return objc_getAssociatedObject(self, &UserInfoKey);
    }else{
        return nil;
    }
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"sungh--- ");
}
@end
