//
//  XHLiveChatRoomViewController.h
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLiveChatRoomViewController.h"
#import "RCDLiveGiftMessage.h"
#import "RCDLiveTipMessageCell.h"
#import "RCDLiveMessageModel.h"
#import "RCDLive.h"
#import "RCDLiveCollectionViewHeader.h"
#import "RCDLiveKitUtility.h"
#import "RCDLiveKitCommonDefine.h"
#import <RongIMLib/RongIMLib.h>
#import <objc/runtime.h>
#import "RCDLiveTipMessageCell.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "UIView+RCDDanmaku.h"
#import "RCDDanmaku.h"
#import "RCDDanmakuManager.h"
#import "NELivePlayerController.h"

#define kWindow [UIApplication sharedApplication].keyWindow
#define KING_WINDOW [[UIApplication sharedApplication].windows lastObject]
//主屏幕的大小
#define WindowScreen [[UIScreen mainScreen] bounds]

//设备屏幕尺寸
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height) //! 屏幕高度
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)   //!< 屏幕宽度



#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(255.0) / 255.0 blue:arc4random_uniform(255.0) / 255.0 alpha:1]

//输入框的高度
#define MinHeight_InputView 50.0f
#define kBounds [UIScreen mainScreen].bounds.size
@interface XHLiveChatRoomViewController () <
UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate,
UIScrollViewDelegate, UINavigationControllerDelegate,RCTKInputBarControlDelegate,RCConnectionStatusChangeDelegate,UIAlertViewDelegate>

@property(nonatomic, strong) RCDLiveCollectionViewHeader *collectionViewHeader;

/**
 *  存储长按返回的消息的model
 */
@property(nonatomic, strong) RCDLiveMessageModel *longPressSelectedModel;

/**
 *  是否需要滚动到底部
 */
@property(nonatomic, assign) BOOL isNeedScrollToButtom;

/**
 *  是否正在加载消息
 */
@property(nonatomic) BOOL isLoading;

/**
 *  会话名称
 */
@property(nonatomic,copy) NSString *navigationTitle;

/**
 *  点击空白区域事件
 */
@property(nonatomic, strong) UITapGestureRecognizer *resetBottomTapGesture;

/**
 *  播放器view
 */
@property(nonatomic,strong) UIView *liveView;

/**
 *  底部显示未读消息view
 */
@property (nonatomic, strong) UIView *unreadButtonView;
@property (nonatomic, strong) UILabel *unReadNewMessageLabel;

/**
 *  滚动条不在底部的时候，接收到消息不滚动到底部，记录未读消息数
 */
@property (nonatomic, assign) NSInteger unreadNewMsgCount;

/**
 *  当前融云连接状态
 */
@property (nonatomic, assign) RCConnectionStatus currentConnectionStatus;

/**
 *  返回按钮
 */
@property (nonatomic, strong) UIButton *backBtn;

/**
 *  鲜花按钮
 */
@property(nonatomic,strong)UIButton *flowerBtn;

/**
 *  评论按钮
 */
@property(nonatomic,strong)UIButton *feedBackBtn;

/**
 *  掌声按钮
 */
@property(nonatomic,strong)UIButton *clapBtn;
@property(nonatomic,strong)UICollectionView *portraitsCollectionView;




@property (nonatomic,strong) BaseButtonControl *closeButtonControl;

@property (nonatomic, strong) NELivePlayerController *player; //播放器sdk

@end

/**
 *  文本cell标示
 */
static NSString *const rctextCellIndentifier = @"rctextCellIndentifier";

/**
 *  小灰条提示cell标示
 */
static NSString *const RCDLiveTipMessageCellIndentifier = @"RCDLiveTipMessageCellIndentifier";

/**
 *  礼物cell标示
 */
static NSString *const RCDLiveGiftMessageCellIndentifier = @"RCDLiveGiftMessageCellIndentifier";

@implementation XHLiveChatRoomViewController


#pragma mark - 视图生命周期方法
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self rcinit];
    }
    return self;
}



- (void)rcinit
{
    self.conversationDataRepository = [[NSMutableArray alloc] init];
    self.conversationMessageCollectionView = nil;
    self.targetId = nil;
    [self registerNotification];
    self.defaultHistoryMessageCountOfChatRoom = 10;
    [[RCIMClient sharedRCIMClient]setRCConnectionStatusChangeDelegate:self];
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addGestureRecognizer:_resetBottomTapGesture];
    [self.conversationMessageCollectionView reloadData];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationTitle = self.navigationItem.title;
}

/**
 *  移除监听
 
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
    [self.conversationMessageCollectionView removeGestureRecognizer:_resetBottomTapGesture];
    [self.conversationMessageCollectionView
     addGestureRecognizer:_resetBottomTapGesture];
    
    //退出页面，弹幕停止
    [self.view stopDanmaku];
    
    //退出聊天室
    [self quitConversationViewAndClear];
}



/**
 *  页面加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.closeButtonControl resetFrame:CGRectMake(0, 0, 64, 64)];
    [self.closeButtonControl setImageEdgeFrame:CGRectMake(10+((54-20)/2.0), 20+((44-20)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.closeButtonControl setImage:@"close" withNumberType:0 withAllType:NO];
    
    
    //默认进行弹幕缓存，不过量加载弹幕，如果想要同时大批量的显示弹幕，设置为yes，弹幕就不会做弹道检测和缓存
    RCDanmakuManager.isAllowOverLoad = NO;
    [self doInitPlayer];
    [self doInitPlayerNotication];
    //初始化UI
    [self initializedSubViews];
    
    __weak XHLiveChatRoomViewController *weakSelf = self;
    
    //聊天室类型进入时需要调用加入聊天室接口，退出时需要调用退出聊天室接口
    if (ConversationType_CHATROOM == self.conversationType) {
        [[RCIMClient sharedRCIMClient]
         joinChatRoom:self.targetId
         messageCount:self.defaultHistoryMessageCountOfChatRoom
         success:^{
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 [self initializedLiveSubViews];
                 
                 RCInformationNotificationMessage *joinChatroomMessage = [[RCInformationNotificationMessage alloc]init];
                 joinChatroomMessage.message = [NSString stringWithFormat: @" 来啦"];
                [self sendMessage:joinChatroomMessage pushContent:nil];
             });
         }
         error:^(RCErrorCode status)
        {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (status == KICKED_FROM_CHATROOM) {
                     [weakSelf loadErrorAlert:NSLocalizedStringFromTable(@"JoinChatRoomRejected", @"RongCloudKit", nil)];
                 } else
                 {
                     [weakSelf loadErrorAlert:NSLocalizedStringFromTable(@"JoinChatRoomFailed", @"RongCloudKit", nil)];
                 }
             });
         }];
    }
    
    
    [self.view addSubview:self.closeButtonControl];
}










#pragma mark - Action Method 逻辑操作方法
/**
 *  注册监听Notification
 */
