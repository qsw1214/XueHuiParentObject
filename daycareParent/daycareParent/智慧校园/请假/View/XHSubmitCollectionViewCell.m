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
@property(nonatomic,strong)ParentLabel *headLabel;
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
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}
-(void)setItemObject:(XHRecipientModel *)model
{
    if (model.modelType==XHRecipientNomalModelType) {
        self.nameLabel.text=model.name;
        [self setHeadrPic:model.headPic withName:model.name withType:XHHeaderTeacherType];
    }
    else
    {
         self.nameLabel.text=nil;
         self.headLabel.hidden=YES;
         self.headImageView.image=[UIImage imageNamed:@"ico_addpeo"];
        
    }
}
-(ParentLabel *)headLabel
{
    if (_headLabel==nil) {
        _headLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.width)];
        _headLabel.layer.cornerRadius=self.contentView.frame.size.width/2.0;
        _headLabel.layer.masksToBounds=YES;
        [_headLabel setBackgroundColor:MainColor];
        [_headLabel setTextAlignment:NSTextAlignmentCenter];
        [_headLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [_headLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:_headLabel];
    }
    
    return _headLabel;
}
-(void)setHeadrPic:(NSString*)pic withName:(NSString*)name withType:(XHHeaderType)type
{
    
    pic = [NSString safeString:pic];
    if ([pic isEqualToString:@""])
    {
        self.headLabel.hidden=NO;
        NSInteger length = name.length;
        NSString *makeName = name;
        if ([name isEqualToString:@""])
        {
            [self.headLabel setText:name];
        }
        else
        {
            //        2.截取我们想要的字符串内容
            switch (type)
            {
                case XHHeaderTeacherType:
                {
                    makeName = [name substringWithRange:NSMakeRange(0,1)];
                }
                    break;
                case XHHeaderOtherType:
                {
                    makeName = [name substringWithRange:NSMakeRange((length-1),1)];
                }
                    break;
            }
            
            [self.headLabel setText:makeName];
        }
        
    }
    else
    {
        self.headLabel.hidden=YES;
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(pic)]];
    }
}

@end
