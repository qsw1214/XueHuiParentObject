//
//  UIButton+Category.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/22.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,XHHeadType)
{
    XHTeacherType=1,
    XHstudentType=2,
};

@interface UIButton (Category)

-(void)setHeadrPic:(NSString*)pic withName:(NSString*)name withType:(XHHeadType)type;
-(void)setHeadBackgroundImage:(UIImage *)image forState:(UIControlState)controlState;
@end
