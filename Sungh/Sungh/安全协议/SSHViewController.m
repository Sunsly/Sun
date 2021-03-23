//
//  SSHViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/8/13.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "SSHViewController.h"

@interface SSHViewController ()

@end

@implementation SSHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
/*
 SSH 安全协议
 openssh
 
 
 客户端请求  -> 服务端（服务端将非对称公钥传输给客户端）
 
 客户端 随机生成一个用于对称加密的密钥x  用公钥加密后 传给服务端
 服务端拿到加密后的 信息 用私钥进行解密得到密钥x
 这样双方都拥有密钥x  且别人无法知道他
 
 
 
 ca数字签名制作过程
 
 ca拥有非对称加密的公钥和私钥
 ca对证书铭文信息进行hash

 对hash后的值进行私钥加密 得到数字签名




 
 */


@end