- (void)registerNotification {
    //注册接收消息
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCDLiveKitDispatchMessageNotification
     object:nil];
}

/**
 *  注册cell
 *
 *  @param cellClass  cell类型
 *  @param identifier cell标示
 */
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [self.conversationMessageCollectionView registerClass:cellClass
                               forCellWithReuseIdentifier:identifier];
}


- (void)sendDanmaku:(NSString *)text
{
    if(!text || text.length == 0)
    {
        return;
    }
    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
    danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : kRandomColor}];
    [self.liveView sendDanmaku:danmaku];
}

- (void)sendCenterDanmaku:(NSString *)text
{
    if(!text || text.length == 0){
        return;
    }
    RCDDanmaku *danmaku = [[RCDDanmaku alloc]init];
    danmaku.contentStr = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:218.0/255 green:178.0/255 blue:115.0/255 alpha:1]}];
    danmaku.position = RCDDanmakuPositionCenterTop;
    [self.liveView sendDanmaku:danmaku];
}



#pragma mark 加入聊天室失败的提示
/**
 *  加入聊天室失败的提示
 *
 *  @param title 提示内容
 */
- (void)loadErrorAlert:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}







/**
 *  点击返回的时候消耗播放器和退出聊天室
 *
 *  @param sender sender description
 */
- (void)leftBarButtonItemPressed:(id)sender {
  UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"退出聊天室？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
  [alertview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  [self quitConversationViewAndClear];
}

// 清理环境（退出聊天室并断开融云连接）
- (void)quitConversationViewAndClear
{
    [self doDestroyPlayer];
    
    
    __weak typeof (self) weakSelf = self;
    
    
    if (self.conversationType == ConversationType_CHATROOM)
    {
      //退出聊天室
        [[RCIMClient sharedRCIMClient] quitChatRoom:self.targetId
                                            success:^{
                                                
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    
                                                    weakSelf.conversationMessageCollectionView.dataSource = nil;
                                                    weakSelf.conversationMessageCollectionView.delegate = nil;
                                                    [[NSNotificationCenter defaultCenter] removeObserver:self];
                                                    
                                                    
                                                    
                                                    [weakSelf.navigationController popViewControllerAnimated:YES];
                                                });
                                            } error:^(RCErrorCode status) {}];
    }
}

/**
 *  初始化页面控件
 */
