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
#define kTitleList @[@"给老师留言",@"家庭作业",@"通知公告"]
#define kTitlePic @[@"im_notice",@"im_message",@"im_book",@"im_notice"]
@interface XHChatViewController ()

@property(nonatomic,strong)UIView *navigationView;
@property(nonatomic,strong)NSMutableArray *mouArry;

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
    self.conversationListTableView.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    self.conversationListTableView.separatorColor =LineViewColor;
    [self.conversationListTableView registerClass:[XHRCTableViewCell class] forCellReuseIdentifier:@"RongYunListCell"];
    
    self.conversationListTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHead)];
    
    //进入刷新状态
    [self.conversationListTableView.header beginRefreshing];
    
}
-(void)refreshHead
{
    [XHUserInfo sharedUserInfo].sum=0;
    for (int i = 0; i<3; i++)
    {
        XHRCModel *model = [[XHRCModel alloc] initWithDic:nil];
        model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        model.RCtitle=kTitleList[i];
        model.RCtitlePic=kTitlePic[i];
        switch (i) {
                case 0:
            {
                model.modelType=XHRCTeacherBookType;
            }
                break;
            case 1:
            {
                model.RCContent=@"家庭作业";
                model.sum=@"5";
                model.modelType=XHRCHomeWorkType;
            }
                break;
                
            case 2:
            {
                model.RCContent=@"放假通知";
                model.sum=@"10";
                model.modelType=XHRCnoticeType;
            }
                break;
        }
        
        [XHUserInfo sharedUserInfo].sum=[XHUserInfo sharedUserInfo].sum+[model.sum integerValue];
        [self.conversationListDataSource replaceObjectAtIndex:i withObject:model];
        [self.mouArry addObject:model];
    }
    [self.conversationListTableView reloadData];
    [self.conversationListTableView.header endRefreshing];
    
    [XHUserInfo sharedUserInfo].sum= [XHUserInfo sharedUserInfo].sum;
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app reloadIMBadge];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conversationListDataSource.count;
}
- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.conversationListDataSource[indexPath.row] itemCellHeight];
}

- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XHRCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RongYunListCell" forIndexPath:indexPath];
    [cell setItemObject:self.conversationListDataSource[indexPath.row]];
    return cell;
}

-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(XHRCModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    [self.conversationListTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (model.conversationModelType ) {
        case RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION:
        {
            switch (model.modelType) {
                case XHRCTeacherBookType:
                {
                    XHTeacherAddressBookViewController *teacherBook=[[XHTeacherAddressBookViewController alloc] initHiddenWhenPushHidden];
                    [teacherBook setNavtionTitle:@"给老师留言"];
                    [self.navigationController pushViewController:teacherBook animated:YES];
                }
                    break;
                    case XHRCHomeWorkType:
                {
                    
                }
                    break;
                    case XHRCnoticeType:
                {
                    
                }
                    break;
        }
            break;
            
        default:
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
            break;
    }
    
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
            XHRCModel *model = [[XHRCModel alloc]initWithDic:nil];
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
//            model.RCtitle=kTitleList[i];
//            model.RCtitlePic=kTitlePic[i];
            [self.conversationListDataSource insertObject:model atIndex:i];
        }
    [self refreshHead];
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app reloadIMBadge];
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
