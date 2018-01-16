//
//  XHAchievementContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAchievementContentView.h"

@interface XHAchievementContentView () <UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic,strong) XHAchievementCellContentView *headerView; //!< 头部视图


@end

@implementation XHAchievementContentView




- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setBackgroundColor:[UIColor whiteColor]];
        [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
        [self.tableView beginRefreshing];
        
    }
    return self;
}
-(void)refreshHead
{
    [self getAchievementWithModel:self.childModel];
}

-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}

-(void)setItemArray:(NSMutableArray *)array
{
    self.dataArray=array;
}
-(void)getModel:(XHChildListModel *)model
{
    self.childModel=model;
    [self getAchievementWithModel:model];
}


-(void)getAchievementWithModel:(XHChildListModel *)model
{
    if (model)
    {
        [self.netWorkConfig setObject:model.studentBaseId forKey:@"studentBaseId"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus007" sucess:^(id object, BOOL verifyObject)
        {
            
            if (verifyObject)
            {
                [self.dataArray removeAllObjects];
                NSArray *itemArray = [object objectItemKey:@"object"];
                [itemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop)
                 {
                     NSDictionary *itemObject = [obj objectItemKey:@"propValue"];
                     XHAchievementFrame *frame = [[XHAchievementFrame alloc]init];
                     XHAchievementModel *model = [[XHAchievementModel alloc]init];
                     if (idx == 0)
                     {
                         [model setContentType:XHAchievementTitleType];
                     }
                     else
                     {
                         [model setContentType:XHAchievementContentType];
                     }
                     [model setItemObject:itemObject];
                     [frame setModel:model];
                     [self.dataArray addObject:frame];
                 }];
               [self.tableView refreshReloadData];
            }
           
        } error:^(NSError *error)
        {
            [self.tableView refreshReloadData];
        }];
    }
    else
    {
        [self.tableView refreshReloadData];
    }
  
}


#pragma mark - Deletage Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}

- (XHXHAchievementCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHXHAchievementCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHXHAchievementCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}



@end
