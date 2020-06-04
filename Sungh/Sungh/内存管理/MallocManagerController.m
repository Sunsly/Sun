//
//  MallocManagerController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/3/25.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "MallocManagerController.h"

int (^globalBlock)(void) = ^{
    NSLog(@"");
    return 1;
};

typedef void(^blockConst)(void);

@interface MallocManagerController ()

@property (nonatomic, copy)  NSString *string_copy;
@property (nonatomic, strong)NSString *string_strong;
 
@property (nonatomic, copy)   NSMutableString   *string_muta_copy;
@property (nonatomic, strong) NSMutableString   *string_muta_strong;
@property (nonatomic, strong) UIView   *string_obj;

@property (nonatomic,copy)void(^blockMallocCopy)(void);

@property (nonatomic,strong)void(^blockMallocStrong)(void);

@property (nonatomic,strong)blockConst constStrongBlock;
@property (nonatomic,copy)  blockConst constCopyBlock;
@property (nonatomic,weak) id obj1;
@property (nonatomic,assign) NSString * obj2;

@property (nonatomic,strong)NSMutableArray *mallocArray;

@property (nonatomic,copy)NSMutableArray *mucopyArray;

@property (nonatomic, weak) NSString *string_weak;

@property (nonatomic, copy)NSString *string_Copy;


@end

@implementation MallocManagerController
/*
 //打印自动缓存池对象
 _objc_autoreleasePoolPrint()
 //打印引用计数
 _objc_rootRetainCount（obj）
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    //https://www.jianshu.com/p/d5605bbe4e4b 面试
    self.title = @"内存管理";
    self.obj1 = @"1";
    self.obj2 = @"1";
    self.view.backgroundColor = [UIColor whiteColor];
    [self stringMalloc];
    [self blockMalloc];
    [self autoreleasePoolMalloc];
    
    [self weakMalloc];
    
    [self arrinitMalloc];//数组字典等创建
    
    [self copyAndMutableCopyMalloc];
    
    [self runloopMalloc];
    
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
    
    /*
     NSTaggedPointerString(栈区)      ---> NSString

     __NSCFConstantString(数据常量区)  ---> __NSCFString (堆区) --->NSMutableString --->NSString
     
     */
    
    NSString *string1 = @"hello";//该种方式无论字符串多长,都是 (__NSCFConstantString *) $1 = 0x000000010219d750 @"hello"
    NSString *string2 = @"12345";//即使很短,也是 (__NSCFConstantString *) $3 = 0x000000010219d770 @"12345"
    
    NSString *stringCopy = [string1 copy];//(__NSCFConstantString *) $1 = 0x0000000100450750 @"hello"
    NSMutableString *stringMutableCopy = [string1 mutableCopy];//(__NSCFString *) $3 = 0x000060000089d7a0 @"hello"
    
    NSMutableString *stringMutaCopyCopy = [stringMutableCopy copy];;//(NSTaggedPointerString *) $0 = 0xf7066afb106f7757 @"hello"
    
    [stringMutableCopy appendString:@"12"];
