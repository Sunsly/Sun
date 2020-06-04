//
//  SubjectsViewModels.m
//  Sungh
//
//  Created by yonyouqiche on 2020/5/14.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "SubjectsViewModels.h"
#import "SubjectsModels.h"
@implementation SubjectsViewModels
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
}
-(void)bindTableViewData{
    NSString *param = @"";//在这里拼接参数
    @weakify(self)
      [NetWorkingRequest get:self.url param:param success:^(id  _Nonnull response) {
          @strongify(self)
            SubjectsModels *model = [SubjectsModels mj_objectWithKeyValues:response];
          [self.successObject sendNext:model];
      } failure:^(NSError * _Nonnull error) {
          [self.failObject sendNext:error];
      }];
}
@end
