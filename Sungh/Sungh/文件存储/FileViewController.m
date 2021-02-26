//
//  FileViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2021/2/23.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "FileViewController.h"
#import "TomPerson.h"
#import "Pet.h"
@interface FileViewController ()

@end

@implementation FileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self plistFile];
    
    [self arch];
}


-(void)plistFile{
    NSString *path =  [[NSBundle mainBundle]pathForResource:@"test" ofType:@"plist"];
    NSDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    NSLog(@" --- %@",dic);
//    沙盒
    NSString *pathFile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"testfil.plist"];
    NSArray *arr = @[@"1",@"2"];
    NSDictionary *dict = @{@"dict1":@"value1"};
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:arr forKey:@"arr1"];
    [param setObject:dict forKey:@"param"];
    [param writeToFile:pathFile atomically:YES];

    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:pathFile];
    NSLog(@" ---- %@",dataDictionary);
    
    NSFileManager *filemanage = [NSFileManager defaultManager];
    
    if ([filemanage fileExistsAtPath:pathFile]) {
        NSLog(@" -------- 存在");
    }
}

- (void)arch{
    //沙盒ducument目录
//       NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//       //完整的文件路径
//       NSString *path = [docPath stringByAppendingPathComponent:@"numbers.plist"];
//
//       NSArray *numbers = @[@"one",@"two"];
//
//       //将数据归档到path文件路径里面
//       BOOL success = [NSKeyedArchiver archiveRootObject:numbers toFile:path];
//
//       if (success) {
//           NSLog(@"文件归档成功");
//       }
//
//   NSArray *arr =   [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    NSLog(@" ---- %@",arr);
    
    //沙盒ducument目录
     NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
     //完整的文件路径
     NSString *path = [docPath stringByAppendingPathComponent:@"TomPerson.archive"];
     
     TomPerson *person = [[TomPerson alloc] init];
     person.name = @"谦言忘语";
     person.age = 27;
     
     //将数据归档到path文件路径里面
     BOOL success = [NSKeyedArchiver archiveRootObject:person toFile:path];
     
     if (success) {
         NSLog(@"归档成功");
     }else {
         NSLog(@"归档失败");
     }
    
    
    //沙盒ducument目录
        NSString *docPath2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //完整的文件路径
        NSString *path1 = [docPath2 stringByAppendingPathComponent:@"TomPerson.archive"];
        
    TomPerson *person2 = [NSKeyedUnarchiver unarchiveObjectWithFile:path1];
        NSLog(@"person=%@",person2);
}

- (void)arch2{
    //沙盒ducument目录
       NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
       //完整的文件路径
       NSString *path = [docPath stringByAppendingPathComponent:@"pet.archive"];
       
       TomPerson *person = [[TomPerson alloc] init];
       person.name = @"谦言忘语";
       person.age = 27;
       
       Pet *pet = [[Pet alloc] init];
       pet.name = @"小白";
       pet.master = person;
       
       
       //将数据归档到path文件路径里面
       BOOL success = [NSKeyedArchiver archiveRootObject:pet toFile:path];
       
       if (success) {
           NSLog(@"归档成功");
       }else {
           NSLog(@"归档失败");
       }
    
    Pet *pet3 = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"pet=%@",pet);


}
@end
