//
//  TravinURLProtocol.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/2.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "TravinURLProtocol.h"
@interface TravinURLProtocol()

/*实名认证 被拦截的url中包含 会员编号和登录流水号，用于实名认证，因为从注册跳到实名认证需要在这里获取信息*/
@property (nonatomic, strong) NSMutableDictionary *userInfoForLoginDIc;
@end
@implementation TravinURLProtocol

//+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
//    /*防止无限循环，因为一个请求在被拦截处理过程中，也会发起一个请求，这样又会走到这里，如果不进行处理，就会造成无限循环
//      */
//    if ([NSURLProtocol propertyForKey:kProtocolKey inRequest:request]) {
//        return NO;
//     }
//    BOOL shouldAccept;
//    NSURL *url;
//    shouldAccept = (request != nil);
//    if (shouldAccept) {
//        url = [request URL];
//        shouldAccept = (url != nil);
//        NSString *absoluteStr = url.absoluteString;
//      //判断拿到的url是不是想要的
//        if ([absoluteStr containsString:@"判断条件"]){
//            NSURLComponents *urlCompts = [[NSURLComponents alloc] initWithString:absoluteStr];
//            NSArray *queryItems = urlCompts.queryItems;
//            NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
//           // ............. 拿到url后的处理 ...............
//            return YES;
//        }
//    }
//    return NO;
//
//}
//
//+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
//    return request;
//}
//
//- (void)startLoading {
//    /*防止无限循环：改变property @YES 没有这一句 上面的那一句就是无效的
//       */
////    [NSURLProtocol setProperty:@YES forKey:kProtocolKey inRequest:[self request]];
//    //发送拦截成功通知 或 其他操作
//
//    return;
//}
//
//- (void)stopLoading {
//
//}

@end