//    [stringMutaCopyCopy appendString:@"34"];copy 之后是不可变字符串
    
    NSString *cgstringlongclass = NSStringFromClass([self class]);
    //(__NSCFString *) $0 = 0x00006000024b9700 @"MallocManagerController"
    //较长类情况下,该方法获得的字符串是类型__NSCFString存储在堆区
    
    NSString *taggedStringshort =  NSStringFromClass([NSObject class]);
    // (NSTaggedPointerString *) $1 = 0xef24ec3486c11451 @"NSObject"
    //较短类情况下,该方法获得的字符串是NSTaggedPointerString类型,存储在栈区
    
    NSString *shortClassCopy = [taggedStringshort copy];
    //(NSTaggedPointerString *) $0 = 0x81667153f865e3b5 @"NSObject" 浅拷贝 在栈上
    
    NSString *mutableClassCopy = [taggedStringshort mutableCopy];
   //(__NSCFString *) $0 = 0x0000600002525050 @"NSObject"  深拷贝 到了堆上
 
    NSObject *obj = [[NSObject alloc]init];//(NSObject *) $0 = 0x0000600003469c00

    
    NSString *formatStringLong = [NSString stringWithFormat:@"%@",@"12345678901"];
    //(__NSCFString *) $0 = 0x0000600002047300 @"12345678901" 堆

    NSString *formatStringshort = [NSString stringWithFormat:@"%@",@"123456789"];
    //(NSTaggedPointerString *) $1 = 0xc3d71a10e969179a @"123456789"
    //NSTaggedPointerString 采用六位二进制编码，(14*4)/6=9.333…,可以看出最多存储9位字符。字符数目8~9

    //总结 stringWithFormat方式,最终字符串的类型由字符串长度决定,少于10个字符类型为NSTaggedPointerString,否则为__NSCFString类型
    NSString *strShortConstantCopy = [@"999" copy]; //__NSCFConstantString,0x00000001092b1420,数据区.NSString调用copy是浅拷贝,和strDigital内存地址相同
    NSString *strShortConstantMutaCopy = [@"999" mutableCopy]; //__NSCFString,0x0000600003fad410,堆区,NSMutable类型的string调用mutalbeCopy是深拷贝,返回一个b可变类型字符串;调用copy也是深拷贝,返回不可变字符串
   
    NSString *strLongConstantCopy = [@"1234567890" copy]; //__NSCFConstantString,0x00000001092b1420,数据区.NSString调用copy是浅拷贝,和strDigital内存地址相同
    NSString *strLongConstantMutaCopy = [@"1234567890" mutableCopy];
    
//__NSCFString,0x0000600003fad410,堆区,NSMutable类型的string调用mutalbeCopy是深拷贝,返回一个b可变类型字符串;调用copy也是深拷贝,返回不可变字符串


    
//从以下两个对象的内存地址可以得出结论:stringWithFormat不论接收什么类型的字符串参数,也无论它在数据区栈区还是堆区,都遵守长度临界值9的规则
    NSString *strShortConstantMutaCopyFormat = [NSString stringWithFormat:@"%@",strShortConstantCopy];//NSTaggedPointerString,0x8b25a274d8732690
    NSString *strShortConstantCopyFormat = [NSString stringWithFormat:@"%@",strShortConstantMutaCopy];//NSTaggedPointerString,0x8b25a274d8732690

    
    NSString *strLongConstantMutaCopyFormat = [NSString stringWithFormat:@"%@",strLongConstantCopy];//(__NSCFString *) $0 = 0x000060000035a940 @"1234567890"

     NSString *strLongConstantCopyFormat = [NSString stringWithFormat:@"%@",strLongConstantMutaCopy];//(__NSCFString *) $1 = 0x000060000035a940 @"1234567890"


    /*
     .NSString +copy ( 浅拷贝,返回不可变对象)  NSString+mutableCopy(深拷贝,返回可变对象) NSMutableString+copy(深拷贝,返回不可变对象) NSMutableString+mutableCopy(深拷贝,返回可变对象)
     */
    
    NSString *stringtest = [NSString stringWithFormat:@"%@",@"1234567890"];//(__NSCFString *) $2 = 0x0000600001a8a0a0 @"1234567890"   format 超过9就在堆上
    self.string_copy = stringtest;//(__NSCFString *) $0 = 0x0000600001a8a0a0 @"1234567890"

    self.string_strong = stringtest;//p/x (__NSCFString *) $1 = 0x0000600001a8a0a0 @"1234567890"
        
    self.string_muta_copy = stringtest;//(__NSCFString *) $1 = 0x0000600001a8a0a0 @"1234567890"
    
    self.string_muta_strong = stringtest;//(__NSCFString *) $2 = 0x0000600001a8a0a0 @"1234567890"
    self.string_obj = stringtest;//(__NSCFString *) $2 = 0x0000600001a8a0a0 @"1234567890",类型是由具体运行过程决定的,即便用UIView接收它,也并没有影响string_obj的类型
    //来源是不可变字符串(修改前) 最终都是一份指针地址
    
    stringtest = [NSString stringWithFormat:@"%@",@"abcdefghijklmn"];//p/x string (__NSCFString *) 0x0000600001c0e3e0 @"1234567890"
    self.string_copy = stringtest;//修改之后 地址是一份相同的

    

        NSMutableString *strMuta = [[NSMutableString alloc]initWithString:@"一二三四"];//p/x &strMuta  (NSMutableString **) $7 = 0x0000600002aaa8b0
        
        self.string_strong = strMuta;// p/x &_string_strong (NSString **) $6 = 0x0000600002aaa8b0
        
        self.string_copy = strMuta;//p/x &_string_copy (NSString **) $8 = 0x000060000249a4c0
        
        
        self.string_muta_strong = strMuta;//(__NSCFString *) $0 = 0x0000600002aaa8b0
        self.string_muta_copy = strMuta;//(__NSCFString *) $2 = 0x000060000249ace0
