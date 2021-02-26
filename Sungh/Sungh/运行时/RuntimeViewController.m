//
//  RuntimeViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/4.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "MethodTest.h"
@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self test];
}
- (void)test{
    MethodTest *tes = [[MethodTest alloc]init];
    [tes test];
    [tes performSelector:@selector(eats)];
    
}
/*
 runtime 是什么 是一种运行机制
 怎么通过runtime 找到 方法
 每一个对象生成之后，他的底层实现原理都是会生成一个结构体， 结构体中包含 isa 指针，
 通过isa指针找到对象所属的类，在类的方法列表查找方法，
 
 方法交换
 
 动态添加方法
 
 动态添加属性
 
 
 
 */
- (void)dealloc
{
    
}
@end
