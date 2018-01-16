//
//  XHAddressBookToolBar.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookToolBar.h"
#import "XHAddressBookLecturesControl.h"
#import "XHHelper.h"
#import "XHRCConversationViewController.h"
#import "XHMessageUserInfo.h"
#import "AppDelegate.h"
@interface XHAddressBookToolBar ()

@property (nonatomic,strong) XHAddressBookToolBarItemControl *phoneControl; //!< 电话
@property (nonatomic,strong) XHAddressBookToolBarItemControl *messageControl; //!< 短信
@property (nonatomic,strong) XHAddressBookToolBarItemControl *imControl; //!< 发送即时通讯消息
@property (nonatomic,strong) XHAddressBookToolBarItemControl *courseControl; //!< 课程

@end

@implementation XHAddressBookToolBar


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.phoneControl];
        [self addSubview:self.messageControl];
        [self addSubview:self.imControl];
        [self addSubview:self.courseControl];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    
    [self.phoneControl resetFrame:CGRectMake(0, 0, (frame.size.width/4.0), frame.size.height)];
    [self.messageControl resetFrame:CGRectMake(self.phoneControl.right, self.phoneControl.top, self.phoneControl.width, self.phoneControl.height)];
    [self.imControl resetFrame:CGRectMake(self.messageControl.right, self.phoneControl.top, self.phoneControl.width, self.phoneControl.height)];
    [self.courseControl resetFrame:CGRectMake(self.imControl.right, self.phoneControl.top, self.phoneControl.width, self.phoneControl.height)];
    
}



#pragma mark - Action Method
-(void)controlAction:(XHAddressBookToolBarItemControl*)sender
{
    switch (sender.tag)
    {
#pragma mark case 1 拨打电话
        case 1:
        {
            [[XHHelper sharedHelper] telephone:self.itemFrame.model.phone];
        }
            break;
#pragma mark case 2 发送短信
        case 2:
        {
            [[XHHelper sharedHelper] sendMessage:self.itemFrame.model.phone];
        }
            break;
#pragma mark case 3 发送消息
        case 3:
        {
                BaseViewController *vc =[[XHHelper sharedHelper] currentVC];
                XHMessageUserInfo *messageInfo = [[XHMessageUserInfo alloc] init];
                messageInfo.name = [NSString stringWithFormat:@"%@",self.itemFrame.model.teacherName];
                messageInfo.headPic = [NSString stringWithFormat:@"%@",self.itemFrame.model.headerUrl];
                messageInfo.userId = [NSString stringWithFormat:@"%@",self.itemFrame.model.userID];
                [messageInfo saveOrUpdateByColumnName:@"userId" AndColumnValue:[NSString stringWithFormat:@"%@",self.itemFrame.model.userID]];
               AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
               [app sendRCIMInfo];
                XHRCConversationViewController *conversationVC = [[XHRCConversationViewController alloc] init];
            conversationVC.titleLabel.text=self.itemFrame.model.teacherName;
                conversationVC.conversationType = ConversationType_PRIVATE;
                conversationVC.targetId = [NSString stringWithFormat:@"%@", self.itemFrame.model.userID];
              [vc.navigationController pushViewController:conversationVC animated:YES];
        }
            break;
#pragma mark case 4 所授课程
        case 4:
        {
            XHAddressBookLecturesControl *lectures = [[XHAddressBookLecturesControl alloc]init];
            [lectures setItemFrame:self.itemFrame];
            [lectures show];
        }
            break;
    }
}



#pragma mark - Getter / Setter
-(XHAddressBookToolBarItemControl *)phoneControl
{
    if (_phoneControl == nil)
    {
        _phoneControl = [[XHAddressBookToolBarItemControl alloc]init];
        [_phoneControl setImageName:@"ico_call"];
        [_phoneControl setTitle:@"拨打电话"];
        [_phoneControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_phoneControl setTag:1];
    }
    return _phoneControl;
}


-(XHAddressBookToolBarItemControl *)messageControl
{
    if (_messageControl == nil)
    {
        _messageControl = [[XHAddressBookToolBarItemControl alloc]init];
        [_messageControl setImageName:@"ico_msm"];
        [_messageControl setTitle:@"发送短信"];
        [_messageControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_messageControl setTag:2];
    }
    return _messageControl;
}

-(XHAddressBookToolBarItemControl *)imControl
{
    if (_imControl == nil)
    {
        _imControl = [[XHAddressBookToolBarItemControl alloc]init];
        [_imControl setImageName:@"ico_news"];
        [_imControl setTitle:@"发送消息"];
        [_imControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_imControl setTag:3];
    }
    return _imControl;
}

-(XHAddressBookToolBarItemControl *)courseControl
{
    if (_courseControl == nil)
    {
        _courseControl = [[XHAddressBookToolBarItemControl alloc]init];
        [_courseControl setImageName:@"ico_course"];
        [_courseControl setTitle:@"所授课程"];
        [_courseControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_courseControl setTag:4];
    }
    return _courseControl;
}





@end
