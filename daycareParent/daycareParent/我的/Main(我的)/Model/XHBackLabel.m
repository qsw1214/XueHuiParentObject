//
//  XHBackLabel.m
//  daycareParent
//
//  Created by mac on 2017/12/2.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHBackLabel.h"

@implementation XHBackLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        //self.backgroundColor=[UIColor yellowColor];
        self.textColor=DEFAULTCOLOR;
        self.font=FontLevel2;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // self.backgroundColor=[UIColor yellowColor];
    self.textColor=DEFAULTCOLOR;
    self.font=FontLevel2;
}

@end
