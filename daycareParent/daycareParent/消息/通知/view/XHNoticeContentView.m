//
//  XHNoticeContentView.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNoticeContentView.h"



@interface XHNoticeContentView () <UITableViewDelegate,UITableViewDataSource,XHNoticeContentViewDeletage>


@property (nonatomic,weak) id <XHNoticeContentViewDeletage> deletage;

@property (nonatomic,assign) NSInteger pageNumber;



@end

@implementation XHNoticeContentView

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
        [self.tableView showRefresFooterWithTarget:self withSelector:@selector(refreshFooterAction)];
        [self.tableView beginRefreshing];
    }
    return self;
}


#pragma mark 头部刷新
-(void)refreshHeaderAction
{
    [self getServerItemObjectWith:HeaderRefresh];
}


-(void)refreshFooterAction
{
     [self getNoticeWithType:FooterRefresh];
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
    if ([self.deletage respondsToSelector:@selector(didSelectAtIndex:)])
    {
        [self.deletage didSelectAtIndex:[self.dataArray objectAtIndex:indexPath.row]];
    }
}





#pragma mark - NetWork Method
-(void)getServerItemObjectWith:(BaseRefreshType)type
{
    [self setPageNumber:1];
    [self getNoticeWithType:type];
}

-(void)getNoticeWithType:(BaseRefreshType)type
{
        [self.netWorkConfig setObject:@"20" forKey:@"pageSize"];
        [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",_pageNumber] forKey:@"pageNumber"];
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus019" sucess:^(id object, BOOL verifyObject)
         {
            if (verifyObject)
            {
                switch (type)
                {
                    case HeaderRefresh:
                    {
                        [self.dataArray removeAllObjects];
                    }
                        break;
                    case FooterRefresh:
                        break;
                }
    
                NSArray *itemObjectArray = [[object objectItemKey:@"object"] objectItemKey:@"pageResult"];
                if (itemObjectArray)
                {
                    [itemObjectArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                     {
                         NSDictionary *itemObject = [obj objectItemKey:@"propValue"];
                         XHNoticeFrame *frame = [[XHNoticeFrame alloc]init];
                         XHNoticeModel *model = [[XHNoticeModel alloc]init];
                         [model setItemObject:itemObject];
                         [model.playModel setScrollView:self.tableView];
                         [frame setModel:model];
                         [self.dataArray addObject:frame];
                     }];
    
                    [self.tableView refreshReloadData];
    
                    if ([itemObjectArray count] >= 20)
                    {
                        [self setPageNumber:(self.pageNumber+1)];
                    }
                    else
                    {
                        [self.tableView noMoreData];
                    }
                }
            }
        } error:^(NSError *error)
         {
             [self.tableView refreshReloadData];
         }];
   
}


@end
