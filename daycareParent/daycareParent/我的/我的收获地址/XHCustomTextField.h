//
//  XHCustomTextField.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHCustomTextField : UITextField<UITextFieldDelegate>
-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder clear:(BOOL)clear leftView:(id)view fontSize:(CGFloat)font;
@end
