//
//  JSAndOCViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2018/7/5.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "JSAndOCViewController.h"
#import <WebKit/WebKit.h>
#import "DBManager.h"
@interface JSAndOCViewController ()<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>
@property (nonatomic,strong)WKWebView *kwebView;
@end

@implementation JSAndOCViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"js&&oc";
    
    [self webViewShow];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //son
    //初始化
}
/*
 1.ios8 之后  更多支持html5 特性
 2.高达60fps的滚动刷新率以及内置手势
 3.estimatedProgress
 */

#pragma mark - > webview 初始化
- (void)webViewShow{
    //配置
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    
    //配置适配
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preferences.minimumFontSize = 40.0;
    //设置是否支持javaScript 默认是支持的
    preferences.javaScriptEnabled = YES;//允许 js 交互
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = YES;

    config.preferences = preferences;
    // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
    config.allowsInlineMediaPlayback = YES;
    //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
    config.mediaTypesRequiringUserActionForPlayback = YES;
    //设置是否允许画中画技术 在特定设备上有效
    config.allowsPictureInPictureMediaPlayback = YES;
    //设置请求的User-Agent信息中应用程序名称 iOS9后可用
    config.applicationNameForUserAgent = @"ChinaDailyForiPad";
    
    
    //添加注册方法 js 调用oc
    WKUserContentController *jsuser =[[WKUserContentController alloc]init];
    [jsuser addScriptMessageHandler:self name:@"Share"];
    [jsuser addScriptMessageHandler:self name:@"Camera"];
    config.userContentController = jsuser;
    
    
    //以下代码适配文本大小，由UIWebView换为WKWebView后，会发现字体小了很多，这应该是WKWebView与html的兼容问题，解决办法是修改原网页，要么我们手动注入JS
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    //用于进行JavaScript注入
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [config.userContentController addUserScript:wkUScript];

    
    
    //window.webkit.messageHandlers.collectSendKey.postMessage({body: 'goodsId=1212'});
    

    self.kwebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, kScrWid, kScrHei-64) configuration:config];
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    self.kwebView.allowsBackForwardNavigationGestures = YES;
    self.kwebView.UIDelegate = self;
    self.kwebView.navigationDelegate = self;
    
    if (self.type == WebUrlTypeLocation) {//本地
        NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"WKWebViewMessageHandler" ofType:@"html"];
        NSString *fileURL = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
        
        [self.kwebView loadHTMLString:fileURL baseURL:baseURL];
    }else{//网页
        [self.kwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    }

    [self.view addSubview:self.kwebView];
    
    
    [self.kwebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];//监听 webvie的 加载进度
    
}
#pragma mark - > 监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
}
#pragma mark - > dealloc
- (void)dealloc
{
    
    [self.kwebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.kwebView.configuration.userContentController removeScriptMessageHandlerForName:@"Share"];
    [self.kwebView.configuration.userContentController removeScriptMessageHandlerForName:@"Camera"];
    
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - > 交互 is 调用oc  body 是js 传给oc 的值
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
    if ([message.name isEqualToString:@"Share"]) {
        NSLog(@"交互交互");
        NSLog(@" - -- -%@",message.body);
        [self addData];
    }
}
#pragma mark --- >oc 传值给 js 调用js
- (void)addData{
    
    NSString *str = [NSString stringWithFormat:@"shareResult('%@','%@','%@')",@"sun",@"内容",@"http"];
    [_kwebView evaluateJavaScript:str completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    }];
}
#pragma mark - >webview

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@" ---- 开始 加载");
}

-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@" ---- 正在加载");
    
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"-----加载完成");
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"-----加载失败");
    
}

-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"接收到服务器重新配置请求之后再执行");
}
// API是根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLRequest * request = navigationAction.request;
    NSLog(@"%@",request.URL.absoluteString);
    // 判断请求头是否是 https://www.baidu.com 如果是就不在请求加载跳转
    WKNavigationActionPolicy  actionPolicy = WKNavigationActionPolicyAllow;
    if ([request.URL.absoluteString hasPrefix:@"https://www.baidu.com"]) {
        
        actionPolicy = WKNavigationActionPolicyCancel;
    }
    // 必须这样执行，不然会崩
    decisionHandler(actionPolicy);
}
// API是根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"%@",navigationResponse.response);
    /**
     *  判断响应的数据里面的URL是https://www.baidu.com/开头的，要是就不让它加载跳转
     */
    WKNavigationResponsePolicy responsePolicy = WKNavigationResponsePolicyAllow;
    if ([navigationResponse.response.URL.absoluteString hasPrefix:@"https://www.baidu.com"]) {
        
        responsePolicy = WKNavigationResponsePolicyCancel;
    }
    decisionHandler(responsePolicy);
}
// 创建方法，这个就不在多说了，重点放在下面几个
-(nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    return nil;
}

// ios 9 之后才有的方法
-(void)webViewDidClose:(WKWebView *)webView
{
    
}

@end

