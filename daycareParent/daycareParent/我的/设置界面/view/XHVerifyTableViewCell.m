//
//  XHVerifyTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHVerifyTableViewCell.h"
@interface XHVerifyTableViewCell()

@property(nonatomic,strong)ParentTextFeild *chageTelePhoneTextField;

@end
@implementation XHVerifyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self.contentView addSubview:self.verifyButton];
        [self.contentView addSubview:self.chageTelePhoneTextField];
        [self.contentView addSubview:self.lineLabel];

    }
    return self;
}
-(void)setItemObject:(id)object withIndexPathRow:(NSInteger)row
{
    self.chageTelePhoneTextField.frame=CGRectMake(20, 0, SCREEN_WIDTH-120, 50);
    self.verifyButton.frame=CGRectMake(SCREEN_WIDTH-100, 10, 80, 30);
     self.lineLabel.frame=CGRectMake(0, self.contentView.frame.size.height-0.5, SCREEN_WIDTH, 0.5);
    self.chageTelePhoneTextField.placeholder=@"请输入验证码";
    
    switch (self.modelType) {
        case XHVerifyRegistType:
            case XHVerifyForgetType:
        {
            self.chageTelePhoneTextField.tag=row+10086;
        }
            break;
            
        case XHVerifyFoundType:
        {
               self.chageTelePhoneTextField.tag=row-2+10086;
        }
            break;
    }

}
-(UIButton *)verifyButton
{
    if (_verifyButton==nil) {
        _verifyButton=[[UIButton alloc] init];
        _verifyButton.backgroundColor=MainColor;
        _verifyButton.titleLabel.font=FontLevel3;
        _verifyButton.layer.cornerRadius=CORNER_BTN;
        [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }
    return _verifyButton;
}
-(ParentTextFeild *)chageTelePhoneTextField
{
    if (_chageTelePhoneTextField==nil) {
        _chageTelePhoneTextField=[[ParentTextFeild alloc] init];
        _chageTelePhoneTextField.keyboardType=UIKeyboardTypeNumberPad;
        _chageTelePhoneTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
        
    }
    return _chageTelePhoneTextField;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
