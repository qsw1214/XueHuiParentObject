//
//  XHChildCollectionViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHChildCollectionViewCell.h"
#define NAME_WIDTH
@implementation XHChildCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _childButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 15, USER_HEARD, USER_HEARD)];
        _childButton.layer.cornerRadius=USER_HEARD/2.0;
        _childButton.layer.masksToBounds=YES;
        _childButton.userInteractionEnabled=NO;
        [self.contentView addSubview:_childButton];
        _childNameLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(0, USER_HEARD+20, USER_HEARD, 20)];
        _childNameLabel.textAlignment=NSTextAlignmentCenter;
        _childNameLabel.font=FontLevel3;
        [self.contentView addSubview:_childNameLabel];
        _childClassLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(4, _childNameLabel.bottom+5, USER_HEARD-8, 15)];
        _childClassLabel.textAlignment=NSTextAlignmentCenter;
        _childClassLabel.font=FontLevel4;
        _childClassLabel.textColor=DEFAULTCOLOR;
        [self.contentView addSubview:_childClassLabel];
    }
    return self;
}


@end
