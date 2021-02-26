//
//  TestDemo.m
//  iOS-LockDemo
//
//  Created by yonyouqiche on 2021/1/26.
//  Copyright © 2021 yongzhen. All rights reserved.
//

#import "TestDemo.h"


@interface TestDemo()
@property (nonatomic,copy,readwrite,nonnull)NSString *string;

@end

@implementation TestDemo


-(instancetype)init{
    self =  [super init];
    if (self) {
        self.string = @"sun";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.testBlocl) {
                self.testBlocl();
            };
        });
        
    }
    return self;
    
}
//
//-(NSString *)nickName{
//    return @"name";
//}
//
//-(void)sleep{
//    
//}
//- (void)study{
//    
//}
@end
