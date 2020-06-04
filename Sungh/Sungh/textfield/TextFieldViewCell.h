//
//  TextFieldViewCell.h
//  Sungh
//
//  Created by yonyouqiche on 2020/5/13.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextFieldViewCell : UITableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textf;

@end

NS_ASSUME_NONNULL_END
