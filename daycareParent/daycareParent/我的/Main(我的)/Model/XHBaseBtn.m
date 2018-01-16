//
//  XHBaseBtn.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHBaseBtn.h"

@implementation XHBaseBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor=MainColor;
    self.titleLabel.font=FontLevel2;
    [self setTitleColor:LOGIN_BEFORE  forState:UIControlStateNormal];
    self.layer.cornerRadius=CORNER_BTN;

}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=MainColor;
        self.titleLabel.font=FontLevel2;
        [self setTitleColor:LOGIN_BEFORE  forState:UIControlStateNormal];
        self.layer.cornerRadius=CORNER_BTN;
    }
    return self;
}
@end
