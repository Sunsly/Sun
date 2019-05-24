//
//  RACViewModel.h
//  Sungh
//
//  Created by yonyouqiche on 2019/4/18.
//  Copyright © 2019年 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACViewModel : NSObject

@property (strong, nonatomic) RACSignal *requestSignal; ///< 网络请求信号量


@end

NS_ASSUME_NONNULL_END
