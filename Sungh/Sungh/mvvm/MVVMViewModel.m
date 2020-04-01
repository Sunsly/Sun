//
//  MVVMModelView.m
//  Sungh
//
//  Created by yonyouqiche on 2020/3/31.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "MVVMViewModel.h"

@implementation MVVMViewModel
-(instancetype)init{//https://github.com/wujunyang/MVVMReactiveCocoaDemo
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (void)initialize{
        self.successObject = [RACSubject subject];
        self.failObject = [RACSubject subject];
        self.model = [MVVMModel new];
}
//
-(void)exchangeData{
    @weakify(self);
    [self.model getDataSuccess:^(id  _Nonnull responseObject) {
        @strongify(self);
        [self.successObject sendNext:responseObject];
    } fail:^(id  _Nonnull resopnseObject) {
        [self.failObject sendNext:resopnseObject];
    }];
}

@end
