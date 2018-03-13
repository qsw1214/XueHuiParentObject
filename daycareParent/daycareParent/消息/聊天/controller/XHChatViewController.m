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
#import "XHAddressBookHeader.h"
#define kTitleList @[@"给老师留言",@"家庭作业",@"通知公告"]
#define kTitlePic @[@"im_notice",@"im_message",@"im_book",@"im_notice"]
@interface XHChatViewController ()

@property(nonatomic,strong)UIView *navigationView;
@property(nonatomic,strong)NSMutableArray *mouArry;
@property(nonatomic,strong)XHAddressBookHeader *addressBookHeader;//!<  头滚动

@end

@implementation XHChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.conversationListTableView.tableFooterView = [UIView new];//不显示多余的cell
    self.conversationListTableView.backgroundColor=[UIColor lightTextColor];
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];//显示为圆形
    [self setConversationPortraitSize:CGSizeMake(60, 60)];
    [self.view addSubview:self.navigationView];
    NSMutableArray *arr=[[NSMutableArray alloc] init];
     for (int i = 0; i<10; i++)
     {
     XHChildListModel *model = [[XHChildListModel alloc]init];
     [model setStudentName:@"姚立志"];
     [model setClazzName:@"三年级二班"];
     [model setMarkType:ChildListNormalType];
     [arr addObject:model];
     }
     [self.view addSubview:self.addressBookHeader];
     [self.addressBookHeader setItemArray:arr];
    
    self.conversationListTableView.frame=CGRectMake(0, self.addressBookHeader.bottom+15, SCREEN_WIDTH, SCREEN_HEIGHT-self.addressBookHeader.bottom-70);
    
    [self.conversationListTableView registerClass:[XHRCTableViewCell class] forCellReuseIdentifier:@"RongYunListCell"];
    
    self.conversationListTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshModel)];
    
    //进入刷新状态
    [self.conversationListTableView.header beginRefreshing];
    
}
-(void)refreshModel
{
    for (int i = 0; i<3; i++)
    {
        XHRCModel *model = [[XHRCModel alloc] init];
        model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        model.RCtitle=kTitleList[i];
        model.RCtitlePic=kTitlePic[i];
        model.RCContent=@"123456";
        [self.conversationListDataSource replaceObjectAtIndex:i withObject:model];
        [self.mouArry addObject:model];
    }
    [self.conversationListTableView reloadData];
   
    [self.conversationListTableView.header endRefreshing];
    //[self refreshConversationTableViewIfNeeded];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conversationListDataSource.count;
}
- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 2:
            {
                return 85;
            }
            break;
            
        default:
        {
             return 70;
        }
            break;
    }
   
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    XHRCModel *model = [self.conversationListDataSource objectAtIndex:indexPath.row];
    if(model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION){
        return UITableViewCellEditingStyleNone;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}
- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    XHRCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RongYunListCell" forIndexPath:indexPath];
    [cell setItemObject:self.conversationListDataSource[indexPath.row] atIndex:indexPath.row];
     self.conversationListTableView.separatorColor =LineViewColor;
   [self.conversationListTableView deselectRowAtIndexPath:indexPath animated:YES];
    return cell;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH ,15)];
    view.backgroundColor = LineViewColor;
    return view;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app reloadIMBadge];
}

/**
 *重写RCConversationListViewController的onSelectedTableRow事件
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>2)
    {
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app sendRCIMInfo];
        XHRCConversationViewController *conversationVC = [[XHRCConversationViewController alloc]init];
        conversationVC.conversationType =model.conversationType;
        conversationVC.targetId = model.targetId;
        conversationVC.titleLabel.text = model.conversationTitle;
        conversationVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:conversationVC animated:YES];
    }
    else
    {
        switch (indexPath.row) {
            case 0:
            {
                XHTeacherAddressBookViewController *teacherBook=[[XHTeacherAddressBookViewController alloc] initHiddenWhenPushHidden];
                [teacherBook setNavtionTitle:@"给老师留言"];
                [self.navigationController pushViewController:teacherBook animated:YES];
            }
                break;
                
        }
    }
    
}
- (void)notifyUpdateUnreadMessageCount
{
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app reloadIMBadge];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource
{
        [self.conversationListDataSource setArray:dataSource];
        for (int i = 0; i<kTitleList.count; i++) {
            XHRCModel *model = [[XHRCModel alloc]init];
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
            model.RCtitle=kTitleList[i];
            model.RCtitlePic=kTitlePic[i];
            [self.conversationListDataSource insertObject:model atIndex:i];
        }
    [self refreshModel];
    return self.conversationListDataSource;
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
-(XHAddressBookHeader *)addressBookHeader
{
    if (_addressBookHeader==nil) {
        _addressBookHeader=[[XHAddressBookHeader alloc] init];
        [_addressBookHeader resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 60)];
    }
    return _addressBookHeader;
}
-(UIView *)navigationView
{
    if (_navigationView == nil)
    {
        _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64.0)];
        self.navigationView.backgroundColor=[UIColor whiteColor];
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        [titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        titleLabel.text=@"消息";
        [_navigationView addSubview:titleLabel];
    }
    return _navigationView;
}

-(NSMutableArray *)mouArry
{
    if (_mouArry==nil) {
        _mouArry=[[NSMutableArray alloc] init];
    }
    return _mouArry;
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
