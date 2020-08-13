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

int a = 10;//全局初始化区
char *p ;//全局未初始化区


void (^blockms)(void);
void testBlocks(){
    NSString *string = @"sun";
    blockms = ^{
        NSLog(@" -- string  %@",string);
    };
    NSLog(@"sun --- %@",[blockms class]);
}

int main(int argc, char * argv[]) {
    
    int b;//栈区
    char s[] = "abc";//栈区
    char *p1;//栈区
    char *p2 = "12334";//12334 在常量区  p2在栈区
    static int c = 0;//全局（静态） 初始化区
    
    @autoreleasepool {
        
        
        
        testBlocks();
        blockms();
        

        NSLog(@"开始");
        StartTime = CFAbsoluteTimeGetCurrent();//进入main（）开始的时间
        int res = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        NSLog(@"结束");

        
        testBlocks();
        blockms();
        
        return res;
    }
}
