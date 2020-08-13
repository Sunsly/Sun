//
//  RunLoopViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/8/13.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//
//    NSRunLoop *runl;
//    CFRunLoopRef run2;
    
}

/*
 
 ios 有两套api 可以拿到runloop
 
 Foundation：NSRunoop 基于CFRunLoopRef 的一层oc报装对象
 
 Core Foundation CFRunLoopRef
 
 
 
 
 面试1；
 线程与runloop关系
 每一条线程都有唯一一个与之对应的runloop对象
 
 
 runloop 保存在一个全局的字典里，线程作为key，runloop 作为value
 
 runloop 销毁时间是 线程结束的时候就会销毁 ，他与线程一对一
 
CFRunLoopMode;
 
CFRunLoopSourceRef
 
CFRunLoopTimerRef
 
CFRunLoopObserverRef
 *
 
 */

- (void)loop{
    
    [NSRunLoop currentRunLoop];
    
    CFRunLoopRef ref = CFRunLoopGetCurrent();
}

@end
