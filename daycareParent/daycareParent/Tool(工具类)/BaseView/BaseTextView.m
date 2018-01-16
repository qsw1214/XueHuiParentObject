//
//  BaseTextView.m
//  liaotian
//
//  Created by XueHui on 17/9/13.
//  Copyright © 2017年 姚立志. All rights reserved.
//

#import "BaseTextView.h"


@interface BaseTextView () <UITextViewDelegate>

@property (nonatomic,strong) UILabel *placeholderLabel; //!< 占位字符


@end

@implementation BaseTextView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setDelegate:self];
        [self addSubview:self.placeholderLabel];
        [self setFont:self.placeholderLabel.font];
    }
    return self;
}


-(void)reset
{
    [self setText:@""];
    [self.placeholderLabel setText:_placeholder];
    [self.placeholderLabel setHidden:NO];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self.placeholderLabel setText:placeholder];
}

-(void)setPlaceholderColor:(UIColor*)color //!< 占位字符的颜色
{
    [self.placeholderLabel setTextColor:color];
}

-(void)resetText:(NSString*)text
{
    [self setText:text];
    [self.placeholderLabel setHidden:YES];
}

#pragma mark - Getter / Setter
-(UILabel *)placeholderLabel
{
    if (_placeholderLabel == nil)
    {
        _placeholderLabel = [[UILabel alloc]init];
        [_placeholderLabel setTextColor:RGB(220.0, 220.0, 220.0)];
        [_placeholderLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_placeholderLabel setHidden:NO];
    }
    return _placeholderLabel;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.placeholderLabel setFrame:CGRectMake(5, 10.0, frame.size.width-10.0, 15.0)];
}

#pragma mark - Deletage Method

#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        [self.placeholderLabel setHidden:NO];
    }
    else
    {
        [self.placeholderLabel setHidden:YES];
    }
    
    if ([self.textDeletage respondsToSelector:@selector(textViewDidChange:)])
    {
        [self.textDeletage textViewDidChange:textView];
    }
}
@end
