//
//  CustomUrlProtocol.m
//  Sungh
//
//  Created by yonyouqiche on 2020/12/7.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "CustomUrlProtocol.h"

@implementation CustomUrlProtocol
+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
  //只处理http和https请求 返回NO默认让系统去处理
    NSString *scheme = [[request URL] scheme];
    if ( ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
     [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame))
    {
        //看看是否已经处理过了，防止无限循环 根据业务来截取
        if ([NSURLProtocol propertyForKey:URLProtocolHandledKey inRequest:request]) {
            return NO;
        }
    
         //还要在这里截取DSN解析请求中的链接 判断拦截域名请求的链接如果是返回NO
         if (@"https://baidu.com") {
            return NO;
        }
        
        return YES;
    }
    return NO;
}
@end
