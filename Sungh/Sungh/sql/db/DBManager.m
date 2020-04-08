//
//  DBManager.m
//  Sungh
//
//  Created by yonyouqiche on 2018/7/17.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabaseAdditions.h"
/*
 Documents：应用中用户数据可以放在这里，iTunes备份和恢复的时候会包括此目录
 tmp：存放临时文件，iTunes不会备份和恢复此目录，此目录下文件可能会在应用退出后删除
 Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 */
/*
 优点:
 
 对多线程的并发操作进行处理，所以是线程安全的；
 
 以OC的方式封装了SQLite的C语言API，使用起来更加的方便；
 
 FMDB是轻量级的框架，使用灵活。
 
 缺点:
 
 因为它是OC的语言封装的，只能在ios开发的时候使用，所以在实现跨平台操作的时候存在局限性。
 
 FMDB框架中重要的框架类
 
 FMDatabase
 
 FMDatabase对象就代表一个单独的SQLite数据库，用来执行SQL语句
 
 FMResultSet
 
 使用FMDatabase执行查询后的结果集
 
 FMDatabaseQueue
 
 用于在多线程中执行多个查询或更新，它是线程安全的
 */
#define DBPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]
@implementation DBManager
{
    FMDatabase *database;
}
// 初始化 路径
- (void)open{
    NSString *path = [NSString stringWithFormat:@"%@/user.db",DBPath];
    database = [FMDatabase databaseWithPath:path];
}
+ (DBManager *)shareManager
{
    static DBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DBManager alloc]init];
        NSLog(@" ----- %@",DBPath);
        [manager open];
    });
    return manager;
}
#pragma mark 创建
-(void)createSql
{
    NSLog(@" ----- %@",DBPath);
    if ([database open]) {//打开

        NSString *sql = [NSString stringWithFormat:@"create table if not exists user%@ (id integer primary key autoincrement ,userid char(128) not null, name char(128) not null,age char(128) not null,sex char(128) not null,hei char(128) not null,wei char(128) not null,school char(128) not null)",USERID];
       BOOL rel =  [database executeUpdate:sql];
        if (rel) {
            NSLog(@"创建table success");
        }else{
            NSLog(@"创建table fail");
        }
        [self addNewSql];

        [database close];//关闭 数据库
    }else{
        NSLog(@"打开失败");
    }
}