//        [self.string_muta_copy appendString:@"1234"];//崩溃,原因是:copy修饰的string_muta_copy在接收到字符串时,无论是可变还是不可变,都给你深拷贝一遍,NSMutableString调用copy方法虽是深拷贝,但返回的是不可变对象,不可变对象是没有appendString方法的
    NSString *str11 = [NSString stringWithFormat:@"FlyElephant"];//(__NSCFString *) $0 = 0x000060000398b740 @"FlyElephant"
    NSString *str21 = [NSString stringWithFormat:@"FlyElephant"];//(__NSCFString *) $1 = 0x000060000398a760 @"FlyElephant"
    NSString *str31 = @"FlyElephant";//(__NSCFConstantString *) $2 = 0x0000000107e67870 @"FlyElephant"
    
    NSString *str41 = @"FlyElephant1";
    
    NSLog(@"str1:-%p--str2:%p---str3:%p",str11,str21,str31);
    NSLog(@"== %d",str11 == str21);
    NSLog(@"isEqual--%d",[str11 isEqual:str21]);
    
//    NSLog(@"isEqualclass--%d",[[str11 class] isEqual:[str41 class]]);

    NSLog(@"%@--isEqualToString:%d",str11,[str11 isEqualToString:str21]);
    NSLog(@"%@--isEqualToString--%d",str11,[str11 isEqualToString:str31]);
    /*
     isEqual，方法首先检查指针的等同性，相等直接返回YES，
     然后是类的等同性，空或非同类对象直接返回NO，
     最后调用对象的比较器进行比较。比较器的名称指示出参与比较的对象的类名称。若均相等，返回YES
     isEqualToString，在比较对象都是字符串的前提下， 直接判断字符串内容，比较对象不是字符串，报错。
     */
    
}


