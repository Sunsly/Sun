//
//  CustomPickViewController.m
//  CarNetworkingModule
//
//  Created by yy on 2021-03-2.
//  Copyright (c) 2021年 yy. All rights reserved.
//

#import "CustomPickViewController.h"
#define RGBAAllColor(rgb, a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0  \
green:((float)((rgb & 0xFF00) >> 8))/255.0     \
blue:((float)(rgb & 0xFF))/255.0              \
alpha:(a)/1.0]
 
@interface CustomPickViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIView *customView;//pickview 容器
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic,strong)UIPickerView *pickView;
@property (strong, nonatomic) IBOutlet UILabel *pickTitle;
@property (nonatomic,copy) NSString  *pickModel;

@end

@implementation CustomPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBAAllColor(0x000000,0.3);
    [self initCustomUI];
}
- (void)initCustomUI{
    self.dataSouce = [[NSMutableArray alloc]init];
    if (self.pickViewType == PickViewDefault) {
        self.pickTitle.text = @"护理级别";
        NSArray *arr = @[@"一级",@"二级",@"三级",@"特级"];
        [self.dataSouce addObjectsFromArray:arr];
        [self.customView addSubview:self.pickView];
    }else if (self.pickViewType == PickViewTFTypeSZ){
        self.pickTitle.text = @"神志";
        NSArray *arr = @[@"清楚",@"嗜睡",@"模糊",@"昏睡",@"昏迷"];
        [self.dataSouce addObjectsFromArray:arr];
        [self.customView addSubview:self.pickView];
    }else if (self.pickViewType == PickViewTFTypeDG){
        self.pickTitle.text = @"导管";
        NSArray *arr = @[@"胃管",@"深静脉穿刺",@"导尿管",@"其他"];
        [self.dataSouce addObjectsFromArray:arr];
        [self.customView addSubview:self.pickView];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
//行中有几列
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSouce.count;
}
//列显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    self.pickModel = self.dataSouce[row];
    return self.pickModel;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
}
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)sureAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.pickBlock) {
        self.pickBlock(self.pickModel);
    }
}
-(UIPickerView *)pickView{
    if (_pickView == nil) {
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, kScrWid,  self.customView.frame.size.height)];
        _pickView.dataSource = self;
        _pickView.delegate = self;
        _pickView.showsSelectionIndicator = YES;
    }
    return _pickView;
}

@end
