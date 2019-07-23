//
//  JSAndOCViewController.h
//  Sungh
//
//  Created by yonyouqiche on 2018/7/5.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WebUrlTypeLocation,//本地
    WebUrlTypeNet//网络
} WebUrlType;
@interface JSAndOCViewController : UIViewController

@property (nonatomic,assign)WebUrlType type;

@end
