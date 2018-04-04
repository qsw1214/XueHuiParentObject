//
//  XHMessageCell.m
//  TLMessageView
//
//  Created by 郭锐 on 16/8/18.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import "XHMessageCell.h"
#import "Masonry.h"
#import "XHChatManager.h"
@interface XHMessageCell ()
@end

@implementation XHMessageCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.constraints = [NSMutableArray array];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).priorityHigh();
        }];
        
        [self.contentView addSubview:self.dateTimeLabel];
        [self.dateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.height.mas_offset(0);
        }];
        
        [self.contentView addSubview:self.headControl];
        [self.headControl resetFrame:CGRectMake(0, 0, 40, 40)];
        [self.headControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dateTimeLabel.mas_bottom).offset(8);
            make.size.mas_offset(CGSizeMake(40, 40));
            SMAS(make.left.equalTo(self.contentView.mas_left).offset(10));
        }];
        
        [self.contentView addSubview:self.bubbleImageView];
        [self.bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headControl.mas_top).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-8).priorityHigh();
            SMAS(make.left.equalTo(self.headControl.mas_right).offset(7));
            SMAS(make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-78));
        }];
        
        [self.contentView addSubview:self.statusView];
        [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bubbleImageView.mas_centerY).offset(0);
            make.size.mas_offset(CGSizeMake(38, 38));
            SMAS(make.left.equalTo(self.bubbleImageView.mas_right).offset(0));
        }];
        
        [self.statusView addSubview:self.activityIndicator];
        [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.statusView.mas_centerY).offset(0);
            make.centerX.equalTo(self.statusView.mas_centerX).offset(0);
            make.size.mas_offset(CGSizeMake(10, 10));
        }];
        
        [self.statusView addSubview:self.retryBtn];
        [self.retryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.statusView.mas_centerY).offset(0);
            make.centerX.equalTo(self.statusView.mas_centerX).offset(0);
        }];
        
        UITapGestureRecognizer *avatarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarTapAction)];
        [self.headControl addGestureRecognizer:avatarTap];
    }
    return self;
}
#pragma mark- 刷新cell界面
-(void)updateDirection:(RCMessageDirection)direction{
    [self removeAllConstraints];
    
    NSString *bubbleNamed = direction == MessageDirection_RECEIVE ? @"chat_from_bg_normal" : @"chat_to_bg_normal";
    self.bubbleImageView.image = [[UIImage imageNamed:bubbleNamed] stretchableImageWithLeftCapWidth:15 topCapHeight:25];
    
    [self.headControl mas_makeConstraints:^(MASConstraintMaker *make) {
        if (direction == MessageDirection_RECEIVE)
        {
         SMAS(make.left.equalTo(self.contentView.mas_left).offset(10));
            
        }
        else
        {
        SMAS(make.right.equalTo(self.contentView.mas_right).offset(-10));
            
        }
    }];
    if (direction==MessageDirection_RECEIVE)
    {
        XHMessageUserInfo *info = [[XHChatManager shareManager] getUserInfoTargetId:self.message.content.senderUserInfo.userId];
        [self.headControl setHeadrUrl:info.headPic withName:info.name withType:XHHeaderTeacherType];
    }
    else
    {
        XHUserInfo *info=[XHUserInfo sharedUserInfo];
         [self.headControl setHeadrUrl:ALGetFileHeadThumbnail(info.guardianModel.headPic)  withName:info.guardianModel.guardianName withType:XHHeaderTeacherType];
    }
    [self.bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (direction == MessageDirection_RECEIVE) {
            SMAS(make.left.equalTo(self.headControl.mas_right).offset(7));
            SMAS(make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-78));
        }else{
            SMAS(make.right.equalTo(self.headControl.mas_left).offset(-7));
            SMAS(make.left.greaterThanOrEqualTo(self.contentView.mas_left).offset(78));
        }
    }];
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (direction == MessageDirection_RECEIVE) {
            SMAS(make.left.equalTo(self.bubbleImageView.mas_right).offset(0));
        }else{
            SMAS(make.right.equalTo(self.bubbleImageView.mas_left).offset(0));
        }
    }];
    
    
}
#pragma mark- 显示时间
-(void)updateDate:(long long)date showDate:(BOOL)showDate{
    if (!showDate) {
        [self.dateTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
        }];
        self.dateTimeLabel.hidden = YES;
        return;
    }
    
    self.dateTimeLabel.hidden = NO;
   
    [self.dateTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(18);
    }];
    self.dateTimeLabel.text = [[NSDate alloc] getDateString:date];
}
#pragma mark- 数据源方法
-(void)updateMessage:(RCMessage *)message showDate:(BOOL)showDate{
    if (!message.content) {
        return;
    }
    self.message = message;
    self.msgStatus = message.sentStatus; 
    [self updateDirection:message.messageDirection];
    [self updateDate:message.sentTime showDate:showDate];
}
#pragma mark- 显示消息是否发送成功状态
-(void)setMsgStatus:(RCSentStatus)msgStatus{
    if (msgStatus == SentStatus_SENT) {
        self.retryBtn.hidden = YES;
        self.activityIndicator.hidden = YES;
    }
    self.retryBtn.hidden = msgStatus != SentStatus_FAILED;
    if (msgStatus == SentStatus_SENDING) {
        [self.activityIndicator startAnimating];
        self.activityIndicator.hidden = NO;
    }else{
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
    }
}
#pragma mark- 点击头像方法
-(void)avatarTapAction {
    self.clickAvatar(self.message.messageDirection);
}
-(void)removeAllConstraints{
    for (MASConstraint *constraint in self.constraints) {
        [constraint uninstall];
    }
}
#pragma mark- 点击重新发送方法
-(void)retryBtnAction{
    if (self.reSendAction) self.reSendAction(self.message);
}
-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(BOOL)canResignFirstResponder{
    return YES;
}

-(UILabel *)dateTimeLabel{
    if (!_dateTimeLabel) {
        _dateTimeLabel = [[UILabel alloc] init];
        _dateTimeLabel.textColor = UIColorFromRGB(0x999999);
        _dateTimeLabel.font = [UIFont systemFontOfSize:9];
        _dateTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateTimeLabel;
}
-(XHHeaderControl *)headControl{
    if (!_headControl) {
        _headControl = [[XHHeaderControl alloc] init];
        _headControl.layer.cornerRadius = 20;
        _headControl.layer.masksToBounds = YES;
        _headControl.userInteractionEnabled = YES;
    }
    return _headControl;
}
-(UIView *)statusView{
    if (!_statusView) {
        _statusView = [[UIView alloc] init];
    }
    return _statusView;
}
-(UIButton *)retryBtn{
    if (!_retryBtn) {
        _retryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_retryBtn setImage:[UIImage imageNamed:@"news_failinsend"] forState:UIControlStateNormal];
        [_retryBtn addTarget:self action:@selector(retryBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryBtn;
}
-(UIActivityIndicatorView *)activityIndicator{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] init];
        _activityIndicator.hidesWhenStopped = YES;
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        _activityIndicator.color = UIColorFromRGB(0x999999);
    }
    return _activityIndicator;
}
-(TLMessageBubble *)bubbleImageView{
    if (!_bubbleImageView) {
        _bubbleImageView = [[TLMessageBubble alloc] init];
        _bubbleImageView.userInteractionEnabled = YES;
    }
    return _bubbleImageView;
}
-(UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sharp"]];
    }
    return _arrowImageView;
}
@end



@implementation TLMessageBubble
-(BOOL)canBecomeFirstResponder{
    return YES;
}
@end
