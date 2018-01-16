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
@property (nonatomic,strong) BaseButtonControl *headerControl; //!< 头像
@property (nonatomic,strong) BaseButtonControl *gradeControl; //!< 年级
@property (nonatomic,strong) UILabel *userNameLael; //!< 用户名标签
@property (nonatomic,strong) UILabel *subjectLabel;  //!< 学科标签
@property (nonatomic,strong) UILabel *dateLabel; //!< 日期标签
@property (nonatomic,strong) UILabel *contentLabel; //!< 作业标签
@property (nonatomic,strong) UIView *lineView; //!< 分割线

@end



@implementation XHHomeWorkCellContentView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
     
        [self setItemColor:NO];
        [self addSubview:self.headerControl];
        [self addSubview:self.userNameLael];
        [self addSubview:self.subjectLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.gradeControl];
        [self addSubview:self.collectionView];
        
    }
    return self;
}


-(void)setItemFrame:(XHHomeWorkFrame*)itemFrame
{
    //重置Frame
    [self setFrame:itemFrame.itemFrame];
    
    switch (itemFrame.model.homeWorkType)
    {
#pragma mark case HomeWorkType
        case HomeWorkType:
        {
            [self.headerControl resetFrame:CGRectMake(10.0, 10.0, 60.0, 60.0)];
            //设置用户名
            [self.userNameLael setFrame:CGRectMake(self.headerControl.right+10.0, self.headerControl.top, 60.0, 30.0)];
            [self.subjectLabel setFrame:CGRectMake(self.userNameLael.right+5.0, self.userNameLael.top+5, itemFrame.subjectSize.width, (self.userNameLael.height-10.0))];
            //设置日期
            [self.dateLabel setFrame:CGRectMake(self.subjectLabel.right+5.0, self.subjectLabel.top, (itemFrame.itemFrame.size.width-(self.subjectLabel.right+15.0)), self.subjectLabel.height)];
            //设置内容视图
            [self.contentLabel setFrame:CGRectMake(self.userNameLael.left, self.userNameLael.bottom, (itemFrame.itemFrame.size.width-(self.userNameLael.left+10.0)), 30.0)];
            [self.lineView setFrame:CGRectMake(0, itemFrame.itemFrame.size.height-0.5, itemFrame.itemFrame.size.width, 0.5)];
            
            //设置属性
            [self.subjectLabel setLayerCornerRadius:(self.subjectLabel.height/2.0)];
            [self.subjectLabel setBackgroundColor:itemFrame.model.subjectColor];
            [self.contentLabel setNumberOfLines:1];
            
            
            //赋值
            [self.headerControl sd_setImageWithURL:itemFrame.model.headerUrl withPlaceholder:@"addman" withNumberType:0 withAllType:NO];
            [self.userNameLael setText:itemFrame.model.userName];
            [self.subjectLabel setText:itemFrame.model.subject];
            [self.dateLabel setText:itemFrame.model.releaseDate];
            [self.contentLabel setText:itemFrame.model.workContent];
            switch (itemFrame.model.homeWorkUnreadType)
            {
                case HomeWorkUnreadType:
                {
                    [self.headerControl setIconImageViewBackGroundColor:[UIColor redColor] withNumberType:1 withAllType:NO];
                    [self.userNameLael setFont:[UIFont boldSystemFontOfSize:16.0]];
                    [self.contentLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
                }
                    break;
                case HomeWorkAlreadyReadType:
                {
                    [self.headerControl setIconImageViewBackGroundColor:[UIColor clearColor] withNumberType:1 withAllType:NO];
                    [self.userNameLael setFont:FontLevel2];
                    [self.contentLabel setFont:FontLevel2];
                }
                    break;
            }
        }
            break;
#pragma mark case HomeWorkDetailsType
        case HomeWorkDetailsType:
        {
            [self.headerControl resetFrame:CGRectMake(10.0, 10.0, 60.0, 60.0)];
            [self.userNameLael setFrame:CGRectMake(self.headerControl.right+10.0, self.headerControl.top, 60.0, 30.0)];
            [self.subjectLabel setFrame:CGRectMake(self.userNameLael.right+5.0, self.userNameLael.top+5, itemFrame.subjectSize.width, (self.userNameLael.height-10.0))];
            [self.subjectLabel setLayerCornerRadius:(self.subjectLabel.height/2.0)];
            [self.subjectLabel setBackgroundColor:itemFrame.model.subjectColor];
            [self.contentLabel setFrame:CGRectMake(self.userNameLael.left, self.userNameLael.bottom, itemFrame.contentSize.width, itemFrame.contentSize.height)];
            [self.collectionView resetFrame:CGRectMake(self.contentLabel.left, self.contentLabel.bottom+5.0, itemFrame.previewSize.width, itemFrame.previewSize.height)];
            [self.gradeControl resetFrame:CGRectMake(self.contentLabel.left, (self.contentLabel.bottom+(itemFrame.previewSize.height > 0 ? itemFrame.previewSize.height+10.0 : 5.0) ), self.contentLabel.width-80, 20)];
            [self.dateLabel setFrame:CGRectMake(self.gradeControl.right+5.0, self.gradeControl.top, 80, self.gradeControl.height)];
            //设置属性
            [self.subjectLabel setLayerCornerRadius:(self.subjectLabel.height/2.0)];
            [self.subjectLabel setBackgroundColor:itemFrame.model.subjectColor];
            [self.contentLabel setNumberOfLines:0];
            [self.gradeControl setImageEdgeFrame:CGRectMake(0, 0, 20.0, self.gradeControl.height) withNumberType:0 withAllType:NO];
            [self.gradeControl setTitleEdgeFrame:CGRectMake(30.0, 0, self.gradeControl.width-30.0, self.gradeControl.height) withNumberType:0 withAllType:NO];
            
            [self.headerControl sd_setImageWithURL:itemFrame.model.headerUrl withPlaceholder:@"addman" withNumberType:0 withAllType:NO];
            [self.userNameLael setText:itemFrame.model.userName];
            [self.subjectLabel setText:itemFrame.model.subject];
            [self.dateLabel setText:itemFrame.model.releaseDate];
            [self.contentLabel setText:itemFrame.model.workContent];
            [self.gradeControl setText:[NSString stringWithFormat:@"%@%@",itemFrame.model.gradeName,itemFrame.model.clazzName] withNumberType:0 withAllType:NO];
            [self.collectionView setItemArray:itemFrame.model.imageUrlArray];
        }
            break;
    }
    
    

   
}






#pragma mark - Getter / Setter
-(BaseButtonControl *)headerControl
{
    if (_headerControl == nil)
    {
        _headerControl = [[BaseButtonControl alloc]init];
        [_headerControl setNumberImageView:2];
        [_headerControl setImageEdgeFrame:CGRectMake(0, 0, 60.0, 60.0) withNumberType:0 withAllType:NO];
        [_headerControl setImageEdgeFrame:CGRectMake(50.0, 5.0, 10.0, 10.0) withNumberType:1 withAllType:NO];
        [_headerControl setImageLayerCornerRadius:30.0 withNumberType:0 withAllType:NO];
        [_headerControl setImageLayerCornerRadius:5.0 withNumberType:1 withAllType:NO];
    }
    return _headerControl;
}


-(BaseButtonControl *)gradeControl
{
    if (_gradeControl == nil)
    {
        _gradeControl = [[BaseButtonControl alloc]init];
        [_gradeControl setNumberLabel:1];
        [_gradeControl setNumberImageView:1];
        [_gradeControl setTextColor:RGB(124, 124, 124) withTpe:0 withAllType:NO];
        [_gradeControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_gradeControl setImage:@"ico_class" withNumberType:0 withAllType:NO];
    }
    return _gradeControl;
}


-(UILabel *)userNameLael
{
    if (_userNameLael == nil)
    {
        _userNameLael = [[UILabel alloc]init];
        [_userNameLael setTextColor:RGB(2, 2, 2)];
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
         [_subjectLabel setFont:FontLevel3];
    }
    return _subjectLabel;
}

-(UILabel *)dateLabel
{
    if (_dateLabel == nil)
    {
        _dateLabel = [[UILabel alloc]init];
        [_dateLabel setTextAlignment:NSTextAlignmentRight];
        [_dateLabel setTextColor:RGB(124, 124, 124)];
        [_dateLabel setFont:FontLevel4];
    }
    return _dateLabel;
}

-(UILabel *)contentLabel
{
    if (_contentLabel == nil)
    {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setTextColor:RGB(3, 3, 3)];
        [_contentLabel setFont:FontLevel2];
    }
    return _contentLabel;
}

-(UIView *)lineView
{
    if (_lineView == nil)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
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
        [self.headerControl setIconImageViewBackGroundColor:[UIColor redColor] withNumberType:0 withAllType:NO];
        [self.headerControl setIconImageViewBackGroundColor:[UIColor greenColor] withNumberType:1 withAllType:NO];
    }
}






@end