- (void)initializedSubViews
{
    //聊天区
    if(self.contentView == nil)
    {
        CGRect contentViewFrame = CGRectMake(0, self.view.bounds.size.height-237, self.view.bounds.size.width,237);
        self.contentView.backgroundColor = RCDLive_RGBCOLOR(235, 235, 235);
        self.contentView = [[UIView alloc]initWithFrame:contentViewFrame];
        [self.view addSubview:self.contentView];
    }
    //聊天消息区
    if (nil == self.conversationMessageCollectionView) {
        UICollectionViewFlowLayout *customFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        customFlowLayout.minimumLineSpacing = 0;
        customFlowLayout.sectionInset = UIEdgeInsetsMake(10.0f, 0.0f,5.0f, 0.0f);
        customFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGRect _conversationViewFrame = self.contentView.bounds;
        _conversationViewFrame.origin.y = 0;
        _conversationViewFrame.size.height = self.contentView.bounds.size.height - 50;
        _conversationViewFrame.size.width = 240;
        self.conversationMessageCollectionView =
        [[UICollectionView alloc] initWithFrame:_conversationViewFrame
                           collectionViewLayout:customFlowLayout];
        [self.conversationMessageCollectionView
         setBackgroundColor:[UIColor redColor]];
        self.conversationMessageCollectionView.showsHorizontalScrollIndicator = NO;
        self.conversationMessageCollectionView.alwaysBounceVertical = YES;
        self.conversationMessageCollectionView.dataSource = self;
        self.conversationMessageCollectionView.delegate = self;
        [self.contentView addSubview:self.conversationMessageCollectionView];
    }
    //输入区
    if(self.inputBar == nil)
    {
        float inputBarOriginY = self.conversationMessageCollectionView.bounds.size.height +30;
        float inputBarOriginX = self.conversationMessageCollectionView.frame.origin.x;
        float inputBarSizeWidth = self.contentView.frame.size.width;
        float inputBarSizeHeight = MinHeight_InputView;
        self.inputBar = [[RCDLiveInputBar alloc]initWithFrame:CGRectMake(inputBarOriginX, inputBarOriginY,inputBarSizeWidth,inputBarSizeHeight)];
        self.inputBar.delegate = self;
        self.inputBar.backgroundColor = [UIColor clearColor];
        self.inputBar.hidden = YES;
        [self.contentView addSubview:self.inputBar];    }
    self.collectionViewHeader = [[RCDLiveCollectionViewHeader alloc]
                                 initWithFrame:CGRectMake(0, -50, self.view.bounds.size.width, 40)];
    _collectionViewHeader.tag = 1999;
    [self.conversationMessageCollectionView addSubview:_collectionViewHeader];
    [self registerClass:[RCDLiveTipMessageCell class]forCellWithReuseIdentifier:RCDLiveTipMessageCellIndentifier];
    [self changeModel:YES];
    _resetBottomTapGesture =[[UITapGestureRecognizer alloc]
                             initWithTarget:self
                             action:@selector(tap4ResetDefaultBottomBarStatus:)];
    [_resetBottomTapGesture setDelegate:self];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(10, 35, 72, 25);
    UIImageView *backImg = [[UIImageView alloc]
                            initWithImage:[UIImage imageNamed:@"back"]];
    backImg.frame = CGRectMake(0, 0, 25, 25);
    [_backBtn addSubview:backImg];
    [_backBtn addTarget:self
                 action:@selector(leftBarButtonItemPressed:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    
    _feedBackBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    _feedBackBtn.frame = CGRectMake(10, self.view.frame.size.height - 45, 35, 35);
    UIImageView *clapImg = [[UIImageView alloc]
                            initWithImage:[UIImage imageNamed:@"feedback"]];
    clapImg.frame = CGRectMake(0,0, 35, 35);
    [_feedBackBtn addSubview:clapImg];
    [_feedBackBtn addTarget:self
                     action:@selector(showInputBar:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_feedBackBtn];
    
    _flowerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _flowerBtn.frame = CGRectMake(self.view.frame.size.width-90, self.view.frame.size.height - 45, 35, 35);
    UIImageView *clapImg2 = [[UIImageView alloc]
                             initWithImage:[UIImage imageNamed:@"giftIcon"]];
    clapImg2.frame = CGRectMake(0,0, 35, 35);
    [_flowerBtn addSubview:clapImg2];
    [_flowerBtn addTarget:self
                   action:@selector(flowerButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [_flowerBtn setHidden:YES];
    [self.view addSubview:_flowerBtn];
    
    _clapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clapBtn.frame = CGRectMake(self.view.frame.size.width-45, self.view.frame.size.height - 45, 35, 35);
    UIImageView *clapImg3 = [[UIImageView alloc]
                             initWithImage:[UIImage imageNamed:@"heartIcon"]];
    clapImg3.frame = CGRectMake(0,0, 35, 35);
    [_clapBtn addSubview:clapImg3];
    [_clapBtn addTarget:self
                 action:@selector(clapButtonPressed:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_clapBtn];
}

-(void)showInputBar:(id)sender
{
    self.inputBar.hidden = NO;
    [self.inputBar setInputBarStatus:RCDLiveBottomBarKeyboardStatus];
}

#pragma mark 发送钻石
/**
 *  发送鲜花
 *
 *  @param sender sender description
 */
-(void)flowerButtonPressed:(id)sender
{
    
    [XHShowHUD showNOHud:@"账户余额不足"];

    //!< 产品要求暂停此功能
    /**
     RCDLiveGiftMessage *giftMessage = [[RCDLiveGiftMessage alloc]init];
     giftMessage.type = @"0";
     [self sendMessage:giftMessage pushContent:@""];
     NSString *text = [NSString stringWithFormat:@"%@ 送了一个钻戒",giftMessage.senderUserInfo.name];
     [self sendDanmaku:text];
     [self praiseGift];
     */
    
}

#pragma mark 发送点赞
/**
 *  发送点赞
 *
 *  @param sender 传递的id值
 */
-(void)clapButtonPressed:(id)sender
{
    /**
     因为Andr和IOS中“RCDLiveGiftMessage”对象属性不一致，导致IOS发送点赞消息，
     Android不能正确解析，Android中”RCDLiveGiftMessage“有“content”属性，而IOS中没有该属性
     RCDLiveGiftMessage *giftMessage = [[RCDLiveGiftMessage alloc]init];
     [giftMessage setType:@"1"];
     [giftMessage setContent:@"为您点赞"];
     */

    RCTextMessage *rcTextMessage = [RCTextMessage messageWithContent:@"为您点赞"];
    [rcTextMessage setExtra:@"点赞"];
    [self sendMessage:rcTextMessage pushContent:@"为您点赞"];
    NSString *text = [NSString stringWithFormat:@"%@ 为您点赞",rcTextMessage.senderUserInfo.name];
    [self sendDanmaku:text];
    [self praiseHeart];
}

/**
 *  未读消息View
 *
 *   <#return value description#>
 */
- (UIView *)unreadButtonView {
    if (!_unreadButtonView) {
        _unreadButtonView = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2, self.view.frame.size.height - MinHeight_InputView - 30, 80, 30)];
        _unreadButtonView.userInteractionEnabled = YES;
        _unreadButtonView.backgroundColor = RCDLive_HEXCOLOR(0xffffff);
        _unreadButtonView.alpha = 0.7;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabUnreadMsgCountIcon:)];
        [_unreadButtonView addGestureRecognizer:tap];
        _unreadButtonView.hidden = YES;
        [self.view addSubview:_unreadButtonView];
        _unreadButtonView.layer.cornerRadius = 4;
    }
    return _unreadButtonView;
}

/**
 *  底部新消息文字
 *
 *   return value description
 */
- (UILabel *)unReadNewMessageLabel {
    if (!_unReadNewMessageLabel) {
        _unReadNewMessageLabel = [[UILabel alloc]initWithFrame:_unreadButtonView.bounds];
        _unReadNewMessageLabel.backgroundColor = [UIColor clearColor];
        _unReadNewMessageLabel.font = [UIFont systemFontOfSize:12.0f];
        _unReadNewMessageLabel.textAlignment = NSTextAlignmentCenter;
        _unReadNewMessageLabel.textColor = RCDLive_HEXCOLOR(0xff4e00);
        [self.unreadButtonView addSubview:_unReadNewMessageLabel];
    }
    return _unReadNewMessageLabel;
    
}

/**
 *  更新底部新消息提示显示状态
 */
- (void)updateUnreadMsgCountLabel{
    if (self.unreadNewMsgCount == 0) {
        self.unreadButtonView.hidden = YES;
    }
    else{
        self.unreadButtonView.hidden = NO;
        self.unReadNewMessageLabel.text = @"底部有新消息";
    }
}

/**
 *  检查是否更新新消息提醒
 */
- (void) checkVisiableCell{
    NSIndexPath *lastPath = [self getLastIndexPathForVisibleItems];
    if (lastPath.row >= self.conversationDataRepository.count - self.unreadNewMsgCount || lastPath == nil || [self isAtTheBottomOfTableView] ) {
        self.unreadNewMsgCount = 0;
        [self updateUnreadMsgCountLabel];
    }
}

/**
 *  获取显示的最后一条消息的indexPath
 *
 *   indexPath
 */
- (NSIndexPath *)getLastIndexPathForVisibleItems
{
    NSArray *visiblePaths = [self.conversationMessageCollectionView indexPathsForVisibleItems];
    if (visiblePaths.count == 0) {
        return nil;
    }else if(visiblePaths.count == 1) {
        return (NSIndexPath *)[visiblePaths firstObject];
    }
    NSArray *sortedIndexPaths = [visiblePaths sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *path1 = (NSIndexPath *)obj1;
        NSIndexPath *path2 = (NSIndexPath *)obj2;
        return [path1 compare:path2];
    }];
    return (NSIndexPath *)[sortedIndexPaths lastObject];
}

/**
 *  点击未读提醒滚动到底部
 *
 *  @param gesture gesture description
 */
- (void)tabUnreadMsgCountIcon:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self scrollToBottomAnimated:YES];
    }
}

