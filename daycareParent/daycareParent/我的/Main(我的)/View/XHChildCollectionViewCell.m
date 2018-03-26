//
//  XHChildCollectionViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHChildCollectionViewCell.h"
#import "XHChildListModel.h"
#define NAME_WIDTH

@interface XHChildCollectionViewCell()
@property(nonatomic,strong)UIButton *childButton;
@property(nonatomic,strong)ParentLabel *childNameLabel;
@property(nonatomic,strong)ParentLabel *childClassLabel;
@end


@implementation XHChildCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _childButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 15, USER_HEARD, USER_HEARD)];
        _childButton.layer.cornerRadius=USER_HEARD/2.0;
        _childButton.layer.masksToBounds=YES;
        _childButton.userInteractionEnabled=NO;
        [self.contentView addSubview:_childButton];
        _childNameLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(-10, USER_HEARD+20, USER_HEARD+20, 20)];
        _childNameLabel.textAlignment=NSTextAlignmentCenter;
        _childNameLabel.font=kFont(15.0);
        [self.contentView addSubview:_childNameLabel];
        _childClassLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(-10, _childNameLabel.bottom+5, USER_HEARD+20, 15)];
        _childClassLabel.textAlignment=NSTextAlignmentCenter;
        _childClassLabel.font=kFont(13.0);
        _childClassLabel.textColor=DEFAULTCOLOR;
        [self.contentView addSubview:_childClassLabel];
    }
    return self;
}
-(void)setItemObject:(XHChildListModel *)model
{
    [self.childButton setHeadrPic:model.headPic withName:model.studentName withType:XHstudentType];
    self.childNameLabel.text=model.studentName;
    self.childClassLabel.text=model.clazzName;
}

@end
