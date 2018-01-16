//
//  XHIMNoticeViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHIMNoticeViewController.h"
#import "XHNoticeViewController.h"
#import "XHChatViewController.h"
#import "XHRCConversationViewController.h"
#import "AppDelegate.h"
#import "XHMessageUserInfo.h"
@interface XHIMNoticeViewController ()
{
    XHNoticeViewController *notific;
    XHChatViewController *chat;
    UIViewController *currentController;
    UISegmentedControl *_sc;
}
@property(nonatomic,strong)UIView *navigationView;

@end

@implementation XHIMNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sc = [[UISegmentedControl alloc] initWithItems:@[@"公告",@"消息"]];
    _sc.selectedSegmentIndex = 0;
    _sc.tintColor = [UIColor whiteColor];
    _sc.frame = CGRectMake(0, 0, 100, 28);
    _sc.center=CGPointMake(SCREEN_WIDTH/2.0, 42);
    [_sc addTarget:self action:@selector(changeMail:) forControlEvents:UIControlEventValueChanged];
    [kWindow addSubview:_sc];
    notific = [[XHNoticeViewController alloc] init];
    [self addChildViewController:notific];
    chat = [[XHChatViewController alloc] init];
    [self addChildViewController:chat];
    currentController = notific;
    [self.view  addSubview:notific.view];
//    //自定义导航左右按钮
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"单聊" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
//    [rightButton setTintColor:[UIColor whiteColor]];
//    self.navigationItem.rightBarButtonItem = rightButton;
    
}
//-(void)rightBarButtonItemPressed:(id)sender
//{
//
//    XHMessageUserInfo *messageInfo = [[XHMessageUserInfo alloc] init];
//    messageInfo.name = [NSString stringWithFormat:@"%@",@"马俊"];
//    messageInfo.headPic = [NSString stringWithFormat:@"%@",ALGetFileHeadThumbnail(@"f8059a90-f4d6-43b2-ae0f-c8a50da41d39.JPEG")];
//    messageInfo.userId = [NSString stringWithFormat:@"%@",@"851718303058542592"];
//    [messageInfo saveOrUpdateByColumnName:@"userId" AndColumnValue:[NSString stringWithFormat:@"%@",@"851718303058542592"]];
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app sendRCIMInfo];
//    XHRCConversationViewController *conversationVC = [[XHRCConversationViewController alloc] init];
//    conversationVC.conversationType = ConversationType_PRIVATE;
//    conversationVC.targetId = [NSString stringWithFormat:@"%@", @"851718303058542592"];
//    conversationVC.title = @"马俊";
//    conversationVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:conversationVC animated:YES];
//}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
    [kWindow addSubview:self.navigationView];
     [kWindow addSubview:_sc];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_sc removeFromSuperview];
    [self.navigationView removeFromSuperview];
}
- (void)changeMail:(UISegmentedControl *)control
{
    
    switch (control.selectedSegmentIndex) {
        case 1:
        {
            if (currentController == chat) {
                return;
            }
            [self transitionFromViewController:currentController toViewController:chat duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
                CATransition *transtion = [CATransition animation];
                transtion.duration = 0.25;
                transtion.timingFunction = UIViewAnimationCurveEaseInOut;
                transtion.type = kCATransitionPush;
                transtion.subtype = kCATransitionFromRight;
                [[self.view layer] addAnimation:transtion forKey:@"animation"];
            } completion:^(BOOL finished) {
                currentController = chat;
            }];
            break;
        }
        case 0:
        {
            if (currentController == notific)
            {
                return;
            }
            [self transitionFromViewController:currentController toViewController:notific duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
                
                CATransition *transtion = [CATransition animation];
                transtion.duration = 0.25;
                transtion.timingFunction = UIViewAnimationCurveEaseInOut;
                transtion.type = kCATransitionPush;
                transtion.subtype = kCATransitionFromLeft;
                
                [[self.view layer] addAnimation:transtion forKey:@"animation"];
                
            } completion:^(BOOL finished) {
                currentController = notific;
            }];
            break;
        }
            
        default:
            break;
    }
    
}
-(UIView *)navigationView
{
    if (_navigationView == nil)
    {
        _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64.0)];
        self.navigationView.backgroundColor=MainColor;
    }
    return _navigationView;
}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
