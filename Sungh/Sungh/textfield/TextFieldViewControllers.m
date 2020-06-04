//
//  TextFieldViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/5/13.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "TextFieldViewControllers.h"
#import "TextFieldViewCell.h"
@interface TextFieldViewControllers ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tablev;
@end

@implementation TextFieldViewControllers

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tablev = [[UITableView alloc]initWithFrame:CGRectMake(64, 0, kScrWid, kScrHei - 64)];
    self.tablev.delegate = self;
    self.tablev.dataSource = self;
    [self.tablev registerNib:[UINib nibWithNibName:@"TextFieldViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FieldViewCell"];
    [self.view addSubview:self.tablev];
    
    
    NSString *string = @"你好啊sungh同学";
    NSMutableString * reverString = [NSMutableString stringWithString:string];
    for (int i = 0 ;i < (string.length+1)/2; i++) {
        [reverString replaceCharactersInRange:NSMakeRange(i, 1) withString:[string substringWithRange:NSMakeRange(string.length-i-1, 1)]];
        [reverString replaceCharactersInRange:NSMakeRange(string.length-i-1, 1) withString:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    NSLog(@" --- %@",reverString);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TextFieldViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FieldViewCell"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TextFieldViewCell *cell = [self.tablev cellForRowAtIndexPath:indexPath];
    NSString *str =  cell.textf.text;
    NSLog(@" ----- %@",str);
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