- (void)blockMalloc{
    
    
/*
 block内存分为三种类型：

 _NSConcreteGlobalBlock（全局）
 _NSConcreteStackBlock（栈）
 _NSConcreteMallocBlock（堆）
 */
    //___NSGlobalBlock__当我们声明一个block 如果这个block 没有b捕获外部的变量，那么这个block就位于全局区，
    int mu = 10;

    void(^myGlobalBlock)(int x);
    myGlobalBlock= ^(int num){
        int result = num + 100;//mu 换成mu 后 引用了外部的变量 就block只要捕获了外部变量就会位于堆
        NSLog(@"result -- %d",result);
    };
    myGlobalBlock(100);
    
    //__NSStackBlock__： 我们在声明一个block的时候，使用了__weak或者__unsafe__unretained的修饰符，那么系统就不会为我们做copy的操作，不会将其迁移到堆区。下面我们实验一下：
    __weak void (^myStackBlock) (int mu) = ^(int num){
        int result = num + mu;
        NSLog(@"result -- %d",result);
        };
    myStackBlock(12);
    NSLog(@" -- %@",myStackBlock);
    
    
  __block  NSString * mp = @"100";//(__NSCFConstantString *) $0 = 0x000000010a5aaa60 @"100"

    void(^myBlocks)(int x);
    
    myBlocks = ^(int m){
//        mp = @"10";//如果值发生变化 内存地址就发生变化
        NSLog(@" --- %@",mp);//(__NSCFConstantString *) $2 = 0x000000010a5aaa80 @"20"

    };
    mp = @"20";//(__NSCFConstantString *) $1 = 0x000000010a5aaa80 @"20"

    myBlocks(100);
    NSLog(@" -- %@",mp);
    
   /*
    是无法修改的,那怎么样才能在block内部修改外部变量呢?有三种方法:
    1:使用static修饰age
    2:把age变成全局变量
    3:使用__block修饰age
    */

}

- (void)autoreleasePoolMalloc{//autoreleasePool
   /*
    App启动后，苹果在主线程 RunLoop 里注册了两个 Observer，其回调都是 _wrapRunLoopWithAutoreleasePoolHandler()。
    第一个 Observer 监视的事件是 Entry(即将进入Loop)，其回调内会调用 _objc_autoreleasePoolPush() 创建自动释放池
    第二个 Observer 监视了两个事件： BeforeWaiting(准备进入休眠) 时调用_objc_autoreleasePoolPop() 和 _objc_autoreleasePoolPush() 释放旧的池并创建新池；Exit(即将退出Loop) 时调用 _objc_autoreleasePoolPop() 来释放自动释放池。
    */
    [NSTimer scheduledTimerWithTimeInterval:1.0
      target:self
    selector:@selector(updateTime)
    userInfo:nil
     repeats:YES];
    dispatch_queue_t qu = dispatch_queue_create("121212", nil);
    dispatch_async(qu, ^{

    for (int i = 0; i < 100000; i++) {
//            @autoreleasepool {
                       NSString *str = [NSString stringWithFormat:@"hello -%04d", i];
                       str = [str stringByAppendingString:@" - world"];
//                }
  
//        NSLog(@" -- %d",i);
    }
              });
        // 场景 1
//        NSString *string = [NSString stringWithFormat:@"1234567890"];
//        self.string_weak = string;
//        NSLog(@"string: %@",self.string_weak);
        
        //场景 2
//        @autoreleasepool {
//            NSString *string = [NSString stringWithFormat:@"1234567890"];
//            _string_weak = string;//因为是弱引用 autorelease 已经n中被释放 nil
//            _string_Copy = @"12";
//
//        }
//        NSLog(@"string: %@ -- %@",_string_weak,_string_Copy);//(null) -- 12
//
        // 场景 3
        NSString *string = nil;
        @autoreleasepool {
            string = [NSString stringWithFormat:@"1234567890"];
            _string_weak = string;
        }
        NSLog(@"string: %@",self.string_weak);
    
}
- (void)updateTime{
    
}
- (void)weakMalloc{
    /*
Runtime维护了一个weak表，用于存储指向某个对象的所有weak指针。weak表其实是一个hash（哈希）表，Key是所指对象的地址，Value是weak指针的地址（这个地址的值是所指对象指针的地址）数组。
     1、初始化时：runtime会调用objc_initWeak函数，初始化一个新的weak指针指向对象的地址。
     2、添加引用时：objc_initWeak函数会调用 objc_storeWeak() 函数， objc_storeWeak() 的作用是更新指针指向，创建对应的弱引用表。
3、释放时，调用clearDeallocating函数。clearDeallocating函数首先根据对象地址获取所有weak指针地址的数组，然后遍历这个数组把其中的数据设为nil，最后把这个entry从weak表中删除，最后清理对象的记录。
     
     调用objc_release
     2、因为对象的引用计数为0，所以执行dealloc
     3、在dealloc中，调用了_objc_rootDealloc函数
     4、在_objc_rootDealloc中，调用了object_dispose函数
     5、调用objc_destructInstance
     6、最后调用objc_clear_deallocating
     
     bjc_initWeak(id *location, id newObj)
     {
         if (!newObj) {
             *location = nil;
             return nil;
         }

         return storeWeak<DontHaveOld, DoHaveNew, DoCrashIfDeallocating>
             (location, (objc_object*)newObj);
     }
     
     .m和.mm的区别

     .m：源代码文件，这个典型的源代码文件扩展名，可以包含OC和C代码。
     .mm：源代码文件，带有这种扩展名的源代码文件，除了可以包含OC和C代码之外，还可以包含C++代码。仅在你的OC代码中确实需要使用C++类或者特性的时候才用这种扩展名。

     */
    NSObject *obj = [[NSObject alloc]init];
    
    
    self.obj1 = obj;
    
    self.obj2 = @"12";
    
}
-(void)dealloc{
    
    /*
     dealloc 之后 self.obj1 不在被引用 所以此时 self.obj1 会被置空
     p self.obj1
     (id) $2 = nil
     */
    
}

