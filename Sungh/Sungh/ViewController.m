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
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ViewController
- (void)drawBackViewWithView:(UIView *)view BackColor:(UIColor *) color LabelText:(NSString *)string{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *bezier = [UIBezierPath bezierPath];
        [bezier moveToPoint:CGPointMake(25, 0)];
        [bezier addLineToPoint:CGPointMake(55, 0)];
        [bezier addLineToPoint:CGPointMake(80, 25)];
        [bezier addLineToPoint:CGPointMake(0, 25)];
        [bezier addLineToPoint:CGPointMake(25, 0)];
    layer.path = bezier.CGPath;
    layer.fillColor = color.CGColor;
    [view.layer addSublayer:layer];
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 80, 25)];
    labe.text = string;
    labe.textColor = [UIColor whiteColor];
    labe.textAlignment = NSTextAlignmentCenter;
    labe.font = [UIFont systemFontOfSize:14];
    [view addSubview:labe];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL isbools = [STool isWiFiEnabled];
    if (isbools) {
        
        NSLog(@" -------  -sju");
    }
    UIView *vc = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 80, 25)];
    vc.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:vc];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 80, 25)];// 坐标可以自行修改
    view.transform = CGAffineTransformMakeRotation(M_PI_4);
    view.backgroundColor = [UIColor purpleColor];

    [self.view addSubview:view];
    BOOL is = [CheckRegularTool isPhoneNumber:@"111"];

//
    //测试
//    [[UIScreen mainScreen].bounds.size.width];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = [NSMutableArray arrayWithObjects:@"js && oc",@"sql",@"textfield输入限制", nil];

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
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        JSAndOCViewController *vc = [JSAndOCViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1){
        SQLViewController *vc = [SQLViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        TextFieldViewController *vc = [TextFieldViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
