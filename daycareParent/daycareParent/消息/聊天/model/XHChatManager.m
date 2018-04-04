//
//  XHChatManager.m
//  TLMessageView
//
//  Created by 郭锐 on 16/8/20.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import "XHChatManager.h"
#import <RongIMLib/RongIMLib.h>
#import "NSDate+Utils.h"
//static NSString *RongCloundKey = @"8w7jv4qb8wt3y";//y745wfm844a4v


@interface XHChatManager () <RCIMClientReceiveMessageDelegate>
@property(nonatomic,strong)XHMessageUserInfo *userInfo;
@end

@implementation XHChatManager
+(XHChatManager *)shareManager{
    static dispatch_once_t onceToken;
    static XHChatManager *player;
    dispatch_once(&onceToken, ^{
        player = [[XHChatManager alloc] init];
    });
    return player;
}
- (instancetype) init{
    if (self = [super init]) {
        [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:nil];
       
    }
    return self;
}
#pragma mark-----上传个人数据到融云服务器
-(RCUserInfo *)sendUserInfo
{
    XHUserInfo *user=[XHUserInfo sharedUserInfo];
    RCUserInfo *userInfo = [[RCUserInfo alloc] init];
    userInfo.userId = user.guardianModel.guardianId;
    userInfo.portraitUri = ALGetFileHeadThumbnail(user.guardianModel.headPic);
    
    userInfo.name = user.guardianModel.guardianName;
    [RCIMClient sharedRCIMClient].currentUserInfo = userInfo;
    return userInfo;
}
#pragma mark- 初始化融云
- (void) initEnv{
    [[RCIMClient sharedRCIMClient] init:RONGCLOUD_IM_APPKEY_];
    
}
#pragma mark- 断开与融云服务器的连接，并不再接收远程推送
- (void) disconnect{
    [[RCIMClient sharedRCIMClient] logout];
}
#pragma mark- 登录融云
- (void) connectWithToken:(NSString*)token{
    if (!token) return;
    [[RCIMClient sharedRCIMClient] connectWithToken:token success:^(NSString *userId) {
        NSLog(@"****************************************");
        NSLog(@"Rong connectWithToken success");
        NSLog(@"Rong uid is:%@", userId);
        NSLog(@"****************************************");
        BOOL creat = [XHMessageUserInfo createTable];
        if (creat) {
            NSLog(@"表已存在");
        }else{
            NSLog(@"建表");
        }
       
        [self sendUserInfo];
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"💥Rong connectWithToken error:%tu", status);
    } tokenIncorrect:^{
        NSLog(@"💥Rong connectWithToken incorrect");
    }];
}
#pragma mark- 发送消息并是否成功回调
- (void) sendMessage:(RCMessage *)message
        successBlock:(void(^)(RCMessage *))successBlock
         failedBlock:(void(^)(RCMessage *))failedBlock
{
    
    [[RCIMClient sharedRCIMClient] sendMessage:message.conversationType targetId:message.targetId content:message.content pushContent:nil pushData:nil success:^(long messageId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (successBlock) {
                successBlock(message);
            }
        });
    } error:^(RCErrorCode nErrorCode, long messageId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failedBlock) {
                failedBlock(message);
            }
        });
    }];
}

#pragma mark- 获取本地聊天列表信息
-(NSArray *)getConversationList
{
    NSArray *conversationList = [[RCIMClient sharedRCIMClient]
                                 getConversationList:@[@(ConversationType_PRIVATE)]];

    return conversationList;
}
#pragma mark- 获取本地聊天信息
-(NSArray *)getHistoryMessages:(NSString *)targetId oldestMessageNumber:(long)oldestMessageId
{
    NSArray *historyMessages=[[RCIMClient sharedRCIMClient] getHistoryMessages:ConversationType_PRIVATE targetId:targetId oldestMessageId:oldestMessageId count:5];

    return historyMessages;
}
#pragma mark- 获取最新本地聊天消息
-(NSArray *)getLatestMessages:(NSString *)targetId
{
    NSArray *arry= [[RCIMClient sharedRCIMClient] getLatestMessages:ConversationType_PRIVATE targetId:targetId count:5];
    return arry;
}
#pragma mark-  接收消息的回调方法
- (void)onReceived:(RCMessage *)message
              left:(int)nLeft
            object:(id)object{
    if (message.conversationType == ConversationType_PRIVATE) {
        if ([self.delegate respondsToSelector:@selector(rcManagerReceiveMsg:)]) {
            [self.delegate rcManagerReceiveMsg:message];
        }
    }
}
#pragma mark- 清除未读消息
-(void)clearMessagesUnread:(NSString *)targetId
{
    [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:ConversationType_PRIVATE targetId:targetId];
}
#pragma mark- 刷新本地缓存
-(void)refreshCashRCUserInfo:(RCUserInfo *)userInfo
{
    self.userInfo.name = userInfo.name;
    self.userInfo.userId = userInfo.userId;
    self.userInfo.headPic=userInfo.portraitUri;
    [self.userInfo saveOrUpdateByColumnName:@"userId" AndColumnValue:userInfo.userId];

}
#pragma mark- 本地缓存对象
-(XHMessageUserInfo *)getUserInfoTargetId:(NSString *)targetId
{
    XHMessageUserInfo *info = [XHMessageUserInfo findFirstByCriteria:[NSString stringWithFormat:@"WHERE userId = %@",targetId]];
    return info;
}
#pragma mark- 写入文件
-(void)writeToFileMessage:(RCMessage *)msg
{
    if ([msg.content isKindOfClass:[RCImageMessage class]])
    {
        RCImageMessage *imgMessage = (RCImageMessage *)msg.content;
        NSString *filePath = [[self class] getIconCachePath:[NSString stringWithFormat:@"user%@.png", [[NSDate alloc] getDateString:msg.sentTime]]];
        [UIImagePNGRepresentation(imgMessage.originalImage) writeToFile:filePath atomically:YES];
    }
  
}
#pragma mark- 读取文件
-(NSString *)getFileUrlMessage:(RCMessage *)msg
{
    if ([msg.content isKindOfClass:[RCImageMessage class]])
    {
        NSString *filePath = [[self class] getIconCachePath:[NSString stringWithFormat:@"user%@.png", [[NSDate alloc] getDateString:msg.sentTime]]];
        
        return filePath;
    }
   
    return nil;
}
+ (NSString *)getIconCachePath:(NSString *)fileName {
    NSString *cachPath =
    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath =
    [cachPath stringByAppendingPathComponent:[NSString stringWithFormat:@"CachedIcons/%@",
                                              fileName]]; // 保存文件的名称
    
    NSString *dirPath = [cachPath stringByAppendingPathComponent:[NSString stringWithFormat:@"CachedIcons"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dirPath]) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filePath;
}
-(XHMessageUserInfo *)userInfo
{
    if (_userInfo==nil) {
        _userInfo=[[XHMessageUserInfo alloc] init];
    }
    return _userInfo;
}
@end
