//
//  CopyViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/12/7.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "CopyViewController.h"
#import "PersonCopy.h"
#import "CopyObject.h"
@interface CopyViewController ()

@end

@implementation CopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"copy&mutabcopy";
    // Do any additional setup after loading the view.


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self copytest2];
}
#pragma mark ------>非容器类
- (void)copytest1{
//    非容器类
#if  1
    NSString *string = @"origionppppppp";
    NSString *stringCopy = [string copy];
    
    NSMutableString *stringMCopy = [string mutableCopy];
    NSLog(@"string -%p    cpoy--%p   mcopy --%p",string,stringCopy,stringMCopy);//对象的内存地址
    //string -0x1097080f8    cpoy--0x1097080f8   mcopy --0x60000140e0d0
    NSLog(@"string -%p    cpoy--%p   mcopy --%p",&string,&stringCopy,&stringMCopy);//指针变量的内存地址；地址的指针

//string -0x7ffee6522a38    cpoy--0x7ffee6522a40   mcopy --0x7ffee6522a30
    [stringMCopy appendString:@"!!"];
    
    NSLog(@"string -%p    cpoy--%p   mcopy --%p",string,stringCopy,stringMCopy);
    
    NSLog(@"string -%p    cpoy--%p   mcopy --%p",&string,&stringCopy,&stringMCopy);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@" ---%@------ %p ----- %p",string,string,&string);

    });
    string = @"kkkkkkkkksakskakskas";
    NSLog(@" --------- %p ----- %p",string,&string);
    
#else
      NSMutableString *string = [NSMutableString stringWithString: @"origionweewwewew"];
      NSString *stringCopy = [string copy];
      NSMutableString *mStringCopy = [string copy];
      NSMutableString *stringMCopy = [string mutableCopy];
    NSLog(@"*****string -%p    cpoy--%p   mcopy --%p",string,stringCopy,stringMCopy);
    NSLog(@"*******string -%p    cpoy--%p   mcopy --%p",&string,&stringCopy,&stringMCopy);
    

#endif
/*   总结：不可变 copy 浅拷贝 只是拷贝了指针的内存地址  有新的指针  指向了同一块对象的内存地址  对象的内存地址不变
    返回的是不可变对象
 mutablecopy 深拷贝 生成了新的指针， 和新的对象的内存地址 ，返回的是可变类型
 可变的  copy 深拷贝 不只拷贝的指针的内存地址，还拷贝的新的对象的内存地址 ，返回的不可变类型
 mytablecopy 深拷贝 ，拷贝了对象的指针地址 和内存地址 ，返回的可变类型
 */
    
}

#pragma mark ------> 容器类
- (void)copytest2{
    
#if  1
    CopyObject *objc = [[CopyObject alloc]init];
    objc.age = @"test";
    NSLog(@"objc ----- %p ------ %p",objc,&objc);
    NSString *copyStr = @"测试copy";
    NSArray *array1 = [NSArray arrayWithObjects:@"a",@"b",@"c",objc,copyStr,nil];
    CopyObject *objc1 =[array1[3] copy];

    CopyObject *objc3 = [objc copy];
    
    objc3.age = @"3";
    NSLog(@" --- %@ -- %@",objc.age,objc3.age);
    
    
    NSArray *arrayCopy1 = [[NSArray alloc]initWithArray:array1 copyItems:YES];
    CopyObject *objc2 =arrayCopy1[3];
    objc2.age = @"1ppp";
    NSLog(@"objc2 ----- %p ------ %p -----%@--%@",objc2,&objc2,objc.age,objc2.age);
    
    NSLog(@" --- %p   %p",array1,arrayCopy1);//内存地址指向的是同一个  指针地址是不同的（新的指针地址）
    NSLog(@" --- %p   %p",&array1,&arrayCopy1);

    NSMutableArray *mArrayCopy1 = [array1 mutableCopy];
    NSLog(@" --- %p %p",mArrayCopy1,array1); //mu 指针的地址  和对象的内存地址均为新生成的
    NSLog(@" --- %p %p",&mArrayCopy1,&array1);
    
    CopyObject *objc4 =mArrayCopy1[3];
    objc4.age = @"objc4";
    
    NSLog(@" ----- %@ ---- %@ --- %@",objc4.age,objc.age,objc1.age);

    
#else
    
#endif
/*
 数组容器：不论是copy 还是mutablecopy 都是浅拷贝 ，并不能拷贝数组中的item
 
 */
    
}
- (void)mutabCopy{

}
/*
 总结：
 当 使用copy的时候 因为str1 str2 都是不可变字符串，指向同一块内存地址，为了性能优化，系统没必要提供新的内存地址 ，只生成了新的指针指向同一块内存地址
 当重新给str1 赋值 因为之前的内容不可变，所系系统会s开辟新的内存地址
 */

@end
