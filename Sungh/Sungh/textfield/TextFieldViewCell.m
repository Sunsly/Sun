//
//  TextFieldViewCell.m
//  Sungh
//
//  Created by yonyouqiche on 2020/5/13.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "TextFieldViewCell.h"

@implementation TextFieldViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@" ------- %@",textField.text);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField.text.length>5) {
        NSLog(@" ----%@",textField.text);
    }
    return YES;
}
@end
