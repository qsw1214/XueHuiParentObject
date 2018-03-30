//
//  XHChatViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHChatViewController.h"
#import "AppDelegate.h"
#import "XHRCConversationViewController.h"
#import "XHRCTableViewCell.h"
#import "XHRCModel.h"
#import "XHTeacherAddressBookViewController.h"
#import "XHHomeWorkViewController.h"
#import "XHNoticeListViewController.h"
#define kTitleList @[@"给老师留言",@"家庭作业",@"通知公告"]
#define kTitlePic @[@"im_message",@"im_book",@"im_notice"]
@interface XHChatViewController ()

@property(nonatomic,strong)UIView *navigationView;
@property(nonatomic,assign)CGFloat topHeight;
@property(nonatomic,assign)CGFloat bottom;

@property(nonatomic,strong)XHNetWorkConfig *net;
@property(nonatomic,strong)NSMutableArray *dataArry;

@property(nonatomic,strong) ParentControl *teacherControl;//!< 给老师留言

@property(nonatomic,strong) ParentControl *homeWorkControl;//!< 家庭作业

@property(nonatomic,strong) ParentControl *noticeControl;//!< 通知公告

@end

@implementation XHChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[XHHelper sharedHelper] isIphoneX])
    {
        self.topHeight = 30.0;
        self.bottom=34;
    }
    else
    {
        self.topHeight = 0;
        self.bottom=0;
    }
    [self setItemColor:NO];
    
    
    self.view.backgroundColor=RGB(239, 239, 239);
    
    // Do any additional setup after loading the view.
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION)]];
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    
    [self.view addSubview:self.navigationView];
    
    

    self.teacherControl.frame=CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 60);
    self.homeWorkControl.frame=CGRectMake(0, self.teacherControl.bottom, SCREEN_WIDTH, 60);
    self.noticeControl.frame=CGRectMake(0, self.homeWorkControl.bottom, SCREEN_WIDTH, 75);
    
    [self.view addSubview:self.teacherControl];
    [self.view addSubview:self.homeWorkControl];
    [self.view addSubview:self.noticeControl];
    
    self.conversationListTableView.tableFooterView = [UIView new];//不显示多余的cell
    self.conversationListTableView.backgroundColor=[UIColor lightTextColor];
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];//显示为圆形
    [self setConversationPortraitSize:CGSizeMake(50, 50)];
    
    self.conversationListTableView.frame=CGRectMake(0, self.noticeControl.bottom, SCREEN_WIDTH, (SCREEN_HEIGHT-self.noticeControl.bottom-(50.0+self.bottom)));
    self.conversationListTableView.separatorColor =LineViewColor;
    [self.conversationListTableView registerClass:[XHRCTableViewCell class] forCellReuseIdentifier:@"RongYunListCell"];
    self.emptyConversationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.conversationListTableView  setSeparatorColor:LineViewColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeMethod) name:@"noticeName" object:nil];
    
   
    
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
#pragma mark- Delegate Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conversationListDataSource.count;
}

- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XHRCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RongYunListCell" forIndexPath:indexPath];
    [cell setItemObject:self.conversationListDataSource[indexPath.row]];
    
    return cell;
}

-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(XHRCModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    [self.conversationListTableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app sendRCIMInfo];
    XHRCConversationViewController *conversationVC = [[XHRCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.titleLabel.text = model.conversationTitle;
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}
- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource
{
    [self.conversationListDataSource setArray:dataSource];
    return self.conversationListDataSource;
}
- (void)notifyUpdateUnreadMessageCount
{
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app reloadIMBadge];
    });
    
}
- (void)didLongPressCellPortrait:(RCConversationModel *)model
{
    if (model.isTop) {
        [self showAlertSheet:@"取消置顶" targetID:model.targetId type:1];
    }else{
        [self showAlertSheet:@"置顶" targetID:model.targetId type:0];
    }
    
}
- (void)showAlertSheet:(NSString *)title targetID:(NSString *)targetID type:(NSInteger)type
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"是否置顶？" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (type == 0) {
            [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_PRIVATE targetId:targetID isTop:YES];
        }else{
            [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_PRIVATE targetId:targetID isTop:NO];
        }
        [XHShowHUD showOKHud:title];
        [self refreshConversationTableViewIfNeeded];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Getter / Setter
-(UIView *)navigationView
{
    if (_navigationView == nil)
    {
       _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (self.topHeight+64.0))];
        self.navigationView.backgroundColor=[UIColor whiteColor];
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,(20.0+self.topHeight), SCREEN_WIDTH, 44.0)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        [titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        titleLabel.text=@"消息";
        UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, titleLabel.bottom-0.5, SCREEN_WIDTH, 0.5)];
        bottomView.backgroundColor=LineViewColor;
        [_navigationView addSubview:titleLabel];
        [_navigationView addSubview:bottomView];
      
    }
    return _navigationView;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    [self refreshDataSource];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app reloadIMBadge];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"noticeName" object:nil];
}
-(void)noticeMethod
{
    //进入刷新状态
    [self.conversationListTableView.header beginRefreshing];
}
-(XHNetWorkConfig *)net
{
    if (_net==nil) {
        _net=[[XHNetWorkConfig alloc] init];
    }
    return _net;
}
-(void)viewDidLayoutSubviews
{
    if ([self.conversationListTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.conversationListTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.conversationListTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.conversationListTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.teacherControl setBackgroundColor:[UIColor redColor]];
        [self.noticeControl setBackgroundColor:[UIColor orangeColor]];
        [self.homeWorkControl setBackgroundColor:[UIColor purpleColor]];
    }
}







@end
