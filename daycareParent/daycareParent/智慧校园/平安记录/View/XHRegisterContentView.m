//
//  XHRegisterContentView.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHRegisterContentView.h"
#import "XHRegisterTableViewCell.h"
#import "BaseTableView.h"
@interface XHRegisterContentView () <UITableViewDelegate,UITableViewDataSource>


@end

@implementation XHRegisterContentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
         [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
        [self.tableView beginRefreshing];
    }
    return self;
}

-(void)refreshHead
{
    [self getRegisterWithModel:self.childModel];
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}

-(void)getModel:(XHChildListModel *)model
{
    self.childModel=model;
    [self getRegisterWithModel:model];
}



-(void)getRegisterWithModel:(XHChildListModel*)model
{
    if (model)
    {
        [self.netWorkConfig setObject:self.childModel.studentBaseId forKey:@"studentBaseId"];
        [self.netWorkConfig setObject:self.childModel.schoolId forKey:@"schoolId"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus002" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject) {
                [self.dataArray removeAllObjects];
                NSArray *arr=[object objectItemKey:@"object"];
                for (NSDictionary *dic in arr) {
                    XHRegisterFrame *frame = [[XHRegisterFrame alloc]init];
                    XHRegisterModel *model = [[XHRegisterModel alloc]init];
                    [model setUserName:self.childModel.studentName];
                    [model setRegisterDate:[dic objectItemKey:@"time"]];
                    [model setOneTimeSolt:[dic objectItemKey:@"d1"]];
                    [model setTwoTimeSolt:[dic objectItemKey:@"d2"]];
                    [model setThreeTimeSolt:[dic objectItemKey:@"d3"]];
                    [model setFourTimeSolt:[dic objectItemKey:@"d4"]];
                    [frame setModel:model];
                    [self.dataArray addObject:frame];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView refreshReloadData];
                });
            }
        } error:^(NSError *error) {
            [self.tableView refreshReloadData];
        }];
    }
    else
    {
        [self.tableView refreshReloadData];
    }
}




#pragma mark - Deletage Method
#pragma mark UITableViewDataSource 数据源代理方法
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}

- (XHRegisterTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHRegisterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHRegisterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}



@end