- (void)addNewSql{
    if (![database columnExists:@"bask" inTableWithName:[NSString stringWithFormat:@"user%@",USERID]]) {
        NSString *alertStr = [NSString stringWithFormat:@"alter table %@ add %@ integer",[NSString stringWithFormat:@"user%@",USERID],@"bask"];
        
        [database executeUpdate:alertStr];
    }
    
}
-(void)insertSql:(DBUserModel *)model
{
    if ([database open]) {
        //如果有该条数据 则不做插入
       BOOL ref =  [self searchSql:model.userId];
        if (!ref) {
            NSString *sql = [NSString stringWithFormat:@"insert into user%@ (userid,name,age,sex,hei,wei,school) values (?,?,?,?,?,?,?);",USERID];
            BOOL rel =  [database executeUpdate:sql,model.userId,model.name,model.age,model.sex,model.hei,model.wei,model.school];
            if (rel) {
                NSLog(@"插入成功");
            }else{
                NSLog(@"插入失败");
            }
        }
        [database close];
    }else{
        NSLog(@"数据库打开失败");
    }
}
//查询 userid是否存在
- (BOOL)searchSql:(NSString *)Id{
    NSString *sql = [NSString stringWithFormat:@"select count(userid) as countNum from user%@ where userid = ?",USERID];
    FMResultSet *resultSet = [database executeQuery:sql,Id];
    while ([resultSet next]){
        NSInteger count = [resultSet intForColumn:@"countNum"];
        if (count > 0) {
            return YES;
        } else {
            return NO;
        }
    };
    return YES;
}
-(NSMutableArray *)getResultsSql
{
    //查询整个 表用户 数据
    if ([database open]) {
        NSString *sql = [NSString stringWithFormat:@"select *from user%@",USERID];
            FMResultSet *result = [database executeQuery:sql];
            NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:0];
            while ([result next]) {
                DBUserModel *model= [[DBUserModel alloc]initWithDictionary:result.resultDictionary];
                [resultArr addObject:model];
            }
        [database close];
        return resultArr;
    }
    return nil;
}
- (BOOL)updateData:(DBUserModel *)model
{
    if ([database open]) {
        NSString *sql = [NSString stringWithFormat:@"update user%@ set name = ? where userid = ?",USERID];
        BOOL ref =   [database executeUpdate:sql,model.name,model.userId];
        if (ref) {
            NSLog(@"更新");
            
        }else{
            NSLog(@"更新fial成功");
        }
        [database close];

        return ref;
    }
    return NO;
}
- (BOOL)deleteData:(NSString *)userid{
    
    if ([database open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from user%@  where userid = ?",USERID];
        BOOL ref =   [database executeUpdate:sql,userid];
        if (ref) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"fial");
        }
        [database close];
        return ref;
    }
    return NO;
}
-(BOOL)addNewcolumn:(NSString *)newColumn
{
    if ([database open]) {
        if (![database columnExists:newColumn inTableWithName:[NSString stringWithFormat:@"user%@",USERID]] ) {
            //
            NSString *sqls = [NSString stringWithFormat:@"alter table user%@ add %@ char",USERID,newColumn];
         BOOL ref =   [database executeUpdate:sqls];
            if (ref ) {
                NSLog(@"插入成功");
            }else{
                NSLog(@"插入失败");
            }
            [database close];
            return ref;
        }
        [database close];
        return YES;
    }
    [database close];
    return NO;
}
- (NSMutableArray*)refreshData:(NSInteger )page limit:(NSInteger)limit{
    if ([database open]) {
        NSString *sql = [NSString stringWithFormat:@"select *from user%@ order by id asc limit %ld,%ld",USERID,page,limit];
        FMResultSet *result = [database executeQuery:sql];
        NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:0];
        while ([result next]) {
            DBUserModel *model= [[DBUserModel alloc]initWithDictionary:result.resultDictionary];
            [resultArr addObject:model];
        }
        [database close];
        return resultArr;
    }
    return nil;
}






//**********************************************多线程



FMDatabaseQueue *queue;

- (void)createQueue{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"FMDB.db"];
    queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
}
- (void)operation{
    
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
      //操作
    }];
    //多线程使用事物
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        
    }];
}


#pragma mark --- 》事物
-(void)transaction {
    NSDate *date1 = [NSDate date];
    // 创建表
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"mytable1.db"];
    NSLog(@"dbPath = %@",dbPath);
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    // 注意这里的判断一步都不能少,特别是这里open的判断
    
    if (![dataBase open]) {
        NSLog(@"打开数据库失败");
        return ;
    }
    
    NSString *sqlStr = @"create table if not exists mytable1(num integer,name varchar(7),sex char(1),primary key(num));";
    BOOL res = [dataBase executeUpdate:sqlStr];
    if (!res) {
        NSLog(@"error when creating mytable1");
        
        [dataBase close];
    }
    
    // 开启事务
    [dataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (int i = 0; i<500; i++) {
            NSNumber *num = @(i+1);
            NSString *name = [[NSString alloc] initWithFormat:@"student_%d",i];
            NSString *sex = (i%2==0)?@"f":@"m";
            
            NSString *sql = @"insert into mytable1(num,name,sex) values(?,?,?);";
            BOOL result = [dataBase executeUpdate:sql,num,name,sex];
            if ( !result ) {
                NSLog(@"插入失败！");
                return;
            }
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        // 事务回退
        [dataBase rollback];
    }
    @finally {
        if (!isRollBack) {
            //事务提交
            [dataBase commit];
        }
    }
    
    [dataBase close];
    NSDate *date2 = [NSDate date];
    NSTimeInterval a = [date2 timeIntervalSince1970] - [date1 timeIntervalSince1970];
    NSLog(@"FMDatabase使用事务插入500条数据用时%.3f秒",a);
}



@end
