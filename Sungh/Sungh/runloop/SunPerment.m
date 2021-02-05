//
//  SunPerment.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/4.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "SunPerment.h"
#import "SunThread.h"

@interface SunPerment()

@property (nonatomic,strong)SunThread *innerThread;
@property (nonatomic,assign)BOOL isstop;

@end


@implementation SunPerment

-(instancetype)init{
    if (self = [super init]) {
        self.isstop = NO;
        __weak typeof(self)weakself = self;
        self.innerThread = [[SunThread alloc]initWithBlock:^{
            NSLog(@" ------- %s ---- %@",__func__,[NSThread currentThread]);
            [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    //        [[NSRunLoop currentRunLoop]run];
            while (weakself && !weakself.isstop) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
            NSLog(@" ---------end ---%s",__func__);
        }];
//        [self.innerThread start];
    }
    return self;
}
-(void)run{
    [self.innerThread start];
}

-(void)excuteTaskBlock:(void (^)(void))task{
    
    if (self.innerThread == nil || task == nil) {
        return;
    }
    [self performSelector:@selector(__executeTsak:) onThread:self.innerThread withObject:task waitUntilDone:NO];

}
-(void)stop{
    if (self.innerThread == nil) {
        return;
    }
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}


- (void)__stop{
    self.isstop = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
    
}

- (void)__executeTsak:(void(^)(void))task{
    task();
}
-(void)dealloc{
    [self stop];
    NSLog(@" -------%s",__func__);
}
@end
