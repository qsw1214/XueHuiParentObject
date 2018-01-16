//
//  BaseTableView.m
//  liaotian
//
//  Created by XueHui on 17/7/10.
//  Copyright © 2017年 姚立志. All rights reserved.
//

#import "BaseTableView.h"


@interface BaseTableView ()
@property (nonatomic,strong) BaseTipView *tipView; //!< 提示视图
@property (nonatomic,strong) NSMutableArray *dataSourceArray; //!< 数据源数组


@end

@implementation BaseTableView



-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self setBackgroundColor:RGB(238.0, 238.0, 238.0)];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self addSubview:self.tipView];
        [self.tipView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tipView setFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
    
    
}
#pragma mark 进入刷新

/**
 开始刷新
 */
-(void)beginRefreshing
{
    [self.header beginRefreshing];
}


#pragma mark 设置头部和脚部的标题
-(void)setFooterTitle:(NSString*)title forState:(MJRefreshState)state
{
    [self.animateFooter setTitle:title forState:state];
}


#pragma mark 设置头部和脚部的标题
-(void)setHeaderTitle:(NSString*)title forState:(MJRefreshState)state
{
    [self.animateHeader setTitle:title forState:state];
}


#pragma mark 是否隐藏头部刷新，不调用该方法，默认为隐藏，调用该方法后即可显示
/**
 是否隐藏头部刷新，不调用该方法，默认为隐藏，调用该方法后即可显示
  -(void)refreshHeaderAction
 */
-(void)showRefresHeaderWithTarget:(id)target withSelector:(SEL)selector
{
    self.animateHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:selector];
    [self setHeader:self.animateHeader];
}




#pragma mark 设置脚部刷新
/**
 是否隐藏头部刷新，不调用该方法，默认为隐藏，调用该方法后即可显示
  -(void)refreshFooterAction
 */
-(void)showRefresFooterWithTarget:(id)target withSelector:(SEL)selector;
{
    self.animateFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:selector];
    [self setFooter:self.animateFooter];
    
}


#pragma mark 项目中如果表数据源为空的时候，显示提示图标
/**
 如果数组为空时显示提示图标
 在表代理方法"numberOfRowsInSection"中添加
 */
-(void)tableTipViewWithArray:(NSMutableArray*)taskArray
{
    [self setDataSourceArray:taskArray];
}

#pragma mark 设置提醒类型、提醒标题、提醒图标
/**
 type设置当前的提示类型
 1.只有文字类型的提示
 2.文字和图标类型的提示
 
 tipTitle:提醒的标题
 tipImage:提醒的图片
 
 withSuperViewFrame:添加的父视图
 
 */
-(void)setTipType:(BaseTipViewType)type withTipTitle:(NSString*)tipTitle withTipImage:(NSString*)tipImage
{
    [self.tipView setTipType:type withTipTitle:tipTitle withTipImage:tipImage];
}

-(BaseTipView *)tipView
{
    if (_tipView == nil)
    {
        _tipView = [[BaseTipView alloc]init];
        [_tipView.tipButton addTarget:self action:@selector(tipButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tipView setHidden:YES];
    }
    return _tipView;
}


-(NSMutableArray *)dataSourceArray
{
    if (_dataSourceArray == nil)
    {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}
/**
 重新刷新数据
 */
-(void)refreshReloadData
{
    [self reloadData];
    [self.dataSourceArray count] >0 ? [self.tipView setHidden:YES] :[self.tipView setHidden:NO];
    [self.header endRefreshing];
    [self.footer endRefreshing];
}
/**
 重新刷新数据
 */
-(void)refreshReload
{
    [self reloadData];
    [self.header endRefreshing];
    [self.footer endRefreshing];
}
-(void)noMoreData
{
    [self refreshReloadData];
    [self.footer noticeNoMoreData];
}

-(void)tipButtonAction:(BaseButtonControl*)sender
{
    [self beginRefreshing];
}

@end
