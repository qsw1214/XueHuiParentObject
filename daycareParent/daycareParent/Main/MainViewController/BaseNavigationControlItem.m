//
//  BaseNavigationControlItem.m
//  BaseViewController
//
//  Created by Git on 17/7/10.
//  Copyright © 2017年 Object. All rights reserved.
//

#import "BaseNavigationControlItem.h"





@interface BaseNavigationControlItem ()

@property (nonatomic,assign) CGRect BaseNavigationFrame; //!< 记录当前导航条的Farme，为了后面设置图标和标题使用

@property (nonatomic,strong) UIImageView *iconImageView; //!< 图标
@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签

@end

@implementation BaseNavigationControlItem



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        [self setBaseNavigationFrame:frame];
        [self addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self setitemColor:NO];
    }
    return self;
}



#pragma mark - Action Method
-(void)setItemContentType:(BaseNavigationControlItemContentType)contentType withItemType:(BaseNavigationControlItemType)itemType withIconName:(NSString*)iconName withTitle:(NSString*)title
{
    [self.titleLabel setHidden:YES];
    [self.iconImageView setHidden:YES];
    [self setHidden:NO];
    switch (contentType)
    {
        case NavigationTitleType: //!< 标题类型
        {
            switch (itemType)
            {
                case NavigationItemLeftType:
                {
                    [self.titleLabel setHidden:NO];
                    [self.titleLabel setFrame:CGRectMake(10, 0, self.BaseNavigationFrame.size.width, self.BaseNavigationFrame.size.height)];
                    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
                    [self.titleLabel setText:title];
                }
                    break;
                case NavigationItemRightype:
                {
                    [self.titleLabel setHidden:NO];
                    [self.titleLabel setFrame:CGRectMake(0, 0, self.BaseNavigationFrame.size.width-10, self.BaseNavigationFrame.size.height)];
                    [self.titleLabel setTextAlignment:NSTextAlignmentRight];
                    [self.titleLabel setText:title];
                }
                    break;
                case NavigationItemLeftAndRightype:
                    break;
            }
            
        }
            break;
        case NavigationIconype: //!< 图标类型
        {
            switch (itemType)
            {
                case NavigationItemLeftType:
                {
                    [self.iconImageView setHidden:NO];
                    [self.iconImageView setImage:[UIImage imageNamed:(iconName ? iconName : nil)]];
                    [self.iconImageView setFrame:CGRectMake(10, (44-20)/2.0, 20, 20)];
                }
                    break;
                case NavigationItemRightype:
                {
                    [self.iconImageView setHidden:NO];
                    [self.iconImageView setImage:[UIImage imageNamed:(iconName ? iconName : nil)]];
                    [self.iconImageView setFrame:CGRectMake(self.BaseNavigationFrame.size.width-40, (44-20)/2.0, 20, 20)];
                }
                    break;
                case NavigationItemLeftAndRightype:
                    break;
            }
        }
        
            break;
        case NavigationIconAndTitle: //!< 图标和标题类型
        {
            switch (itemType)
            {
                case NavigationItemLeftType:
                {
                    [self.iconImageView setHidden:NO];
                    [self.iconImageView setImage:[UIImage imageNamed:(iconName ? iconName : nil)]];
                    [self.iconImageView setFrame:CGRectMake(10, (44-20)/2.0, 20, 20)];
                    
                    [self.titleLabel setHidden:NO];
                    [self.titleLabel setFrame:CGRectMake(self.iconImageView.right, 0, (self.BaseNavigationFrame.size.width-self.iconImageView.right), self.BaseNavigationFrame.size.height)];
                    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
                    [self.titleLabel setText:title];
                }
                    break;
                case NavigationItemRightype:
                {
                    [self.iconImageView setHidden:NO];
                    [self.iconImageView setImage:[UIImage imageNamed:(iconName ? iconName : nil)]];
                    [self.iconImageView setFrame:CGRectMake((self.BaseNavigationFrame.size.width-40), (44-20)/2.0, 20, 20)];
                    [self.titleLabel setHidden:NO];
                    [self.titleLabel setFrame:CGRectMake(0, 0, (self.BaseNavigationFrame.size.width-40.0), self.BaseNavigationFrame.size.height)];
                    [self.titleLabel setTextAlignment:NSTextAlignmentRight];
                    [self.titleLabel setText:title];
                }
                    break;
                case NavigationItemLeftAndRightype:
                    break;
            }
        }
            break;
    }
}

#pragma mark 要隐藏的按钮
-(void)setItemContentItemHiddenWithType:(BaseNavigationControlItemHiddenType)hiddenType withHidden:(BOOL)hidden
{
    
}


#pragma mark 设置标题
-(void)setTitle:(NSString*)title
{
    [self.titleLabel setText:title];
}


#pragma mark 设置标题
-(void)setTextColor:(UIColor*)color
{
    [self.titleLabel setTextColor:color];
}

#pragma mark 设置图标名称
-(void)setImageName:(NSString*)imageName
{
    [self.iconImageView setImage:[UIImage imageNamed:imageName]];
}


-(void)setitemColor:(BOOL)color
{
    if (color)
    {
        [self.iconImageView setBackgroundColor:[UIColor grayColor]];
        [self.titleLabel setBackgroundColor:[UIColor orangeColor]];
    }
}



#pragma mark - Getter / Setter

-(UIImageView *)iconImageView
{
    if (_iconImageView == nil)
    {
        _iconImageView = [[UIImageView alloc]init];
        [_iconImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _iconImageView;
}



-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setAdjustsFontSizeToFitWidth:YES];
        [_titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
    }
    return _titleLabel;
}


-(void)selectedAction:(BaseNavigationControlItem*)sender
{
//    [self setUserInteractionEnabled:NO];
//    [self performSelector:@selector(userInteractionEnabled:) withObject:@"可以使用" afterDelay:1.0];
}

-(void)userInteractionEnabled:(NSString*)object
{
//    [self setUserInteractionEnabled:YES];
}





@end

