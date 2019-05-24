//
//  RACView.m
//  Sungh
//
//  Created by yonyouqiche on 2019/4/19.
//  Copyright © 2019年 yonyouqiche. All rights reserved.
//

#import "RACView.h"

@implementation RACView

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


@end
