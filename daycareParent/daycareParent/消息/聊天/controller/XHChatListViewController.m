//
//  XHChatListViewController.m
//  TestRongCloud
//
//  Created by 钧泰科技 on 2018/4/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XHChatListViewController.h"
#import "XHChatManager.h"
#import "XHChatViewController.h"
#import "XHRCTableViewCell.h"
#import "XHMessageUserInfo.h"
#import "XHTeacherAddressBookViewController.h"
#import "XHHomeWorkViewController.h"
#import "XHNoticeListViewController.h"
#import "XHRCModel.h"
#import "AppDelegate.h"
#define kTitleList @[@"给老师留言",@"家庭作业",@"通知公告"]
#define kTitlePic @[@"im_message",@"im_book",@"im_notice"]
@interface XHChatListViewController ()<UITableViewDelegate,UITableViewDataSource,XHChatManagerDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,assign)CGFloat tabbarBottom;
@property(nonatomic,strong)XHNetWorkConfig *net;
@property(nonatomic,strong) ParentControl *teacherControl;//!< 给老师留言

@property(nonatomic,strong) ParentControl *homeWorkControl;//!< 家庭作业

@property(nonatomic,strong) ParentControl *noticeControl;//!< 通知公告
@end

@implementation XHChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[XHHelper sharedHelper] isIphoneX])
    {
        self.tabbarBottom=34;
    }
    else
    {
        self.tabbarBottom=0;
    }
     self.view.backgroundColor=RGB(239, 239, 239);
    [self setItemContentItemHiddenWithType:NavigationLeftType withHidden:YES];
    [self setNavtionTitle:@"消息"];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.teacherControl.frame=CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 60);
    self.homeWorkControl.frame=CGRectMake(0, self.teacherControl.bottom, SCREEN_WIDTH, 60);
    self.noticeControl.frame=CGRectMake(0, self.homeWorkControl.bottom, SCREEN_WIDTH, 75);
    
    [self.view addSubview:self.teacherControl];
    [self.view addSubview:self.homeWorkControl];
    [self.view addSubview:self.noticeControl];
    self.tableView.frame=CGRectMake(0, self.noticeControl.bottom, SCREEN_WIDTH, (SCREEN_HEIGHT-self.noticeControl.bottom-(50.0+self.tabbarBottom)));
    [self.view addSubview:self.tableView];
}

#pragma mark - 获取通知和家庭作业信息
-(void)refreshDataSource
{
    [self.net setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
    [self.net postWithUrl:@"zzjt-app-api_smartCampus018" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSDictionary *dic=[object objectItemKey:@"object"];
            NSDictionary *schoolWorkDic = [dic objectItemKey:@"schoolWork"];
            [self getDataSource:schoolWorkDic withdic:dic];
        }
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app reloadIMBadge];
    } error:^(NSError *error) {}];
}

#pragma mark - private Method
-(void)getDataSource:(NSDictionary*)schoolWorkDic withdic:(NSDictionary*)dic
{
    XHRCModel *schoolWorkModel = [[XHRCModel alloc] initWithDic:[schoolWorkDic objectItemKey:@"propValue"]];
    [self.homeWorkControl setLabelText:schoolWorkModel.RCContent withNumberIndex:1];
    [self.homeWorkControl setLabelText:[NSDate dateStr:schoolWorkModel.createTime FromFormatter:ALL_DEFAULT_TIME_FORM ToFormatter:DEFAULT_TIME_FORM1] withNumberIndex:2];
    
    if ([schoolWorkModel.sum integerValue]!=0) {
        [self.homeWorkControl setLabelCGRectMake:CGRectMake(35, 9, [self getCustomWidth:schoolWorkModel.sum], 15) withNumberIndex:4];
        [self.homeWorkControl setLabelText:schoolWorkModel.sum withNumberIndex:4];
    }
    else
    {
        [self.homeWorkControl setLabelCGRectMake:CGRectZero withNumberIndex:4];
    }
    [XHUserInfo sharedUserInfo].sum=0;
    [XHUserInfo sharedUserInfo].sum=[XHUserInfo sharedUserInfo].sum+[schoolWorkModel.sum integerValue];
    XHRCModel *model = [[XHRCModel alloc] initWithDic:[dic objectItemKey:@"notice"]];
    model.sum=[dic objectItemKey:@"noticeUnReadNum"];
    [self.noticeControl setLabelText:model.RCContent withNumberIndex:1];
    [self.noticeControl setLabelText:[NSDate dateStr:model.createTime FromFormatter:ALL_DEFAULT_TIME_FORM ToFormatter:DEFAULT_TIME_FORM1] withNumberIndex:2];
    if ([model.sum integerValue]!=0) {
        [self.noticeControl setLabelCGRectMake:CGRectMake(35, 9, [self getCustomWidth:model.sum], 15) withNumberIndex:5];
        [self.noticeControl setLabelText:model.sum withNumberIndex:5];
    }
    else
    {
        [self.noticeControl setLabelCGRectMake:CGRectZero withNumberIndex:5];
    }
    
    [XHUserInfo sharedUserInfo].sum=[XHUserInfo sharedUserInfo].sum+[model.sum integerValue];
}

