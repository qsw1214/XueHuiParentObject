//
//  XHRCTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHRCTableViewCell.h"
#import "XHMessageUserInfo.h"
#import "NSDate+Utils.h"
@interface XHRCTableViewCell()
@property(nonatomic,strong)XHHeaderControl *headControl;
@property(nonatomic,strong)ParentLabel *titleLab;
@property(nonatomic,strong)ParentBackLabel *ContentLab;
@property(nonatomic,strong)ParentBackLabel *detailLab;
@property(nonatomic,strong)UILabel *smallLab;
@property(nonatomic,strong)UILabel *bgLabel;
@property(nonatomic,strong)UIImageView *smalImage;
@end

@implementation XHRCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _headControl=[[XHHeaderControl alloc] init];
        [self.contentView addSubview:_headControl];
        _smallLab=[[UILabel alloc] init];
        _smallLab.textAlignment=NSTextAlignmentCenter;
        _smallLab.font=[UIFont systemFontOfSize:14.0f];
        _smallLab.textColor=[UIColor whiteColor];
        _smallLab.layer.masksToBounds=YES;
        _smallLab.backgroundColor=[UIColor redColor];
        _smallLab.layer.cornerRadius=7.5;
        [self.contentView addSubview:_smallLab];
        
        _titleLab=[[ParentLabel alloc] init];
        _titleLab.font=kFont(15.0);
        //_titleLab.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:_titleLab];
        
        _detailLab=[[ParentBackLabel alloc] init];
        _detailLab.font=kFont(12.0);
        _detailLab.textColor=RGB(143, 143, 143);
        _detailLab.textAlignment=NSTextAlignmentRight;
        //_detailLab.backgroundColor=[UIColor blueColor];
        [self.contentView addSubview:_detailLab];
        
        _ContentLab=[[ParentBackLabel alloc] init];
        _ContentLab.font=kFont(14.0);
        //_ContentLab.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:_ContentLab];
        
        _bgLabel=[[UILabel alloc] init];
        _bgLabel.backgroundColor=RGB(244, 244, 244);
        [self.contentView addSubview:_bgLabel];
        [self.contentView addSubview:self.lineLabel];
    }
    return self;
}
-(void)setItemObject:(RCConversation *)model
{
    [self.headControl resetFrame:CGRectMake(15, (self.frame.size.height-50)/2.0, 50, 50)];
    self.headControl.layer.cornerRadius=25;
    self.headControl.layer.masksToBounds=YES;
    self.headControl.layer.cornerRadius=self.headControl.frame.size.height/2.0;
    self.titleLab.frame=CGRectMake(88, 10, 90, 20);
    self.ContentLab.frame=CGRectMake(88, 35, self.frame.size.width-98, self.frame.size.height-45);
    self.detailLab.frame=CGRectMake(170, 10, self.frame.size.width-180, 20);
     self.lineLabel.frame=CGRectMake(0, self.bounds.size.height-0.5, SCREEN_WIDTH, 0.5);
    int Unread=model.unreadMessageCount;
    if (Unread) {
        NSString *UnreadStr=[NSString stringWithFormat:@"%d",Unread];
        self.smallLab.frame=CGRectMake(53, 9, [self getCustomWidth:UnreadStr], 15);
        self.smallLab.text=UnreadStr;
    }
    else
    {
        self.smallLab.frame=CGRectZero;
    }
    
    self.detailLab.text=[[NSDate alloc] getDateString:model.sentTime];
    if ([model.lastestMessage isKindOfClass:[RCTextMessage class]]) {
        RCTextMessage *TextMessage=(RCTextMessage *)model.lastestMessage;
        self.ContentLab.text=TextMessage.content;
        
    }
    else  if ([model.lastestMessage isKindOfClass:[RCImageMessage class]]) {
        self.ContentLab.text=@"[图片]";
    }
    else  if ([model.lastestMessage isKindOfClass:[RCVoiceMessage class]])
    {
        self.ContentLab.text=@"[语音]";
    }
    else if ([model.lastestMessage isKindOfClass:[RCLocationMessage class]])
    {
        self.ContentLab.text=@"[位置]";
    }
    else
    {
        self.ContentLab.text=@" ";
    }
    XHMessageUserInfo *info = [[XHChatManager shareManager] getUserInfoTargetId:model.targetId];
    
    [self.headControl setHeadrUrl:info.headPic withName:info.name withType:XHHeaderTeacherType];
    
    self.titleLab.text=info.name;
}

-(CGFloat)getCustomWidth:(NSString *)str
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(22, 22) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    if (str.length==0)
    {
        return 0;
    }
    if (str.length==1)
    {
        return 15;
    }
    else
    {
        return textSize.width+8;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
