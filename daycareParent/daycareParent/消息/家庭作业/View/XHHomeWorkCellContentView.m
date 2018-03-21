//
//  XHHomeWorkCellContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkCellContentView.h"
#import "XHHomeWorkCollectionView.h"
#import "BaseButtonControl.h"



@interface XHHomeWorkCellContentView ()

@property (nonatomic,strong) XHHomeWorkCollectionView *collectionView;
@property (nonatomic,strong) XHHeaderControl *headerImageView; //!< 头像
@property (nonatomic,strong) UILabel *userNameLael; //!< 用户名标签
@property (nonatomic,strong) UILabel *subjectLabel;  //!< 学科标签
@property (nonatomic,strong) UILabel *dateLabel; //!< 日期标签
@property (nonatomic,strong) UILabel *contentLabel; //!< 作业标签

@end



@implementation XHHomeWorkCellContentView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
     
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.headerImageView];
        [self addSubview:self.userNameLael];
        [self addSubview:self.subjectLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.collectionView];
        
        
        [self setItemColor:NO];
        
    
        
    }
    return self;
}


-(void)setItemFrame:(XHHomeWorkFrame*)itemFrame
{
    //重置Frame
    [self setFrame:itemFrame.itemFrame];
    [self setLayerCornerRadius:5.0];
    [self.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self.layer setShadowRadius:5.0];
    
    switch (itemFrame.model.homeWorkType)
    {
#pragma mark case HomeWorkType
        case HomeWorkType:
        {
            //设置头像
            [self.headerImageView resetFrame:CGRectMake(10.0, 10.0, 40.0, 40.0)];
            [self.headerImageView setLayerCornerRadius:(self.headerImageView.height/2.0)];
            //设置用户名
            [self.userNameLael setFrame:CGRectMake((self.headerImageView.right+10.0), self.headerImageView.top, (itemFrame.itemFrame.size.width-((self.headerImageView.right+10.0)+55.0)), 20.0)];
            [self.userNameLael setTextAlignment:NSTextAlignmentLeft];
            //设置日期
            [self.dateLabel setFrame:CGRectMake(self.userNameLael.left, (self.userNameLael.bottom+5.0), self.userNameLael.width, (self.userNameLael.height-5.0))];
            [self.dateLabel setTextAlignment:NSTextAlignmentLeft];
            //设置属性
            [self.subjectLabel setFrame:CGRectMake((itemFrame.itemFrame.size.width-45.0), (self.headerImageView.top+2.5), 35.0, 35.0)];
            [self.subjectLabel setLayerCornerRadius:5.0];
            //设置内容视图
            [self.contentLabel setFrame:CGRectMake(self.headerImageView.left, (self.headerImageView.bottom+10.0), (itemFrame.contentSize.width), (itemFrame.contentSize.height))];
        
            //设置
            switch (itemFrame.model.contentType)
            {
                case XHHomeWorkTextType:
                {
                    [self.collectionView resetFrame:CGRectZero];
                }
                    break;
                case XHHomeWorkTextAndImageType:
                {
                    [self.collectionView resetFrame:CGRectMake(self.headerImageView.left, self.contentLabel.bottom+5.0, itemFrame.previewSize.width, itemFrame.previewSize.height)];
                    [self.collectionView setItemArray:itemFrame.model.imageUrlArray];
                }
                    break;
            }
            
            
            
           
            
            
            //赋值
            [self.headerImageView setHeadrUrl:itemFrame.model.headerPic withName:itemFrame.model.userName withType:XHHeaderTeacherType];
            [self.userNameLael setText:itemFrame.model.userName];
            [self.subjectLabel setText:itemFrame.model.subject];
            [self.dateLabel setText:itemFrame.model.releaseDate];
            [self.contentLabel setText:itemFrame.model.workContent];
            
            switch (itemFrame.model.homeWorkUnreadType)
            {
                case HomeWorkUnreadType:
                {
                    [self.subjectLabel setBackgroundColor:RGB(255,86,87)];
                }
                    break;
                case HomeWorkAlreadyReadType:
                {
                    [self.subjectLabel setBackgroundColor:MainColor];
                }
                    break;
            }
        }
            break;
#pragma mark case NotifyType
        case NotifyType:
        {
            //!< 学科
            [self.subjectLabel setHidden:YES];
            
            //设置头像
            [self.headerImageView resetFrame:CGRectMake(10.0, 10.0, 40.0, 40.0)];
            [self.headerImageView setLayerCornerRadius:(self.headerImageView.height/2.0)];
            //设置属性
            [self.subjectLabel setFrame:CGRectMake(self.headerImageView.left+30.0, (self.headerImageView.top+2.5), 10.0, 10.0)];
            [self.subjectLabel setLayerCornerRadius:(self.subjectLabel.height/2.0)];
            //设置用户名
            [self.userNameLael setFrame:CGRectMake((self.headerImageView.right+10.0), (self.headerImageView.top+10.0), ((itemFrame.itemFrame.size.width-(self.headerImageView.right+20.0))/2.0), 20.0)];
            //设置日期
            [self.dateLabel setFrame:CGRectMake(self.userNameLael.right, (self.userNameLael.top), self.userNameLael.width, (self.userNameLael.height-5.0))];
            [self.dateLabel setTextAlignment:NSTextAlignmentRight];
            //设置内容视图
            [self.contentLabel setFrame:CGRectMake(self.headerImageView.left, (self.headerImageView.bottom+10.0), (itemFrame.contentSize.width), (itemFrame.contentSize.height))];
            
            //设置
            switch (itemFrame.model.contentType)
            {
                case XHHomeWorkTextType:
                {
                    [self.collectionView resetFrame:CGRectZero];
                }
                    break;
                case XHHomeWorkTextAndImageType:
                {
                    [self.collectionView resetFrame:CGRectMake(self.headerImageView.left, self.contentLabel.bottom+5.0, itemFrame.previewSize.width, itemFrame.previewSize.height)];
                    [self.collectionView setItemArray:itemFrame.model.imageUrlArray];
                }
                    break;
            }
            
            
            
            
            
            
            //赋值
            [self.headerImageView setHeadrUrl:itemFrame.model.headerPic withName:itemFrame.model.userName withType:XHHeaderTeacherType];
            [self.userNameLael setText:itemFrame.model.userName];
            [self.dateLabel setText:itemFrame.model.releaseDate];
            [self.contentLabel setText:itemFrame.model.workContent];
            switch (itemFrame.model.homeWorkUnreadType)
            {
                case HomeWorkUnreadType:
                {
                    [self.subjectLabel setBackgroundColor:RGB(255,86,87)];
                    [self.subjectLabel setHidden:NO];
                }
                    break;
                case HomeWorkAlreadyReadType:
                {
                    [self.subjectLabel setBackgroundColor:MainColor];
                    [self.subjectLabel setHidden:YES];
                }
                    break;
            }
        }
            break;
    }
    
    

   
}






