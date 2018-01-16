//
//  BaseTipView.h
//  BaseTipView
//
//  Created by XueHui on 17/7/31.
//  Copyright © 2017年 姚立志. All rights reserved.
//
#pragma mark 表视图中提示“网络异常，请重试”视图

typedef NS_ENUM(NSInteger,BaseTipViewType)
{
    /**
     文本类型
     */
    TipTitleType = 1,
    /**
     文本和图片类型
     */
    TipTitleAndTipImage = 2,
    
    TipImage = 3,
};


#import <UIKit/UIKit.h>
#import "BaseButtonControl.h"

@interface BaseTipView : UIView

@property (nonatomic,strong) BaseButtonControl *tipButton; //!< 提示图片视图


#pragma mark 设置提醒类型、提醒标题、提醒图标
/**
 type设置当前的提示类型
 1.只有文字类型的提示
 2.文字和图标类型的提示
 
 tipTitle:提醒的标题
 tipImage:提醒的图片
 
 withSuperViewFrame:添加的父视图
 
 */
-(void)setTipType:(BaseTipViewType)type withTipTitle:(NSString*)tipTitle withTipImage:(NSString*)tipImage;




@end