- (void)arrinitMalloc{
    /*
     创建不可变 数组、字典、字符串，不管用类方法创建还是对象方法创建，只要是创建空的对象， 发现得到的地址都是一样的，由此可以知道初始化空的对象的时候会生成一个单例
     */
    NSString *str1;//空(NSString *) $0 = nil
    NSString *str2 = [NSString string];//(__NSCFConstantString *) $1 = 0x00007fff80971d08 @""
    NSString *str3 = [[NSString alloc]init];//(__NSCFConstantString *) $2 = 0x00007fff80971d08 @""

    NSArray *a = [NSArray array];         //0x00007fff80617ad0
    NSArray *b = [NSArray array];         //0x00007fff80617ad0
    NSArray *c = [NSArray array];         //0x00007fff80617ad0
    NSArray *e = [[NSArray alloc] init];  //0x00007fff80617ad0
    NSArray *d = [NSArray array];         //0x00007fff80617ad0
    NSArray *f = [[NSArray alloc] initWithObjects:@"1", nil];//(__NSSingleObjectArrayI *) $4 = 0x0000600000be4500 @"1 element"

    NSArray *g = [[NSArray alloc] initWithObjects:@"1", nil];//(__NSSingleObjectArrayI *) $6 = 0x0000600000be4660 @"1 element"
    
    //2. 创建可变 数组、字典、字符串，都会申请不同的内存空间。

    NSMutableArray *arr1  =[NSMutableArray arrayWithCapacity:0];//(__NSArrayM *) $0 = 0x00006000013af5d0 @"0 elements"

    NSMutableArray *arr2  =[[NSMutableArray alloc]init];//(__NSArrayM *) $1 = 0x00006000013af3f0 @"0 elements"
    NSMutableString *str5 = [[NSMutableString alloc]init];//(__NSCFString *) $0 = 0x0000600003b67330

    NSMutableString *str6 = [NSMutableString string];        //(__NSCFString *) $1 = 0x0000600003b67360

    NSMutableString *str7 ;//(NSMutableString *) $2 = nil


    
    NSString *value = nil;
    NSArray *arrValue = [[NSArray alloc]initWithObjects:@"12",value,@"122" ,nil];//(__NSSingleObjectArrayI *) $0 = 0x0000600000cf4fe0 @"1 element"
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"valye",@"key",value,@"key2",@"valye",@"key3",nil];
    /*
     (lldb) po dic
     {
         key = valye;
     }
     */
