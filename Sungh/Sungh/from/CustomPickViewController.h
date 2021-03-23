//
//  CustomPickViewController.h
//  CarNetworkingModule
//
//  Created by yy on 2021-03-2.
//  Copyright (c) 2021年 yy. All rights reserved.
//

#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    PickViewDefault,//
    PickViewTFTypeSZ,
    PickViewTFTypeDG

} CustomPickViewType;

@interface CustomPickViewController : UIViewController

@property (nonatomic,assign)CustomPickViewType pickViewType;
@property(nonatomic,strong)NSMutableArray *dataSouce;
@property (nonatomic,copy)void(^pickBlock)(NSString *string);
@property (nonatomic,copy)void(^dismissBlock)();

@end

NS_ASSUME_NONNULL_END
