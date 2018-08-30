//
//  BaseModel.m
//  Sungh
//
//  Created by yonyouqiche on 2018/7/19.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key{
    if (value == nil) {
        [super setValue:@"" forKey:key];
    }
    else if ([value isKindOfClass:[NSNull class]]){
        [super setValue:@"" forKey:key];
    }
    
    else{
        [super setValue:value forKey:key];
    }
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end
