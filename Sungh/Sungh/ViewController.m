//
//  ViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2018/6/25.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "ViewController.h"
#import "JSAndOCViewController.h"
#import "SQLViewController.h"
#import "NSFileTool.h"
#import "CheckRegularTool.h"
#import "UIButton+Position.h"
#import "TextFieldViewController.h"
#import "STool.h"
#import "UIImageView+WebCache.h"
#import "DownLoadingsViewController.h"
#import "ArithmeticViewController.h"
#import "RACViewController.h"
#import "SynchronizedViewController.h"
#define     TICK  NSDate *startTime = [NSDate date]
#define     TOCK  NSLog(@"Time: %f",-[startTime timeIntervalSinceNow])
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    BOOL isbools = [STool isWiFiEnabled];
//    TICK;
//    if (isbools) {
//
//        NSLog(@" -------  -sju");
//    }
//    TOCK;
//
////
//    //测试
////    [[UIScreen mainScreen].bounds.size.width];
//    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = [NSMutableArray arrayWithObjects:@"js && oc",@"sql",@"textfield输入限制", @"下载",@"算法",@"RAC",@"多线程",nil];

    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScrWid, kScrHei-64)];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;

    [self.view addSubview:self.tableview];
//
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootcell"];
    if (cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rootcell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        JSAndOCViewController *vc = [JSAndOCViewController new];
        vc.type = WebUrlTypeNet;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1){
        SQLViewController *vc = [SQLViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        TextFieldViewController *vc = [TextFieldViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        DownLoadingsViewController *vc = [DownLoadingsViewController new];
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.row  == 4){
        ArithmeticViewController *vc = [ArithmeticViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        RACViewController *vc = [RACViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 6){
        SynchronizedViewController *vc = [SynchronizedViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
