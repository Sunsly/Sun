//
//  NetWorkingRequest.h
//  Sungh
//
//  Created by yonyouqiche on 2020/5/14.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkingRequest : NSObject
+ (void)post:(NSString *)url param:(NSString *)param success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure;

+ (void)get:(NSString *)url param:(NSString *)param success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
