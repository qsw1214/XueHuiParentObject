//
//  XHSubmitCollectionViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSubmitCollectionViewCell.h"
#import "XHRecipientModel.h"
@interface XHSubmitCollectionViewCell ()
@property(nonatomic,strong)ParentLabel *nameLabel;
@property(nonatomic,strong)UIButton *headbutton;
@property(nonatomic,strong)ParentLabel *headLabel;
@end

@implementation XHSubmitCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _headbutton=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, frame.size.width-10, frame.size.width-10)];
        _headbutton.userInteractionEnabled=NO;
        [_headbutton setHeadBackgroundImage:[UIImage imageNamed:@"ico_addpeo"] forState:UIControlStateNormal];
        _headbutton.layer.cornerRadius=frame.size.width/2.0-5;
        _headbutton.layer.masksToBounds=YES;
        [self.contentView addSubview:_headbutton];
        _nameLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(0, _headbutton.bottom, frame.size.width, frame.size.height-_headbutton.height)];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}
-(void)setItemObject:(XHRecipientModel *)model
{
    if (model.modelType==XHRecipientNomalModelType) {
        self.nameLabel.text=model.name;
        [self.headbutton setHeadrPic:model.headPic withName:model.name withType:XHstudentType];
    }
    else
    {
        self.nameLabel.text=nil;
        [self.headbutton setHeadBackgroundImage:[UIImage imageNamed:@"ico_addpeo"] forState:UIControlStateNormal];
    }
}

@end
