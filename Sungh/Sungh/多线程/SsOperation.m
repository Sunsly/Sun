//
//  SsOperation.m
//  Sungh
//
//  Created by yonyouqiche on 2019/8/13.
//  Copyright © 2019 yonyouqiche. All rights reserved.
//

#import "SsOperation.h"

@implementation SsOperation
//自定义NSOperation的子类
/**
 * 需要执行的任务
 */
-(void)main{
    for (int i = 0; i < 2; i++) {
        NSLog(@"NSOperation的子类中 --- - %@",[NSThread currentThread]);
    }
}
@end
