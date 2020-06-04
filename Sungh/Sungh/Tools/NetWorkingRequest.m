//
//  NetWorkingRequest.m
//  Sungh
//
//  Created by yonyouqiche on 2020/5/14.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "NetWorkingRequest.h"

@implementation NetWorkingRequest
//+ (void)post:(NSString *)url param:(NSString *)param success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
//{
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/csv",@"application/json",@"text/json", @"text/plain", @"text/html", nil];
//
//    [mgr POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObj) {
//        if (success) {
//            NSError *err;
//            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:&err];
//
//            if(err) {
//                Log(@"json解析失败：%@",err);
//            }
//            success(responseDic);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

+ (void)get:(NSString *)url param:(NSString *)param success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager = [AFHTTPSessionManager manager];
      // 设置超时时间
      [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
      manager.requestSerializer.timeoutInterval = 120.f;
      [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
      manager.completionQueue = dispatch_get_global_queue(0, 0);//关键设置，区分 shareHTTPSession
      
      //申明返回的结果是json类型
      manager.responseSerializer = [AFJSONResponseSerializer serializer];
      
      // 2.设置非校验证书模式
      manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
      manager.securityPolicy.allowInvalidCertificates = YES;
      [manager.securityPolicy setValidatesDomainName:NO];
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
    }];
}
@end
