//
//  XHRecordVoice.h
//  TLMessageView
//
//  Created by 郭锐 on 16/8/19.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XHRecorderVoiceDelegate <NSObject>
-(void)recorderVoiceFailure;
-(void)recorderVoiceSuccessWithVoiceData:(NSData *)voiceData duration:(long)duration;
@end

@interface XHRecordVoice : NSObject
@property(nonatomic,assign)id <XHRecorderVoiceDelegate> delegate;
-(instancetype)initWithDelegate:(id <XHRecorderVoiceDelegate>)delegate;
-(void)startRecord;
-(void)completeRecord;
-(void)cancelRecord;
@end
