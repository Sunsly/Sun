//
//  FormTableViewCell.m
//  Sungh
//
//  Created by yonyouqiche on 2021/3/1.
//  Copyright © 2021 yonyouqiche. All rights reserved.
//

#import "FormTableViewCell.h"

@implementation FormTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.time addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tw addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.mb addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.hx addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.xy addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.yl addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.yc addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.gw addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldDidChange:(UITextField *)textField {
    self.selTextBlock(textField.text, textField.tag);
}
-(void)setModel:(FormModel *)model{
    [self.dgBtn setTitle:model.formDG forState:UIControlStateNormal];
    [self.szBtn setTitle:model.formSz forState:UIControlStateNormal];
    [self.hlBtn setTitle:model.formDJ forState:UIControlStateNormal];
    
    [self.dateBtn setTitle:model.formDate forState: UIControlStateNormal];
    self.time.text = model.formTime;
    self.tw.text = model.formTW;
    self.mb.text = model.formMB;
    self.hx.text = model.formHX;
    self.xy.text = model.formXY;
    self.yl.text = model.formYL;
    self.yc.text = model.formYC;
    self.gw.text = model.formGW;
    self.qt.text = model.formQT;
    self.cs.text = model.formCS;
    self.qm.text = model.formQM;
}

- (IBAction)hlAction:(id)sender {
    if (self.selBlock) {
        self.selBlock(self.hlBtn.tag, 9);
    }
}
- (IBAction)szAction:(id)sender {
    if (self.selBlock) {
        self.selBlock(self.szBtn.tag, 10);
    }
}
- (IBAction)dgAction:(id)sender {
    if (self.selBlock) {
        self.selBlock(self.dgBtn.tag, 11);
    }
}
- (void)textViewDidChange:(UITextView *)textView {
    self.selTextBlock(textView.text, textView.tag);
}
- (IBAction)dateAction:(id)sender {
    self.dateBlock(self.dateBtn.tag);
}
//只是作为标记使用
-(void)setDataTag:(NSInteger)tag{
    self.dgBtn.tag = tag;
    self.hlBtn.tag = tag;
    self.szBtn.tag = tag;
    self.dateBtn.tag = tag;
    
    self.time.tag = 10;
    self.tw.tag = 11;
    self.mb.tag = 12;
    self.hx.tag = 13;
    self.xy.tag = 14;
    self.yl.tag = 15;
    self.yc.tag = 16;
    self.gw.tag = 17;
    self.qt.tag = 18;
    self.cs.tag = 19;
    self.qm.tag = 20;
}
@end
