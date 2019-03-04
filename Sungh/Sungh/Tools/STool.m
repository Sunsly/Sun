//
//  STool.m
//  Sungh
//
//  Created by yonyouqiche on 2018/9/17.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "STool.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
@implementation STool
+ (BOOL)isWiFiEnabled {
    NSCountedSet * cset = [[NSCountedSet alloc] init];
    struct ifaddrs *interfaces;
    if( !getifaddrs(&interfaces) ) {
        for( struct ifaddrs *interface = interfaces; interface; interface = interface -> ifa_next) {
            if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
                [cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
            }
        }
    }
    return [cset countForObject:@"awdl0"] > 1 ? YES : NO;
}
#pragma mark --- 获取文字高度
- (CGFloat)getTextHeight:(NSString *)text{
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 2;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentLeft;
    label.text = text;
    label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    CGSize labelSize = [label sizeThatFits:CGSizeMake(kScrWid - 130, MAXFLOAT)];
    CGFloat height = ceil(labelSize.height);
    return height;
}
@end
