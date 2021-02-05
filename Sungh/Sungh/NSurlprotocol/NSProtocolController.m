//
//  NSProtocolController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/2.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "NSProtocolController.h"

@interface NSProtocolController ()

@end

@implementation NSProtocolController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = webView;
    NSURL *url = [NSURL URLWithString:@"http://www.jianshu.com/p/ec5d6c204e17"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
