//
//  NSFileTool.m
//  Sungh
//
//  Created by yonyouqiche on 2018/8/20.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "NSFileTool.h"
#import "SDImageCache.h"

@implementation NSFileTool

+(NSString *)documentPathFile:(NSString *)path
{
    NSString *pathStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    return [NSString stringWithFormat:@"%@/%@",pathStr,path];
}

+(NSString *)libraryFilePath:(NSString *)path
{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    return [NSString stringWithFormat:@"%@/%@",libraryPath,path];
}
+(NSString *)libraryCacheFilePath:(NSString *)path
{
    NSString *libraryCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [NSString stringWithFormat:@"%@/%@",libraryCachePath,path];
}

+(NSString *)preferencesFilePath:(NSString *)path
{
    NSString *librarypath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *PreferencesPath = [librarypath stringByAppendingString:@"/Preferences"];
    return [NSString stringWithFormat:@"%@/%@",PreferencesPath,path];

}


// 获取缓存大小 根据路径获得文件大小

+ (NSString *)getCacheSizeWithPath:(NSString *)path{
    //获取当前路径下的所有文件：
    NSArray *subPathArr = [[NSFileManager defaultManager]subpathsAtPath:path];
    NSString *filePath = nil;
    NSInteger *totleSize = 0;
    for (NSString *subPath in subPathArr) {
        //拼接每一个子文件的路径：
        filePath = [path stringByAppendingString:subPath];
        //是否是文件夹：
        BOOL isDirectory = NO;
        //文件是否存在
        BOOL isExist = [[NSFileManager defaultManager]fileExistsAtPath:filePath isDirectory:&isDirectory];
        //文件过滤
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) {
            continue;
        }
        //指定路径，获取这个路径属性
        long size = [[[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil]fileSize];
        totleSize += size;
    }
    long SDSize = [[SDImageCache sharedImageCache]totalDiskSize];
    totleSize += SDSize;
    //将文件夹大小转化为M/KB/B
    NSString *totleStr = @"";
    if ((long)totleSize > 1000 * 1000) {
        totleStr = [NSString stringWithFormat:@"%.2fM",(long)totleSize / (1000.00f * 1000.00f)];
    }else if ((long)totleSize > 1000){
        totleStr = [NSString stringWithFormat:@"%.2fK",(long)totleSize / 1000.00f];
    }else{
        totleStr = [NSString stringWithFormat:@"%.2fB",(long)totleSize / 1.00f];
    }
    return totleStr;
}

// 根据路径删除路径下缓存
+ (BOOL)clearCacheWithFilePath:(NSString *)path{
    
    //获取所有子路径
    
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSString *filePath = @"";
    NSError *error = nil;
    for (NSString *subPath in subPathArr) {
        filePath = [path stringByAppendingString:subPath];
        //删除子文件
        [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
        if (error) {
            return NO;
        }
    }
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
    }];
    return YES;
}

//****
/*
    tmp：保存应用程序的临时文件夹，使用完毕后，将相应的文件从这个目录中删除，如果空间不够，系统也可能会删除这个目录下的文件，iTunes不会同步这个文件夹，在iPhone重启的时候，该目录下的文件会被删除。
 NSString *temPath = NSTemporaryDirectory();
 */
//+(NSString *)URLEncodedString:(NSString *)str{
//
//}

+(NSString *)URLDecodedString:(NSString *)str{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
    
}


@end
