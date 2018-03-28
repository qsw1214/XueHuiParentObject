//
//  ParentLabel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentLabel.h"

@implementation ParentLabel
-(instancetype)init
{
    if (self=[super init])
    {
        [self setFont:[UIFont systemFontOfSize:16.0]];
        [self setTextColor:RGB(51, 51, 51)];
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self setFont:[UIFont systemFontOfSize:16.0]];
        [self setTextColor:RGB(51, 51, 51)];
    }
    return self;
}
-(void)setParagraph:(NSString *)str
{
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
