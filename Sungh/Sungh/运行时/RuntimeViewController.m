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

/*
 
 1.动态改变成员变量值
 2.动态交换方法
 3.动态添加方法
 4.属性扩展
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self test];
}
- (void)test{
    MethodTest *tes = [[MethodTest alloc]init];
//    [tes test];
////    [tes performSelector:@selector(eats)];
    
    unsigned count = 0;
    
    Ivar *ivar = class_copyIvarList([MethodTest class], &count);
    
    for (int i = 0; i < count; i++) {
        
        Ivar var = ivar[i];
        
        const char *ivarname = ivar_getName(var);
        
        NSString *name = [NSString stringWithUTF8String:ivarname];
        
        
        NSLog(@" ---- %@",name);
        
    }
    
    
    
}

- (void)addMethods{
    MethodTest *tes = [[MethodTest alloc]init];
// "v@:@"  v表示void  @表示id  :表示方法 SEL
    class_addMethod([tes class], @selector(runs:), (IMP)runsMethod, "v@:@");
}
void runsMethod(NSString *miles)
{
    
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
