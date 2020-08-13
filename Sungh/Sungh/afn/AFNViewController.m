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
    /*
    https 《图解HTTP》这本书中曾提过HTTPS是身披SSL外壳的HTTP。HTTPS是一种通过计算机网络进行安全通信的传输协议，经由HTTP进行通信，利用SSL/TLS建立全信道，加密数据包。HTTPS使用的主要目的是提供对网站服务器的身份认证，同时保护交换数据的隐私与完整性。
     SSL证书需要购买申请，功能越强大的证书费用越高
     SSL证书通常需要绑定IP，不能在同一IP上绑定多个域名，IPv4资源不可能支撑这个消耗（SSL有扩展可以部分解决这个问题，但是比较麻烦，而且要求浏览器、操作系统支持，Windows XP就不支持这个扩展，考虑到XP的装机量，这个特性几乎没用）。
     根据ACM CoNEXT数据显示，使用HTTPS协议会使页面的加载时间延长近50%，增加10%到20%的耗电。
     HTTPS连接缓存不如HTTP高效，流量成本高。
     HTTPS连接服务器端资源占用高很多，支持访客多的网站需要投入更大的成本。
     HTTPS协议握手阶段比较费时，对网站的响应速度有影响，影响用户体验。比较好的方式是采用分而治之，类似12306网站的主页使用HTTP协议，有关于用户信息等方面使用HTTPS。

        http 1.0  1.1  2.0
     
     咳、简单总结一下：
     1、下载任务时：
     NSURLConnection会先放在内存、最后写入沙盒。可能引起内存暴涨。
     NSURLSession会直接写在沙盒和tem文件夹中、最后需要手动转移。
     2、请求控制：
     NSURLConnection创建好了对象、便开始网络请求。
     只能cancel并不能恢复。
     NSURLSession则在挂起状态需要手动resume。
     可以取消（cancel）、暂停（suspend）、继续（resume）。
     3、断点续传：
     NSURLConnection通过设置访问请求的HTTPHeaderField的Range属性、继续下载剩余的部分。
     NSURLSession通过将任务暂停时候代理返回的resumeData传入downloadTaskWithResumeData:方法进行续传。
     4、配置信息：
     NSURLConnection只能全局配置。
     NSURLSession每一个实例都可以通过NSURLSessionConfiguration进行配置。
     
     */
}
@end
