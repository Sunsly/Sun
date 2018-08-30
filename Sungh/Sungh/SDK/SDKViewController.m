//
//  SDKViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2018/8/1.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "SDKViewController.h"

@interface SDKViewController ()

@end

@implementation SDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/*
 打包sdk framework
 1.创建 xcode 的工作空间workspace
 2.在工作空间的基础上 创建一个project 工程  选择 cocoa touch framework 选项 （add to group 在该空间内）；
 3.在空间sdk中 添加需要 封装的代码
 4.在build  setting 的  all combined 中 找到  linking 下面的 mach- o type  选择 static library
 5.architectures 下面 找到 buide aactive architecture only 设置为 no
 6.找到 architectures  添加 armv7s
 7.在build phases 下 找到 headers  将需要暴露在外面的头文件 放到 public 一栏
 8.将sdk中的.h文件导入到***SDK 例如 #import <***SDK/*****.H>
 9.选中sdk的工作空间，在xcode的标题栏 上面 找到 editor ，添加target  - 选择cross-platform 一栏下的aggregate （命名随便）
 创建结束后 选中刚创建的aggregate  选择build phases -> new run script phase  添加脚本
 
 *****************
 # Sets the target folders and the final framework product.
 # 如果工程名称和Framework的Target名称不一样的话，要自定义FMKNAME
 
 # 例如: FMK_NAME ="MyFramework"
 
 FMK_NAME=${PROJECT_NAME}
 
 # Install dir will be the final output to the framework.
 
 # The following line create it in the root
 
 folder of the current project.
 
 INSTALL_DIR=${SRCROOT}/Products/${FMK_NAME}.framework
 
 # Working dir will be deleted after the framework creation.
 
 WRK_DIR=build
 
 DEVICE_DIR=${WRK_DIR}/Release-iphoneos/${FMK_NAME}.framework
 
 SIMULATOR_DIR=${WRK_DIR}/Release-iphonesimulator/${FMK_NAME}.framework
 
 # -configuration ${CONFIGURATION}
 
 # Clean and Building both architectures.
 
 xcodebuild -configuration "Release" -target"${FMK_NAME}" -sdk iphoneos clean build
 
 xcodebuild -configuration "Release" -target"${FMK_NAME}" -sdk iphonesimulator clean build
 
 # Cleaning the oldest.
 
 if [ -d "${INSTALL_DIR}" ]
 
 then
 
 rm -rf "${INSTALL_DIR}"
 
 fi
 
 mkdir -p "${INSTALL_DIR}"
 
 cp -R "${DEVICE_DIR}/""${INSTALL_DIR}/"
 
 # Uses the Lipo Tool to merge both binary files (i386 + armv6/armv7) into one Universal final product.
 
 lipo -create "${DEVICE_DIR}/${FMK_NAME}""${SIMULATOR_DIR}/${FMK_NAME}" -output"${INSTALL_DIR}/${FMK_NAME}"
 
 rm -r "${WRK_DIR}"
 
 open "${INSTALL_DIR}"
 
 *******************
 
 10.commond b 编辑 sdk工作空间  然后finder 中就可以找到sdk
 //详解
 https://blog.csdn.net/shihuboke/article/details/78450955
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
