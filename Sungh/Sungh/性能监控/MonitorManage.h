//
//  MonitorManage.h
//  Sungh
//
//  Created by yonyouqiche on 2021/2/24.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MonitorManage : NSObject
+ (instancetype)shareInstance;

- (void)beginMonitor; //开始监视卡顿
- (void)endMonitor;   //停止监视卡顿
@end

NS_ASSUME_NONNULL_END
