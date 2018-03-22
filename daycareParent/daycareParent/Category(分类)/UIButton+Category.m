//
//  UIButton+Category.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

-(void)setHeadrPic:(NSString*)pic withName:(NSString*)name withType:(XHHeadType)type
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:18.0];
    pic = [NSString safeString:pic];
    if ([pic isEqualToString:@""])
    {
        self.backgroundColor=MainColor;
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        NSInteger length = name.length;
        NSString *makeName = name;
        if ([name isEqualToString:@""])
        {
            [self setTitle:name forState:UIControlStateNormal];
        }
        else
        {
            //        2.截取我们想要的字符串内容
            switch (type)
            {
                case XHTeacherType:
                {
                    makeName = [name substringWithRange:NSMakeRange(0,1)];
                }
                    break;
                case XHstudentType:
                {
                    makeName = [name substringWithRange:NSMakeRange((length-1),1)];
                }
                    break;
            }
            
            [self setTitle:makeName forState:UIControlStateNormal];
        }
        
    }
    else
    {
        self.backgroundColor=[UIColor whiteColor];
        [self setTitle:nil forState:UIControlStateNormal];
        [self sd_setBackgroundImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(pic)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
    }
}
-(void)setHeadBackgroundImage:(UIImage *)image forState:(UIControlState)controlState
{
    self.backgroundColor=[UIColor whiteColor];
    [self setTitle:nil forState:controlState];
    [self setBackgroundImage:image forState:controlState];
}
@end
