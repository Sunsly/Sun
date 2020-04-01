//
//  MVVMModelView.h
//  Sungh
//
//  Created by yonyouqiche on 2020/3/31.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "MVVMModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVVMViewModel : NSObject
@property (nonatomic,strong)RACSubject *successObject;//创建绑定信号源
@property (nonatomic,strong)RACSubject *failObject;//创建失败绑定信号源

@property (nonatomic,strong)MVVMModel *model;//model 数据
-(void)exchangeData;//发送信号



@end

NS_ASSUME_NONNULL_END
