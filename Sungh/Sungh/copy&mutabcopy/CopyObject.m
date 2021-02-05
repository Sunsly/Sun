//
//  CopyObject.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/3.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "CopyObject.h"

@implementation CopyObject
-(id)copyWithZone:(NSZone *)zone{

    CopyObject *person = [CopyObject allocWithZone:zone];
    person.age = self.age;
    return person;
}
-(id)mutableCopyWithZone:(NSZone *)zone{

    CopyObject *person = [CopyObject allocWithZone:zone];
    person.age = [self.age mutableCopy];
    return person;
}

@end
