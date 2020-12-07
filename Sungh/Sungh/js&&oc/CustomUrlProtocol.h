//
//  CustomUrlProtocol.h
//  Sungh
//
//  Created by yonyouqiche on 2020/12/7.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
static NSString* const URLProtocolHandledKey = @"URLProtocolHandledKey";

@interface CustomUrlProtocol : NSURLProtocol<NSURLConnectionDelegate>
@property (nonatomic, strong) NSURLConnection *connection;

@end

NS_ASSUME_NONNULL_END
