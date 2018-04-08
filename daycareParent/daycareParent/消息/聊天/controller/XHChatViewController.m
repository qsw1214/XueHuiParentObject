//
//  TLChatViewController.m
//  TLMessageView
//
//  Created by 郭锐 on 16/8/18.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import "XHChatViewController.h"
#import "XHTextMessageCell.h"
#import "XHPhotoMessageCell.h"
#import "XHVoiceMessageCell.h"
#import "XHLocationMessageCell.h"
#import "TLChatInputView.h"
#import "XHChatManager.h"
#import <RongIMLib/RongIMLib.h>
#import "MJRefresh.h"
#import "XHMessageUserInfo.h"
#import "Masonry.h"
#import "XHChatManager.h"
@interface XHChatViewController ()

<UITableViewDelegate,
UITableViewDataSource,
XHChatManagerDelegate>

@property(nonatomic,strong)TLChatInputView *inputView;
@property(nonatomic,strong)NSMutableArray *messages;
@property(nonatomic,assign)long number;
@end

@implementation XHChatViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [XHChatManager shareManager].delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.number=0;
    [self.view addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_offset(@45);
    }];
    
    [self.view addSubview:self.chatTableView];
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.navigationView.mas_bottom).offset(0);
        make.bottom.equalTo(self.inputView.mas_top).offset(0);
    }];

    weakifySelf;
    //发送消息回调
    self.inputView.sendMsgAction =  ^(RCMessageContent *x){
        strongifySelf;
        [self sendMessage:x];
    };
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden=YES;
    self.chatTableView.header=header;
    
    // 马上进入刷新状态
    [self.chatTableView.header beginRefreshing];

}
-(void)loadNewData
{
    NSArray *arry=nil;
    
    if (self.number==0)
    {
        arry= [[XHChatManager shareManager]getLatestMessages:self.targetID];
    }
    else
    {
        arry=[[XHChatManager shareManager] getHistoryMessages:self.targetID oldestMessageNumber:self.number];

    }
    if (arry)
    {
        for (int i=0; i<arry.count; i++)
        {
            [self.messages insertObject:arry[i] atIndex:0];
            RCMessage *message=arry[i];
            self.number=message.messageId;
        }
        [self.chatTableView reloadData];
        [self.chatTableView.header endRefreshing];
        [self scrollToBottom];
    }
    
}

#pragma - mark tableviewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCMessage *msg = self.messages[indexPath.row];
    RCMessage *lastMsg = [self lasetMsgWithIndex:indexPath.row];
    
    XHMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifierWithMsg:msg]];
#pragma mark- 点击重新发送回调方法
    weakifySelf;
    cell.reSendAction = ^(RCMessage *msg){
        strongifySelf;
        msg.sentStatus = SentStatus_SENDING;
        [self retrySendMessage:msg];
    };
#pragma mark- 点击头像回调方法
    cell.clickAvatar = ^(RCMessageDirection msgDirection){
        
    };
#pragma mark- 数据源
    [cell updateMessage:msg showDate:(msg.sentTime - lastMsg.sentTime > 60 * 5 * 1000)];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCMessage *msg = self.messages[indexPath.row];
    RCMessage *lastMsg = [self lasetMsgWithIndex:indexPath.row];
    CGFloat height = [tableView fd_heightForCellWithIdentifier:[self cellIdentifierWithMsg:msg] cacheByIndexPath:indexPath configuration:^(XHMessageCell *cell) {
        [cell updateMessage:msg showDate:(msg.sentTime - lastMsg.sentTime > 60 * 5 * 1000)];
    }];
    return height;
}

#pragma - mark RCManagerDelegate
#pragma mark- 收到消息回调方法
-(void)rcManagerReceiveMsg:(RCMessage *)msg
{
    
    msg.sentStatus = SentStatus_RECEIVED;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self insertMessage:msg];
        [[XHChatManager shareManager] refreshCashRCUserInfo:msg.content.senderUserInfo];
        [[XHChatManager shareManager] clearMessagesUnread:self.targetID];
        [self.chatTableView reloadData];
    });
}

