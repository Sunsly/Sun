//
//  MVVMModel.h
//  Sungh
//
//  Created by yonyouqiche on 2020/3/31.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVVMModel : NSObject
- (void)getDataSuccess:(void(^)(id responseObject))success
                  fail:(void(^)(id resopnseObject))fail;
@end

NS_ASSUME_NONNULL_END
