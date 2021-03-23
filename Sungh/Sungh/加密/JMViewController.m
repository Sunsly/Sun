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
- (void)loadView{
    [super loadView];
    NSLog(@" --- %s",__func__);
}
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
     
     
     
     RSA 非对称 加密算法：算法是公开的，特点
     公钥加密，私钥解密
     私钥加密，公钥解密
     破解的方式 因式分解
     
     哈希函数：哈希函数常见的算法
     MD5、SHA1、SHA256/512(SHA1、SHA256/512这几个底部原理都是一样的只是，加密强度不一样而已)
     
     
     
     ***
     数据进行MD5(SHA1)签名，得到一个和商品信息唯一相关的字符串，然后对改商品字符串进行加密，
     加密之后将这个字符串
     
     *
     
     *
     
     
     
     */
}
@end
