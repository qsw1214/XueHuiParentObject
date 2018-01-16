//
//  XHChatViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHChatViewController.h"
#import "AppDelegate.h"
#import "XHRCConversationViewController.h"
@interface XHChatViewController ()
{
    NSMutableArray *modelArr;
}
@property(nonatomic,strong)UIView *navigationView;
@end

@implementation XHChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION)]];
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    
    
    //   self.title = @"消息";
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    image.image = [UIImage imageNamed:@"wuxiaoxi"];
    [image setContentMode:UIViewContentModeScaleAspectFill];
    self.emptyConversationView = image;//数据为空时显示的图片
    self.conversationListTableView.tableFooterView = [UIView new];//不显示多余的cell
    self.conversationListTableView.backgroundColor=[UIColor lightTextColor];
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];//显示为圆形
    [self setConversationPortraitSize:CGSizeMake(60, 60)];
    [self.view addSubview:self.navigationView];
    self.conversationListTableView.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app reloadIMBadge];
}

/**
 *重写RCConversationListViewController的onSelectedTableRow事件
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app sendRCIMInfo];
    XHRCConversationViewController *conversationVC = [[XHRCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.titleLabel.text = model.conversationTitle;
     conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}
- (void)notifyUpdateUnreadMessageCount
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app reloadIMBadge];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource
{
    modelArr = [NSMutableArray arrayWithArray:dataSource];
    return modelArr;
}
- (void)didLongPressCellPortrait:(RCConversationModel *)model
{
    if (model.isTop) {
        //[self showAlertSheet:@"取消置顶" targetID:model.targetId type:1];
          [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_PRIVATE targetId:model.targetId isTop:NO];
    }else{
       // [self showAlertSheet:@"置顶" targetID:model.targetId type:0];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[RCIMClient sharedRCIMClient] setConversationToTop:ConversationType_PRIVATE targetId:model.targetId isTop:YES];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
