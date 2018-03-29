//
//  XHIMViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/28.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIMViewController.h"
#import "AppDelegate.h"
#import "XHRCConversationViewController.h"
#import "XHIMTableViewCell.h"
#import "XHIMModel.h"
#import "XHTeacherAddressBookViewController.h"
#import "XHHomeWorkViewController.h"
#import "XHNoticeListViewController.h"
#import "XHMessageUserInfo.h"
#import "AppDelegate.h"
#define kTitleList @[@"给老师留言",@"家庭作业",@"通知公告"]
#define kTitlePic @[@"im_message",@"im_book",@"im_notice"]
@interface XHIMViewController ()<RCIMReceiveMessageDelegate,RCIMConnectionStatusDelegate
,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIView *navigationView;
@property(nonatomic,strong)XHNetWorkConfig *net;
@property(nonatomic,strong)NSMutableArray *dataArry;
@end

@implementation XHIMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self setConversationPortraitSize:CGSizeMake(50, 50)];
    [self.view addSubview:self.navigationView];
    
    if ([[XHHelper sharedHelper] isIphoneX])
    {
        self.conversationListTableView.frame=CGRectMake(0, 94, SCREEN_WIDTH, SCREEN_HEIGHT-94-50-34);
    }
    else
    {
        self.conversationListTableView.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-50);
    }
    self.conversationListTableView.separatorColor =LineViewColor;
    [self.conversationListTableView registerClass:[XHIMTableViewCell class] forCellReuseIdentifier:@"RongYunListCell"];
    
    self.conversationListTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHead)];
    [self.conversationListTableView  setSeparatorColor:LineViewColor];
    //进入刷新状态
    [self.conversationListTableView.header beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeMethod) name:@"noticeName" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app reloadIMBadge];
    [self.conversationListTableView reloadData];
    
}
-(void)refreshHead
{
    [self.net setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
    [self.net postWithUrl:@"zzjt-app-api_smartCampus018" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSDictionary *dic=[object objectItemKey:@"object"];
            
            NSDictionary *schoolWorkDic=[dic objectItemKey:@"schoolWork"];
            XHIMModel *schoolWorkModel = [[XHIMModel alloc] initWithDic:[schoolWorkDic objectItemKey:@"propValue"]];
            schoolWorkModel.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
            schoolWorkModel.RCtitle=kTitleList[1];
            schoolWorkModel.RCtitlePic=kTitlePic[1];
            //schoolWorkModel.modelType=XHRCHomeWorkType;
            [XHUserInfo sharedUserInfo].sum=0;
            [XHUserInfo sharedUserInfo].sum=[XHUserInfo sharedUserInfo].sum+[schoolWorkModel.sum integerValue];
            [self.conversationListDataSource replaceObjectAtIndex:1 withObject:schoolWorkModel];
            [self.dataArry replaceObjectAtIndex:1 withObject:schoolWorkModel];
            
            XHIMModel *model = [[XHIMModel alloc] initWithDic:[dic objectItemKey:@"notice"]];
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
            model.sum=[dic objectItemKey:@"noticeUnReadNum"];
            model.RCtitle=kTitleList[2];
            model.RCtitlePic=kTitlePic[2];
           // model.modelType=XHRCnoticeType;
            [XHUserInfo sharedUserInfo].sum=[XHUserInfo sharedUserInfo].sum+[model.sum integerValue];
            [self.conversationListDataSource replaceObjectAtIndex:2 withObject:model];
            [self.dataArry replaceObjectAtIndex:2 withObject:model];
            
        }
        [self.conversationListTableView reloadData];
        [self.conversationListTableView.header endRefreshing];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app reloadIMBadge];
    } error:^(NSError *error) {
        [self.conversationListTableView.header endRefreshing];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conversationListDataSource.count;
}
- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
//- (void)didReceiveMessageNotification:(NSNotification *)notification{
//
//
//
//    RCMessage *messgae = (RCMessage *)notification.object;
//    RCUserInfo *user = messgae.content.senderUserInfo;
////    XHMessageUserInfo *info = [[XHMessageUserInfo alloc] init];
////    info.name = user.name;
////    info.headPic = user.portraitUri;
////    info.userId = user.userId;
////    [info saveOrUpdateByColumnName:@"userId" AndColumnValue:user.userId];
////    dispatch_async(dispatch_get_main_queue(),^{
////        [self reloadIMBadge];
////    });
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XHIMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RongYunListCell" forIndexPath:indexPath];
    [cell setItemObject:self.conversationListDataSource[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.conversationListTableView deselectRowAtIndexPath:indexPath animated:YES];
    XHIMModel *model=self.conversationListDataSource[indexPath.row];
//    switch (model.conversationModelType ) {
//        case RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION:
//        {
//            switch (model.modelType) {
//                case XHRCTeacherBookType:
//                {
//                    XHTeacherAddressBookViewController *teacherBook=[[XHTeacherAddressBookViewController alloc] initHiddenWhenPushHidden];
//                    teacherBook.enterType=TeacherAddressBookIMType;
//                    [teacherBook setNavtionTitle:@"给老师留言"];
//                    [self.navigationController pushViewController:teacherBook animated:YES];
//
//                }
//                    break;
//                case XHRCHomeWorkType:
//                {
//                    XHHomeWorkViewController *homeWork=[[XHHomeWorkViewController alloc] initHiddenWhenPushHidden];
//                    [self.navigationController pushViewController:homeWork animated:YES];
//                    homeWork.isRefresh = ^(BOOL ok ) {
//                        if (ok) {
//                            [self refreshHead];
//                        }
//                    };
//                }
//                    break;
//                case XHRCnoticeType:
//                {
//                    XHNoticeListViewController *notice=[[XHNoticeListViewController alloc] initHiddenWhenPushHidden];
//                    [self.navigationController pushViewController:notice animated:YES];
//                    notice.isRefresh = ^(BOOL ok ) {
//                        if (ok) {
//                            [self refreshHead];
//                        }
//                    };
//                }
//                    break;
//            }
//            break;
//
//        default:
//            {
//                AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                [app sendRCIMInfo];
//                XHRCConversationViewController *conversationVC = [[XHRCConversationViewController alloc]init];
//                conversationVC.conversationType =model.conversationType;
//                conversationVC.targetId = model.targetId;
//                conversationVC.titleLabel.text = model.conversationTitle;
//                conversationVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:conversationVC animated:YES];
//            }
//            break;
//        }
//
//    }
}

- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource
{
    [self.conversationListDataSource setArray:dataSource];
    
    NSRange range=NSMakeRange(0,[self.dataArry count]);
    [self.conversationListDataSource insertObjects:self.dataArry atIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    for (int i=0; i<dataSource.count; i++) {
        RCConversationModel *model = dataSource[i];
        XHIMModel *IMmodel=[[XHIMModel alloc] init];
        if(model.conversationType == ConversationType_PRIVATE){
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
             XHMessageUserInfo *info = [XHMessageUserInfo findFirstByCriteria:[NSString stringWithFormat:@"WHERE userId = %@",model.senderUserId]];
            kNSLog(info.name);
            IMmodel.RCtitle=model.senderUserId;
            IMmodel.RCContent=[model.lastestMessage valueForKey:@"content"];
            kNSLog([model.lastestMessage valueForKey:@"content"]);
            IMmodel.createTime=kFormat(@"%zd",model.receivedTime);
            [self.conversationListDataSource replaceObjectAtIndex:i+3 withObject:IMmodel];
        }
    }
    return self.conversationListDataSource;
}
- (void)didReceiveMessageNotification:(NSNotification *)notification{

    RCMessage *messgae = (RCMessage *)notification.object;
    RCUserInfo *user = messgae.content.senderUserInfo;
    XHMessageUserInfo *info = [[XHMessageUserInfo alloc] init];
    info.name = user.name;
    info.headPic = user.portraitUri;
    info.userId = user.userId;
    [info saveOrUpdateByColumnName:@"userId" AndColumnValue:user.userId];
    dispatch_async(dispatch_get_main_queue(),^{
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app reloadIMBadge];
    });
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    XHIMModel *model = [self.conversationListDataSource objectAtIndex:indexPath.row];
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
        if ([[XHHelper sharedHelper]isIphoneX]) {
            _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 94.0)];
            self.navigationView.backgroundColor=[UIColor whiteColor];
            UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 74)];
            titleLabel.textAlignment=NSTextAlignmentCenter;
            [titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
            titleLabel.text=@"消息";
            UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 93, SCREEN_WIDTH, 1)];
            bottomView.backgroundColor=LineViewColor;
            [_navigationView addSubview:titleLabel];
            [_navigationView addSubview:bottomView];
        }
        else
        {
            _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64.0)];
            self.navigationView.backgroundColor=[UIColor whiteColor];
            UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
            titleLabel.textAlignment=NSTextAlignmentCenter;
            [titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
            titleLabel.text=@"消息";
            UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
            bottomView.backgroundColor=LineViewColor;
            [_navigationView addSubview:titleLabel];
            [_navigationView addSubview:bottomView];
        }
        
    }
    return _navigationView;
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
-(NSMutableArray *)dataArry
{
    if (_dataArry==nil) {
        _dataArry=[[NSMutableArray alloc] init];
        for (int i = 0; i<kTitleList.count; i++) {
            XHIMModel *model = [[XHIMModel alloc]initWithDic:nil];
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
            model.RCtitle=kTitleList[i];
            model.RCtitlePic=kTitlePic[i];
            switch (i) {
                case 0:
                {
                    //model.modelType=XHRCTeacherBookType;
                }
                    break;
                case 1:
                {
                   // model.modelType=XHRCHomeWorkType;
                }
                    break;
                    
                case 2:
                {
                   // model.modelType=XHRCnoticeType;
                }
                    break;
            }
            [_dataArry addObject:model];
        }
    }
    return _dataArry;
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
/*
-(RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.conversationListDataSource.count&&indexPath.row < self.conversationListDataSource.count)
    {
        RCConversationModel *model = self.conversationListDataSource[indexPath.row];
        //        [[RCDataManager shareManager] getUserInfoWithUserId:model.targetId completion:^(RCUserInfo *userInfo) {
        //            NSLog(@"rcConversationListTableView 名字 ＝ %@  ID ＝ %@",userInfo.name,userInfo.userId);
        //        }];
        NSInteger unreadCount = model.unreadMessageCount;
        XHRCTableViewCell *cell = (XHRCTableViewCell *)[[XHRCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RCCustomCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.receivedTime/1000];
        NSString *timeString = [[self stringFromDate:date] substringToIndex:10];
        NSString *temp = [self getyyyymmdd];
        NSString *nowDateString = [NSString stringWithFormat:@"%@-%@-%@",[temp substringToIndex:4],[temp substringWithRange:NSMakeRange(4, 2)],[temp substringWithRange:NSMakeRange(6, 2)]];
        
        if ([timeString isEqualToString:nowDateString]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm"];
            NSString *showtimeNew = [formatter stringFromDate:date];
            cell.detailLab.text = [NSString stringWithFormat:@"%@",showtimeNew];
            
        }else{
            cell.detailLab.text = [NSString stringWithFormat:@"%@",timeString];
        }
//        cell.ppBadgeView.dragdropCompletion = ^{
//            NSLog(@"VC = FFF ，ID ＝ %@",model.targetId);
//
//
//
//
//
//            [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:ConversationType_PRIVATE targetId:model.targetId];
//            model.unreadMessageCount = 0;
//            NSInteger ToatalunreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];
//
//            long tabBarCount = ToatalunreadMsgCount-model.unreadMessageCount;
//
//            if (tabBarCount > 0) {
//                [AppDelegate shareAppDelegate].tabbarVC.selectedViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",tabBarCount];
//            }
//            else {
//                [AppDelegate shareAppDelegate].tabbarVC.selectedViewController.tabBarItem.badgeValue = nil;
//            }
//        };
//        if (unreadCount==0) {
//            cell.ppBadgeView.text = @"";
//
//        }else{
//            if (unreadCount>=100) {
//                cell.ppBadgeView.text = @"99+";
//            }else{
//                cell.ppBadgeView.text = [NSString stringWithFormat:@"%li",(long)unreadCount];
//
//            }
//        }
        
        
      
            if ([model.targetId isEqualToString:userInfo.userId]) {
                
                cell.nameLabel.text = [NSString stringWithFormat:@"%@",userInfo.name];
                if ([userInfo.portraitUri isEqualToString:@""]||userInfo.portraitUri==nil) {
                    cell.avatarIV.image = [UIImage imageNamed:@"chatlistDefault"];
                    [cell.contentView bringSubviewToFront:cell.avatarIV];
                }else{
                    [cell.avatarIV sd_setImageWithURL:[NSURL URLWithString:userInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"chatlistDefault"]];
                }
                
                if ([model.lastestMessage isKindOfClass:[RCTextMessage class]]) {
                    cell.contentLabel.text = [model.lastestMessage valueForKey:@"content"];
                    
                }else if ([model.lastestMessage isKindOfClass:[RCImageMessage class]]){
                    
                    if ([model.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
                        //我自己发的
                        RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
                        
                        if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                            cell.contentLabel.text =[NSString stringWithFormat:@"来自\"%@\"的图片消息，点击查看",myselfInfo.name];
                        }else{
                            cell.contentLabel.text =[NSString stringWithFormat:@"来自\"%@\"的图片消息，点击查看",myselfInfo.name];
                            
                        }
                    }else{
                        
                        cell.contentLabel.text =[NSString stringWithFormat:@"来自\"%@\"的图片消息，点击查看",userInfo.name] ;
                    }
                    
                }else if ([model.lastestMessage isKindOfClass:[RCVoiceMessage class]]){
                    if ([model.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
                        //我自己发的
                        RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
                        if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的语音消息，点击查看",myselfInfo.name];
                            
                        }else{
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的语音消息，点击查看",myselfInfo.name];
                        }
                    }else{
                        cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的语音消息，点击查看",userInfo.name];
                    }
                }
                else if ([model.lastestMessage isKindOfClass:[RCLocationMessage class]]){
                    if ([model.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
                        //我自己发的
                        RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
                        if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的位置消息，点击查看",myselfInfo.name];
                        }else{
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的位置消息，点击查看",myselfInfo.name];
                        }
                    }else{
                        cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的位置消息，点击查看",userInfo.name];
                    }
                }
                else if ([model.lastestMessage isKindOfClass:[WMVideoMessage class]]){
                    if ([model.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
                        //我自己发的
                        RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
                        if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的视频消息，点击查看",myselfInfo.name];
                        }else{
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的视频消息，点击查看",myselfInfo.name];
                        }
                    }else{
                        cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的视频消息，点击查看",userInfo.name];
                    }
                }
                
            }
      
        
        return cell;
    }
    else{
        
        return [[RCConversationBaseCell alloc]init];
    }
    
    
}
*/
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
