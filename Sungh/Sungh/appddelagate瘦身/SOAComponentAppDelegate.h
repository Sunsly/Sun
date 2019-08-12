//
//  SOAComponentAppDelegate.h
//  Sungh
//
//  Created by yonyouqiche on 2019/8/12.
//  Copyright © 2019 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SOAComponentAppDelegate : NSObject

+(instancetype)instance;

//装服务的数组
-(NSMutableArray*)services;
@end

NS_ASSUME_NONNULL_END
