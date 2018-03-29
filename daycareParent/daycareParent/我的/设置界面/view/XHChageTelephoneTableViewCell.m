//
//  XHChageTelephoneTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHChageTelephoneTableViewCell.h"

@interface XHChageTelephoneTableViewCell()

@property(nonatomic,strong)ParentTextFeild *chageTelePhoneTextField;

@end

@implementation XHChageTelephoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _chageTelePhoneTextField=[[ParentTextFeild alloc] init];
        _chageTelePhoneTextField.keyboardType=UIKeyboardTypeNumberPad;
        [self.contentView addSubview:_chageTelePhoneTextField];
        [self.contentView addSubview:self.lineLabel];
    }
    return self;
}
-(void)setItemObject:(id)object withIndexPathRow:(NSInteger)row
{
     self.chageTelePhoneTextField.frame=CGRectMake(20, 0, SCREEN_WIDTH-25, self.contentView.frame.size.height);
     self.lineLabel.frame=CGRectMake(0, self.contentView.frame.size.height-0.5, SCREEN_WIDTH, 0.5);
    
    switch (self.modelType) {
        case XHChageTelephoneRegistType:
            case XHChageTelephoneForgetType:
            
        {
            self.chageTelePhoneTextField.placeholder=kPlaceTitle[row];
            [self.contentView addSubview:self.lineLabel];
            self.chageTelePhoneTextField.tag=row+10086;
            if (row==0) {
                self.chageTelePhoneTextField.keyboardType=UIKeyboardTypeNumberPad;
            }
            else
            {
                self.chageTelePhoneTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
                self.chageTelePhoneTextField.secureTextEntry=YES;
            }
        }
            break;
            
        case XHChageTelephoneyFoundType:
        {
              self.chageTelePhoneTextField.tag=row-2+10086;
             self.chageTelePhoneTextField.placeholder=@"请输入新手机号";
        }
            break;
    }
  
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