//    NSArray *arrValu1 = @[@"12",value,@"122"];//会崩溃 不能有空
/*
 结论
 .数组使用alloc进行初始化的时候，如果某一个值为空，则不会奔溃，但是到此为止，后面的值不会再添加进数组。
 2.字典使用 alloc进行初始化的时候，如果某个 key为空，会造成奔溃。
 3.字典使用alloc进行初始化的时候，如果某一个value为空，则不会造成奔溃，但是到此为止，后面的值不会再添加进字典。
 4.字典使用alloc进行初始化的时候，如果某其中一个键值对都为空(key 为空，value 为空)，则不会造成奔溃，但是到此为止，后面的值不会再添加进字典。

 */
    
    
    
}

- (void)copyAndMutableCopyMalloc{
    
    NSString *string1 = @"12122112188";//(__NSCFConstantString *) $0 = 0x000000010c8a3b20   @"121221121"
    NSString *copyStr = [string1 copy];//(__NSCFConstantString *) $1 = 0x000000010c8a3b20 @"121221121"
    NSMutableString *muCopyStr = [string1 mutableCopy];//(__NSCFString *) $2 = 0x0000600001791980 @"121221121cmucopy"  NSMutableString类型的字符串
    [muCopyStr appendFormat:@"cmucopy"];
    string1 = @"sun";
    
    NSDictionary *dict = @{@"name" : @"Jerry"};
//    [dict copy] --> 拷贝出内容与dict相同的NSDictionary类型的字典
//    [dict mutableCopy] --> 拷贝出内容与dict相同的NSMutableDictionary类型的字典
    
    /*
     copy拷贝出来的对象类型总是不可变类型(例如, NSString, NSDictionary, NSArray等等)
     mutableCopy拷贝出来的对象类型总是可变类型(例如, NSMutableString, NSMutableDictionary, NSMutableArray等等)

     何为深拷贝, 何为浅拷贝?
     */
    
    NSArray *arr = @[@"123", @"456", @"asd"];//(__NSArrayI *) $0 = 0x00006000016fda40 @"3 elements"

    self.mucopyArray = [arr mutableCopy];//(__NSArrayI *) $1 = 0x00006000016fdef0 @"3 elements"

 
    NSString *copyStr1 = @"12";//(__NSCFConstantString *) $0 = 0x0000000102aa3838 @"12"

    NSMutableString *str = [[NSMutableString alloc]initWithString:@"123"];//(__NSCFString *) $0 = 0x000060000274b900 @"123"

    NSString *copystr2 = [copyStr1 copy];//(__NSCFConstantString *) $1 = 0x0000000102aa3838 @"12"

    NSMutableArray *copystr3 = [copyStr1 copy];//(__NSCFConstantString *) $2 = 0x0000000102aa3838 @"12"

    NSString *copystr4 = [copyStr1 mutableCopy];//(__NSCFString *) $3 = 0x0000600000c9ad00 @"12"
    
    NSString *copyStr5 = [str copy];//(NSTaggedPointerString *) $1 = 0x8c9831d736c2a7f8 @"123"

    
    /*
      总结:用copy 修饰或者赋值的 变量肯定是不可变的
     用copy修饰的 要看源对象是不是可变的，若源对象可变，则拷贝值到另外一份内存中，
     用mutableCopy 肯定会申请新的内存地址
    */

}

- (void)runloopMalloc{
    //https://blog.ibireme.com/2015/05/18/runloop/
    /*
     Autoreleasepool 与 Runloop 的关系
     ARC 下什么样的对象由 Autoreleasepool 管理 //https://www.jianshu.com/p/e3690f3e4675
     子线程默认不会开启 Runloop，那出现 Autorelease 对象如何处理？不手动处理会内存泄漏吗？

     */
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // self.obj1  (id) $0 = nil;
    
}

-(NSMutableArray *)mallocArray{
    if (_mallocArray == nil) {
        _mallocArray = [NSMutableArray arrayWithCapacity:0];//(__NSArrayM *) $0 = 0x00006000006e0600 @"0 elements"

    }
    return _mallocArray;
}
@end


