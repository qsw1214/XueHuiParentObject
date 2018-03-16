//
//  XHSystemNotificViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSystemNotificViewController.h"
#import "XHSystemModel.h"
#import "XHSystemNoticeTableViewCell.h"
@interface XHSystemNotificViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _pageNumber;
}
@property(nonatomic,strong)BaseTableView *tableView;
@end

@implementation XHSystemNotificViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"系统通知"];
    _pageNumber=1;
    [self.view addSubview:self.tableView];
    [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [self.tableView showRefresFooterWithTarget:self withSelector:@selector(refreshFoot)];
    [self.tableView beginRefreshing];
}
-(void)refreshHead
{
    _pageNumber=1;
    [self getRefreshType:HeaderRefresh];
}
-(void)refreshFoot
{
    [self getRefreshType:FooterRefresh];
}
-(void)getRefreshType:(BaseRefreshType)refreshType
{
    [self.netWorkConfig setObject:@"1" forKey:@"clientType"];
    [self.netWorkConfig setObject:@"10" forKey:@"pageSize"];
    [self.netWorkConfig setObject:kFormat(@"%zd",_pageNumber) forKey:@"pageNum"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_listAnnouncement" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            
            NSDictionary *dic=[object objectItemKey:@"object"];
            NSArray *resultArry=[dic objectItemKey:@"pageResult"];
            switch (refreshType) {
                case HeaderRefresh:
                {
                    [self.dataArray removeAllObjects];
                }
                    break;
                    
                case FooterRefresh:
                    break;
            }
            for (NSDictionary *dic in resultArry) {
                NSDictionary *Dic=[dic objectItemKey:@"propValue"];
                XHSystemModel *model=[[XHSystemModel alloc] initWithDic:Dic];
                [self.dataArray addObject:model];
            }
            [self.tableView refreshReloadData];
            
            if ([resultArry count] >= 10)
            {
                _pageNumber++;
            }
            else
            {
                [self.tableView noMoreData];
            }
        }
        else
        {
            [self.tableView refreshReloadData];
        }
     
    } error:^(NSError *error) {
       [self.tableView refreshReloadData];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray[indexPath.section] itemCellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHSystemNoticeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemObject:self.dataArray[indexPath.section]];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 15;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else
        if(scrollView.contentOffset.y >= sectionHeaderHeight){

            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
}
-(BaseTableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[XHSystemNoticeTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
