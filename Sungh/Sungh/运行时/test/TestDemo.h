//
//  TestDemo.h
//  iOS-LockDemo
//
//  Created by yonyouqiche on 2021/1/26.
//  Copyright © 2021 yongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol PersonPro <NSObject>
//
//@required
//@property (nonatomic,copy,readonly)NSString *name;
//
//@optional
//- (void)sleep;
//
//@end
//
//
//@protocol Child <NSObject>
//
//@required
//- (NSString *)nickName;
//@optional
//- (void)study;
//@end

@interface TestDemo : NSObject
@property (nonatomic,copy,readonly,nonnull)NSString *string;
@property (nonatomic,copy)void(^testBlocl)(void);
@end

NS_ASSUME_NONNULL_END
