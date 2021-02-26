//
//  TomPerson.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/23.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "TomPerson.h"

@implementation TomPerson
//NSCoding协议方法：将需要归档的属性进行归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

//NSCoding协议方法：将需要解档的属性进行解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    
    return self;
}

//重写description方法，方便直接打印对象
- (NSString *)description {
    return [NSString stringWithFormat:@"person.name=%@,person.age=%zd,person.height=%f",self.name,self.age,self.height];
}

@end
