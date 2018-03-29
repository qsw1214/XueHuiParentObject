//
//  XHAlertBoardControl.h
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//



typedef NS_ENUM(NSInteger,XHAlertBoardType)
{
    XHAlertBoardNormalType = 1, //!< 普通类型
    XHAlertBoardOptionType = 2, //!< 选择类型（设定监护人类型）
    XHAlertBoardKindType = 3, //!< 选择类型（爸爸、妈妈、其他类型）
};









#import "BaseControl.h"
#import "BaseCollectionView.h"
#import "XHAlertItemCell.h"



@protocol XHAlertBoardControlDelegate <NSObject>

-(void)didSelectItem:(XHAlertModel*)mdoel;

@end

@interface XHAlertBoardControl : BaseControl

@property (nonatomic,strong) BaseButtonControl *cancelControl;  //!< 取消
@property (nonatomic,strong) BaseButtonControl *confirmControl;  //!< 确定
@property (nonatomic,assign) XHAlertBoardType boardTyp;

@property (nonatomic,weak) id <XHAlertBoardControlDelegate> delegate;

-(void)setTitle:(NSString*)title;



@end
