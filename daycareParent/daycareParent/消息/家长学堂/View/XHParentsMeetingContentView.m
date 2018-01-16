//
//  XHParentsMeetingContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHParentsMeetingContentView.h"




@interface XHParentsMeetingContentView () <UITableViewDelegate,UITableViewDataSource>

{
    NSInteger _pageNumber;
}

@property (nonatomic,weak) id <XHParentsMeetingContentViewDeletage> deletage;


@end



@implementation XHParentsMeetingContentView


-(instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self setDeletage:deletage];
//        [self.tableView beginRefreshing];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.tableView showRefresFooterWithTarget:self withSelector:@selector(refreshFooterAction)];
        [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
    }
    return self;
}
-(void)refreshHeaderAction
{
    _pageNumber=1;
    [self getRefreshWitgType:HeaderRefresh];
}
-(void)refreshFooterAction
{
    [self getRefreshWitgType:FooterRefresh];
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
    [self.tableView beginRefreshing];
}

#pragma mark - Deletage Method
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}
- (XHParentsMeetingCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHParentsMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHParentsMeetingCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.deletage respondsToSelector:@selector(didSelectItemObject:)])
    {
        [self.deletage didSelectItemObject:[self.dataArray objectAtIndex:indexPath.row]];
    }
}
-(void)getRefreshWitgType:(BaseRefreshType)type
{
    [self.netWorkConfig setObject:@"20" forKey:@"pageSize"];
    [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",_pageNumber] forKey:@"pageNumber"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus017" sucess:^(id object, BOOL verifyObject) {
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
            
            
            
            NSArray *arr=[[object objectItemKey:@"object"] objectItemKey:@"pageResult"];
            for (NSDictionary *dic in arr) {
                NSDictionary *Dic=[dic objectItemKey:@"propValue"];
                XHParentsMeetingFrame *frame = [[XHParentsMeetingFrame alloc]init];
                XHParentsMeetingModel *model = [[XHParentsMeetingModel alloc]init];
                [model setTitle:[Dic objectItemKey:@"tTitle"]];
                [model setDate:[NSString dateStr:[Dic objectItemKey:@"fbrq"]]];
                [model setPreviewUrl:ALGetFileImageOriginal([Dic objectItemKey:@"tImgUrl"])];
                [model setContent:[Dic objectItemKey:@"tHtml"]];
                [model setObjectID:[Dic objectItemKey:@"xh"]];
                [frame setModel:model];
                [self.dataArray addObject:frame];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
            [self.tableView refreshReloadData];
                if ([arr count] >= 20)
                {
                    _pageNumber++;
                }
                else
                {
                    [self.tableView noMoreData];
                }
            });
            
        }
    } error:^(NSError *error) {
         [self.tableView refreshReloadData];
    }];
}

@end
