//
//  XHVerifyTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentTableViewCell.h"
typedef NS_ENUM(NSInteger,XHVerifyModelType)
{
    XHVerifyRegistType=1,
    XHVerifyForgetType=2,
     XHVerifyFoundType=3,
};

@interface XHVerifyTableViewCell : ParentTableViewCell
@property(nonatomic,strong)UIButton *verifyButton;
@property(nonatomic,assign)XHVerifyModelType modelType;
@end
