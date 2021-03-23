//
//  LibViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/3/16.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "LibViewController.h"

@interface LibViewController ()

@end

@implementation LibViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
/*
 clang -ccc-print-phases
 
 
 +- 0: input, "main.m", objective-c
            +- 1: preprocessor, {0}, objective-c-cpp-output
         +- 2: compiler, {1}, ir
      +- 3: backend, {2}, assembler
   +- 4: assembler, {3}, object
+- 5: linker, {4}, image
6: bind-arch, "x86_64", {5}, image
 
 
 
 
 源代码 => 预处理器 => 编译器 => 汇编 => 机器码 => 链接 => 可执行文件
 
 如果静态库中有category类，则在使用静态库的项目配置中【Other Linker Flags】需要添加参数【-ObjC]或者【-all_load】。

 如果使用framework的使用出现【Umbrella header for module 'XXXX' does not include header 'XXXXX.h'】,是因为错把xxxxx.h拖到了public中。

 如果出现【dyld: Library not loaded:XXXXXX】，是因为打包的framework版本太高。比如打包framework时，选择的是iOS 9.0，而实际的工程环境是iOS 8开始的。需要到iOS Deployment Target设置对应版本。

 如果创建的framework类中使用了.dylib或者.tbd，首先需要在实际项目中导入.dylib或者.tbd动态库，然后需要设置【Allow Non-modular Includes ....】为YES，否则会报错"Include of non-modular header inside framework module"。

 有时候我们会发现在使用的时候加载不了动态Framework里的资源文件，其实是加载方式不对，比如用pod的时候使用的是use_frameworks!，那么资源是在Framework里面的，需要使用以下代码加载（具体可参考给pod添加资源文件）：

 */

@end
