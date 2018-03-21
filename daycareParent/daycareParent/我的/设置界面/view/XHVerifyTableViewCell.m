//
//  XHVerifyTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHVerifyTableViewCell.h"

@implementation XHVerifyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _chageTelePhoneTextField=[[UITextField alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-120, self.contentView.bounds.size.height)];
        _chageTelePhoneTextField.placeholder=@"请输入短信密码";
       _chageTelePhoneTextField.keyboardType=UIKeyboardTypeNumberPad;
        _chageTelePhoneTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:_chageTelePhoneTextField];
        _verifyButton=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, (self.contentView.bounds.size.height-30)/2.0, 80, 30)];
        _verifyButton.backgroundColor=MainColor;
        _verifyButton.titleLabel.font=FontLevel3;
        _verifyButton.layer.cornerRadius=CORNER_BTN;
        [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.contentView addSubview:_verifyButton];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
