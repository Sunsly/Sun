//
//  NetWorkViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/3/23.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "NetWorkViewController.h"
#import <UIImageView+WebCache.h>
#import "NSFileTool.h"
@interface NetWorkViewController ()

@end

@implementation NetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    
    [image sd_setImageWithURL:[NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fp1-q.mafengwo.net%2Fs7%2FM00%2F25%2FE2%2FwKgB6lPh4UeARKPpAABh4pruLDc72.jpeg%3FimageMogr2%252Fthumbnail%252F%21310x207r%252Fgravity%252FCenter%252Fcrop%252F%21310x207%252Fquality%252F90&refer=http%3A%2F%2Fp1-q.mafengwo.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1619158050&t=f760005c5ba5572078855939060af89b"]];
    
    [self.view addSubview:image];

//
    NSLog(@" ----- %@",[NSFileTool documentPathFile:@""]);
    NSLog(@" ----- %@",[NSFileTool libraryCacheFilePath:@""]);
    NSLog(@" ----- %@",[NSFileTool libraryFilePath:@""]);

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",nil];
    [manager GET:@"https://www.baidu.com/"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task,
                   id  _Nullable responseObject) {
             NSLog(@"%@", responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task,
                   NSError * _Nonnull error) {
             
         }];
    [manager GET:@"https://www.baidu.com/"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task,
                   id  _Nullable responseObject) {
             NSLog(@"%@", responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task,
                   NSError * _Nonnull error) {
             
         }];
    [manager GET:@"https://www.baidu.com/"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task,
                   id  _Nullable responseObject) {
             NSLog(@"%@", responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task,
                   NSError * _Nonnull error) {
             
         }];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://www.jianshu.com/p/572ce4fb4e66"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"NSURLSessionConfiguration -----------    %@",dict);
    }];
    [dataTask resume];

    
        
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    static int umnb = 0;
    NSLog(@" ---- %d",umnb++);
    
}
/** 注释
    TCP/IP
 
 A
 
 B
 
 TCP 面向数据流
 
 连接
 A ->SYN（i） 同步数据包     B ->ACK(k) +SYN(i+1)        A-> ACK(K+1)
 
 
 断开连接
 A-> FIN(i)     B-> ACK(i+1)
 B ->FIN(k)   A-> ACK(k+1)
 面向连接的可靠的协议
 
 
 
 不可靠的
 用户数据报协议    面向应用层报文
 UDP
 
 
 
 区别：
 首先呢，两者都是TCP/IP结构中 运输层中的协议
 UDP 是用户数据报协议
 TCP是传输控制协议
 
 区别：1，UDP 不需要建立链接  TCP 三次握手的链接
      2.UDP 多播，广播  TCP 是仅仅支持单播
 3.UDP 是面向报文，不会对传输的数据进行拆分合并  TCP是面向字节流
 4.UDP 开销小 （首部8个字节）  TCP 开销较大
 5.UDP数据可能会发生丢失，发送数据大  TCP 面向连接的可靠传输 服务  文件传输
 */
//MARK:业务处理相关方法
//FIXME:参数不正确时会导致崩溃
//TODO:需要记录操作日志
@end
