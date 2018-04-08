//
//  XHChatManager.h
//  TLMessageView
//
//  Created by 郭锐 on 16/8/20.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import "XHMessageUserInfo.h"
#import <RongIMLib/RongIMLib.h>
@protocol XHChatManagerDelegate <NSObject>
-(void)rcManagerReceiveMsg:(RCMessage *)msg;
@end

@interface XHChatManager : NSObject
@property(nonatomic,assign)id <XHChatManagerDelegate> delegate;

+(XHChatManager *)shareManager;
- (void)initEnv;
- (void)connectWithToken:(NSString*)token;
- (void)sendMessage:(RCMessage *)message
        successBlock:(void(^)(RCMessage *))successBlock
         failedBlock:(void(^)(RCMessage *))failedBlock;
-(NSArray *)getConversationList;
-(NSArray *)getHistoryMessages:(NSString *)targetId oldestMessageNumber:(long)oldestMessageId;
-(NSArray *)getLatestMessages:(NSString *)targetId;
-(BOOL)removeConversation:(NSString *)targetId;
-(void)clearMessagesUnread:(NSString *)targetId;
-(void)refreshCashRCUserInfo:(RCUserInfo *)userInfo;
-(XHMessageUserInfo *)getUserInfoTargetId:(NSString *)targetId;
-(RCUserInfo *)sendUserInfo;
-(UIImage *)getRCImage:(RCMessage *)message;
@end