#pragma mark - Getter / Setter
-(XHHeaderControl *)headerImageView
{
    if (_headerImageView == nil)
    {
        _headerImageView = [[XHHeaderControl alloc]init];
    }
    return _headerImageView;
}

-(UILabel *)userNameLael
{
    if (_userNameLael == nil)
    {
        _userNameLael = [[UILabel alloc]init];
        [_userNameLael setTextColor:RGB(51,51,51)];
        [_userNameLael setFont:FontLevel2];
    }
    return _userNameLael;
}
-(UILabel *)subjectLabel
{
    if (_subjectLabel == nil)
    {
        _subjectLabel = [[UILabel alloc]init];
        [_subjectLabel setTextAlignment:NSTextAlignmentCenter];
        [_subjectLabel setTextColor:[UIColor whiteColor]];
        [_subjectLabel setNumberOfLines:0];
        [_subjectLabel setFont:FontLevel4];
    }
    return _subjectLabel;
}

-(UILabel *)dateLabel
{
    if (_dateLabel == nil)
    {
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setTextColor:RGB(104,111,121)];
        [_dateLabel setFont:FontLevel2A];
    }
    return _dateLabel;
}

-(UILabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setFont:FontLevel2A];
        [_contentLabel setNumberOfLines:0];
        [_contentLabel setTextColor:RGB(51,51,51)];
    }
    return _contentLabel;
}

-(XHHomeWorkCollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        _collectionView = [[XHHomeWorkCollectionView alloc]init];
    }
    return _collectionView;
}







-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.userNameLael setBackgroundColor:[UIColor yellowColor]];
        [self.subjectLabel setBackgroundColor:[UIColor grayColor]];
        [self.dateLabel setBackgroundColor:[UIColor darkGrayColor]];
        [self.contentLabel setBackgroundColor:[UIColor purpleColor]];
        [self.headerImageView setBackgroundColor:[UIColor orangeColor]];
        [self.collectionView setBackgroundColor:[UIColor orangeColor]];
    }
}






@end
