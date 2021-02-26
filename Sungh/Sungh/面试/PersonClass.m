//
//  PersonClass.m
//  ms
//
//  Created by yonyouqiche on 2020/11/24.
//  Copyright © 2020 sunly. All rights reserved.
//

#import "PersonClass.h"

@implementation PersonClass
- (void)sep{
    
    NSMutableDictionary *dic;
    [dic setObject:nil forKey:@"age"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    
    NSMutableArray *arr;
    void(^bl)(void) =^{
        [arr addObject: @"1"];
    };
    bl();
    
}
@end
