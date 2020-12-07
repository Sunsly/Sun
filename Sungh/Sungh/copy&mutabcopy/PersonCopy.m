//
//  PersonCopy.m
//  Sungh
//
//  Created by yonyouqiche on 2020/12/7.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "PersonCopy.h"

@implementation PersonCopy

-(id)copyWithZone:(NSZone *)zone{
    
    PersonCopy *person = [PersonCopy allocWithZone:zone];
    person.name = self.name;
    return person;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    
    PersonCopy *person = [PersonCopy allocWithZone:zone];
    person.name = self.name;
    return person;
}

@end
