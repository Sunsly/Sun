//
//  SubjectsModels.h
//  LXProjectSpecification
//
//  Created by yonyouqiche on 2020/5/14.
//

#import <Foundation/Foundation.h>

@class MaxModels;
@class RatingModels;
@class DirectorsModel;
@class AvatarsModel;

NS_ASSUME_NONNULL_BEGIN

@interface SubjectsModels : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong)NSArray *subjects;
@end

@interface RatingModels : NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,assign)NSInteger collect_count;
@property (nonatomic,copy)NSString *year;
@property (nonatomic,strong)MaxModels *rating;
@property (nonatomic,strong)NSArray *genres;
@property (nonatomic,strong)NSArray *directors;

@end
@interface MaxModels : NSObject

@property (nonatomic,copy)NSString *stars;
@property (nonatomic,assign)NSInteger max;
@property (nonatomic,assign)NSInteger average;

@end

@interface DirectorsModel : NSObject

@property (nonatomic,copy)NSString *name_en;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *alt;
@property (nonatomic,strong)AvatarsModel *avatars;

@end

@interface AvatarsModel : NSObject
@property (nonatomic,copy)NSString *small;
@property (nonatomic,copy)NSString *large;
@property (nonatomic,copy)NSString *medium;

@end


NS_ASSUME_NONNULL_END
