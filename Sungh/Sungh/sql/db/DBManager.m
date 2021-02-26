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
static const NSString *version = @"1.0.0";
#define DBVersion @"1.0.0"

@implementation DBManager

{
    FMDatabase *database;
    FMDatabaseQueue *queueDatabase;
}
// 初始化 路径
- (void)initPath{
    NSString *path = [NSString stringWithFormat:@"%@/user.db",DBPath];
//    database = [FMDatabase databaseWithPath:path];
    NSLog(@" -- %@",path);
    queueDatabase = [FMDatabaseQueue databaseQueueWithPath:path];
}
+ (DBManager *)shareManager
{
    static DBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DBManager alloc]init];
        [manager initPath];
        [manager initTable];
        if (![[manager getDBInfoValue] isEqualToString:DBVersion]) {
            [manager insertVersion];
        }
    });
    return manager;
}
#pragma mark 创建
-(void)initTable
{
        [queueDatabase inDatabase:^(FMDatabase * _Nonnull db) {
            [self initUserTable:db];
            [self initVersionTable:db];
        }];
}

- (void)initUserTable:(FMDatabase *)db{
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists user%@ (id integer primary key autoincrement ,userid char(128) not null, name char(128) not null,age char(128) not null,sex char(128) not null,hei char(128) not null,wei char(128) not null,school char(128) not null)",USERID];
        BOOL rel =  [db executeUpdate:sql];
        if (rel) {
            NSLog(@"创建user success");
        }else{
            NSLog(@"创建user fail");
        }
        [db close];
    }else{
        NSLog(@" ---user 打开失败");
    }
    
}
- (void)initVersionTable:(FMDatabase *)db{
    if ([db open]) {
        BOOL result = false;
        if (![db tableExists:@"tableVersion"]) {
            NSString *sql =@"create table  tableVersion (verison TEXT)";
            result = [db executeUpdate:sql];
            if (result) {
                NSLog(@"创建version success");
            }else{
                NSLog(@"创建version fail");
            }
        }
        [db close];
    }else{
        NSLog(@" ---tableVersion 打开失败");

    }
}
- (void)insertVersion{
    if ([queueDatabase openFlags]) {
        [queueDatabase inDatabase:^(FMDatabase *db) {
               NSString *sql = @"insert into tableVersion (verison) values (?);";
               BOOL result = [db executeUpdate:sql,DBVersion];
               if (result) {
                   NSLog(@"插入数据成功");
               } else {
                   NSLog(@"插入数据失败");
               }
           }];
        [queueDatabase close];
    }else{
        NSLog(@"打开失败");
    }
}
#pragma mark 得到版本信息
- (NSString*)getDBInfoValue
{
    __block NSString * version = nil;
//     *dbUnit =[DataBaseUtil unit];
    [queueDatabase inDatabase:^(FMDatabase *db) {
        [db open];
        FMResultSet* set =[db executeQuery:@"select verison from tableVersion"];
        if (set) {
            while ([set next]) {
                version = [set stringForColumn:@"verison"];
            }
        }
        [db close];
    }];
    return version;
}
//FIXME:新增字段
- (void)addNewSql{
    if (![database columnExists:@"bask" inTableWithName:[NSString stringWithFormat:@"user%@",USERID]]) {
        NSString *alertStr = [NSString stringWithFormat:@"alter table %@ add %@ integer",[NSString stringWithFormat:@"user%@",USERID],@"bask"];
        [database executeUpdate:alertStr];
    }
}
//TODO:插入
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
//查
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
//更新
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
//删除 某一条
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
        
        [db beginTransaction];
        
        BOOL isRollBack = NO;
        
        
        @try
        {
//            插入db1  db2
            
        }
        @catch (NSException *exception) {
            isRollBack = YES;
            [db rollback];
        }
        @finally {
            
        }
        
    }];
    //多线程使用事物
    __block BOOL flag = NO;
    
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        @try
        {
            //                           for (NSString *type in typeArr) {
            //                               flag = [db executeUpdateWithFormat:@"INSERT INTO TypeList (type) VALUES (%@);", type];
            //                           }
        }
        @catch (NSException *exception) {
            *rollback = YES;
            flag = NO;
        }
        @finally {
            *rollback = !flag;
            //                           if (flag) {
            //                               [self resultWithResult:flag success:success failed:failed];
            //                           }
        }
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

/*
 FMDB的正确打开方式

 如果用 while 循环遍历 FMResultSet 就不存在该问题，因为 [FMResultSet next] 遍历到最后会调用 [FMResultSet close]。
 
 // 安全
    while ([result next]) {
    }
    
    // 安全
    if ([result next]) {
    }
    [result close];

 */

@end
