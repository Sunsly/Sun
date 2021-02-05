//
//  SunPerment.h
//  Sungh
//
//  Created by yonyouqiche on 2021/2/4.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SunPerment : NSObject



/// 开启
- (void)run;

- (void)excuteTaskWithTarget:(id)targert action:(SEL)action object:(id)object;

- (void)excuteTaskBlock:(void(^)(void))task;

/// 销毁 停止
- (void)stop;

@end

NS_ASSUME_NONNULL_END
