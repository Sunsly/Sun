//
//  SOAComponentAppDelegate.m
//  Sungh
//
//  Created by yonyouqiche on 2019/8/12.
//  Copyright © 2019 yonyouqiche. All rights reserved.
//

#import "SOAComponentAppDelegate.h"
#import "SServiceManager.h"

@implementation SOAComponentAppDelegate


{
    NSMutableArray *allServices;
}

//需要运行程序之前，手工增加根据需要的新服务

-(void)registeServices
{
    [self registeService:[[SServiceManager alloc] init]];
    
}

#pragma mark - 获取单利

+(instancetype)instance{
    static SOAComponentAppDelegate *insance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        insance = [[SOAComponentAppDelegate alloc]init];
    });
    return insance;
}


#pragma mark - 获取全部服务
-(NSMutableArray *)services
{
    
    if (!allServices) {
        allServices = [[NSMutableArray alloc]init];
        [self registeServices];
    }
    
    return allServices;
}

#pragma mark - 服务动态注册
-(void)registeService:(id)service
{
    if (![allServices containsObject:service])
    {
        [allServices addObject:service];
    }
}
@end
