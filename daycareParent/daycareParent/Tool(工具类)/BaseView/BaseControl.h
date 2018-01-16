//
//  BaseControl.h
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//





#import <UIKit/UIKit.h>
#import "BaseTableView.h"

@interface BaseControl : UIControl

@property (nonatomic,strong) NSMutableArray *dataArray; //!< 数据源数组
@property (nonatomic,strong) BaseTableView *tableView; //!< 表视图
@property (nonatomic,strong) XHNetWorkConfig *netWorkConfig; //!< 网络请求


-(instancetype)init;
-(void)resetFrame:(CGRect)frame;
-(void)setItemArray:(NSMutableArray*)array;
-(void)setItemFrame:(id)frame;




@end
