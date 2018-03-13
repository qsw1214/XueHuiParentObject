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
@property(nonatomic,strong)ParentImageView *headImageView;

@end

@implementation XHSubmitCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _headImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        _headImageView.image=[UIImage imageNamed:@"ico_addpeo"];
        _headImageView.layer.cornerRadius=frame.size.width/2.0;
        _headImageView.layer.masksToBounds=YES;
        [self.contentView addSubview:_headImageView];
        _nameLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(0, _headImageView.bottom, frame.size.width, frame.size.height-_headImageView.height)];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        //_nameLabel.text=@"完颜忍忍";
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}
-(void)setItemObject:(XHRecipientModel *)model
{
    if (model.modelType==XHRecipientNomalModelType) {
        self.nameLabel.text=model.name;
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(model.headPic)] placeholderImage:[UIImage imageNamed:@"addman"]];
    }
    else
    {
         self.nameLabel.text=nil;
         self.headImageView.image=[UIImage imageNamed:@"ico_addpeo"];
        
    }
}
@end
