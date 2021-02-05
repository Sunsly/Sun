//
//  ViewController.h
//  Sungh
//
//  Created by yonyouqiche on 2018/6/25.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol delegatetest <NSObject>

@required
- (void)func:(NSString *)str;

@end

@interface ViewController : UIViewController


@end

