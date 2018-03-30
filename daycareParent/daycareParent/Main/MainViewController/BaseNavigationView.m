//
//  BaseNavigationView.m
//  liaotian
//
//  Created by Git on 17/7/10.
//  Copyright © 2017年 姚立志. All rights reserved.
//

#import "BaseNavigationView.h"
@interface BaseNavigationView ()


@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签

@property (nonatomic,strong) UIView *bottomView; //!< 底部颜色视图

@end




@implementation BaseNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.letfItem];
        [self addSubview:self.rightItem];
        [self addSubview:self.titleLabel];
        [self addSubview:self.bottomView];
        [self setItemColor:NO];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    CGFloat height = frame.size.height > 64.0 ? 30.0 : 0.0;
    [self.letfItem setFrame:CGRectMake(0, (20+height), 80, 44)];
    [self.titleLabel setFrame:CGRectMake(80, (20+height), SCREEN_WIDTH-(80*2), 44)];
    [self.rightItem setFrame:CGRectMake(SCREEN_WIDTH-80, (20+height), 80, 44)];
    [self.bottomView setFrame:CGRectMake(0, ((64.0+height)-0.5), SCREEN_WIDTH, 0.5)];
}




#pragma mark 设置按钮的样式
-(void)setItemContentType:(BaseNavigationControlItemContentType)contentType withItemType:(BaseNavigationControlItemType)itemType withIconName:(NSString*)iconName withTitle:(NSString*)title
{
    switch (itemType)
    {
        case NavigationItemLeftType:
        {
            [self.letfItem setItemContentType:contentType withItemType:itemType withIconName:iconName withTitle:title];
        }
            break;
        case NavigationItemRightype:
        {
            [self.rightItem setItemContentType:contentType withItemType:itemType withIconName:iconName withTitle:title];
        }
            break;
        case NavigationItemLeftAndRightype:
        {
            [self.letfItem setItemContentType:contentType withItemType:itemType withIconName:iconName withTitle:title];
            [self.rightItem setItemContentType:contentType withItemType:itemType withIconName:iconName withTitle:title];
        }
            break;
    }
}

#pragma mark 设置标题
-(void)setNavtionTitle:(NSString*)title
{
    [self.titleLabel setText:title];
}

#pragma mark 设置标题颜色
-(void)setNavtionTitleColor:(UIColor*)color
{
    [self.titleLabel setTextColor:color];
}


#pragma mark 设置左标题
-(void)setLeftItemTitle:(NSString*)title
{
    [self.letfItem setTitle:title];
}
#pragma mark 设置右标题
-(void)setRightItemTitle:(NSString*)title
{
    [self.rightItem setTitle:title];
}


#pragma mark 设置左右按钮标题颜色
-(void)setItemTextColor:(UIColor*)color withItemType:(BaseNavigationControlItemType)type
{
    switch (type)
    {
     
        case NavigationItemLeftType:
        {
            [self.letfItem setTextColor:color];
        }
            break;
        case NavigationItemRightype:
        {
            [self.rightItem setTextColor:color];
        }
            break;
        case NavigationItemLeftAndRightype:
        {
            [self.rightItem setTextColor:color];
            [self.letfItem setTextColor:color];
        }
            break;
    }
}

#pragma mark 设置左图标
-(void)setLeftImageName:(NSString*)imageName
{
    [self.letfItem setImageName:imageName];
}
#pragma mark 设置右图标
-(void)setRightImageName:(NSString*)imageName
{
    [self.rightItem setImageName:imageName];
}



#pragma mark 设置按钮的隐藏类型
-(void)setItemContentItemHiddenWithType:(BaseNavigationControlItemHiddenType)hiddenType withHidden:(BOOL)hidden
{
    switch (hiddenType)
    {
        case NavigationLeftType:
        {
            [self.letfItem setHidden:hidden];
        }
            break;
        case NavigationRightType:
        {
            [self.rightItem setHidden:hidden];
        }
            break;
        case NavigationLeftAndRight:
        {
            [self.letfItem setHidden:hidden];
            [self.rightItem setHidden:hidden];
        }
    }
}

#pragma mark - Getter / Setter
-(BaseNavigationControlItem *)letfItem
{
    if (_letfItem == nil)
    {
        _letfItem = [[BaseNavigationControlItem alloc]initWithFrame:CGRectMake(0, 20, 80, 44)];
    }
    return _letfItem;
}

-(BaseNavigationControlItem *)rightItem
{
    if (_rightItem == nil)
    {
        _rightItem = [[BaseNavigationControlItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 20, 80, 44)];
        
    }
    return _rightItem;
}


-(UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, SCREEN_WIDTH-(80*2), 44)];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UIView *)bottomView
{
    if (_bottomView==nil) {
        _bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
        _bottomView.backgroundColor=LineViewColor;
    }
    return _bottomView;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.letfItem setBackgroundColor:[UIColor redColor]];
        [self.rightItem setBackgroundColor:[UIColor darkGrayColor]];
        [self.titleLabel setBackgroundColor:[UIColor purpleColor]];
        
        [self.letfItem setHidden:NO];
        [self.rightItem setHidden:NO];
        [self.titleLabel setHidden:NO];
    }
}


@end
