//
//  BaseControl.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"



@interface BaseControl ()


@end


@implementation BaseControl



- (instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self setHidden:NO];
}

-(void)setItemArray:(NSMutableArray*)array
{
    
}


-(void)setItemFrame:(id)frame
{
    
}

#pragma mark - GEtter / Setter
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


-(BaseTableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}


-(XHNetWorkConfig *)netWorkConfig
{
    if (!_netWorkConfig)
    {
        _netWorkConfig = [[XHNetWorkConfig alloc]init];
    }
    return _netWorkConfig;
}


@end
