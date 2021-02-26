//
//  SQLViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2018/7/17.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "SQLViewController.h"
#import "DBManager.h"
#import "DBUserModel.h"

@interface SQLViewController ()
@property(nonatomic,strong)FMDatabase *iFmDb;
@property(nonatomic,strong)FMDatabaseQueue *databaseQueue;

@end

@implementation SQLViewController

//-(BOOL)shouldAutorotate
//{
//    return YES;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"11111" forKey:@"title"];
    
    NSArray *arrs = @[@"1",@"2",@"3"];
    
    [dic setObject:arrs forKey:@"content"];
    
    [dic setObject:@"1" forKey:@"type"];

    
    NSLog(@" -- -- - %@",dic);
    
    self.navigationItem.title = @"js&&oc";
    self.view.backgroundColor = [UIColor whiteColor];
    DBManager *sql =  [DBManager shareManager];
    DBUserModel *user = [[DBUserModel alloc]init];
    user.name = @"sun";
    user.sex  = @"男";
    user.hei  = @"178";
    user.wei  = @"65";
    user.age  = @"18";
    user.userId = @"12123";
    user.school = @"1111";
    user.bask = @"篮球";

//    [sql insertSql:user];
//    [sql transaction];
    NSMutableArray *arr = [sql getResultsSql];
    NSLog(@"---  %@",[[DBManager shareManager]getDBInfoValue]);
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    DBManager *sql =  [DBManager shareManager];
////    [sql deleteData:@"12123"];
////    NSMutableArray *arr = [sql getResultsSql];
//        [sql addNewcolumn:@"address"];
//    NSLog(@"---  %@",[sql refreshData:0 limit:8]);
//
////    [sql addNewcolumn:@"school"];
////
//////    [sql createSql];
//    DBUserModel *user = [[DBUserModel alloc]init];
//    user.name = @"suns";
//    user.sex  = @"男";
//    user.hei  = @"178";
//    user.wei  = @"65";
//    user.age  = @"18";
//    user.userId = @"1003";
//    user.school = @"农大";
//    [sql insertSql:user];
    [self openDB];

    [self testDBSpeed];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(BOOL)openDB
{
    NSFileManager *filaManager = [NSFileManager defaultManager];
    BOOL isFile = NO;
    //判断有没有数据库文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    
    NSString* uidPath = documentDirectory;
    
    BOOL isDir = FALSE;
    
    BOOL isDirExist = [filaManager fileExistsAtPath:uidPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [filaManager createDirectoryAtPath:uidPath withIntermediateDirectories:YES attributes:nil error:nil];
        
        if(!bCreateDir)
        {
//            MCLogDebug(@"Create MsgPic Directory Failed.");
        }
    }
    
    NSString* DBFilePath = [uidPath stringByAppendingPathComponent:@"DBInfo.db"];
    if([filaManager fileExistsAtPath:DBFilePath])
        isFile = YES;
    
    self.iFmDb = [FMDatabase databaseWithPath:DBFilePath];
    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:DBFilePath];
    NSLog(@"openDB");
    if (![self.iFmDb open])
    {
        return NO;
    }
    return YES;
}
-(void)testDBSpeed
{
    NSDate *date1 = [NSDate date];
    [self insertData:500 useTransaction:NO];
    NSDate *date2 = [NSDate date];
    NSTimeInterval a = [date2 timeIntervalSince1970] - [date1 timeIntervalSince1970];
    NSLog(@"不使用事务插入500条数据用时%.3f秒",a);
    [self insertData:500 useTransaction:YES];
    NSDate *date3 = [NSDate date];
    NSTimeInterval b = [date3 timeIntervalSince1970] - [date2 timeIntervalSince1970];
    NSLog(@"使用事务插入500条数据用时%.3f秒",b);
    
}
- (void)insertData:(int)fromIndex useTransaction:(BOOL)useTransaction
{
    [self openDB];
    if (useTransaction) {
        [self.iFmDb beginTransaction];
        BOOL isRollBack = NO;
        @try {
            for (int i = fromIndex; i<500+fromIndex; i++) {
                NSString *nId = [NSString stringWithFormat:@"%d",i];
                NSString *phone= [[NSString alloc] initWithFormat:@"phone_%d",i];
                NSString *strName = [[NSString alloc] initWithFormat:@"name_%d",i];
                NSString *roomID= [[NSString alloc] initWithFormat:@"roomid_%d",i];
                NSString *sql = @"INSERT INTO GroupPersonInfo(uid,phone,name,groupRoomId) VALUES (?,?,?,?)";
                BOOL a = [self.iFmDb executeUpdate:sql,nId,phone,strName,roomID];
                if (!a) {
                    NSLog(@"插入失败1");
                }
            }
        }
        @catch (NSException *exception) {
            isRollBack = YES;
            [self.iFmDb rollback];
        }
        @finally {
            if (!isRollBack) {
                [self.iFmDb commit];
            }
        }
    }else{
        for (int i = fromIndex; i<500+fromIndex; i++) {
            NSString *nId = [NSString stringWithFormat:@"%d",i];
            NSString *phone= [[NSString alloc] initWithFormat:@"phone_%d",i];
            NSString *strName = [[NSString alloc] initWithFormat:@"name_%d",i];
            NSString *roomID= [[NSString alloc] initWithFormat:@"roomid_%d",i];
            NSString *sql = @"INSERT INTO GroupPersonInfo(uid,phone,name,groupRoomId) VALUES (?,?,?,?)";
            BOOL a = [self.iFmDb executeUpdate:sql,nId,phone,strName,roomID];
            if (!a) {
                NSLog(@"插入失败2");
            }
        }
    }
    [self closeDB];
}
- (BOOL) closeDB
{
    NSLog(@"closeDB");
    if (self.iFmDb)
    {
        return [self.iFmDb close];
    }
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
