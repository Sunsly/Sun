//
//  SDWebViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/3/17.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "SDWebViewController.h"
#import <UIView+WebCache.h>
#import <UIImageView+WebCache.h>
@interface SDWebViewController ()

@end

@implementation SDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imagev = [[UIImageView alloc]init];
    
    [imagev sd_setImageWithURL:@"" placeholderImage:@"" options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    
    
    
    
}

/** 注释
    
 */
@end
