//
//  JMViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/10/13.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "JMViewController.h"

@interface JMViewController ()

@end

@implementation JMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加密";
    self.view.backgroundColor = [UIColor whiteColor];
    /*
     常见的iOS代码加密常用加密方式包括Base64加密、MD5加密、AES加密、RSA加密等
      
     base64  是从二进制到字符的过程  是一种常见的编码方式
     是一种编码方式 不是加密  编码后会增加字节数 ，变为原来的4/3
     可逆  解码方便
     
     md5 不可逆的加密
     */
}
@end
