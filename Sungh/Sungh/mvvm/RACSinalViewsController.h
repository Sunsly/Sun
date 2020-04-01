//
//  RACSinalViewsController.h
//  Sungh
//
//  Created by yonyouqiche on 2020/4/1.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACSinalViewsController : UIViewController

/**
获取当前占用内存
*/
@property (nonatomic,strong)RACSubject *delegateSubject;

@end

NS_ASSUME_NONNULL_END
