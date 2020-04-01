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
    self.view.backgroundColor = [UIColor whiteColor];
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
    [RACObserve(self.view, center) subscribeNext:^(id x) {
        NSLog(@" ------ %@",x);
        @strongify(self)
    }];
    
    
}
- (void)addTap:(UIGestureRecognizer *)tap{
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    if (self.delegateSubject) {
//        [self.delegateSubject sendNext:@"代替代理"];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
