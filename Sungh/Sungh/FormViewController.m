//
//  FormViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/3/1.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "FormViewController.h"
#import "FormTableViewCell.h"
#import "FormHeaderView.h"
#import "FormModel.h"
#import "CustomPickViewController.h"
#import "CustomDatePickerView.h"
@interface FormViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)UIScrollView *scroll;
@property (nonatomic,strong)UIScrollView *scrollTop;
@property (nonatomic,strong)FormHeaderView *headerView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 20; i++) {
        FormModel *model = [[FormModel alloc]init];
        [self.dataArr addObject:model];
    }
    [self initUI];
}
- (void)initUI{
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+80, kScrWid, kScrHei-64-80)];
    self.scroll.delegate  = self;
    self.scroll.contentSize  = CGSizeMake(15*60,kScrHei-64-80);
    [self.view addSubview:self.scroll];
    self.scrollTop = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScrWid,80)];
    self.scrollTop.contentSize  = CGSizeMake(15*60, 80);
    self.scrollTop.delegate = self;
    self.scrollTop.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollTop];
    self.headerView =  [[[NSBundle mainBundle]loadNibNamed:@"FormHeaderView" owner:self options:nil]lastObject];
    [self.scrollTop addSubview:self.headerView];
    
    self.tableview  = [[UITableView alloc]initWithFrame:CGRectMake(0,0,15*60,kScrHei-64-80)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"FormTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FormTableViewCell"];
    [self.scroll addSubview:self.tableview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FormTableViewCell"];
    FormModel *model =  self.dataArr[indexPath.row];
    cell.model = model;
    [cell setDataTag:indexPath.row];
    cell.selBlock = ^(NSInteger row, NSInteger type) {
        [self dateDataBlock:row type:type];
    };
    cell.dateBlock = ^(NSInteger rowe) {
        CustomDatePickerView *datepicker = [[CustomDatePickerView alloc] initWithDateStyle:DateStyleShowMonthDay CompleteBlock:^(NSDate *selectDate) {
            NSString *dateString = [selectDate stringWithFormat:@"MM-dd"];
        model.formDate = dateString;
            [self.tableview reloadData];
        }];
        [datepicker show];
    };
    cell.selTextBlock = ^(NSString * _Nonnull str, NSInteger type) {
        [self textDataBlock:str type:type model:model];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
- (void)textDataBlock:(NSString *)str type:(NSInteger)type model:(FormModel *)model
{
    if (type==10) {
        model.formTime = str;
    }else if (type==11){
        model.formTW = str;
    }else if (type==12){
        model.formMB = str;
    }else if (type==13){
        model.formHX = str;
    }else if (type==14){
        model.formXY = str;
    }else if (type==15){
        model.formYL = str;
    }else if (type==16){
        model.formYC = str;
    }else if (type==17){
        model.formGW = str;
    }else if (type==18){
        model.formQT = str;
    }else if (type==19){
        model.formCS = str;
    }else if (type==20){
        model.formQM = str;
    }
}
- (void)dateDataBlock:(NSInteger)row type:(NSInteger)type {
    CustomPickViewController *vc = [[CustomPickViewController alloc]initWithNibName:@"CustomPickViewController" bundle:[NSBundle mainBundle]];
    if (type == 9) {
        vc.pickViewType = PickViewDefault;
    }else if (type == 10){
        vc.pickViewType = PickViewTFTypeSZ;
    }else if(type == 11){
        vc.pickViewType = PickViewTFTypeDG;
    }
    vc.pickBlock = ^(NSString * _Nonnull string) {
        FormModel *model = self.dataArr[row];
        if (type == 9) {
            model.formDJ= string;
        }else if (type == 10){
            model.formSz= string;
        }else if (type == 11){
            model.formDG= string;
        }
        [self.tableview reloadData];
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    nav.view.backgroundColor = [UIColor clearColor];
    [self presentViewController:nav animated:NO completion:nil];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollTop) {
        CGFloat y = self.scroll.contentOffset.y;
        self.scroll.contentOffset = CGPointMake(self.scrollTop.contentOffset.x, y);
    }else if (scrollView == self.scroll){
        CGFloat y = self.scrollTop.contentOffset.y;
        self.scrollTop.contentOffset = CGPointMake(self.scroll.contentOffset.x,y);
    }
}
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end

