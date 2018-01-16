//
//  BaseTextView.h
//  liaotian
//
//  Created by XueHui on 17/9/13.
//  Copyright © 2017年 姚立志. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTextViewDeletage <NSObject>

- (void)textViewDidChange:(UITextView *)textView;

@end

@interface BaseTextView : UITextView

@property (nonatomic,copy) NSString *placeholder; //!< 占位字符

@property (nonatomic,weak) id <BaseTextViewDeletage> textDeletage;

-(void)resetText:(NSString*)text;
-(void)setPlaceholderColor:(UIColor*)color; //!< 占位字符的颜色

-(void)resetFrame:(CGRect)frame;



-(void)reset;

/**
 字数限制方法
 
 //正在改变
 - (void)textViewDidChange:(UITextView *)textView
 {
 FDLog(@"%@", textView.text);
 
 self.placeHolder.hidden = YES;
 //允许提交按钮点击操作
 self.commitButton.backgroundColor = FDMainColor;
 self.commitButton.userInteractionEnabled = YES;
 //实时显示字数
 self.stirngLenghLabel.text = [NSString stringWithFormat:@"%lu/100", (unsigned long)textView.text.length];
 
 //字数限制操作
 if (textView.text.length >= 100) {
 
 textView.text = [textView.text substringToIndex:100];
 self.stirngLenghLabel.text = @"100/100";
 
 }
 //取消按钮点击权限，并显示提示文字
 if (textView.text.length == 0) {
 
 self.placeHolder.hidden = NO;
 self.commitButton.userInteractionEnabled = NO;
 self.commitButton.backgroundColor = [UIColor lightGrayColor];
 
 }
 
 }

 */



@end
