//
//  UIView+GTMCWavesAnimation.h
//  CarNetworkingModule
//
//  Created by yonyouqiche on 2020/11/4.
//  Copyright © 2020 shuaikun.cao. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GTMCWavesAnimation)
@property(nonatomic,strong)UIColor *radarColor; //扩散颜色
@property(nonatomic,assign)UIColor *radarBorderColor; //扩散边界颜色
@property(nonatomic,assign)CALayer *animationLayer; //扩散边界颜色
-(void)addRadarAnimation;//添加动画
-(void)removeRadarAnimation; //移除动画，配合动画进入后台假死，重新添加
@end

NS_ASSUME_NONNULL_END
