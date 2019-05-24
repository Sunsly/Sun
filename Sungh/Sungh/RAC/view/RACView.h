//
//  RACView.h
//  Sungh
//
//  Created by yonyouqiche on 2019/4/19.
//  Copyright © 2019年 yonyouqiche. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACView : UIView
@property (nonatomic,strong)RACSignal *signal;
- (void)start;


@end

NS_ASSUME_NONNULL_END
