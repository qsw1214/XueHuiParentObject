//
//  XHChageTelephoneTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHChageTelephoneTableViewCell.h"

@implementation XHChageTelephoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _chageTelePhoneTextField=[[UITextField alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, self.contentView.bounds.size.height)];
        _chageTelePhoneTextField.placeholder=@"请输入新手机号";
        _chageTelePhoneTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _chageTelePhoneTextField.keyboardType=UIKeyboardTypeNumberPad;
        [self.contentView addSubview:_chageTelePhoneTextField];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