#pragma mark- 点击control方法调用
-(void)controlMethod:(UIControl *)control
{
    switch (control.tag) {
        case 1:
        {
            XHTeacherAddressBookViewController *teacherBook=[[XHTeacherAddressBookViewController alloc] initHiddenWhenPushHidden];
            teacherBook.enterType=TeacherAddressBookIMType;
            [teacherBook setNavtionTitle:@"给老师留言"];
            [self.navigationController pushViewController:teacherBook animated:YES];
        }
            break;
        case 2:
        {
            XHHomeWorkViewController *homeWork=[[XHHomeWorkViewController alloc] initHiddenWhenPushHidden];
            [self.navigationController pushViewController:homeWork animated:YES];
            homeWork.isRefresh = ^(BOOL ok ) {
                if (ok) {
                    [self refreshDataSource];
                }
            };
        }
            break;
            
        case 3:
        {
            XHNoticeListViewController *notice=[[XHNoticeListViewController alloc] initHiddenWhenPushHidden];
            [self.navigationController pushViewController:notice animated:YES];
            notice.isRefresh = ^(BOOL ok ) {
                if (ok) {
                    [self refreshDataSource];
                }
            };
        }
            break;
            
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHRCTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setItemObject:self.dataArry[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCConversation *model=self.dataArry[indexPath.row];
   
    XHChatViewController *chat=[[XHChatViewController alloc] init];
    
    chat.targetID=model.targetId;
    
    XHMessageUserInfo *info=[[XHChatManager shareManager] getUserInfoTargetId:model.targetId];
    [chat setNavtionTitle:info.name];
    [self.navigationController pushViewController:chat animated:YES];
     [[XHChatManager shareManager] clearMessagesUnread:model.targetId];
    [[XHChatManager shareManager] sendUserInfo];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    if (self.tableView == tableView)
    {  
        if (editingStyle == UITableViewCellEditingStyleDelete)  
        {  
            RCConversation *model=self.dataArry[indexPath.row];
            
            [[XHChatManager shareManager] removeConversation:model.targetId];//1.先移除数组中的
            
            [self.dataArry removeObject:model];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
           
        }  
    }  
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        [_tableView registerClass:[XHRCTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [XHChatManager shareManager].delegate = self;
        [self.dataArry setArray:[[XHChatManager shareManager] getConversationList]];
        
        [self.tableView reloadData];
        [self refreshDataSource];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app reloadIMBadge];
    });

}
-(void)rcManagerReceiveMsg:(RCMessage *)msg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dataArry setArray:[[XHChatManager shareManager] getConversationList]];
        [self.tableView reloadData];
        [[XHChatManager shareManager] refreshCashRCUserInfo:msg.content.senderUserInfo];
    });
   
}
- (void)notifyUpdateUnreadMessageCount
{
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app reloadIMBadge];
    });
    
}

