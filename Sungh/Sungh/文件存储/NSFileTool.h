//
//  NSFileTool.h
//  Sungh
//
//  Created by yonyouqiche on 2018/8/20.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileTool : NSObject


/**
 Document文件：用来保存应由程序运行时生成的需要持久化的数据， iTunes会自动备份该目录

 @param path 文件名
 @return 路径
 */
+ (NSString *)documentPathFile:(NSString *)path;

/**
  Library文件夹：用来存储程序的默认设置和其他状态信息，iTunes也会自动备份该目录

 @param path 文件名
 @return 路径
 */
+ (NSString *)libraryFilePath:(NSString *)path;

/**
 Library/Caches文件夹：

 @param path 文件名
 @return 路径
 */
+ (NSString *)libraryCacheFilePath:(NSString *)path;

/**
 Library/Preferences:用来存储用户的偏好设置，iOS的setting（设置）会在这个目录中查找应用程序的设置信息，iTunes会自动备份该目录，通常这个文件夹都是由系统进行维护的，不建议操作它

 @param path 文件名
 @return 路径
 */
+ (NSString *)preferencesFilePath:(NSString *)path;

/**
  获取缓存大小 根据路径获得文件大小
 @param path 文件名
 @return 大小
 */
+ (NSString *)getCacheSizeWithPath:(NSString *)path;

/**
 // 根据路径删除路径下缓存


 @param path 文件名
 @return bool 是否删除成功
 */
+ (BOOL)clearCacheWithFilePath:(NSString *)path;
@end
