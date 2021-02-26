//
//  Pet.h
//  Sungh
//
//  Created by yonyouqiche on 2021/2/23.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TomPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface Pet : NSObject<NSCoding>

@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong) TomPerson*master;

@end

NS_ASSUME_NONNULL_END
