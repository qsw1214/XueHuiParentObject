//
//  ParentBackLabel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentBackLabel.h"

@implementation ParentBackLabel

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
        self.textColor=DEFAULTCOLOR;
        self.font=FontLevel2;
    }
    return self;
}
-(id)init
{
    if (self=[super init]) {
        self.textColor=DEFAULTCOLOR;
        self.font=FontLevel2;
    }
    return self;
}
@end
