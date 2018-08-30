//
//  DBManager.h
//  Sungh
//
//  Created by yonyouqiche on 2018/7/17.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "DBUserModel.h"
@interface DBManager : NSObject

/**
 整个工程 启动时候只会初始化一次

 @return self
 */
+(DBManager *)shareManager;

/**
 创建

 @param userId 用户
 */
- (void)createSql;

/**
 插入

 @param model <#model description#>
 @param userId <#userId description#>
 */
- (void)insertSql:(DBUserModel *)model;

/**
 取出

 @param userId <#userId description#>
 @return <#return value description#>
 */
- (NSMutableArray *)getResultsSql;
//- (BOOL)updateData:(NSString *)userId

- (BOOL)updateData:(DBUserModel *)model;

- (BOOL)deleteData:(NSString *)userid;

- (BOOL)addNewcolumn:(NSString *)newColumn;


/**
 分页查询

 @param page 0
 @param limit 10
 @return 查询结果
 */
- (NSMutableArray*)refreshData:(NSInteger )page limit:(NSInteger)limit;


//事物
-(void)transaction ;
@end
