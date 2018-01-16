//
//  XHNoticeDetailView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/21.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNoticeDetailView.h"

@interface XHNoticeDetailView () <UITableViewDelegate,UITableViewDataSource,XHNoticeCellContentViewDeletage>


@property (nonatomic,weak) id <XHNoticeDetailViewDeletage> deletage;



@end

@implementation XHNoticeDetailView


-(instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:[UIColor redColor]];
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
    [self.tableView refreshReloadData];
}


#pragma mark - Deletage Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}

- (XHNoticeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==  nil)
    {
        cell = [[XHNoticeTableViewCell alloc]initWithDeletage:self];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row] withIndexPath:indexPath];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark XHNoticeContentViewDeletage Method
-(void)videoPlayerAction:(XHNoticeFrame *)object
{
    [[XHVideoControl sharedVideo] playerWithModel:object.model.playModel];
}

-(void)refreshHeaderAction
{
    [self.tableView refreshReloadData];
}


-(void)dealloc
{
    [[XHVideoControl sharedVideo] dismiss];
}




@end
