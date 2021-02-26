//
//  OnScreenViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/26.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "OnScreenViewController.h"

@interface OnScreenViewController ()

@end

@implementation OnScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//self.view.layer.shouldRasterize
}
/*
 帧缓存区   - 取出 显示
 垂直信号（帧缓存区的信号是否绘制完毕）  双缓存区（交换缓存结果）
 
 掉帧
 渲染耗时过长
 
 离屛渲染 渲染不能一次性渲染
 离屏缓存区
 需要分开渲染  然后合并
 
 单个图层圆角不会离屛渲染
 
 光栅化
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
