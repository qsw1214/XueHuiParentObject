//
//  XHNoticeViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNoticeViewController.h"
#import "XHNotifceTableViewCell.h"
#import "XHParentsMeetingViewController.h"
#import "XHAddressBookViewController.h"
#import "XHIMNoticeModel.h"
#import "XHNoticeListViewController.h"
#import "BaseTableView.h"
#define TITLE_IMV @[@"ico_notice",@"ico_leave-msm",@"ico_parents"]
#define TITLE @[@"通知公告",@"给老师留言",@"家长学堂"]
@interface XHNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BaseTableView *_tableView;
    XHIMNoticeModel *_informationModel;
    XHIMNoticeModel *_noticeModel;
}
@property(nonatomic,strong)UIView *navigationView;
@end

@implementation XHNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navigationView];
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
     [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=70;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 0, CGFLOAT_MIN)];
    [_tableView registerClass:[XHNotifceTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [_tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [_tableView beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"noticeName" object:nil];
}
-(void)refreshHead
{
    [self refresh];
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden=YES;
//    [self refresh];
//}

- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(BaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHNotifceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.headImageView.image=[UIImage imageNamed:TITLE_IMV[indexPath.row]];
    cell.titleLab.text=TITLE[indexPath.row];
    cell.ContentLab.frame=CGRectMake(80, 35, SCREEN_WIDTH-95, 30);
    if (indexPath.row==0) {
        if ([_noticeModel.sum integerValue] <100) {
            if ([_noticeModel.sum integerValue]==0) {
            }
            else
            {
                cell.smallLab.text=_noticeModel.sum;
            }

        }
        else
        {
            cell.smallLab.text=@"99+";
        }
        cell.smallLab.frame=CGRectMake(45, 6, [self getCustomWidth:cell.smallLab.text], 15);
        cell.smallLab.layer.cornerRadius=7.5;
        cell.detailLab.text=[NSString dateStr:_noticeModel.createTime];
        cell.ContentLab.text=_noticeModel.content;
    
    }
  
    if (indexPath.row==2) {
        
        cell.detailLab.text=[NSString dateStr:_informationModel.createTime];
        cell.ContentLab.text=_informationModel.content;
    }
    if (indexPath.row==1) {
        cell.ContentLab.hidden=YES;
        cell.smallLab.hidden=YES;
        cell.detailLab.hidden=YES;
    }
    else
    {
        cell.ContentLab.hidden=NO;
        cell.detailLab.hidden=NO;
        if (indexPath.row==0) {
              cell.smallLab.hidden=NO;
        }
        else
        {
            cell.smallLab.hidden=YES;
        }
    }
    return cell;
}
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        XHNoticeListViewController *list=[[XHNoticeListViewController alloc] initHiddenWhenPushHidden];
        list.isRefresh = ^(BOOL ok) {
            if (ok) {
                [self refresh];
            }
        };
        [self.navigationController pushViewController:list animated:YES];
    }
    if (indexPath.row==1) {
        XHAddressBookViewController *addressBook=[[XHAddressBookViewController alloc] initHiddenWhenPushHidden];
        [addressBook setNavtionTitle:@"给老师留言"];
        [self.navigationController pushViewController:addressBook animated:YES];
    }
    if (indexPath.row==2) {
        XHParentsMeetingViewController *meet=[[XHParentsMeetingViewController alloc] initHiddenWhenPushHidden];
        
        [self.navigationController pushViewController:meet animated:YES];
    }
    
}
-(XHNetWorkConfig *)net
{
    if (_net==nil) {
        _net=[[XHNetWorkConfig alloc] init];
    }
    return _net;
}
-(UIView *)navigationView
{
    if (_navigationView == nil)
    {
        _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64.0)];
        self.navigationView.backgroundColor=MainColor;
    }
    return _navigationView;
}

-(void)refresh
{
    [self.net setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
    [self.net postWithUrl:@"zzjt-app-api_smartCampus018" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSDictionary *dic=[object objectItemKey:@"object"];
            _informationModel=[[XHIMNoticeModel alloc] initWithDic:[dic objectItemKey:@"informationText"]];
            _noticeModel=[[XHIMNoticeModel alloc] initWithDic:[dic objectItemKey:@"notice"]];
            _noticeModel.sum=[dic objectItemKey:@"sum"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView refreshReload];
            });
        }
    } error:^(NSError *error) {
        [_tableView refreshReload];
    }];
}
-(CGFloat)getCustomWidth:(NSString *)str
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(22, 22) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    if (str.length==0) {
        return 0;
    }
    if (str.length==1) {
        return 15;
    }
    else
    {
        return textSize.width+8;
    }
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
