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
#import <sys/sysctl.h>
#import <mach/mach.h>
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


//获取当前设备可用内存
+ (double)availableMemory{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return ((vm_page_size * vmStats.free_count)/1024.0)/1024.0;
}
//获取当前任务所占用内存
+(double)usedMemory{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return taskInfo.resident_size/1024.0/1024.0;
}
+(void)removeCurrentController:(UIViewController *)controller{
    NSArray *array = controller.navigationController.viewControllers;
    NSMutableArray *controllerArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < array.count - 1; i++) {
        [controllerArray addObject:array[i]];
    }
    controller.navigationController.viewControllers = controllerArray;
}

+ (UIImage *)getGitImageWithData:(NSData* )data
{
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(imageSource);
    NSMutableArray *images = [NSMutableArray array];
    NSTimeInterval duration = 0;
    for (size_t i = 0; i < count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(imageSource, i, NULL);
        if (!image) continue;
        duration += durationWithSourceAtIndex(imageSource, i);
        [images addObject:[UIImage imageWithCGImage:image]];
        CGImageRelease(image);
    }
    if (!duration) duration = 0.1 * count;
    CFRelease(imageSource);
    return [UIImage animatedImageWithImages:images duration:duration];
}
#pragma mark 获取每一帧图片的时长
float durationWithSourceAtIndex(CGImageSourceRef source, NSUInteger index) {
    float duration = 0.1f;
    CFDictionaryRef propertiesRef = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *properties = (__bridge NSDictionary *)propertiesRef;
    NSDictionary *gifProperties = properties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTime = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTime) duration = delayTime.floatValue;
    else {
        delayTime = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTime) duration = delayTime.floatValue;
    }
    CFRelease(propertiesRef);
    return duration;
}

+ (UIImage *)getLocalGifWithImageNamed:(NSString *)imageName
{
    if (![imageName hasSuffix:@".gif"]) {
        imageName = [imageName stringByAppendingString:@".gif"];
    }
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    return  [STool getGitImageWithData:data];
    
}

+(NSString *)formatterStringCardNum:(NSString *)string length:(NSInteger)length

{
    NSString *tempStr=string;
    NSInteger size =(tempStr.length / length);
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++){
        [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(size*4, (tempStr.length % length))]];
    tempStr = [tmpStrArr componentsJoinedByString:@" "];
    return tempStr;
}
@end
