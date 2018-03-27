//
//  XHChageTelephoneTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentTableViewCell.h"

typedef NS_ENUM(NSInteger,XHChageTelephoneModelType)
{
    XHChageTelephoneRegistType=1,
    XHChageTelephoneForgetType=2,
    XHChageTelephoneyFoundType=3,
};

@interface XHChageTelephoneTableViewCell : ParentTableViewCell
@property(nonatomic,assign)XHChageTelephoneModelType modelType;
@end
