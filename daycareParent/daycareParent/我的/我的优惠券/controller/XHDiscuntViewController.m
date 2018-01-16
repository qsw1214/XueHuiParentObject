//
//  XHDiscuntViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDiscuntViewController.h"
#import "BaseTableView.h"
@interface XHDiscuntViewController ()<UITableViewDelegate,UITableViewDataSource>
{
      BaseTableView *_tableView;
}
@end

@implementation XHDiscuntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"我的优惠券"];
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.rowHeight=100;
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeader)];
    [_tableView beginRefreshing];
    [_tableView setTipType:TipTitleAndTipImage withTipTitle:@"暂时还没有优惠券哦" withTipImage:@"morentu_nocoupon"];
}
-(void)refreshHeader
{
    [_tableView refreshReloadData];
}
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [_tableView tableTipViewWithArray:self.dataArray];
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
    
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
