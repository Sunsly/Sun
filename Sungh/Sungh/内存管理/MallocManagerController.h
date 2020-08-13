//
//  MallocManagerController.h
//  Sungh
//
//  Created by yonyouqiche on 2020/3/25.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MallocManagerController : UIViewController


@property (nonatomic,copy)void(^blockMall)(void);
@end

NS_ASSUME_NONNULL_END
