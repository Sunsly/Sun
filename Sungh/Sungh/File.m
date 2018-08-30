//
//  File.m
//  Sungh
//
//  Created by yonyouqiche on 2018/7/10.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "File.h"

@implementation File
/*
 NSLineBreakByWordWrapping = 0 //以空格为界，保留整个单词。
 
 NSLineBreakByCharWrapping //保留整个字符
 
 NSLineBreakByClipping //简单剪裁，到边界为止
 
 NSLineBreakByTruncatingHead //前面部分文字以……方式省略，显示尾部文字内容
 
 NSLineBreakByTruncatingTail //结尾部分的内容以……方式省略，显示头的文字内容。
 
 NSLineBreakByTruncatingMiddle //中间的内容以……方式省略，显示头尾的文字内容。
 */

/*
 dismiss 到跟视图
 UIViewController *rootVC = self.presentingViewController;
 while (rootVC.presentingViewController) {
 rootVC = rootVC.presentingViewController;
 }
 [rootVC dismissViewControllerAnimated:YES completion:nil];

 
 pop到跟视图
 
 UIViewController *target = nil;
 for (UIViewController * controller in self.navigationController.viewControllers) { //遍历
 if ([controller isKindOfClass:[YYOUUserInfoEditController class]]) { //这里判断是否为你想要跳转的页面
 target = controller;
 }
 }
 if (target) {
 [self.navigationController popToViewController:target animated:YES]; //跳转
 }
 
 */

/*
 plist 网络https  访问权限
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSAllowsArbitraryLoads</key>
 <true/>
 </dict>
 
 <key>NSCameraUsageDescription</key>
 <string>App需要您的同意,才能访问相机</string>
 <key>NSLocationAlwaysUsageDescription</key>
 <string>App需要您的同意,才能始终访问位置</string>
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>App需要您的同意,才能在使用期间访问位置</string>
 <key>NSMicrophoneUsageDescription</key>
 <string>App需要您的同意,才能访问麦克风</string>
 <key>NSPhotoLibraryUsageDescription</key>
 <string>App需要您的同意,才能访问相册</string>
 
 */
@end
