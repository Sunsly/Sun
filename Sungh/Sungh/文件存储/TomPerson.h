//
//  TomPerson.h
//  Sungh
//
//  Created by yonyouqiche on 2021/2/23.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TomPerson : NSObject<NSCoding>

@property (nonatomic,copy)NSString *name;

@property (nonatomic,assign)NSInteger age;

//有些属性可以不进行归档
@property (nonatomic,assign)CGFloat height;

@end

NS_ASSUME_NONNULL_END
