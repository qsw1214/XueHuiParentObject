//
//  XHIMViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/28.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHIMViewController.h"
#import "AppDelegate.h"
#import "XHRCModel.h"
#import "XHRCTableViewCell.h"
#define kTitleList @[@"给老师留言",@"家庭作业",@"通知公告"]
#define kTitlePic @[@"im_message",@"im_book",@"im_notice"]
@interface XHIMViewController ()<RCIMReceiveMessageDelegate
,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArry;
@end

@implementation XHIMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveMessageNotification:)name:RCKitDispatchMessageNotification object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app reloadIMBadge];
    [self.conversationListTableView reloadData];
    
}
/*!
 接收消息的回调方法
 *
 */
-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left
{
    NSLog(@" onRCIMReceiveMessage %@",message.content);
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app reloadIMBadge];
    [self.conversationListTableView reloadData];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    XHRCModel *model = [self.conversationListDataSource objectAtIndex:indexPath.row];
    if(model.conversationModelType == RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION){
        return UITableViewCellEditingStyleNone;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}
//高度
-(CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return [self.conversationListDataSource[indexPath.row] CellHeight];
}
- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource
{
    [self.conversationListDataSource setArray:dataSource];
    NSRange range=NSMakeRange(0,[self.dataArry count]);
    [self.conversationListDataSource insertObjects:self.dataArry atIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    return self.conversationListDataSource;
}
-(NSMutableArray *)dataArry
{
    if (_dataArry==nil) {
        _dataArry=[[NSMutableArray alloc] init];
        for (int i = 0; i<kTitleList.count; i++) {
            XHRCModel *model = [[XHRCModel alloc]initWithDic:nil];
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
                    model.modelType=XHRCHomeWorkType;
                }
                    break;
                    
                case 2:
                {
                    model.modelType=XHRCnoticeType;
                }
                    break;
            }
            [_dataArry addObject:model];
        }
    }
    return _dataArry;
}
-(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyyMMdd";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;
    
}
-(NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
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
