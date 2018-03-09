//
//  BaseScrollView.h
//  daycareParent
//
//  Created by Git on 2017/12/23.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseScrollView : UIScrollView

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) MJRefreshNormalHeader *animateHeader; //!< 头部
@property (nonatomic,strong) MJRefreshAutoNormalFooter *animateFooter; //!< 脚部



#pragma mark - Public Method
-(void)resetFrame:(CGRect)frame;



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


-(void)beginRefreshing;


/**
 重新刷新数据
 */
-(void)refreshReloadData;


-(void)setItemColor:(BOOL)color;



@end
