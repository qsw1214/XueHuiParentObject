//
//  XHBaseLabel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHBaseLabel.h"

@implementation XHBaseLabel

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
        self.font=FontLevel2;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //self.backgroundColor=[UIColor yellowColor];
    self.font=FontLevel2;
}


@end
