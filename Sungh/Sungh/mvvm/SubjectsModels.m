//
//  SubjectsModels.m
//  LXProjectSpecification
//
//  Created by yonyouqiche on 2020/5/14.
//

#import "SubjectsModels.h"

@implementation SubjectsModels

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"subjects":[RatingModels class]};
}
@end

@implementation RatingModels

+(NSDictionary *)mj_objectClassInArray{
        return @{@"directors":[DirectorsModel class]};
}

@end

@implementation MaxModels

@end

@implementation DirectorsModel

@end

@implementation AvatarsModel

@end
