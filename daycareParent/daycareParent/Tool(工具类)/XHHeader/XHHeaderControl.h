//
//  XHHeaderControl.h
//  daycareParent
//
//  Created by mac on 2018/3/21.
//  Copyright © 2018年 XueHui. All rights reserved.
//

typedef NS_ENUM(NSInteger,XHHeaderType)
{
    XHHeaderTeacherType = 1,
    XHHeaderOtherType = 2,
};


#import "BaseControl.h"

@interface XHHeaderControl : BaseControl

-(void)setHeadrUrl:(NSString*)url withName:(NSString*)name withType:(XHHeaderType)type;

-(void)setImageName:(NSString*)imageName;

@end
