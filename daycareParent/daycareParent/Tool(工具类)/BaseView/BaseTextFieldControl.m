//
//  BaseTextFieldControl.m
//  ShoppingMall
//
//  Created by XueHui on 2017/10/11.
//  Copyright © 2017年 YX. All rights reserved.
//

#import "BaseTextFieldControl.h"


@interface BaseTextFieldControl ()




@end



@implementation BaseTextFieldControl


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.inputTextField];
    }
    return self;
}



-(void)setText:(NSString*)text
{
    [self.inputTextField setText:text];
}

-(NSString*)text
{
    return self.inputTextField.text;
}




-(void)setPlaceholder:(NSString*)placeholder
{
    [self.inputTextField setPlaceholder:placeholder];
}
-(void)setKeyboardType:(UIKeyboardType)keyboardType //!< 设置键盘模式
{
    [self.inputTextField setKeyboardType:keyboardType];
}

-(void)setFont:(UIFont*)font
{
    [self.inputTextField setFont:font];
    
}

-(void)setTextColor:(UIColor*)color
{
    [self.inputTextField setTextColor:color];
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.inputTextField setFrame:CGRectMake(10.0, 0, frame.size.width-20.0, frame.size.height)];
}

-(void)setResignFirstResponder
{
    [self.inputTextField resignFirstResponder];
}


-(void)setSecureTextEntry:(BOOL)entry
{
    [self.inputTextField setSecureTextEntry:entry];
}


#pragma mark - 输入框
-(UITextField *)inputTextField
{
    if (_inputTextField == nil)
    {
        _inputTextField = [[UITextField alloc]init];
        [_inputTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_inputTextField resignFirstResponder];
    }
    return _inputTextField;
}








@end
