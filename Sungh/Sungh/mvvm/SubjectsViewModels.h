//
//  SubjectsViewModels.h
//  Sungh
//
//  Created by yonyouqiche on 2020/5/14.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubjectsViewModels : NSObject

@property (nonatomic,strong)RACSubject *successObject;//创建绑定信号源
@property (nonatomic,strong)RACSubject *failObject;//创建失败绑定信号源


@property (nonatomic,assign)NSInteger page;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,copy)NSString *phone;


-(void)bindTableViewData;

@end

NS_ASSUME_NONNULL_END
