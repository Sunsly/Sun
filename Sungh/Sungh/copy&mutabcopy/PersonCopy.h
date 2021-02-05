//
//  PersonCopy.h
//  Sungh
//
//  Created by yonyouqiche on 2020/12/7.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonCopy : NSObject<NSCopying,NSMutableCopying>

@property (nonatomic,copy)NSString *name;

@end

NS_ASSUME_NONNULL_END
