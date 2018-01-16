//
//  XHHomeWorkDetailView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/21.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkDetailView.h"
@interface XHHomeWorkDetailView () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,weak) id <XHHomeWorkDetailViewDeletage> deletage;



@end

@implementation XHHomeWorkDetailView


-(instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        [self setDeletage:deletage];
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
    
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
    [self.dataArray setArray:array];
    [self.tableView reloadData];
}


#pragma mark - Deletage Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}

- (XHHomeWorkTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHHomeWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==  nil)
    {
        cell = [[XHHomeWorkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor=[UIColor whiteColor];
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.deletage respondsToSelector:@selector(didSelectAtIndex:)])
    {
        [self.deletage didSelectAtIndex:[self.dataArray objectAtIndex:indexPath.row]];
    }
}
@end
