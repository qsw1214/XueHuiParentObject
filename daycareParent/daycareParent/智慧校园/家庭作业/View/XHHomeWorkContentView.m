//
//  XHHomeWorkContentView.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkContentView.h"



@interface XHHomeWorkContentView () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,weak) id <XHHomeWorkContentViewDeletage> deletage;

@property (nonatomic,assign) NSInteger pageNumber;



@end

@implementation XHHomeWorkContentView

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
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.tableView beginRefreshing];
    }
    return self;
}





#pragma mark 头部刷新
-(void)refreshHeaderAction
{
    [self getServerItemObjectWith:HeaderRefresh];
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



#pragma mark - NetWork Method
-(void)getServerItemObjectWith:(BaseRefreshType)type
{
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus004" sucess:^(id object, BOOL verifyObject)
     {
         if (verifyObject)
         {
             [self.dataArray removeAllObjects];
             NSArray *arr = [object objectItemKey:@"object"];
             for (NSDictionary *dic in arr)
             {
                 XHHomeWorkFrame *frame = [[XHHomeWorkFrame alloc]init];
                 XHHomeWorkModel *model = [[XHHomeWorkModel alloc]init];
                 [model setItemObject:dic];
                 [frame setModel:model];
                 [self.dataArray addObject:frame];
             }
             
             [self.tableView refreshReloadData];
         }
     } error:^(NSError *error)
     {
         [self.tableView refreshReloadData];
     }];
}








@end
