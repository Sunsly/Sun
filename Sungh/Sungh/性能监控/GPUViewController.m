//
//  GPUViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/24.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "GPUViewController.h"

@interface GPUViewController ()

@end

@implementation GPUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    usleep(1 * 1000 * 1000); // 1秒

    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//     usleep(1 * 1000 * 1000); // 1秒
//    NSArray *arr = @[@"2"];
//    NSLog(@" --- %@",arr[1]);
   //master
    
    
}

/*
 cpu 计算好显示内容，（视图 图片 文本绘制）
 gpu负责渲染 渲染后的结果存放到  帧缓存区
 视频控制器会按照vsync(垂直信号)读取帧缓存区的数据，最后转化显示
 
 gpu会等待垂直心血号vsync发出后，才进行新的帧渲染和缓冲区的更新
 
 一旦cpu 和gpu 计算量过大，错过了下一次c-sync 的到来，（16.67ms）就会出现卡顿
 
 主线程监控卡顿 方案
 子线程监控主线程的runloop
 beforesource beforewaiting
 
 
 */

@end
