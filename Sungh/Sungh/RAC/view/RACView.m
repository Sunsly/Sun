//
//  RACView.m
//  Sungh
//
//  Created by yonyouqiche on 2019/4/19.
//  Copyright © 2019年 yonyouqiche. All rights reserved.
//

#import "RACView.h"

@implementation RACView

<<<<<<< Updated upstream
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self btnClick];
}
- (void)btnClick{
}
-(void)start{
    
    
}

-(RACSignal *)signal{
    if (_signal == nil) {
        _signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"ces"];
            [subscriber sendCompleted];
            
        return   [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }
    return _signal;
}
=======
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
>>>>>>> Stashed changes

@end
