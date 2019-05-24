//
//  ArithmeticViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2019/4/10.
//  Copyright © 2019年 yonyouqiche. All rights reserved.
//

#import "ArithmeticViewController.h"

@interface ArithmeticViewController ()

@end

@implementation ArithmeticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"算法";
    
    //54321
    /*
     
     0   45321
         43521
         43251
         43215
     1   34215
         32415
         32145
     
     
     */
    
    /*
     
     0   45321
         35421
         25431
         15432
     1
     
     
     */
    
    
    //冒泡 --- -- - --适用于数据量很小的排序场景，因为冒泡原理简单
    NSMutableArray  *arr = [[NSMutableArray alloc]initWithObjects:@1,@5,@3,@6,@9,@8,@10,@11,@2,@2,@13,@14,@15,@16, nil];
    
    
    NSInteger index = 0;
    for (int i = 0; i < arr.count-1; i++) {
        for (int j = 0; j < arr.count - 1 - i; j++) {
            if ([arr[j] integerValue]> [arr[j+1] integerValue]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                index ++;
            }
        }
    }
    NSLog(@" -- -- -- %@ --  %ld",arr,index);
    
    
    
    
    
    
    
    
    
    NSInteger len = arr.count - 1;
    NSInteger source = arr.count - 1;
    
    NSInteger lastIndex = 0;
    
    
    for (NSInteger i = 0; i < len; i++) {
        BOOL isflag = YES;
        for (NSInteger j = 0; j < source;j++) {
            if ([arr[j] integerValue] >[arr[j + 1] integerValue]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                isflag = NO;//记录是否有交换  进入 这里证明有交换记录 设置为no
                lastIndex = j;//记录最后一次交换的坐标
            }
            NSLog(@"jjj ----  %ld      %ld",i,j);
        }
        source = lastIndex;//减少 循环次数
        if (isflag) {
            break;
        }

    }
    NSLog(@" --- %@",arr);//1234
    
    NSMutableArray  *arr1 = [[NSMutableArray alloc]initWithObjects:@1,@5,@3,@6,@9,@8,@10,@11,@2,@2,@13,@14,@15,@16, nil];

    for (int i = 0; i < arr1.count-1; i++) {
        for (int j = i+1; j<arr1.count-1; j++) {
            if ([arr1[i] integerValue] > [arr1[j] integerValue] ) {
                [arr1 exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    NSLog(@" -- -- %@",arr1);
    /*
     冒泡排序：
     
         适用于数据量很小的排序场景，因为冒泡原理简单
     
     选择排序：
     
         适用于大多数排序场景，虽然他的对比次数较多，但是数据量大的时候，他的效率明显优于冒泡，而且数据移动是非常耗时的，选择排序移动次数少。
     
     插入排序：
     
         插入排序适用于已有部分数据有序的情况，有序部分越大越好。

     */
}



@end
