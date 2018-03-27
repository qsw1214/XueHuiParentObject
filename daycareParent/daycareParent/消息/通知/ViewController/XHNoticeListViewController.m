//
//  XHNoticeListViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNoticeListViewController.h"
#import "XHNoticeDetailViewController.h" //!< 家庭作业详情
#import "XHDatePicker.h"



@interface XHNoticeListViewController () <UITableViewDelegate,UITableViewDataSource,XHDatePickerDelegate>

@property (nonatomic,strong) XHNoticeContentView *contentView;
@property (nonatomic,assign) NSInteger pageNumber;
@property (nonatomic,copy) NSString *date;

@end

@implementation XHNoticeListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"通知公告"];
    [self setItemContentType:NavigationIconype withItemType:NavigationItemRightype withIconName:@"ico_date" withTitle:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.mainTableView setDelegate:self];
        [self.mainTableView setDataSource:self];
        [self.mainTableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.mainTableView showRefresFooterWithTarget:self withSelector:@selector(refreshFooterAction)];
        [self.mainTableView setTipType:TipTitleAndTipImage withTipTitle:@"暂无公告" withTipImage:@"pic_nothing"];
        [self.mainTableView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom)];
        [self.view addSubview:self.mainTableView];
        [self.mainTableView beginRefreshing];
    }
}



-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    XHDatePicker *datePicker = [[XHDatePicker alloc]init];
    [datePicker setDelegate:self];
    [datePicker show];
    
}


-(void)refreshHeaderAction
{
    self.pageNumber=1;
    [self getNoticeWithType:HeaderRefresh];
}


-(void)refreshFooterAction
{
    [self getNoticeWithType:FooterRefresh];
}



#pragma mark - Deletage Method
#pragma mark  XHHomeWorkContentViewDeletage
-(void)didSelectAtIndex:(XHNoticeFrame *)object
{
    XHNoticeDetailViewController *noticeDetail = [[XHNoticeDetailViewController alloc]init];
    [noticeDetail setItemObjet:object];
    [self.navigationController pushViewController:noticeDetail animated:YES];
    noticeDetail.refeshBlock = ^(BOOL isRefesh)
    {
        if (isRefesh)
        {
            [self.contentView.tableView beginRefreshing];
        }
        
    };
}


#pragma mark - Getter / Setter
-(XHNoticeContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHNoticeContentView alloc]initWithDeletage:self];
    }
    return _contentView;
}
-(void)refresh
{
    [self.contentView.tableView beginRefreshing];
}









#pragma mark - Delegate Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.mainTableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}



- (XHHomeWorkTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHHomeWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[XHHomeWorkTableViewCell alloc]init];
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
    
}

#pragma mark XHDatePickerDelegate
-(void)datePickerAction:(NSString *)date
{
    [self setDate:date];
    [self.mainTableView beginRefreshing];
}


-(void)getNoticeWithType:(BaseRefreshType)type
{
    [self.netWorkConfig setObject:@"20" forKey:@"pageSize"];
    [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",self.pageNumber] forKey:@"pageNumber"];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
    [self.netWorkConfig setObject:self.date forKey:@"date"];
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
                 @WeakObj(self);
                 [itemObjectArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                  {
                      @StrongObj(self);
                      NSDictionary *itemObject = [obj objectItemKey:@"propValue"];
                      XHHomeWorkFrame *frame = [[XHHomeWorkFrame alloc]init];
                      XHHomeWorkModel *model = [[XHHomeWorkModel alloc]init];
                      [model setNoticeItemObject:itemObject];
                      [frame setModel:model];
                      [self.dataArray addObject:frame];
                      if (self.isRefresh)
                      {
                          self.isRefresh(YES);
                      }
                  }];
                 
                 [self.mainTableView refreshReloadData];
                 
                 if ([itemObjectArray count] >= 20)
                 {
                     [self setPageNumber:(self.pageNumber+1)];
                 }
                 else
                 {
                     [self.mainTableView noMoreData];
                 }
             }
             else
             {
                 [self.mainTableView refreshReloadData];
             }
         }
         else
         {
             [self.mainTableView refreshReloadData];
         }
         
     } error:^(NSError *error)
     {
         [self.mainTableView refreshReloadData];
     }];
    
}

-(NSString *)date
{
    if (_date==nil) {
        _date=[[NSString alloc]init];
    }
    return _date;
}




@end
