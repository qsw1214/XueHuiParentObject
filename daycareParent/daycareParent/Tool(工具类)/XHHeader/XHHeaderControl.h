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



/**
 网络加载头像，根据加载成功与否，显示名字内容

 @param url 头像Url
 @param name 对象的名字
 @param type XHHeaderType
 */
-(void)setHeadrUrl:(NSString*)url withName:(NSString*)name withType:(XHHeaderType)type;



/**
 设置本地图标

 @param imageName 图片名称
 */
-(void)setImageName:(NSString*)imageName;

@end