-(ParentControl *)teacherControl
{
    if (_teacherControl==nil) {
        _teacherControl=[[ParentControl alloc] init];
        _teacherControl.backgroundColor=[UIColor whiteColor];
        [_teacherControl setNumberImageView:1];
        [_teacherControl setNumberLabel:3];
        [_teacherControl setImageViewCGRectMake:CGRectMake(15, (60-32)/2.0, 32, 32) withNumberIndex:0];
        [_teacherControl setImageViewName:kTitlePic[0] withNumberIndex:0];
        
        [_teacherControl setLabelCGRectMake:CGRectMake(70, 10, 90, 20) withNumberIndex:0];
        [_teacherControl setLabelFont:kFont(15.0) withNumberIndex:0];
        [_teacherControl setLabelText:kTitleList[0] withNumberIndex:0];
        
        [_teacherControl setLabelCGRectMake:CGRectMake(70, 30, SCREEN_WIDTH-80, 20) withNumberIndex:1];
        [_teacherControl setLabelFont:kFont(14.0) withNumberIndex:1];
        [_teacherControl setLabelCGRectMake:CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5) withNumberIndex:2];
        [_teacherControl setLabelBackgroundColor:LineViewColor withNumberIndex:2];
        [_teacherControl setTag:1];
        [_teacherControl addTarget:self action:@selector(controlMethod:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _teacherControl;
}
-(ParentControl *)homeWorkControl
{
    if (_homeWorkControl==nil) {
        _homeWorkControl=[[ParentControl alloc] init];
        _homeWorkControl.backgroundColor=[UIColor whiteColor];
        [_homeWorkControl setNumberImageView:1];
        [_homeWorkControl setNumberLabel:5];
        
        [_homeWorkControl setImageViewCGRectMake:CGRectMake(15, (60-32)/2.0, 32, 32) withNumberIndex:0];
        [_homeWorkControl setImageViewName:kTitlePic[1] withNumberIndex:0];
        
        [_homeWorkControl setLabelCGRectMake:CGRectMake(70, 10, 90, 20) withNumberIndex:0];
        [_homeWorkControl setLabelFont:kFont(15.0) withNumberIndex:0];
        [_homeWorkControl setLabelText:kTitleList[1] withNumberIndex:0];
        
        [_homeWorkControl setLabelCGRectMake:CGRectMake(70, 30, SCREEN_WIDTH-80, 20) withNumberIndex:1];
        [_homeWorkControl setLabelFont:kFont(14.0) withNumberIndex:1];
        
        
        [_homeWorkControl setLabelCGRectMake:CGRectMake(170, 10, SCREEN_WIDTH-180, 20) withNumberIndex:2];
        [_homeWorkControl setLabelFont:kFont(12.0) withNumberIndex:2];
        [_homeWorkControl setLabelTextAlignment:NSTextAlignmentRight withNumberIndex:2];
        
        [_homeWorkControl setLabelCGRectMake:CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5) withNumberIndex:3];
        [_homeWorkControl setLabelBackgroundColor:LineViewColor withNumberIndex:3];
        [_homeWorkControl setTag:2];
        [_homeWorkControl addTarget:self action:@selector(controlMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        [_homeWorkControl setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:4];
        [_homeWorkControl setLabelTextColor:[UIColor whiteColor] withNumberIndex:4];
        [_homeWorkControl setLabelCornerRadius:7.5 withNumberIndex:4];
        [_homeWorkControl setLabelBackgroundColor:[UIColor redColor] withNumberIndex:4];
    }
    return _homeWorkControl;
}
-(ParentControl *)noticeControl
{
    if (_noticeControl==nil) {
        _noticeControl=[[ParentControl alloc] init];
        _noticeControl.backgroundColor=[UIColor whiteColor];
        [_noticeControl setNumberImageView:1];
        [_noticeControl setNumberLabel:6];
        
        [_noticeControl setImageViewCGRectMake:CGRectMake(15, (60-32)/2.0, 32, 32) withNumberIndex:0];
        [_noticeControl setImageViewName:kTitlePic[2] withNumberIndex:0];
        
        [_noticeControl setLabelCGRectMake:CGRectMake(70, 10, 90, 20) withNumberIndex:0];
        [_noticeControl setLabelFont:kFont(15.0) withNumberIndex:0];
        [_noticeControl setLabelText:kTitleList[2] withNumberIndex:0];
        
        [_noticeControl setLabelCGRectMake:CGRectMake(70, 30, SCREEN_WIDTH-80, 20) withNumberIndex:1];
        [_noticeControl setLabelFont:kFont(14.0) withNumberIndex:1];
        
        [_noticeControl setLabelCGRectMake:CGRectMake(170, 10, SCREEN_WIDTH-180, 20) withNumberIndex:2];
        [_noticeControl setLabelFont:kFont(12.0) withNumberIndex:2];
        [_noticeControl setLabelTextAlignment:NSTextAlignmentRight withNumberIndex:2];
        
        [_noticeControl setLabelCGRectMake:CGRectMake(0, 60, SCREEN_WIDTH, 15) withNumberIndex:3];
        [_noticeControl setLabelBackgroundColor:LineViewColor withNumberIndex:3];
        
        [_noticeControl setLabelCGRectMake:CGRectMake(0, 74.5, SCREEN_WIDTH, 0.5) withNumberIndex:4];
        [_noticeControl setLabelBackgroundColor:LineViewColor withNumberIndex:4];
        [_noticeControl setTag:3];
        [_noticeControl addTarget:self action:@selector(controlMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        [_noticeControl setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:5];
        [_noticeControl setLabelTextColor:[UIColor whiteColor] withNumberIndex:5];
        [_noticeControl setLabelCornerRadius:7.5 withNumberIndex:5];
        [_noticeControl setLabelBackgroundColor:[UIColor redColor] withNumberIndex:5];
    }
    return _noticeControl;
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"noticeName" object:nil];
}
-(void)noticeMethod
{
    //进入刷新状态
    [self.tableView.header beginRefreshing];
}
-(XHNetWorkConfig *)net
{
    if (_net==nil) {
        _net=[[XHNetWorkConfig alloc] init];
    }
    return _net;
}

-(CGFloat)getCustomWidth:(NSString *)str
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(22, 22) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    if (str.length==0)
    {
        return 0;
    }
    if (str.length==1)
    {
        return 15;
    }
    else
    {
        return textSize.width+8;
    }
    
}

-(NSMutableArray *)dataArry
{
    if (_dataArry==nil) {
        _dataArry=[[NSMutableArray alloc] init];
    }
    return _dataArry;
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