/**
 *  初始化视频直播
 */
- (void)initializedLiveSubViews
{
    _liveView.frame = self.view.frame;
    [self.view addSubview:_liveView];
    [self.view sendSubviewToBack:_liveView];
    
  
    
}

/**
 *  全屏和半屏模式切换
 *
 *  @param isFullScreen 全屏或者半屏
 */
- (void)changeModel:(BOOL)isFullScreen {
    
    self.conversationMessageCollectionView.backgroundColor = [UIColor clearColor];
    CGRect contentViewFrame = CGRectMake(0, self.view.bounds.size.height-237, self.view.bounds.size.width,237);
    self.contentView.frame = contentViewFrame;
    _feedBackBtn.frame = CGRectMake(10, self.view.frame.size.height - 45, 35, 35);
    _flowerBtn.frame = CGRectMake(self.view.frame.size.width-90, self.view.frame.size.height - 45, 35, 35);
    _clapBtn.frame = CGRectMake(self.view.frame.size.width-45, self.view.frame.size.height - 45, 35, 35);
    [self.view sendSubviewToBack:_liveView];
    
    float inputBarOriginY = self.conversationMessageCollectionView.bounds.size.height + 30;
    float inputBarOriginX = self.conversationMessageCollectionView.frame.origin.x;
    float inputBarSizeWidth = self.contentView.frame.size.width;
    float inputBarSizeHeight = MinHeight_InputView;
    //添加输入框
    [self.inputBar changeInputBarFrame:CGRectMake(inputBarOriginX, inputBarOriginY,inputBarSizeWidth,inputBarSizeHeight)];
    [self.conversationMessageCollectionView reloadData];
    [self.unreadButtonView setFrame:CGRectMake((self.view.frame.size.width - 80)/2, self.view.frame.size.height - MinHeight_InputView - 30, 80, 30)];
}

/**
 *  顶部插入历史消息
 *
 *  @param model 消息Model
 */
- (void)pushOldMessageModel:(RCDLiveMessageModel *)model {
    if (!(!model.content && model.messageId > 0)
        && !([[model.content class] persistentFlag] & MessagePersistent_ISPERSISTED)) {
        return;
    }
    long ne_wId = model.messageId;
    for (RCDLiveMessageModel *__item in self.conversationDataRepository) {
        if (ne_wId == __item.messageId) {
            return;
        }
    }
    [self.conversationDataRepository insertObject:model atIndex:0];
}

/**
 *  加载历史消息(暂时没有保存聊天室消息)
 */
- (void)loadMoreHistoryMessage {
    long lastMessageId = -1;
    if (self.conversationDataRepository.count > 0) {
        RCDLiveMessageModel *model = [self.conversationDataRepository objectAtIndex:0];
        lastMessageId = model.messageId;
    }
    
    NSArray *__messageArray =
    [[RCIMClient sharedRCIMClient] getHistoryMessages:_conversationType
                                             targetId:_targetId
                                      oldestMessageId:lastMessageId
                                                count:10];
    for (int i = 0; i < __messageArray.count; i++) {
        RCMessage *rcMsg = [__messageArray objectAtIndex:i];
        RCDLiveMessageModel *model = [[RCDLiveMessageModel alloc] initWithMessage:rcMsg];
        [self pushOldMessageModel:model];
    }
    [self.conversationMessageCollectionView reloadData];
    if (_conversationDataRepository != nil &&
        _conversationDataRepository.count > 0 &&
        [self.conversationMessageCollectionView numberOfItemsInSection:0] >=
        __messageArray.count - 1) {
        NSIndexPath *indexPath =
        [NSIndexPath indexPathForRow:__messageArray.count - 1 inSection:0];
        [self.conversationMessageCollectionView scrollToItemAtIndexPath:indexPath
                                                       atScrollPosition:UICollectionViewScrollPositionTop
                                                               animated:NO];
    }
}



#pragma mark - Deletage Method代理方法
#pragma mark <UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

/**
 *  滚动条滚动时显示正在加载loading
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 是否显示右下未读icon
    if (self.unreadNewMsgCount != 0) {
        [self checkVisiableCell];
    }
    
    if (scrollView.contentOffset.y < -5.0f) {
        [self.collectionViewHeader startAnimating];
    } else {
        [self.collectionViewHeader stopAnimating];
        _isLoading = NO;
    }
}

/**
 *  滚动结束加载消息 （聊天室消息还没存储，所以暂时还没有此功能）
 *
 *  @param scrollView scrollView description
 *  @param decelerate decelerate description
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y < -15.0f && !_isLoading) {
        _isLoading = YES;
    }
}

/**
 *  消息滚动到底部
 *
 *  @param animated 是否开启动画效果
 */
