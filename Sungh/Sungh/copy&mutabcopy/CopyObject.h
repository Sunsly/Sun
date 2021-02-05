//
//  CopyObject.h
//  Sungh
//
//  Created by yonyouqiche on 2021/2/3.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CopyObject : NSObject<NSCopying,NSMutableCopying>
@property (nonatomic,copy)NSString *age;
@end

NS_ASSUME_NONNULL_END
