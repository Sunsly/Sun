//
//  main.m
//  Sungh
//
//  Created by yonyouqiche on 2018/6/25.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
CFAbsoluteTime StartTime;
int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        NSLog(@"开始");
        StartTime = CFAbsoluteTimeGetCurrent();//进入main（）开始的时间
        int res = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        NSLog(@"结束");

        return res;
    }
}