- (void)scrollToBottomAnimated:(BOOL)animated {
    if ([self.conversationMessageCollectionView numberOfSections] == 0) {
        return;
    }
    NSUInteger finalRow = MAX(0, [self.conversationMessageCollectionView numberOfItemsInSection:0] - 1);
    if (0 == finalRow) {
        return;
    }
    NSIndexPath *finalIndexPath =
    [NSIndexPath indexPathForItem:finalRow inSection:0];
    [self.conversationMessageCollectionView scrollToItemAtIndexPath:finalIndexPath
                                                   atScrollPosition:UICollectionViewScrollPositionTop
                                                           animated:animated];
}
#pragma mark <UICollectionViewDataSource>
/**
 *  定义展示的UICollectionViewCell的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.conversationDataRepository.count;
}

/**
 *  每个UICollectionView展示的内容
 *
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RCDLiveMessageModel *model =
    [self.conversationDataRepository objectAtIndex:indexPath.row];
    RCMessageContent *messageContent = model.content;
    RCDLiveMessageBaseCell *cell = nil;
    if ([messageContent isMemberOfClass:[RCInformationNotificationMessage class]] || [messageContent isMemberOfClass:[RCTextMessage class]] || [messageContent isMemberOfClass:[RCDLiveGiftMessage class]])
    {
        RCDLiveTipMessageCell *__cell = [collectionView dequeueReusableCellWithReuseIdentifier:RCDLiveTipMessageCellIndentifier forIndexPath:indexPath];
        __cell.isFullScreenMode = YES;
        [__cell setDataModel:model];
        [__cell setDelegate:self];
        cell = __cell;
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

/**
 *  cell的大小
 *
 */
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RCDLiveMessageModel *model =
    [self.conversationDataRepository objectAtIndex:indexPath.row];
    if (model.cellSize.height > 0) {
        return model.cellSize;
    }
    RCMessageContent *messageContent = model.content;
    if ([messageContent isMemberOfClass:[RCTextMessage class]] || [messageContent isMemberOfClass:[RCInformationNotificationMessage class]] || [messageContent isMemberOfClass:[RCDLiveGiftMessage class]]) {
        model.cellSize = [self sizeForItem:collectionView atIndexPath:indexPath];
    } else {
        return CGSizeZero;
    }
    return model.cellSize;
}

/**
 *  计算不同消息的具体尺寸
 *
 */
