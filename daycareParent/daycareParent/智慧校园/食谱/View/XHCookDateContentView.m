//
//  XHCookDateContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCookDateContentView.h"


@interface XHCookDateContentView () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,weak) id <XHCookDateContentViewDeletage> deletage;

@end

@implementation XHCookDateContentView



- (instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        [self setDeletage:deletage];
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setBackgroundColor:[UIColor whiteColor]];
        [self.tableView setShowsVerticalScrollIndicator:NO];
        [self.tableView setShowsHorizontalScrollIndicator:NO];
     
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}


-(void)setItemArray:(NSMutableArray *)array
{
    
    [array enumerateObjectsUsingBlock:^(XHCookBookFrame *obj, NSUInteger idx, BOOL *stop)
     {
         if (idx == 0)
         {
             [obj.model setSelectType:CookBookSelectType];
         }
         else
         {
             [obj.model setSelectType:CookBookNormalType];
         }
     }];
    
    [self.dataArray setArray:array];
    [self.tableView reloadData];
    
    if ([self.dataArray count])
    {
        if ([self.deletage respondsToSelector:@selector(didSelectItemObject:)])
        {
            [self.deletage didSelectItemObject:[self.dataArray firstObject]];
        }
    }
    
}



#pragma mark - Deletage Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (XHCookBookCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHCookBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHCookBookCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray enumerateObjectsUsingBlock:^(XHCookBookFrame *obj, NSUInteger idx, BOOL *stop)
     {
         if (idx == indexPath.row)
         {
             [obj.model setSelectType:CookBookSelectType];
         }
         else
         {
             [obj.model setSelectType:CookBookNormalType];
         }
     }];
    
    [self.tableView reloadData];
    
    if ([self.deletage respondsToSelector:@selector(didSelectItemObject:)])
    {
        [self.deletage didSelectItemObject:[self.dataArray objectAtIndex:indexPath.row]];
    }
    
    
}


@end
