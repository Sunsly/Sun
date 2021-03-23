//
//  FormTableViewCell.h
//  Sungh
//
//  Created by yonyouqiche on 2021/3/1.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FormTableViewCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *time;

@property (strong, nonatomic) IBOutlet UIButton *hlBtn;

@property (strong, nonatomic) IBOutlet UIButton *szBtn;
@property (strong, nonatomic) IBOutlet UITextField *tw;
@property (strong, nonatomic) IBOutlet UITextField *mb;
@property (strong, nonatomic) IBOutlet UITextField *hx;
@property (strong, nonatomic) IBOutlet UITextField *xy;
@property (strong, nonatomic) IBOutlet UITextField *yl;
@property (strong, nonatomic) IBOutlet UITextField *yc;
@property (strong, nonatomic) IBOutlet UIButton    *dgBtn;
@property (strong, nonatomic) IBOutlet UITextField *gw;
@property (strong, nonatomic) IBOutlet UITextView  *qt;
@property (strong, nonatomic) IBOutlet UITextView  *cs;
@property (strong, nonatomic) IBOutlet UITextView  *qm;
@property (strong, nonatomic) IBOutlet UIButton    *dateBtn;
@property (nonatomic,strong)FormModel *model;

///
@property (nonatomic,copy)void(^selBlock)(NSInteger row,NSInteger type);

@property (nonatomic,copy)void(^dateBlock)(NSInteger row);

@property (nonatomic,copy)void(^refreshBlock)(NSInteger row);

@property (nonatomic,copy)void(^selTextBlock)(NSString *str,NSInteger type);

- (void)setDataTag:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_END
