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
#define kTitleList @[@"给老师留言",@"家庭作业",@"通知公告"]
#define kTitlePic @[@"im-mesasage",@"im-book",@"im-notice"]
@interface XHChatViewController ()

@property(nonatomic,strong)UIView *navigationView;
@property(nonatomic,strong)NSMutableArray *modelArr;;
@end

@implementation XHChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    
    //   self.title = @"消息";
    
//    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
//    image.image = [UIImage imageNamed:@"wuxiaoxi"];
//    [image setContentMode:UIViewContentModeScaleAspectFill];
//    self.emptyConversationView = image;//数据为空时显示的图片
    self.conversationListTableView.tableFooterView = [UIView new];//不显示多余的cell
    self.conversationListTableView.backgroundColor=[UIColor lightTextColor];
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];//显示为圆形
    [self setConversationPortraitSize:CGSizeMake(60, 60)];
    [self.view addSubview:self.navigationView];
    self.conversationListTableView.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-54);
    [self.conversationListTableView registerClass:[XHRCTableViewCell class] forCellReuseIdentifier:@"RongYunListCell"];
    [self.conversationListTableView registerClass:[RCConversationBaseCell class] forCellReuseIdentifier:@"cell"];
    //RCConversationBaseCell
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//
//    return 3;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section==0)
//    {
//        return 0;
//    }
//    else
//    {
//         return 15;
//    }
//
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section==0) {
//        return 1;
//    }
//    if (section==1) {
//        return 3;
//    }
//   else {
        return self.conversationListDataSource.count;
//    }
}
- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCConversationModel *model = [self.conversationListDataSource objectAtIndex:indexPath.row];
    if(model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION){
        return UITableViewCellEditingStyleNone;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}
- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        XHRCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RongYunListCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        RCConversationModel *model = self.conversationListDataSource[indexPath.row];
        [cell setItemObject:model];
        return cell;
    
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH ,15)];
    view.backgroundColor = RGB(239, 239, 239);
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
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app sendRCIMInfo];
    XHRCConversationViewController *conversationVC = [[XHRCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.titleLabel.text = model.conversationTitle;
     conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
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
//    //    if ([PersonInfo.type isEqualToString:@"STUDY"]) {
    //NSArray * _titleArr = @[@"给老师留言",@"家庭作业",@"通知公告"];
//    //    }else if ([PersonInfo.type isEqualToString:@"TEACHER"]){
//    //        _titleArr = @[@"系统通知",@"评论",@"点赞",@"访客"];
//    //    }
    for (int i = 0; i<kTitleList.count; i++) {
        RCConversationModel *model = [[RCConversationModel alloc]init];
        model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        model.conversationTitle = kTitleList[i];
        model.senderUserName=kTitlePic[i];
        model.isTop = YES;
        [self.conversationListDataSource insertObject:model atIndex:i];
    }
    [self.modelArr setArray:self.conversationListDataSource];
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
-(NSMutableArray *)modelArr
{
    if (_modelArr==nil) {
        _modelArr=[[NSMutableArray alloc] init];
    }
    return _modelArr;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
