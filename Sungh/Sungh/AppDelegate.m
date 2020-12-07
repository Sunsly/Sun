//
//  AppDelegate.m
//  Sungh
//
//  Created by yonyouqiche on 2018/6/25.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AppDelegate+Config.h"
#import "SOAComponentAppDelegate.h"
#import "SServiceManager.h"
#import "UIViewController+MDHook.h"
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>
#import <Bugly/Bugly.h>
#import "CustomUrlProtocol.h"

//#import <Flutter/Flutter.h>

/**/
extern CFAbsoluteTime StartTime;
@interface AppDelegate ()
@end
// 异常日志获取,崩溃把日志写入本地，等下次开启app再上传
void UncaughtExceptionHandler(NSException *exception){

    NSArray  *excpArr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSDictionary * userInfo = [exception userInfo];
    NSString *excpCnt = [NSString stringWithFormat:@"exceptionType: %@ \n reason: %@ \n stackSymbols: %@ \n userInfo: %@",name,reason,excpArr,userInfo];
    //NSDOCUMENTPATH是沙盒路径
//    NSString * errorMessageFile = [NSString stringWithFormat:@"%@/error.txt",NSDOCUMENTPATH];
    //将崩溃信息写入沙盒里的error.txt文件
//    [excpCnt writeToFile:errorMessageFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    NSString * errorMessageFile = [NSString stringWithFormat:@"%@/error.txt",NSDOCUMENTPATH];

    [UIViewController hookUIViewController];
    id<UIApplicationDelegate>service;
    for (service in [SOAComponentAppDelegate instance].services) {
        if ([service respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [service application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    [NSURLProtocol registerClass:[CustomUrlProtocol class]];

    dispatch_queue_t queue  = dispatch_queue_create("sun.com.dis", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"sun.com.dis");
    });

    //打印main（）耗时时间
    double launchTime = (CFAbsoluteTimeGetCurrent() - StartTime);
    NSLog(@" -- - -- - -%f",launchTime);
    [self createUUID];
    [Bugly startWithAppId:@"ab85ee08dd"];
//520dd2e8-6d87-47c1-9600-4b42f5578ddf
//    NSArray *arr = @[];
//    NSLog(@" -- %@",arr[2]);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    id<UIApplicationDelegate>service;
    for (service in [SOAComponentAppDelegate instance].services) {
        if ([service respondsToSelector:@selector(applicationWillResignActive:)]) {
            [service applicationWillResignActive:application];
        }
    }

    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    id<UIApplicationDelegate> service;
    for(service in [[SOAComponentAppDelegate instance] services]){
        if ([service respondsToSelector:@selector(applicationDidEnterBackground:)]){
            [service applicationDidEnterBackground:application];
        }
    }
    NSLog(@"appdelegate -- - -- -applicationDidEnterBackground -------- %ld",[SOAComponentAppDelegate instance].services.count);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    id<UIApplicationDelegate> service;
    for(service in [[SOAComponentAppDelegate instance] services]){
        if ([service respondsToSelector:@selector(applicationWillEnterForeground:)]){
            [service applicationWillEnterForeground:application];
        }
    }
}

//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    id<UIApplicationDelegate> service;
//
//    for(service in [[SOAComponentAppDelegate instance] services]){
//        if ([service respondsToSelector:@selector(applicationDidBecomeActive:)]){
//            [service applicationDidBecomeActive:application];
//        }
//    }
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"nihao" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"哈哈哈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"u确定吗？" preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:action];
//    [alert addAction:action2];
//    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
//}


- (void)applicationWillTerminate:(UIApplication *)application {

    id<UIApplicationDelegate> service;
    for(service in [[SOAComponentAppDelegate instance] services]){
        if ([service respondsToSelector:@selector(applicationWillTerminate:)]){
            [service applicationWillTerminate:application];
        }
    }
}
- (NSString *)createUUID{
    CFUUIDRef uuid =CFUUIDCreate(NULL);
    CGPDFStringRef uuidf = CFUUIDCreateString(NULL, uuid);
    NSString *uuidstr = (__bridge NSString *)uuidf;
    return  uuidstr;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSLog(@" ---- %@ ----- %@",url.scheme,url.path);
    return YES;
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@" ----*****************");

}



@end
