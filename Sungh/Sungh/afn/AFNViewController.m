//
//  AFNViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/6/5.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "AFNViewController.h"

@interface AFNViewController ()

@end

@implementation AFNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self afnR];
}

- (void)afnR{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
        manager.completionQueue = dispatch_get_global_queue(0, 0);//关键设置，区分 shareHTTPSession
        
        //申明返回的结果是json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        // 2.设置非校验证书模式
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.securityPolicy.allowInvalidCertificates = YES;
        [manager.securityPolicy setValidatesDomainName:NO];
    [manager GET:@"https://douban.uieee.com/v2/movie/new_movies?apikey=0df993c66c0c636e29ecbb5344252a4a" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    /*
     AFSSLPinningModeNone
     这个模式表示不做SSL pinning，
     只跟浏览器一样在系统的信任机构列表里验证服务端返回的证书。若证书是信任机构签发的就会通过，若是自己服务器生成的证书就不会通过。

     AFSSLPinningModePublicKey
     这个模式表示用证书绑定方式验证证书，客户端要有服务端的证书拷贝，
     只是验证时只验证证书里的公钥，不验证证书的有效期等信息。只要公钥是正确的，就能保证通信不会被窃听，因为中间人没有私钥，无法解开通过公钥加密的数据。

     AFSSLPinningModeCertificate
     这个模式表示用证书绑定方式验证证书，需要客户端保存有服务端的证书拷贝，这里验证分两步，第一步验证证书的域名有效期等信息，第二步是对比服务端返回的证书跟客户端的是否一致。
//验证模式
     */
}
@end
