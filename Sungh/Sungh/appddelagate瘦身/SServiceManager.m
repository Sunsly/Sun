//
//  SServiceManager.m
//  Sungh
//
//  Created by yonyouqiche on 2019/8/12.
//  Copyright © 2019 yonyouqiche. All rights reserved.
//

#import "SServiceManager.h"

@implementation SServiceManager

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    NSLog(@"BaiduPushService didFinishLaunchingWithOptions");
    return YES;
}
-(void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"BaiduPushService applicationDidEnterBackground");
  

}
-(void)applicationDidBecomeActive:(UIApplication *)application{
    NSLog(@"BaiduPushService applicationDidBecomeActive");

}
@end
