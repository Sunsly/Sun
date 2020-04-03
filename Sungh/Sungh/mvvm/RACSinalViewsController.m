//
//  RACSinalViewsController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/4/1.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "RACSinalViewsController.h"
#import "ReactiveCocoa/RACReturnSignal.h"
@interface RACSinalViewsController ()//https://github.com/wujunyang/MVVMReactiveCocoaDemo
@property (strong, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) IBOutlet UITextField *textf;
@property (strong, nonatomic) IBOutlet UILabel *lab;

@property (nonatomic,strong)UIView *racView;
@end

@implementation RACSinalViewsController
- (IBAction)click:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
     /*
     rac_signalForSelector：用于替代代理。
     rac_valuesAndChangesForKeyPath：用于监听某个对象的属性改变。
     rac_signalForControlEvents：用于监听某个事件。
     rac_addObserverForName:用于监听某个通知。
     rac_textSignal:只要文本框发出改变就会发出这个信号。
     rac_liftSelector:withSignalsFromArray:Signals:当传入的Signals(信号数组)，每一个signal都至少sendNext过一次，就会去触发第一个selector参数的方法。

     
     */
    self.racView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    self.racView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addTap:)];
    [self.racView addGestureRecognizer:tap];
    [self.view addSubview:self.racView];
    @weakify(self)
    [[self.racView rac_signalForSelector:@selector(addTap:)]subscribeNext:^(id x) {
        @strongify(self)
        self.racView.backgroundColor  = [UIColor orangeColor];
    }];
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        self.racView.backgroundColor = [UIColor redColor];
        
    }];
    [[self.textf rac_textSignal]subscribeNext:^(id x) {
        NSLog(@" -- -- %@",x);
        @strongify(self)

    }];
    // 只要文本框文字改变，就会修改label的文字
    RAC(self.lab,text) = self.textf.rac_textSignal;
    [RACObserve(self.view, backgroundColor) subscribeNext:^(id x) {
        NSLog(@" ------ %@",x);
        @strongify(self)
    }];
    
    self.view.backgroundColor = [UIColor redColor];
//
    [self test1];
    [self test2];
    [self test3];
    [self test4];
    [self test5];
//    [self test6];

}
- (void)addTap:(UIGestureRecognizer *)tap{
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.delegateSubject) {
        [self.delegateSubject sendNext:@"代替代理"];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)test1{
    
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@" --- %@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"发送信号"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"销毁");
            }];
        }];
        
    }];
    RACSignal *signal = [command execute:@"121212"];
    [signal subscribeNext:^(id x) {
        NSLog(@" --------- %@",x);//订阅
    }];
    
}
- (void)test2{
    
    RACCommand *command =[[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@" --- %@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"发送信号"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"---- 销毁");
            }];
            
        }];
        
    }];
    // 方式二：
       // 订阅信号
       // 注意：这里必须是先订阅才能发送命令
       // executionSignals：信号源，信号中信号，signalofsignals:信号，发送数据就是信号
    [command.executionSignals subscribeNext:^(id x) {
        //
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@" executionSignals--- %@",x);
        }];
    }];
    [command execute:@(2)];//发送
    
    
}- (void)test3{
    RACCommand *command =[[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
          
          NSLog(@" --- %@",input);
          return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
              
              [subscriber sendNext:@"发送信号"];
              [subscriber sendCompleted];
              return [RACDisposable disposableWithBlock:^{
                  NSLog(@"---- 销毁");
              }];
              
          }];
          
      }];
      // 方式二：
        //
    // switchToLatest获取最新发送的信号，只能用于信号中信号。

      [command.executionSignals.switchToLatest subscribeNext:^(id x) {
          //
              NSLog(@" switchToLatest--- %@",x);
        
      }];
      [command execute:@(3)];//发送
    
    
}
- (void)test4{
    // 创建信号中信号
    RACSubject *singalofsingal = [RACSubject subject];
    RACSubject *singalA = [RACSubject subject];
    
    [singalofsingal.switchToLatest subscribeNext:^(id x) {
        NSLog(@" ---- %@",x);
    }];//订阅
    [singalofsingal sendNext:singalA];
    [singalA sendNext:@4];
    
}
- (void)test5{
    //注意：当前命令内部发送数据完成，一定要主动发送完成
       // 1.创建命令
       RACCommand *command1 = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
           // block调用：执行命令的时候就会调用
           NSLog(@"%@", input);
           // 这里的返回值不允许为nil
           return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
               // 发送数据
               [subscriber sendNext:@"12345"];
               
               // *** 发送完成 **
               [subscriber sendCompleted];
               return nil;
           }];
       }];
       // 监听事件有没有完成
       [command1.executing subscribeNext:^(id x) {
           if ([x boolValue] == YES) { // 正在执行
               NSLog(@"当前正在执行%@", x);
           }else {
               // 执行完成/没有执行
               NSLog(@"执行完成/没有执行");
           }
       }];
       
       // 2.执行命令
       [command1 execute:@"0"];
    
}
- (void)test6{
    
}

@end
