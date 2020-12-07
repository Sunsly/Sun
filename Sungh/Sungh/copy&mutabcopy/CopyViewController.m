//
//  CopyViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/12/7.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "CopyViewController.h"
#import "PersonCopy.h"
@interface CopyViewController ()

@end

@implementation CopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"copy&mutabcopy";
    // Do any additional setup after loading the view.
    
    PersonCopy *per = [[PersonCopy alloc]init];
    per.name = @"sun";
    PersonCopy *per2 = [per copy];
    NSLog(@" -%@-- %p ---%p- %p",per.name,per,per2.name,per2);
    
    per2.name = @"**************";
    
    NSLog(@" -%@-- %p ---%p- %p",per.name,per,per2.name,per2);

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self copytest];
    sleep(3);
    [self mutabCopy];
}
- (void)copytest{
    
    NSString *str1 = @"str1";
    NSString *str2 = [str1 copy];
//    NSString *str3 = str1;
//    str1 = @"66666";
//    str1 = @"233223";
//    重新赋值之后，就相当于创建了新的地址指针
    NSLog(@"\nstr1 = %@ str1P = %p \n str2 = %@ str2P = %p   ", str1, str1, str2, str2);
    str1 = @"pppp";
//不可变 时候修改 原来的数据 h就会生成新的内存地址
    NSLog(@" --- %@ ---- %p",str1,str1);
    
//    NSMutableString *str1 =
    
//        NSMutableString *str1 = [[NSMutableString alloc]initWithString:@"可变"];
//        NSString *str2 = [str1 copy];
//    //    NSString *str3 = str1;
//    //    str1 = @"66666";
//    //    str1 = @"233223";
//    //    重新赋值之后，就相当于创建了新的地址指针
//        NSLog(@"\nstr1 = %@ str1P = %p \n str2 = %@ str2P = %p   ", str1, str1, str2, str2);
//
//    [str1 appendFormat:@" sungh"];
//
//
//        NSLog(@" --- %@ ---- %p",str1,str1);
    
//    ****************数组
//    NSMutableArray *mArr1 = [@[@"123", @"456", @"asd"] mutableCopy];
//    NSMutableArray *mArr2 = [mArr1 copy];
//
//    NSLog(@"\n mArr1 = %@ mArr1P = %p mArr1 class = %@ \n\n mArr2 = %@ mArr2P = %p mArr2 class = %@", mArr1, mArr1, [mArr1 class], mArr2, mArr2, [mArr2 class]);
//    [mArr1 addObject:@"sun"];
//    NSLog(@" --- %p",mArr1);
}
- (void)mutabCopy{
//        NSMutableString *mStr1 = [@"123" mutableCopy];
//        NSMutableString *mStr2 = [mStr1 mutableCopy];
//        NSLog(@"\n mStr1 = %@ mStr1P = %p \n mStr2 = %@ mStr2P = %p", mStr1, mStr1, mStr2, mStr2);
//*************
}
/*
 总结：
 当 使用copy的时候 因为str1 str2 都是不可变字符串，指向同一块内存地址，为了性能优化，系统没必要提供新的内存地址 ，只生成了新的指针指向同一块内存地址
 当重新给str1 赋值 因为之前的内容不可变，所系系统会s开辟新的内存地址
 */

@end
