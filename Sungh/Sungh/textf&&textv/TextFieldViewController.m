//
//  TextFieldViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2018/11/7.
//  Copyright © 2018年 yonyouqiche. All rights reserved.
//

#import "TextFieldViewController.h"
#import "UITextView+placeHolder.h"
#define CALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface TextFieldViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfields;
@property (weak, nonatomic) IBOutlet UITextView *textviews;

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.textfields addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:UITextFieldTextDidChangeNotification object:self.textfields];
    self.textviews.delegate = self;
    self.textfields.delegate = self;
}


//**************textfield

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //1 只能输入数据英文 数字
//        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CALPHANUM] invertedSet];
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        return [string isEqualToString:filtered];
//
    //2  禁止输入 表情
        if ([[[UITextInputMode currentInputMode]primaryLanguage] isEqualToString:@"emoji"]) {
            return NO;
        }
        if ([self isContainsTwoEmoji:string]) {
            return NO;
        }
    return YES;
}
#pragma mark 只能输入中文和英文
- (void)textFiledEditChanged:(NSNotification *)notification{
    
    UITextRange *selectedRange = self.textfields.markedTextRange;
    UITextPosition *position = [self.textfields positionFromPosition:selectedRange.start offset:0];
    if (!position) { ///
        self.textfields.text = [self filterCharactor:self.textfields.text withRegex:@"[^\u4e00-\u9fa5a-zA-Z]"];//过滤中午和汉字
    }else {
        
    }
    
}
//根据正则，过滤特殊字符
- (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
    
}

#pragma mark字数限制
- (void) textFieldDidChange:(UITextField *)textField
{
    NSInteger kMaxLength = 8;
    NSString *toBeString = textField.text;

    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition * position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position)  {// 没有高亮选择的字，则对已输入的文字进行字数统计和限
            if  (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
                
            }
        }else{
            
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
    
}

//****************************


// textview 禁止表情键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([[[UITextInputMode currentInputMode]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    if ([self isContainsTwoEmoji:text]) {
        return NO;
    }
    return YES;
}
// textview 输入长度
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.markedTextRange == nil && textView.text.length > 10) {
        //提示语
        //截取
        textView.text = [textView.text substringToIndex:10];
    }
}
- (BOOL)isContainsTwoEmoji:(NSString *)string{
    if ([self isNineKeyBoard:string]) {
        return NO;
    }else{
        __block BOOL isEomji = NO;
        [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
         ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
             const unichar hs = [substring characterAtIndex:0];
             //         NSLog(@"hs++++++++%04x",hs);
             if (0xd800 <= hs && hs <= 0xdbff) {
                 if (substring.length > 1) {
                     const unichar ls = [substring characterAtIndex:1];
                     const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                     if (0x1d000 <= uc && uc <= 0x1f77f)
                     {
                         isEomji = YES;
                     }
                     //                 NSLog(@"uc++++++++%04x",uc);
                 }
             } else if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 if (ls == 0x20e3|| ls ==0xfe0f) {
                     isEomji = YES;
                 }
                 //             NSLog(@"ls++++++++%04x",ls);
             } else {
                 if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                     isEomji = YES;
                 } else if (0x2B05 <= hs && hs <= 0x2b07) {
                     isEomji = YES;
                 } else if (0x2934 <= hs && hs <= 0x2935) {
                     isEomji = YES;
                 } else if (0x3297 <= hs && hs <= 0x3299) {
                     isEomji = YES;
                 } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                     isEomji = YES;
                 }
             }
             
         }];
        return isEomji;
    }
}
-(BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}
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
