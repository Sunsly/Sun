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
#import "InterViewController.h"
#import "DefineInlineViewController.h"
#import "MallocManagerController.h"
#import "MVVMViewController.h"
#import "CurrentSuperViewController.h"
#import "DemoVC.h"
#import <Flutter/Flutter.h>
#import "RunLoopViewController.h"
static void funcMeth(){
    printf("\n12121\n");
}


static NSString  * const kUserName = @"StrongX";

extern int name;//在第二个类中使用extern来访问

extern int name2;//不可引用

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ViewController


-(NSString *)getNowTimeStamp {

NSDate *date = [NSDate date];
NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
return timeSp;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    funcMeth();
    int a = 100;
    NSLog(@"name ---- %d ---",name);
//    NSLog(@"name2 ---- %d ---",name2);

    NSLog(@"%p",&a);
    
    
    NSLog(@" --- %ld",[[self getNowTimeStamp] integerValue]);
    DemoVC *vc= [[DemoVC alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:vc];

    self.dataArray = [[NSMutableArray alloc]init];
    NSLog(@" --- %p",self.dataArray);
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
    self.dataArray = [NSMutableArray arrayWithObjects:@"js && oc",@"sql",@"textfield输入限制", @"下载",@"算法",@"RAC",@"多线程",@"面试",@"内联函数宏定义",@"内存管理",@"MVVM",@"childView",@"ui事件传递",@"textfield",@"AFNViewController",@"RunLoopViewController",nil];

    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScrWid, kScrHei-64)];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    
    [self.view addSubview:self.tableview];

    
    
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
//    cell.textLabel.clipsToBounds = YES;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.dataArray[indexPath.row];
    if ([str isEqualToString:@"js && oc"]) {
        JSAndOCViewController *vc = [JSAndOCViewController new];
        vc.type = WebUrlTypeNet;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"sql"]){
        SQLViewController *vc = [SQLViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"textfield输入限制"]){
        TextFieldViewController *vc = [TextFieldViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"下载"]){
        DownLoadingsViewController *vc = [DownLoadingsViewController new];
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([str isEqualToString:@"算法"]){
        ArithmeticViewController *vc = [ArithmeticViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"RAC"]){
        RACViewController *vc = [RACViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([str isEqualToString:@"多线程"]){
        SynchronizedViewController *vc = [SynchronizedViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"面试"]){
        
        Class class = NSClassFromString(@"InterViewController");
        //vc.nameStr = @"12";//不可修改
        UIViewController *vc = [[class alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"内联函数宏定义"]){
        DefineInlineViewController *vc = [[DefineInlineViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"内存管理"]){
        MallocManagerController *vc = [[MallocManagerController alloc]init];
   
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"MVVM"]){
        MVVMViewController *vc = [[MVVMViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"childView"]){
        CurrentSuperViewController *vc = [[CurrentSuperViewController alloc]initWithNibName:@"CurrentSuperViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"ui事件传递"]){
        
//        Class class = NSClassFromString(@"UIActionViewController");
//        //vc.nameStr = @"12";//不可修改
//        UIViewController *vc = [[class alloc]init];
//
//        [self.navigationController pushViewController:vc animated:YES];
        FlutterViewController* flutterViewController = [[FlutterViewController alloc] init];
//        [self presentViewController:flutterViewController animated:false completion:nil];
        [self.navigationController pushViewController:flutterViewController animated:YES];

    }else if ([str isEqualToString:@"textfield"]){
        Class class = NSClassFromString(@"TextFieldViewControllers");
            //vc.nameStr = @"12";//不可修改
            UIViewController *vc = [[class alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
    }else if ([str isEqualToString:@"AFNViewController"]){
        Class class = NSClassFromString(@"AFNViewController");
               //vc.nameStr = @"12";//不可修改
               UIViewController *vc = [[class alloc]init];
               
               [self.navigationController pushViewController:vc animated:YES];
    }else if([str isEqualToString:@"RunLoopViewController"]){
        RunLoopViewController *vc = [[RunLoopViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark ------> 水滴gif
- (void)chargeAnimationImages{
    UIImageView *iconImageView;
    NSURL *gifImageUrl = [[NSBundle mainBundle] URLForResource:@"charge_shuidi_img" withExtension:@"gif"];
    iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,187, 187)];;
    
    [self.view addSubview:iconImageView];
    
    iconImageView.image = [STool getGitImageWithData:[NSData dataWithContentsOfURL:gifImageUrl]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
