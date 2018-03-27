//
//  ParentTextFeild.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/27.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentTextFeild.h"

@implementation ParentTextFeild

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    if (self=[super init]) {
        self.font=kFont(16.0);
        [self setValue:RGB(153, 153, 153) forKeyPath:@"_placeholderLabel.textColor"];
        [self setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        self.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.font=kFont(16.0);
        [self setValue:RGB(153, 153, 153) forKeyPath:@"_placeholderLabel.textColor"];
        [self setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        self.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return self;
}
@end