- (CGSize)sizeForItem:(UICollectionView *)collectionView
          atIndexPath:(NSIndexPath *)indexPath {
    CGFloat __width = CGRectGetWidth(collectionView.frame);
    RCDLiveMessageModel *model =
    [self.conversationDataRepository objectAtIndex:indexPath.row];
    RCMessageContent *messageContent = model.content;
    CGFloat __height = 0.0f;
    NSString *localizedMessage;
    if ([messageContent isMemberOfClass:[RCInformationNotificationMessage class]])
    {
        RCInformationNotificationMessage *notification = (RCInformationNotificationMessage *)messageContent;
        localizedMessage = [RCDLiveKitUtility formatMessage:notification];
    }
    else if ([messageContent isMemberOfClass:[RCTextMessage class]])
    {
        RCTextMessage *notification = (RCTextMessage *)messageContent;
        localizedMessage = [RCDLiveKitUtility formatMessage:notification];
        NSString *name;
        if (messageContent.senderUserInfo)
        {
            name = messageContent.senderUserInfo.name;
        }
        localizedMessage = [NSString stringWithFormat:@"%@ %@",name,localizedMessage];
    }else if ([messageContent isMemberOfClass:[RCDLiveGiftMessage class]])
    {
        RCDLiveGiftMessage *notification = (RCDLiveGiftMessage *)messageContent;
        localizedMessage = @"送了一个钻戒";
        if(notification && [notification.type isEqualToString:@"1"])
        {
            localizedMessage = @"为您点赞";
        }
        
        NSString *name;
        if (messageContent.senderUserInfo) {
            name = messageContent.senderUserInfo.name;
        }
        localizedMessage = [NSString stringWithFormat:@"%@  %@",name,localizedMessage];
    }
    CGSize __labelSize = [RCDLiveTipMessageCell getTipMessageCellSize:localizedMessage];
    __height = __height + __labelSize.height;
    
    return CGSizeMake(__width, __height);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

#pragma mark <UICollectionViewDelegate>

/**
 *   UICollectionView被选中时调用的方法
 *
 *
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}









#pragma mark - 发送消息的方法
/**
 *  将消息加入本地数组
 */
- (void)appendAndDisplayMessage:(RCMessage *)rcMessage
{
    if (!rcMessage) {
        return;
    }
    RCDLiveMessageModel *model = [[RCDLiveMessageModel alloc] initWithMessage:rcMessage];
    if([rcMessage.content isMemberOfClass:[RCDLiveGiftMessage class]])
    {
        model.messageId = -1;
    }
    
    if ([self appendMessageModel:model])
    {
        NSIndexPath *indexPath =
        [NSIndexPath indexPathForItem:self.conversationDataRepository.count - 1
                            inSection:0];
        if ([self.conversationMessageCollectionView numberOfItemsInSection:0] !=
            self.conversationDataRepository.count - 1) {
            return;
        }
        [self.conversationMessageCollectionView
         insertItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        if ([self isAtTheBottomOfTableView] || self.isNeedScrollToButtom)
        {
            [self scrollToBottomAnimated:YES];
            self.isNeedScrollToButtom=NO;
        }
    }
}

- (void)sendReceivedDanmaku:(RCMessageContent *)messageContent
{
    if([messageContent isMemberOfClass:[RCInformationNotificationMessage class]])
    {
        RCInformationNotificationMessage *msg = (RCInformationNotificationMessage *)messageContent;
//        [self sendDanmaku:msg.message];
         [self sendCenterDanmaku:msg.message];
        //[self sendCenterDanmaku:[NSString stringWithFormat:@"%@%@",[RCDLive sharedRCDLive].currentUserInfo.name,msg.message]];/////////
    }
    else if ([messageContent isMemberOfClass:[RCTextMessage class]])
    {
        RCTextMessage *msg = (RCTextMessage *)messageContent;
        [self sendDanmaku:msg.content];
    }
    else if([messageContent isMemberOfClass:[RCDLiveGiftMessage class]])
    {
        RCDLiveGiftMessage *msg = (RCDLiveGiftMessage *)messageContent;
        NSString *tip = [msg.type isEqualToString:@"0"]?@"送了一个钻戒":@"为您点赞";
        NSString *text = [NSString stringWithFormat:@"%@ %@",msg.senderUserInfo.name,tip];
        [self sendDanmaku:text];
    }
}

/**
 *  如果当前会话没有这个消息id，把消息加入本地数组
 *
 */
- (BOOL)appendMessageModel:(RCDLiveMessageModel *)model
{
    long newId = model.messageId;
    for (RCDLiveMessageModel *__item in self.conversationDataRepository)
    {
        /*
         * 当id为－1时，不检查是否重复，直接插入
         * 该场景用于插入临时提示。
         */
        if (newId == -1)
        {
            break;
        }
        if (newId == __item.messageId)
        {
            return NO;
        }
    }
    if (!model.content)
    {
        return NO;
    }
    //这里可以根据消息类型来决定是否显示，如果不希望显示直接return NO
    
    //数量不可能无限制的大，这里限制收到消息过多时，就对显示消息数量进行限制。
    //用户可以手动下拉更多消息，查看更多历史消息。
    if (self.conversationDataRepository.count>100)
    {
        //                NSRange range = NSMakeRange(0, 1);
        RCDLiveMessageModel *message = self.conversationDataRepository[0];
        [[RCIMClient sharedRCIMClient]deleteMessages:@[@(message.messageId)]];
        [self.conversationDataRepository removeObjectAtIndex:0];
        [self.conversationMessageCollectionView reloadData];
    }
    
    [self.conversationDataRepository addObject:model];
    return YES;
}

/**
 *  UIResponder
 *
 *
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return [super canPerformAction:action withSender:sender];
}

/**
 *  找出消息的位置
 *
 *
 */
- (NSInteger)findDataIndexFromMessageList:(RCDLiveMessageModel *)model
{
    NSInteger index = 0;
    for (int i = 0; i < self.conversationDataRepository.count; i++)
    {
        RCDLiveMessageModel *msg = (self.conversationDataRepository)[i];
        if (msg.messageId == model.messageId)
        {
            index = i;
            break;
        }
    }
    return index;
}


/**
 *  打开大图。开发者可以重写，自己下载并且展示图片。默认使用内置controller
 *
 *  @param model 图片消息内容
 */
- (void)presentImagePreviewController:(RCDLiveMessageModel *)model
{
    
}

/**
 *  打开地理位置。开发者可以重写，自己根据经纬度打开地图显示位置。默认使用内置地图
 *
 *  @param locationMessageContent 位置消息
 */
- (void)presentLocationViewController:
(RCLocationMessage *)locationMessageContent {
    
}



/*!
 发送消息(除图片消息外的所有消息)
 
 @param messageContent 消息的内容
 @param pushContent    接收方离线时需要显示的远程推送内容
 
 @discussion 当接收方离线并允许远程推送时，会收到远程推送。
 远程推送中包含两部分内容，一是pushContent，用于显示；二是pushData，用于携带不显示的数据。
 
 SDK内置的消息类型，如果您将pushContent置为nil，会使用默认的推送格式进行远程推送。
 自定义类型的消息，需要您自己设置pushContent来定义推送内容，否则将不会进行远程推送。
 
 如果您需要设置发送的pushData，可以使用RCIM的发送消息接口。
 */
- (void)sendMessage:(RCMessageContent *)messageContent
        pushContent:(NSString *)pushContent
{
    if (_targetId == nil)
    {
        return;
    }
    messageContent.senderUserInfo = [RCDLive sharedRCDLive].currentUserInfo;
    if (messageContent == nil)
    {
        return;
    }
    
    [[RCDLive sharedRCDLive] sendMessage:self.conversationType
                                targetId:self.targetId
                                 content:messageContent
                             pushContent:pushContent
                                pushData:nil
                                 success:^(long messageId)
    {
                                     __weak typeof(&*self) __weakself = self;
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         
                                         RCMessage *message = [[RCMessage alloc] initWithType:__weakself.conversationType
                                                                                     targetId:__weakself.targetId
                                                                                    direction:MessageDirection_SEND
                                                                                    messageId:messageId
                                                                                      content:messageContent];
                                         if ([message.content isMemberOfClass:[RCDLiveGiftMessage class]] ) {
                                             message.messageId = -1;//插入消息时如果id是-1不判断是否存在
                                         }
                                         [__weakself appendAndDisplayMessage:message];
                                         [__weakself.inputBar clearInputView];
                                     });
                                 } error:^(RCErrorCode nErrorCode, long messageId) {
                                     [[RCIMClient sharedRCIMClient]deleteMessages:@[ @(messageId) ]];
                                 }];
}

/**
 *  接收到消息的回调
 *
 */
- (void)didReceiveMessageNotification:(NSNotification *)notification
{
    __weak typeof (self) weakSelef = self;
    __block RCMessage *rcMessage = notification.object;
    RCDLiveMessageModel *model = [[RCDLiveMessageModel alloc] initWithMessage:rcMessage];
    NSDictionary *leftDic = notification.userInfo;
    if (leftDic && [leftDic[@"left"] isEqual:@(0)])
    {
        self.isNeedScrollToButtom = YES;
    }
    if (model.conversationType == self.conversationType &&
        [model.targetId isEqual:self.targetId])
    {
        __weak typeof(&*self) __blockSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (rcMessage)
            {
                [__blockSelf appendAndDisplayMessage:rcMessage];
                UIMenuController *menu = [UIMenuController sharedMenuController];
                menu.menuVisible=NO;
                //如果消息不在最底部，收到消息之后不滚动到底部，加到列表中只记录未读数
                if (![weakSelef isAtTheBottomOfTableView]) {
                    weakSelef.unreadNewMsgCount ++ ;
                    [weakSelef updateUnreadMsgCountLabel];
                }
            }
        });
    }
    if([NSThread isMainThread])
    {
        [self sendReceivedDanmaku:rcMessage.content];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelef sendReceivedDanmaku:rcMessage.content];
        });
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  定义展示的UICollectionViewCell的个数
 */
