//
//  BaseTipView.m
//  BaseTipView
//
//  Created by XueHui on 17/7/31.
//  Copyright © 2017年 姚立志. All rights reserved.
//

#import "BaseTipView.h"




@interface BaseTipView ()

@property (nonatomic,strong) UILabel *tipLabel; //!< 提示标签


@end

@implementation BaseTipView





- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setHidden:YES];
        [self addSubview:self.tipButton];
        [self setItemColor:NO];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [self.tipButton setCenter:CGPointMake(self.width/2.0, self.height/2.0)];
}





#pragma mark 设置提醒类型、提醒标题、提醒图标
/**
 type设置当前的提示类型
 1.只有文字类型的提示
 2.文字和图标类型的提示
 
 tipTitle:提醒的标题
 tipImage:提醒的图片
 
 superView:添加的父视图
 
 */
-(void)setTipType:(BaseTipViewType)type withTipTitle:(NSString*)tipTitle withTipImage:(NSString*)imageName
{
    switch (type)
    {
        case TipTitleType:
        {
            [self.tipButton resetFrame:CGRectMake(10.0, ((self.height-60.0)/2.0), SCREEN_WIDTH-20.0, 60.0)];
            [self.tipButton setTitleEdgeFrame:CGRectMake(0, 0, self.tipButton.width, self.tipButton.height) withNumberType:0 withAllType:NO];
            [self.tipButton setText:tipTitle withNumberType:0 withAllType:NO];
        }
            break;
        case TipTitleAndTipImage:
        {
            [self.tipButton resetFrame:CGRectMake(10.0, ((self.height-200.0)/2.0), SCREEN_WIDTH-20.0, 200.0)];
            [self.tipButton setImageEdgeFrame:CGRectMake(0, 0, self.tipButton.width, 140.0) withNumberType:0 withAllType:NO];
            [self.tipButton setTitleEdgeFrame:CGRectMake(0, 140.0, self.tipButton.width, 60.0) withNumberType:0 withAllType:NO];
            [self.tipButton setText:tipTitle withNumberType:0 withAllType:NO];
            [self.tipButton setText:tipTitle withNumberType:0 withAllType:NO];
            [self.tipButton setImage:imageName withNumberType:0 withAllType:NO];
        }
            break;
        case TipImage:
        {
            [self.tipButton resetFrame:CGRectMake(10.0, ((self.height-140.0)/2.0), SCREEN_WIDTH-20.0, 140.0)];
            [self.tipButton setImageEdgeFrame:CGRectMake(0, 0, self.tipButton.width, self.tipButton.height) withNumberType:0 withAllType:NO];
            [self.tipButton setImage:imageName withNumberType:0 withAllType:NO];
        }
            break;
    }
}


#pragma mark - Getter / Setter
-(BaseButtonControl *)tipButton
{
    if (_tipButton == nil)
    {
        _tipButton = [[BaseButtonControl alloc]init];
        [_tipButton setNumberImageView:1];
        [_tipButton setNumberLabel:1];
        [_tipButton setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_tipButton setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_tipButton setTextColor:[UIColor grayColor] withTpe:0 withAllType:NO];
        [_tipButton setNumberOfLines:0 withTpe:0 withAllType:NO];
        [_tipButton setImageContentMode:UIViewContentModeScaleAspectFit withNumberType:0 withAllType:NO];
    }
    return _tipButton;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.tipButton setBackgroundColor:[UIColor redColor]];
    }
}






@end
