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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    id<UIApplicationDelegate>service;
    for (service in [SOAComponentAppDelegate instance].services) {
        if ([service respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [service application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
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


- (void)applicationDidBecomeActive:(UIApplication *)application {
    id<UIApplicationDelegate> service;

    for(service in [[SOAComponentAppDelegate instance] services]){
        if ([service respondsToSelector:@selector(applicationDidBecomeActive:)]){
            [service applicationDidBecomeActive:application];
        }
    }
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
}


- (void)applicationWillTerminate:(UIApplication *)application {

    id<UIApplicationDelegate> service;
    for(service in [[SOAComponentAppDelegate instance] services]){
        if ([service respondsToSelector:@selector(applicationWillTerminate:)]){
            [service applicationWillTerminate:application];
        }
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSLog(@" ---- %@ ----- %@",url.scheme,url.path);
    return YES;
}

@end