- (void)tap4ResetDefaultBottomBarStatus:
(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        //        CGRect collectionViewRect = self.conversationMessageCollectionView.frame;
        //        collectionViewRect.size.height = self.contentView.bounds.size.height - 0;
        //        [self.conversationMessageCollectionView setFrame:collectionViewRect];
        [self.inputBar setInputBarStatus:RCDLiveBottomBarDefaultStatus];
        self.inputBar.hidden = YES;
    }
}

/**
 *  判断消息是否在collectionView的底部
 *
 *   是否在底部
 */
- (BOOL)isAtTheBottomOfTableView {
    if (self.conversationMessageCollectionView.contentSize.height <= self.conversationMessageCollectionView.frame.size.height) {
        return YES;
    }
    if(self.conversationMessageCollectionView.contentOffset.y +200 >= (self.conversationMessageCollectionView.contentSize.height - self.conversationMessageCollectionView.frame.size.height)) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 输入框事件
/**
 *  点击键盘回车或者emoji表情面板的发送按钮执行的方法
 *
 *  @param text  输入框的内容
 */
- (void)onTouchSendButton:(NSString *)text{
    RCTextMessage *rcTextMessage = [RCTextMessage messageWithContent:text];
    [self sendMessage:rcTextMessage pushContent:nil];
    [self sendDanmaku:rcTextMessage.content];
    //    [self.inputBar setInputBarStatus:KBottomBarDefaultStatus];
    //    [self.inputBar setHidden:YES];
}

//修复ios7下不断下拉加载历史消息偶尔崩溃的bug
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark RCInputBarControlDelegate

/**
 *  根据inputBar 回调来修改页面布局，inputBar frame 变化会触发这个方法
 *
 *  @param frame    输入框即将占用的大小
 *  @param duration 时间
 */
- (void)onInputBarControlContentSizeChanged:(CGRect)frame withAnimationDuration:(CGFloat)duration andAnimationCurve:(UIViewAnimationCurve)curve{
    CGRect collectionViewRect = self.contentView.frame;
    self.contentView.backgroundColor = [UIColor clearColor];
    collectionViewRect.origin.y = self.view.bounds.size.height - frame.size.height - 237 +50;
    
    collectionViewRect.size.height = 237;
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:curve];
        [self.contentView setFrame:collectionViewRect];
        [UIView commitAnimations];
    }];
    CGRect inputbarRect = self.inputBar.frame;
    
    inputbarRect.origin.y = self.contentView.frame.size.height -50;
    [self.inputBar setFrame:inputbarRect];
    [self.view bringSubviewToFront:self.inputBar];
    [self scrollToBottomAnimated:NO];
}


/**
 *  横竖屏切换
 *
 *  @param isVertical isVertical description
 */


/**
 *  连接状态改变的回调
 *
 *  @param status <#status description#>
 */
- (void)onConnectionStatusChanged:(RCConnectionStatus)status {
    self.currentConnectionStatus = status;
}




- (void)praiseHeart
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(_clapBtn.frame.origin.x , _clapBtn.frame.origin.y - 49, 35, 35);
    imageView.image = [UIImage imageNamed:@"heart"];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
    
    
    CGFloat startX = round(random() % 200);
    CGFloat scale = round(random() % 2) + 1.0;
    CGFloat speed = 1 / round(random() % 900) + 0.6;
    int imageName = round(random() % 7);
    NSLog(@"%.2f - %.2f -- %d",startX,scale,imageName);
    
    [UIView beginAnimations:nil context:(__bridge void *_Nullable)(imageView)];
    [UIView setAnimationDuration:7 * speed];
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"heart%d.png",imageName]];
    imageView.frame = CGRectMake(kBounds.width - startX, -100, 35 * scale, 35 * scale);
    
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}


#pragma mark 发送小熊作为礼物
- (void)praiseGift
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(_flowerBtn.frame.origin.x , _flowerBtn.frame.origin.y - 49, 35, 35);
    imageView.image = [UIImage imageNamed:@"gift"];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
    
    
    CGFloat startX = round(random() % 200);
    CGFloat scale = round(random() % 2) + 1.0;
    CGFloat speed = 1 / round(random() % 900) + 0.6;
    int imageName = round(random() % 2);
    NSLog(@"%.2f - %.2f -- %d",startX,scale,imageName);
    
    [UIView beginAnimations:nil context:(__bridge void *_Nullable)(imageView)];
    [UIView setAnimationDuration:7 * speed];
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"gift%d.png",imageName]];
    imageView.frame = CGRectMake(kBounds.width - startX, -100, 35 * scale, 35 * scale);
    
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}


- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    
    UIImageView *imageView = (__bridge UIImageView *)(context);
    [imageView removeFromSuperview];
}



#pragma mark - 初始化直播视频播放
- (void)doInitPlayer
{

    [NELivePlayerController setLogLevel:NELP_LOG_VERBOSE];

    NSError *error = nil;
//    self.player = [[NELivePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"rtmp://v68ee57af.live.126.net/live/56bc05e5495b40779a31753f63598d16"] error:&error];
    self.player = [[NELivePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.contentURL] error:&error];
    [self.player.view setBackgroundColor:[UIColor whiteColor]];
    if (self.player == nil)
    {
        NSLog(@"player initilize failed, please tay again.error = [%@]!", error);
    }
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.player.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.player.view];
    self.view.autoresizesSubviews = YES;
    //设置直播属性的

    [self.player setBufferStrategy:NELPLowDelay]; // 直播低延时模式
    [self.player setScalingMode:NELPMovieScalingModeAspectFill]; // 设置画面显示模式，默认原始大小
    [self.player setShouldAutoplay:YES]; // 设置prepareToPlay完成后是否自动播放
    [self.player setHardwareDecoder:YES]; // 设置解码模式，是否开启硬件解码
    [self.player setPauseInBackground:NO]; // 设置切入后台时的状态，暂停还是继续播放
    [self.player setPlaybackTimeout:(15 * 1000)]; // 设置拉流超时时间

    [self.player prepareToPlay];
}

