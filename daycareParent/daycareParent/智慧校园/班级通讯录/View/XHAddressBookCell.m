//
//  XHAddressBookCell.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookCell.h"


@interface XHAddressBookCell ()

@property (nonatomic,strong) UIImageView *headerImageView; //!< 头像视图
@property (nonatomic,strong) UILabel *nameLabel; //!< 名字标签
@property (nonatomic,strong) UILabel *phoneLabel; //!< 手机标签
@property (nonatomic,strong) UIImageView *accessoryImageView; //!< 附件
@property (nonatomic,strong) XHAddressBookToolBar *toolBar; //!< 工具条
@property (nonatomic,strong) UIView *lineView; //!< 分割线



@end




@implementation XHAddressBookCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.accessoryImageView];
        [self.contentView addSubview:self.toolBar];
        [self.contentView addSubview:self.lineView];
        
        
        [self setItemColor:NO];
    }
    return self;
}



-(void)setItemFrame:(XHAddressBookFrame*)frame
{
    [self.headerImageView setFrame:CGRectMake(10.0, 10.0, 40.0, 40.0)];
    [self.headerImageView setLayerCornerRadius:(self.headerImageView.height/2.0)];
    [self.accessoryImageView setFrame:CGRectMake(frame.itemFrame.size.width-20.0, (60.0-20.0)/2.0, 20.0, 20.0)];
    
    [self.nameLabel setFrame:CGRectMake(self.headerImageView.right+10.0,self.headerImageView.top ,frame.itemFrame.size.width-(self.headerImageView.right+self.accessoryImageView.width+20.0),20.0)];
    [self.phoneLabel setFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom, self.nameLabel.width, self.nameLabel.height)];
    
    
    [self.toolBar resetFrame:CGRectMake(10.0, (self.headerImageView.bottom+5.0), frame.itemFrame.size.width, 45.0)];
    
    [self.lineView setFrame:CGRectMake(self.toolBar.left,frame.itemFrame.size.height-0.5 , frame.itemFrame.size.width, 0.5)];
    
    
    //根据数据模型类型设置图片的转动方向
    switch (frame.model.modelType)
    {
        case XHAddressBookModelNormalType:
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                [self.accessoryImageView setTransform:CGAffineTransformMakeRotation(0)];
                
            }];
            
            [self.toolBar setHidden:YES];
            
            
            
            
            
        }
            break;
        case XHAddressBookSelectType:
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                [self.accessoryImageView setTransform:CGAffineTransformMakeRotation(M_PI_2)];
                
            }];
            
            [self.toolBar setHidden:NO];
            
          
        }
            break;
    }
    
    //赋值
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:frame.model.headerUrl] placeholderImage:[UIImage imageNamed:@"addman"]];
    [self.nameLabel setText:frame.model.teacherName];
    [self.phoneLabel setText:frame.model.phone];
    [self.toolBar setItemFrame:frame];
}








#pragma mark - Getter / Setter
-(UIImageView *)headerImageView
{
    if (!_headerImageView)
    {
        _headerImageView = [[UIImageView alloc]init];
        [_headerImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _headerImageView;
}


-(UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc]init];
        [_nameLabel setFont:FontLevel3];
        [_nameLabel setTextColor:RGB(14, 14, 14)];
    }
    return _nameLabel;
}


-(UILabel *)phoneLabel
{
    if (!_phoneLabel)
    {
        _phoneLabel = [[UILabel alloc]init];
        [_phoneLabel setFont:FontLevel3];
        [_phoneLabel setTextColor:RGB(14, 14, 14)];
    }
    return _phoneLabel;
}

-(UIImageView *)accessoryImageView
{
    if (!_accessoryImageView)
    {
        _accessoryImageView = [[UIImageView alloc]init];
        [_accessoryImageView setImage:[UIImage imageNamed:@"ico_arrow"]];
        [_accessoryImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _accessoryImageView;
}

-(XHAddressBookToolBar *)toolBar
{
    if (!_toolBar)
    {
        _toolBar = [[XHAddressBookToolBar alloc]init];
        [_toolBar setHidden:YES];
    }
    return _toolBar;
}


-(UIView *)lineView
{
    if (!_lineView )
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.headerImageView setBackgroundColor:[UIColor orangeColor]];
        [self.nameLabel setBackgroundColor:[UIColor purpleColor]];
        [self.phoneLabel setBackgroundColor:[UIColor magentaColor]];
        [self.toolBar setBackgroundColor:[UIColor cyanColor]];
        [self.accessoryImageView setBackgroundColor:[UIColor greenColor]];
    }
}
@end
