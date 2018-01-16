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
        _childImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 15, USER_HEARD, USER_HEARD)];
        _childImageView.layer.cornerRadius=USER_HEARD/2.0;
        _childImageView.layer.masksToBounds=YES;
        [self.contentView addSubview:_childImageView];
        _childNameLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(0, USER_HEARD+15, USER_HEARD, USER_HEARD/2)];
        _childNameLabel.textAlignment=NSTextAlignmentCenter;
        _childNameLabel.font=FontLevel4;
        [self.contentView addSubview:_childNameLabel];
        _childClassLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(4, USER_HEARD*3/2+15, USER_HEARD-8, (USER_HEARD-20)/2)];
        _childClassLabel.textAlignment=NSTextAlignmentCenter;
        _childClassLabel.font=FontLevel5;
        _childClassLabel.layer.cornerRadius=(USER_HEARD-20)/4;
        _childClassLabel.layer.borderWidth=1;
        _childClassLabel.layer.borderColor=[[UIColor greenColor] CGColor];
        [self.contentView addSubview:_childClassLabel];
    }
    return self;
}
@end
