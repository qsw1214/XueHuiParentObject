//
//  XHLeaveRecordContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHLeaveRecordContentView.h"



@interface XHLeaveRecordContentView () <UITableViewDelegate,UITableViewDataSource>


@end

@implementation XHLeaveRecordContentView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.tableView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
    }
    return self;
}




-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.tableView beginRefreshing];
}



#pragma mark - Deletage Method
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}

- (XHLeaveRecordTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHLeaveRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHLeaveRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];;
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}



#pragma mark - Action Method
-(void)refreshHeaderAction
{
    [self getLeaveRecordWithStudentBaseId:self.model.studentBaseId];
}










#pragma mark - NetWork Method
-(void)getLeaveRecordWithStudentBaseId:(NSString*)studentBaseId
{
    [self.netWorkConfig setObject:studentBaseId forKey:@"studentBaseId"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus014" sucess:^(NSDictionary *object, BOOL verifyObject)
    {
        if (verifyObject)
        {
            
            NSArray *itemArray = [object objectItemKey:@"object"];
            if (itemArray)
            {
                [self.dataArray removeAllObjects];
                [itemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                 {
                     XHLeaveRecordFrame *frame = [[XHLeaveRecordFrame alloc]init];
                     XHLeaveRecordModel *model = [[XHLeaveRecordModel alloc]init];
                     [model setItemObject:obj];
                     [frame setModel:model];
                     [self.dataArray addObject:frame];
                 }];
            }
        }
        
        [self.tableView refreshReloadData];
        
    } error:^(NSError *error)
    {
        [self.tableView refreshReloadData];
    }];
}

@end
