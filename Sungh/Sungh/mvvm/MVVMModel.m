//
//  MVVMModel.m
//  Sungh
//
//  Created by yonyouqiche on 2020/3/31.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "MVVMModel.h"

@implementation MVVMModel
//网络请求
-(void)getDataSuccess:(void (^)(id _Nonnull))success fail:(void (^)(id _Nonnull))fail{
    NSArray  *result =@[@{@"title":@"我是谁",
                          @"tag":@1,
                        },
                        @{@"title":@"我从哪来",
                          @"img":@2,
                        },
                        @{@"title":@"要到哪去",
                          @"img":@3,
                        }];
    if (result.count>0) {
        success(result);
    }else{
        fail(result);
    }
}
@end
