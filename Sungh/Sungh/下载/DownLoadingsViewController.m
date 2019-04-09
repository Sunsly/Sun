//
//  DownLoadingsViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2019/4/9.
//  Copyright © 2019年 yonyouqiche. All rights reserved.
//

#import "DownLoadingsViewController.h"

@interface DownLoadingsViewController ()
{
    // 下载句柄
    NSURLSessionDownloadTask *_downloadTask;
}
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@end

@implementation DownLoadingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"下载";

    
    
    NSURL *url = [NSURL URLWithString:@"https://www.apple.com/105/media/cn/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-cn-20170912_1280x720h.mp4"];
    
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];//
    
    
}



@end
