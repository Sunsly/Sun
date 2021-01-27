//
//  UIActionViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/5/11.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "UIActionViewController.h"
#import "HitUIView.h"
#import "UIView+GTMCWavesAnimation.h"
@interface UIActionViewController ()
{
    UIView *vcm;
}
@end

@implementation UIActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事件传递";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    HitUIView *vc = [[HitUIView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
//    vc.backgroundColor = [UIColor grayColor];
////    vc.layer.borderWidth = 5;
////    vc.layer.borderColor = [UIColor blueColor].CGColor;
//    [self.view addSubview:vc];
//    vc.layer.cornerRadius = 50;
//    vc.clipsToBounds  = YES;
    
//    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(30, 30)];
//    CAShapeLayer *lay = [CAShapeLayer layer];
//    lay.path = path1.CGPath;
//    lay.borderWidth = 5;
//    lay.borderColor = [UIColor blueColor].CGColor;
//    vc.layer.mask = lay;
//
//    lay.shadowColor = [UIColor blackColor].CGColor;
//    lay.shadowOpacity = 0.8;
//    lay.shadowOffset = CGSizeMake(4, 4);
    
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = vc.bounds;
//    // 渐变色数组
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)[UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:0.12].CGColor,
//                       (id)[UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:0.0].CGColor, nil];
//    gradient.startPoint = CGPointMake(1, 0);
//    gradient.endPoint = CGPointMake(0, 0);
//    [vc.layer addSublayer:gradient];
//    
    
    vcm = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:vcm];
    vcm.radarColor = [UIColor redColor];
    vcm.radarBorderColor = [UIColor whiteColor];
    [vcm addRadarAnimation];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [vcm removeRadarAnimation];
    [self performSelector:@selector(add) withObject:nil afterDelay:2];
}
- (void)add{
    vcm.radarColor = [UIColor redColor];
    vcm.radarBorderColor = [UIColor whiteColor];
    [vcm addRadarAnimation];
}
/*
 iOS设备的硬件时钟会发出Vsync（垂直同步信号），然后App的CPU会去计算屏幕要显示的内容，之后将计算好的内容提交到GPU去渲染。，随后GPU将渲染结果提交到帧缓冲区，等到下一个VSync到来时将缓冲区的帧显示到屏幕上。也就是说，一帧的显示是由CPU和GPU共同决定的。
 一般来说，页面滑动流畅是60fps，也就是1s有60帧更新，即每隔16.7ms就要产生一帧画面，而如果CPU和GPU加起来的处理时间超过了16.7ms，就会造成掉帧甚至卡顿。
 
 滑动优化方案
 CPU：把以下操作放在子线程中
 1.对象创建、调整、销毁
 2.预排版（布局计算、文本计算、缓存高度等等）
 3.预渲染（文本等异步绘制，图片解码等）

 GPU:
 纹理渲染，视图混合
 
 
 圆角（当和maskToBounds一起使用时）、图层蒙版、阴影，设置 gpu离屛渲染
 为什么要避免GPU离屏渲染？
 GPU需要做额外的渲染操作。通常GPU在做渲染的时候是很快的，但是涉及到offscreen-render的时候情况就可能有些不同，因为需要额外开辟一个新的缓冲区进行渲染，然后绘制到当前屏幕的过程需要做onscreen跟offscreen上下文之间的切换，这个过程的消耗会比较昂贵，涉及到OpenGL的pipeline跟barrier，而且offscreen-render在每一帧都会涉及到，因此处理不当肯定会对性能产生一定的影响。另外由于离屏渲染会增加GPU的工作量，可能会导致CPU+GPU的处理时间超出16.7ms，导致掉帧卡顿。所以可以的话应尽量减少offscreen-render的图层

 CPU 处理完后交给 GPU 去渲染，如两者合作耗时超过 16m
*/
#pragma mark - Navigation


@end
