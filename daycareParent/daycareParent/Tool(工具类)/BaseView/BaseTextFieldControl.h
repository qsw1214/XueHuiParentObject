//
//  BaseTextFieldControl.h
//  ShoppingMall
//
//  Created by XueHui on 2017/10/11.
//  Copyright © 2017年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTextFieldControl : UIControl
@property (nonatomic,strong) UITextField *inputTextField; //!< 输入框

-(void)setSecureTextEntry:(BOOL)entry;
-(void)setKeyboardType:(UIKeyboardType)keyboardType; //!< 设置键盘模式
-(NSString*)text;
-(void)setText:(NSString*)text;
-(void)setPlaceholder:(NSString*)placeholder;
-(void)setFont:(UIFont*)font;
-(void)setTextColor:(UIColor*)color;
-(void)resetFrame:(CGRect)frame;
-(void)setResignFirstResponder;


@end