#pragma mark 退出直播
- (void)doDestroyPlayer
{
    [self registerNotification];
    [self.player shutdown]; // 退出播放并释放相关资源
    [self.player.view removeFromSuperview];
    self.player = nil;
}


-(void)removeNotication
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark 添加通知
- (void)doInitPlayerNotication
{
    //播放器媒体流初始化完成后触发，收到该通知表示可以开始播放
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerDidPreparedToPlay:)
                                                 name:NELivePlayerDidPreparedToPlayNotification
                                               object:_player];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlaybackStateChanged:)
                                                 name:NELivePlayerPlaybackStateChangedNotification
                                               object:_player];

    // 播放器加载状态发生变化时触发，如开始缓冲，缓冲结束
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NeLivePlayerloadStateChanged:)
                                                 name:NELivePlayerLoadStateChangedNotification
                                               object:_player];

    // 正常播放结束或播放过程中发生错误导致播放结束时触发的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerPlayBackFinished:)
                                                 name:NELivePlayerPlaybackFinishedNotification
                                               object:_player];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstVideoDisplayed:)
                                                 name:NELivePlayerFirstVideoDisplayedNotification
                                               object:_player];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerFirstAudioDisplayed:)
                                                 name:NELivePlayerFirstAudioDisplayedNotification
                                               object:_player];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerReleaseSuccess:)
                                                 name:NELivePlayerReleaseSueecssNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerVideoParseError:)
                                                 name:NELivePlayerVideoParseErrorNotification
                                               object:_player];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NELivePlayerSeekComplete:)
                                                 name:NELivePlayerMoviePlayerSeekCompletedNotification
                                               object:_player];
}



#pragma mark 播放器通知事件
#pragma mark 播放器媒体流初始化完成后触发，收到该通知表示可以开始播放
- (void)NELivePlayerDidPreparedToPlay:(NSNotification*)notification
{
    //add some methods
    NSLog(@"[播放器媒体流初始化完成后触发，收到该通知表示可以开始播放] 收到 NELivePlayerDidPreparedToPlayNotification 通知");
    [self.player play]; //开始播放
}


#pragma mark 播放器播放状态发生改变时的消息通知
- (void)NELivePlayerPlaybackStateChanged:(NSNotification*)notification
{
    NSLog(@"[播放器播放状态发生改变时的消息通知] 收到 NELivePlayerPlaybackStateChangedNotification 通知");
}


#pragma mark 播放器加载状态发生变化时触发，如开始缓冲，缓冲结束
- (void)NeLivePlayerloadStateChanged:(NSNotification*)notification
{
    NSLog(@"[播放器加载状态发生变化时触发，如开始缓冲，缓冲结束] 收到 NELivePlayerLoadStateChangedNotification 通知");

    NELPMovieLoadState nelpLoadState = _player.loadState;

    if (nelpLoadState == NELPMovieLoadStatePlaythroughOK)
    {
        NSLog(@"finish buffering");

    }
    else if (nelpLoadState == NELPMovieLoadStateStalled)
    {
        NSLog(@"begin buffering");
    }
}


#pragma mark 正常播放结束或播放过程中发生错误导致播放结束时触发的通知
- (void)NELivePlayerPlayBackFinished:(NSNotification*)notification
{
    NSLog(@"[正常播放结束或播放过程中发生错误导致播放结束时触发的通知] 收到 NELivePlayerPlaybackFinishedNotification 通知");
    UIAlertController *alertController = NULL;
    UIAlertAction *action = NULL;
    __weak typeof(self) weakSelf = self;
    switch ([[[notification userInfo] valueForKey:NELivePlayerPlaybackDidFinishReasonUserInfoKey] intValue])
    {
        case NELPMovieFinishReasonPlaybackEnded:
        {
            alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"直播结束" preferredStyle:UIAlertControllerStyleAlert];
            action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [weakSelf doDestroyPlayer];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
        }
            break;

        case NELPMovieFinishReasonPlaybackError:
        {
            alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"播放失败" preferredStyle:UIAlertControllerStyleAlert];
            action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [weakSelf doDestroyPlayer];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
            break;
        }

        case NELPMovieFinishReasonUserExited:
            break;

        default:
            break;
    }
}


#pragma mark 播放器第一帧视频显示时的消息通知
- (void)NELivePlayerFirstVideoDisplayed:(NSNotification*)notification
{
    NSLog(@"[播放器第一帧视频显示时的消息通知] 收到 NELivePlayerFirstVideoDisplayedNotification 通知");
}

#pragma mark 播放器第一帧音频播放时的消息通知
- (void)NELivePlayerFirstAudioDisplayed:(NSNotification*)notification
{
    NSLog(@"[播放器第一帧音频播放时的消息通知] 收到 NELivePlayerFirstAudioDisplayedNotification 通知");
}


#pragma mark 视频码流包解析异常时的消息通知
- (void)NELivePlayerVideoParseError:(NSNotification*)notification
{
    NSLog(@"[视频码流包解析异常时的消息通知] 收到 NELivePlayerVideoParseError 通知");
}


#pragma mark seek完成时的消息通知，仅适用于点播，直播不支持。
- (void)NELivePlayerSeekComplete:(NSNotification*)notification
{
    NSLog(@"[seek完成时的消息通知，仅适用于点播，直播不支持。] 收到 NELivePlayerMoviePlayerSeekCompletedNotification 通知");
}


#pragma mark 播放器资源释放完成时的消息通知
- (void)NELivePlayerReleaseSuccess:(NSNotification*)notification
{
    NSLog(@"[播放器资源释放完成时的消息通知] 收到 NELivePlayerReleaseSueecssNotification 通知");
}


-(BaseButtonControl *)closeButtonControl
{
    if (!_closeButtonControl)
    {
        _closeButtonControl = [[BaseButtonControl alloc]init];
        [_closeButtonControl setNumberImageView:1];
    }
    return _collectionViewHeader;
}



@end

