//
//  XHLiveViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLiveViewController.h"
#import "XHLiveContentView.h"
#import "XHLiveChatRoomViewController.h"


@interface XHLiveViewController () <XHLiveContentViewDeletage>


@property (nonatomic,strong) XHLiveContentView *contentView;


@end

@implementation XHLiveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)dealloc
{
    NSLog(@"内存释放");
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    }
}


-(XHLiveContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHLiveContentView alloc]init];
        [_contentView setDeletage:self];
    }
    return _contentView;
}



#pragma mark - Deletage Method
#pragma mark XHLiveContentViewDeletage
-(void)didSelectRowAtIndexPath:(XHLiveFrame *)object
{
    XHLiveChatRoomViewController *chatRoomVC = [[XHLiveChatRoomViewController alloc]init];
    chatRoomVC.conversationType = ConversationType_CHATROOM;
    chatRoomVC.targetId = @"ChatRoom01";
    chatRoomVC.contentURL = @"rtmp://v68ee57af.live.126.net/live/56bc05e5495b40779a31753f63598d16";
    [self.navigationController pushViewController:chatRoomVC animated:YES];
}




@end
