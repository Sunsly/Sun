//
//  File.m
//  Sungh
//
//  Created by yonyouqiche on 2018/7/10.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "File.h"

//定义通用枚举 NSWritingDirectionNatural

typedef NS_ENUM(NSUInteger, LookingType) {
    LookTypeDefault,
    LookTypeDown,
    LookTypeUp
};

//定义  位移枚举 位移枚举即是在你需要的地方可以同时存在多个枚举值
//UISwipeGestureRecognizerDirectionDown
typedef NS_OPTIONS(NSUInteger, SeeingType) {
    SeeingTypeDefaule = 1 << 0,
    SeeingTypeDown = 1 << 1,
    SeeingTypeUp = 1 << 2,
};
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

/*
 模态推出透明界面
 
 UIModalPresentationFullScreen =0,//由下到上,全屏覆盖
 UIModalPresentationPageSheet,//在portrait时是FullScreen，在landscape时和FormSheet模式一样。
 UIModalPresentationFormSheet,// 会将窗口缩小，使之居于屏幕中间。在portrait和landscape下都一样，但要注意landscape下如果软键盘出现，窗口位置会调整。
 UIModalPresentationCurrentContext,//这种模式下，presented VC的弹出方式和presenting VC的父VC的方式相同。
 UIModalPresentationCustom,//自定义视图展示风格,由一个自定义演示控制器和一个或多个自定义动画对象组成。符合UIViewControllerTransitioningDelegate协议。使用视图控制器的transitioningDelegate设定您的自定义转换。
 UIModalPresentationOverFullScreen,//如果视图没有被填满,底层视图可以透过
 UIModalPresentationOverCurrentContext,//视图全部被透过
 UIModalPresentationPopover,
 UIModalPresentationNone ,
 
 
 UIViewController *vc = [[UIViewController alloc] init];
 UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
 
 if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
 {
 na.modalPresentationStyle = UIModalPresentationOverCurrentContext;
 }
 else
 {
 self.modalPresentationStyle=UIModalPresentationCurrentContext;
 }
 
 [self presentViewController:na animated:YES completion:nil];
 */

/*
 iOS跳转到App Store下载应用评分
 
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APPID"]];

 */
/*
 判断当前ViewController是push还是present的方式显示的
 
 NSArray *viewcontrollers=self.navigationController.viewControllers;
 
 if (viewcontrollers.count > 1)
 {
 if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self)
 {
 //push方式
 [self.navigationController popViewControllerAnimated:YES];
 }
 }
 else
 {
 //present方式
 [self dismissViewControllerAnimated:YES completion:nil];
 }
 */

/*
 修改UITextField中Placeholder的文字颜色
 
 [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
 */
/*
 关于NSDateFormatter的格式
 
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S: 毫秒
 */
/*
 Base64编码与NSString对象或NSData对象的转换
 // Create NSData object
 NSData *nsdata = [@"iOS Developer Tips encoded in Base64"
 dataUsingEncoding:NSUTF8StringEncoding];
 
 // Get NSString from NSData object in Base64
 NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
 
 // Print the Base64 encoded string
 NSLog(@"Encoded: %@", base64Encoded);
 
 // Let's go the other way...
 
 // NSData from the Base64 encoded str
 NSData *nsdataFromBase64String = [[NSData alloc]
 initWithBase64EncodedString:base64Encoded options:0];
 
 // Decoded NSString from the NSData
 NSString *base64Decoded = [[NSString alloc]
 initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
 NSLog(@"Decoded: %@", base64Decoded);
 */
/*
 给UIView设置图片
 
 UIImage *image = [UIImage imageNamed:@"image"];
 self.MYView.layer.contents = (__bridge id _Nullable)(image.CGImage);
 self.MYView.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
 */
/*
 dispatch_group的使用
 
 dispatch_group_t dispatchGroup = dispatch_group_create();
 dispatch_group_enter(dispatchGroup);
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 NSLog(@"第一个请求完成");
 dispatch_group_leave(dispatchGroup);
 });
 
 dispatch_group_enter(dispatchGroup);
 
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 NSLog(@"第二个请求完成");
 dispatch_group_leave(dispatchGroup);
 });
 
 dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
 NSLog(@"请求完成");
 });*/

/*
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 {
 // 四位加一个空格
 if ([string isEqualToString:@""])
 {
 // 删除字符
 if ((textField.text.length - 2) % 5 == 0)
 {
 textField.text = [textField.text substringToIndex:textField.text.length - 1];
 }
 return YES;
 }
 else
 {
 if (textField.text.length % 5 == 0)
 {
 textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
 }
 }
 return YES;
 }
 */
/*
 
 find . "(" -name "*.m" -or -name "*.mm" -or -name "*.cpp" -or -name "*.h" -or -name "*.rss" ")" -print | xargs wc -l
 
 查询代码行数
 
 */

#pragma mark  数组去重
/*
 
 开辟新的内存空间
 NSArray *originalArr = @[@1, @2, @3, @1, @3];
 NSMutableArray *resultArrM = [NSMutableArray array];
 
 for (NSString *item in originalArr) {
 if (![resultArrM containsObject:item]) {
 [resultArrM addObject:item];
 }
 }
 NSLog(@"result : %@", resultArrM);
 
 
 
 利用NSDictionary的AllKeys（AllValues）方法
 
 NSArray *originalArr = @[@1, @2, @3, @1, @3];
 NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
 for (NSNumber *n in originalArr) {
 [dict setObject:n forKey:n];
 }
 NSLog(@"%@",[dictM allValues]);
 
 利用NSSet特性, 放入集合自动去重
 NSArray *originalArr = @[@1, @2, @3, @1, @3];
 NSSet *set = [NSSet setWithArray:originalArr];
 NSLog(@"result: %@", [set allObjects]);
 
 通过valueForKeyPath, 去重只需一行代码
 NSArray *originalArr = @[@1, @2, @3, @1, @3];
 NSArray *result = [originalArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
 */
@end
