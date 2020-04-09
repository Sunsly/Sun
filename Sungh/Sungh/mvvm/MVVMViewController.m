//
//  MVVMViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/3/31.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "MVVMViewController.h"
#import "MVVMViewModel.h"
#import "RACSinalViewsController.h"
@interface MVVMViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *bindArr;
@property (nonatomic,strong)MVVMViewModel *viewModel;
@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self bindData];
    [self bingRAC];
}
//数据绑定
- (void)bindData{
    self.viewModel = [[MVVMViewModel alloc]init];
    @weakify(self);
    [self.viewModel.successObject subscribeNext:^(id x) {
        @strongify(self);
        self.bindArr = x;
        [self.tableView reloadData];
    }];//订阅
    [self.viewModel exchangeData];//发送信号

}
//MARK: tableview 懒加载
-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [UITableView new];
        //初始化背景颜色为白色
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.frame = self.view.bounds;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tableView.separatorStyle = NO;
        
    }
    return _tableView;
    
}
//MARK: tableview DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bindArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [self.bindArr[indexPath.row] valueForKey:@"title"];
//    cell.backgroundColor = [UIColor greenColor];
//    cell.textLabel.textColor =[UIColor grayColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//MARK: tableview Delagete
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RACSinalViewsController *vc = [[RACSinalViewsController alloc]initWithNibName:@"RACSinalViewsController" bundle:[NSBundle mainBundle]];
    vc.delegateSubject = [RACSubject subject];
    [vc.delegateSubject subscribeNext:^(id  _Nullable x) {
        NSLog(@" ---- %@",x);
    }];//订阅信号
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)bingRAC{
    //创建信号源 // RACSignal使用步骤：
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"12345"];//发送
        
        [subscriber sendCompleted];//发送完成
        
        return  [RACDisposable disposableWithBlock:^{
            NSLog(@" ---- 信号被销毁");
        }];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@" ---- %@",x);
    }];//订阅d信号
//RACSubscriber:表示订阅者的意思，用于发送信号，这是一个协议，不是一个类，只要遵守这个协议，并且实现方法才能成为订阅者。通过create创建的信号，都有一个订阅者，帮助他发送数据。
//RACDisposable:用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候，就会自动触发它。使用场景:不想监听某个信号时，可以通过它主动取消订阅信号。
    
// RACSubject:RACSubject:信号提供者，自己可以充当信号，又能发送信号。使用场景:通常用来代替代理，有了它，就不必要定义代理了。
    
  //RACReplaySubject:重复提供信号类，RACSubject的子类。
    /*
     RACReplaySubject与RACSubject区别:

     RACReplaySubject可以先发送信号，在订阅信号，RACSubject就不可以。
     使用场景一:如果一个信号每被订阅一次，就需要把之前的值重复发送一遍，使用重复提供信号类。

     使用场景二:可以设置capacity数量来限制缓存的value的数量,即只缓充最新的几个值。
     RACSubject和RACReplaySubject简单使用:

     */
    RACSubject *subject = [RACSubject subject];//创建信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@" -----   RACSubject1 %@",x);
    }];//订阅d信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@" -----   RACSubject2 %@",x);

    }];
    [subject sendNext:@"1"];
    sleep(1);
    [subject sendNext:@"2"];

    
    RACReplaySubject *replaysubject = [RACReplaySubject subject];
    [replaysubject sendNext:@"1"];
    [replaysubject sendNext:@"2"];
    
    [replaysubject subscribeNext:^(id  _Nullable x) {
        NSLog(@" -----    %@",x);
    }];//订阅

    // 订阅信号
    [replaysubject subscribeNext:^(id x) {

        NSLog(@"---------    %@",x);
    }];
    
    
    /*
     *RACTuple:元组类,类似NSArray,用来包装值
     RACSequence:RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典。
     .****/
    
    
    /*
     RACCommand:RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。

     使用场景:监听按钮点击，网络请求

     */
    
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"执行命令");
        
        RACSignal *sinal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"RACCommand"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@" -----  完成后 销毁信号");
            }];
        }];
        return sinal;
    }];
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id x) {
            
            NSLog(@"%@",x);
        }];
    }];//订阅信号
    // 4.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
       [[command.executing skip:1] subscribeNext:^(id x) {
           
           if ([x boolValue] == YES) {
               // 正在执行
               NSLog(@"正在执行");
               
           }else{
               // 执行完成
               NSLog(@"执行完成");
           }
       }];
      // 5.执行命令
       [command execute:@1];
      
//    ReactiveCocoa开发中常见用法

}

@end
