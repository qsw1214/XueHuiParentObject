//
//  BaseCollectionView.h
//  ZhongBangShop
//
//  Created by XueHui on 17/9/12.
//  Copyright © 2017年 姚立志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTipView.h"


@interface BaseCollectionView : UICollectionView




@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) MJRefreshNormalHeader *animateHeader; //!< 头部
@property (nonatomic,strong) MJRefreshAutoNormalFooter *animateFooter; //!< 脚部

-(instancetype)init;


-(void)resetFrame:(CGRect)frame;



#pragma mark 设置头部和脚部的标题
/**
 title：刷新标题
 state:MJRefreshState类型枚举类型
 */
-(void)setFooterTitle:(NSString*)title forState:(MJRefreshState)state;
-(void)setHeaderTitle:(NSString*)title forState:(MJRefreshState)state;

#pragma mark 设置头部刷新
/**
 是否隐藏头部刷新，不调用该方法，默认为隐藏，调用该方法后即可显示
 -(void)refreshHeaderAction
 */
-(void)showRefresHeaderWithTarget:(id)target withSelector:(SEL)selector;




#pragma mark 设置脚部刷新
/**
 是否隐藏头部刷新，不调用该方法，默认为隐藏，调用该方法后即可显示
 -(void)refreshFooterAction
 */
-(void)showRefresFooterWithTarget:(id)target withSelector:(SEL)selector;


#pragma mark 项目中如果表数据源   为空的时候，显示提示图标
/**
 如果数组为空时显示提示图标
 */
-(void)tipViewWithArray:(NSMutableArray*)taskArray;

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

/**
 重新刷新数据
 */
-(void)refreshReloadData;

-(void)noMoreData;

-(void)setItemArray:(NSMutableArray*)itemArray;



@end

