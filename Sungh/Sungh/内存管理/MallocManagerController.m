//
//  MallocManagerController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/3/25.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "MallocManagerController.h"

@interface MallocManagerController ()

@end

@implementation MallocManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内存管理";
    self.view.backgroundColor = [UIColor whiteColor];
    [self stringMalloc];
}

#pragma mark ------> 字符串malloc
- (void)stringMalloc{
    //常量区中的字符串只要内容一致, 不会重复创建
    NSString *a0 = @"aaa";
    NSString *a1 = [NSString stringWithString:a0];
    NSString *a2 = [[NSString alloc] initWithString:a0];
    NSString *a3 = [[NSString alloc] initWithFormat:@"%@", a0];
    NSString *a4 = [[NSString alloc] initWithFormat:@"aaa"];
    NSString *a5 = [[NSString alloc] initWithFormat:@"b%@", a0];
    NSString *a6 = [[NSString alloc] initWithString:a5];
    NSString *a7 = [[NSString alloc] initWithString:a3];
NSLog(@"\na0=~~~~%p\na1=~~~~%p\na2=~~~~%p\na3=~~~~%p\na4=~~~~%p\na5=~~~~%p\na6=~~~~%p\na7=~~~~%p", a0, a1, a2, a3, a4, a5, a6, a7);
    a0 = @"1212";
NSLog(@"\na0=~~~~%p\na1=~~~~%p\na2=~~~~%p\na3=~~~~%p\na4=~~~~%p\na5=~~~~%p\na6=~~~~%p\na7=~~~~%p", a0, a1, a2, a3, a4, a5, a6, a7);
    NSString *pl = @"aaa";
    NSLog(@" ---- %p",pl);
    ///堆区中得字符串哪怕内容一致, 也会重复创建
    NSString *str1 = [NSString stringWithFormat:@"lion"];
    NSString *str2 = [NSString stringWithFormat:@"lion"];
       //输出地址相同
       NSLog(@"\n %p \n %p",str1,str2);
   
    /*
     内存地址由低到高分别为:程序区-->数据区-->堆区-->栈区
https://blog.csdn.net/LIN1986LIN/article/details/87907147
     其中堆区分配内存从低往高分配,栈区分配内存从高往低分配
     
    按照产生对象的isa大致可以分为三种情况：

    产生的对象是 __NSCFConstantString
    产生的对象是 __NSCFString
    产生的对象是 NSTaggedPointerString
     oc存储主要分成数据区、堆区和栈区
     ***
     __NSCFConstantString

     字符串常量，是一种编译时常量，它的 retainCount 值很大，是 4294967295，在控制台打印出的数值则是 18446744073709551615==2^64-1，测试证明，即便对其进行 release 操作，retainCount 也不会产生任何变化。是创建之后便是放不掉的对象。相同内容的 __NSCFConstantString 对象的地址相同，也就是说常量字符串对象是一种单例。

     这种对象一般通过字面值 @"..."、CFSTR("...") 或者 stringWithString: 方法（需要说明的是，这个方法在 iOS6 SDK 中已经被称为redundant，使用这个方法会产生一条编译器警告。这个方法等同于字面值创建的方法）产生。
     这种对象存储在字符串常量区。
     __NSCFConstantString显然是常量字符串，地址————————自然就是存储在数据区
     
     
     */
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
