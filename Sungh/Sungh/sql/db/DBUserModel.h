//
//  DBUserModel.h
//  Sungh
//
//  Created by yonyouqiche on 2018/7/18.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface DBUserModel : BaseModel

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *hei;
@property (nonatomic,copy)NSString *wei;
@property (nonatomic,copy)NSString *age;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *school;

//@property (nonatomic,copy)NSString *

@end
