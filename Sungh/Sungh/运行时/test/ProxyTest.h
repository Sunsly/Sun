//
//  ProxyTest.h
//  iOS-LockDemo
//
//  Created by yonyouqiche on 2021/1/26.
//  Copyright © 2021 yongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProxyTest : NSProxy
+ (id)propx:(id)target;
@property (nonatomic,weak)id target;
@end

NS_ASSUME_NONNULL_END
