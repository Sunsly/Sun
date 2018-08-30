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

@end

@implementation SQLViewController

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
    [sql createSql];
    DBUserModel *user = [[DBUserModel alloc]init];
    user.name = @"sun";
    user.sex  = @"男";
    user.hei  = @"178";
    user.wei  = @"65";
    user.age  = @"18";
    user.userId = @"12123";
    user.school = @"1111";

    [sql insertSql:user];
    [sql transaction];
    NSMutableArray *arr = [sql getResultsSql];
    NSLog(@"---  %@",arr);
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    DBManager *sql =  [DBManager shareManager];
//    [sql deleteData:@"12123"];
//    NSMutableArray *arr = [sql getResultsSql];
    [sql addNewcolumn:@"address"];
    NSLog(@"---  %@",[sql refreshData:0 limit:8]);

//    [sql addNewcolumn:@"school"];
//
////    [sql createSql];
//    DBUserModel *user = [[DBUserModel alloc]init];
//    user.name = @"sun";
//    user.sex  = @"男";
//    user.hei  = @"178";
//    user.wei  = @"65";
//    user.age  = @"18";
//    user.userId = @"1002";
//    user.school = @"农大";
//    [sql insertSql:user];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
