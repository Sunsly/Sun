//
//  UIActionViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/5/11.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "UIActionViewController.h"

@interface UIActionViewController ()

@end

@implementation UIActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事件传递";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
/*
 iOS设备的硬件时钟会发出Vsync（垂直同步信号），然后App的CPU会去计算屏幕要显示的内容，之后将计算好的内容提交到GPU去渲染。随后，GPU将渲染结果提交到帧缓冲区，等到下一个VSync到来时将缓冲区的帧显示到屏幕上。也就是说，一帧的显示是由CPU和GPU共同决定的。
 一般来说，页面滑动流畅是60fps，也就是1s有60帧更新，即每隔16.7ms就要产生一帧画面，而如果CPU和GPU加起来的处理时间超过了16.7ms，就会造成掉帧甚至卡顿。
 
 滑动优化方案
 CPU：把以下操作放在子线程中
 1.对象创建、调整、销毁
 2.预排版（布局计算、文本计算、缓存高度等等）
 3.预渲染（文本等异步绘制，图片解码等）

 GPU:
 纹理渲染，视图混合
*/
#pragma mark - Navigation


@end