#pragma - mark 发送消息
-(void)sendMessage:(id)message
{
    
    RCMessage *msg = [[RCMessage alloc] initWithType:ConversationType_PRIVATE targetId:self.targetID direction:MessageDirection_SEND messageId:0 content:message];
    
    msg.sentStatus = SentStatus_SENDING;
    msg.receivedStatus = ReceivedStatus_READ;
    
    RCUserInfo *info=[[XHChatManager shareManager] sendUserInfo];
    msg.content.senderUserInfo=info;
    
    [self insertMessage:msg];
    [self retrySendMessage:msg];
    
    [[XHChatManager shareManager] writeToImage:msg];
}
#pragma mark- 插入数据库
- (void)insertMessage:(RCMessage *)message
{
    if (!message.content) {
        return;
    }
    [self.messages addObject:message];
    
    [self.chatTableView insertRowsAtIndexPaths:@[[self lastMessageIndexPath]] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.chatTableView scrollToRowAtIndexPath:[self lastMessageIndexPath] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
#pragma mark- 重新发送消息，消息发送状态回调方法
- (void)retrySendMessage:(RCMessage *)message
{
    [[XHChatManager shareManager] sendMessage:message successBlock:^(RCMessage *x){
        x.sentStatus = SentStatus_SENT;
        [self updateCellStatusWithMsg:x];
    } failedBlock:^(RCMessage *x){
        x.sentStatus = SentStatus_FAILED;
        [self updateCellStatusWithMsg:x];
    }];
}
#pragma mark- 刷新cell
-(void)updateCellStatusWithMsg:(RCMessage *)msg
{
    NSInteger index = [self.messages indexOfObject:msg];
    XHMessageCell *cell = [self.chatTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell setMsgStatus:msg.sentStatus];
}
-(void)scrollToBottom
{
    if (self.messages.count)
    {
        [self.chatTableView scrollToRowAtIndexPath:[self lastMessageIndexPath] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

-(NSIndexPath *)lastMessageIndexPath
{
    return [NSIndexPath indexPathForItem:self.messages.count - 1 inSection:0];
}
#pragma mark- 最后一次发送的message
-(RCMessage *)lasetMsgWithIndex:(NSInteger)index
{
    return index > 0 ? self.messages[index - 1] : nil;
}
-(NSString *)cellIdentifierWithMsg:(RCMessage *)msg{
    NSDictionary *dic = @{@"RCTextMessage":@"textcell",
                          @"RCVoiceMessage":@"voicecell",
                          @"RCImageMessage":@"photocell",
                          @"RCLocationMessage":@"locationcell"};
    return  dic[NSStringFromClass([msg.content class])];
}
#pragma - mark getter
-(NSMutableArray *)messages
{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}

-(UITableView *)chatTableView
{
    if (!_chatTableView) {
        _chatTableView = [[UITableView alloc] init];
        _chatTableView.delegate = self;
        _chatTableView.dataSource = self;
        _chatTableView.backgroundColor = UIColorFromRGB(0xebebeb);
        _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chatTableView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        _chatTableView.separatorColor = UIColorFromRGB(0xeeeeee);
        [_chatTableView registerClass:[XHTextMessageCell class] forCellReuseIdentifier:@"textcell"];
        [_chatTableView registerClass:[XHPhotoMessageCell class] forCellReuseIdentifier:@"photocell"];
        [_chatTableView registerClass:[XHVoiceMessageCell class] forCellReuseIdentifier:@"voicecell"];
        [_chatTableView registerClass:[XHLocationMessageCell class] forCellReuseIdentifier:@"locationcell"];
    }
    return _chatTableView;
}
-(TLChatInputView *)inputView
{
    if (!_inputView) {
        _inputView = [[TLChatInputView alloc] initWithChatVc:self];
    }
    return _inputView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
