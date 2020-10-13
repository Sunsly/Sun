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
    self.view.backgroundColor = [UIColor whiteColor];
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
 
CFRunLoopMode;  mode 运行模式  运行的时候只选择一种模式运行
 
CFRunLoopSourceRef
 
CFRunLoopTimerRef
 
CFRunLoopObserverRef
 
 *
 source0 要处理的任务
 source1 基于端口 port
 observe
  自动释放池也是通过它实现的
 
 timer
 
 kCFRunLoopDefaultMode;默认的model
 UITrackingRunLoopMode;界面跟踪，mode
 NSRunLoopCommonModes  共有型 Model 含有上面两种Mode模式的意义
 GSEventReceiveRunLoopMode  Connection 系统内核模式，系统调用事件发生会切换到相应模式下，开发者无法操作
 
 UIInitializationRunLoopMode Modal 项目初始化模式，只会走一次

 */

- (void)loop{
    
    [NSRunLoop currentRunLoop];
    
    CFRunLoopRef ref = CFRunLoopGetCurrent();
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@" --- %s",__func__);
    
}
@end
