//
//  XHUserTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHUserTableViewCell.h"
#import "XHSystemModel.h"
@interface XHUserTableViewCell()



@end

@implementation XHUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        _frontLabel=[[ParentLabel alloc] init];
        [self.contentView addSubview:_frontLabel];
        _backLabel=[[ParentLabel alloc] init];
        _backLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_backLabel];
        _headBtn=[[UIButton alloc] init];
        _headBtn.layer.cornerRadius=USER_HEARD/2.0;
        _headBtn.layer.masksToBounds=YES;
        [self.contentView addSubview:_headBtn];
        
        [self.contentView addSubview:self.lineLabel];
        
        [self.contentView addSubview:self.arrowImageView];
        
    }
    return self;
}
-(void)setItemObject:(id)object withIndexPathRow:(NSInteger)row
{
    self.arrowImageView.frame=CGRectMake(SCREEN_WIDTH-22, (self.bounds.size.height-14)/2.0, 8, 14);
    self.lineLabel.frame=CGRectMake(0, self.bounds.size.height-0.5, SCREEN_WIDTH, 0.5);
    switch (self.modelType) {
        case XHUserTableViewCellSetType:
        {
            self.frontLabel.frame=CGRectMake(10, (self.bounds.size.height-40)/2.0, 120, 40);
            self.backLabel.frame=CGRectMake(120, (self.bounds.size.height-40)/2.0, SCREEN_WIDTH-150, 40);
            self.headBtn.frame=CGRectMake(SCREEN_WIDTH-60, (self.bounds.size.height-30)/2.0, 50, 30);
            
            self.frontLabel.text=kTitle[row];
            self.headBtn.layer.cornerRadius=0;
            BOOL select =[self noticeJupsh];
            if (!select)
            {
                [self.headBtn setBackgroundImage:[UIImage imageNamed:@"ico_set_close"] forState:UIControlStateNormal];
            }
            else
            {
                [self.headBtn setBackgroundImage:[UIImage imageNamed:@"ico_set_open"] forState:UIControlStateNormal];
            }
            if (row==1)
            {
                self.headBtn.hidden=NO;
                self.arrowImageView.hidden=YES;
            }
            else
            {
                self.headBtn.hidden=YES;
                self.arrowImageView.hidden=NO;
                
                if (row==4)
                {
                    self.backLabel.text=kFormat(@"v%@",AppVersion);
                }
            }
        }
            break;
            
       case XHUserTableViewCellPersonType:
        {
            XHUserInfo *userInfo=[XHUserInfo sharedUserInfo];
            
            self.frontLabel.frame=CGRectMake(10, 0, 120, self.bounds.size.height);
            self.backLabel.frame=CGRectMake(130, 0, SCREEN_WIDTH-160, self.bounds.size.height);
            self.frontLabel.text=kPersonTitle[row];
            self.headBtn.frame=CGRectMake(SCREEN_WIDTH-USER_HEARD-30, 10, USER_HEARD, USER_HEARD);
            [self.headBtn setHeadrPic:userInfo.headPic withName:userInfo.guardianModel.guardianName withType:XHstudentType];
            if (row==0) {
                self.headBtn.hidden=NO;
                self.backLabel.hidden=YES;
                self.lineLabel.frame=CGRectMake(0, USER_HEARD+20-0.5, SCREEN_WIDTH, 0.5);
               
            }
            else
            {
                self.headBtn.hidden=YES;
                self.backLabel.hidden=NO;
                self.backLabel.text=userInfo.guardianModel.guardianName;
                self.lineLabel.frame=CGRectMake(0, 50-0.5, SCREEN_WIDTH, 0.5);
            }
        }
            break;
    }
    
}
-(BOOL)noticeJupsh
{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0f) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            NSLog(@"推送关闭");
            return NO;
        }else{
            NSLog(@"推送打开");
            return YES;
        }
    }else
    {
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone == type)
        {
            NSLog(@"推送关闭");
            return NO;
        }else{
            NSLog(@"推送打开");
            return YES;
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
