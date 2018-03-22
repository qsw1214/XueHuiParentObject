//
//  AppDelegate.m
//  daycareParent
//
//  Created by Git on 2017/11/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "AppDelegate.h"
#import "MainRootControllerHelper.h"
#import "XHGuideViewController.h" //!< 引导视图控制器
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
#import "XHMessageUserInfo.h"
#import "XHChatViewController.h"
#import "JPUSHService.h"
#import "MianTabBarViewController.h"
#import "XHLoginViewController.h"
#import "Pingpp.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "XHLoginViewController.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
@interface AppDelegate ()<RCIMConnectionStatusDelegate,RCIMUserInfoDataSource,JPUSHRegisterDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>  //添加代理
{
    AMapLocationManager *_locationManager;
}
@property (nonatomic, strong) CLLocationManager  *cllocationManager;

@end

@implementation AppDelegate
// iOS 8 及以下请用这个   ping++支付回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
  
    [Pingpp handleOpenURL:url withCompletion:^(NSString *result, PingppError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"callBack" object:result];
    }];
    return YES;
}



// iOS 9 以上请用这个
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    
    [Pingpp handleOpenURL:url withCompletion:^(NSString *result, PingppError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"callBack" object:result];//web端调用支付时，收到的支付回调
    }];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Optional
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"caebbdeda1d6d4a5dad8f48c"
                          channel:@"App Store"
                 apsForProduction:YES//0 (默认值)表示采用的是开发证书，1 表示采用生产证书发布应用。
            advertisingIdentifier:nil];
    [UIApplication sharedApplication].applicationIconBadgeNumber =0;
    /**
     * 推送处理1
     */
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, iOS 8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }

    
    //融云监听消息
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCKitDispatchMessageNotification
     object:nil];
    
   
    [AMapServices sharedServices].apiKey = @"439149f18d037f44496205a3ec99f24d";
    
    if (_locationManager == nil)
    {
        _locationManager = [[AMapLocationManager alloc] init];
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        //        [_locationManager setAllowsBackgroundLocationUpdates:NO];
    }
    
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [MainRootControllerHelper isFirstStartWithWindow:self.window];
    
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}
- (void) getUserLocation {
    int status=[CLLocationManager authorizationStatus];
    if (![CLLocationManager locationServicesEnabled] || status < 3) {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8)
        {
            _cllocationManager = [[CLLocationManager alloc] init];
            [_cllocationManager requestAlwaysAuthorization];
            [_cllocationManager requestWhenInUseAuthorization];
        }
    }
}

/**
 *  将得到的devicetoken 传给融云用于离线状态接收push ，您的app后台要上传推送证书
 *
 *  @param application <#application description#>
 *  @param deviceToken <#deviceToken description#>
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];

}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

/**
 *登录融云
 *
 */
-(void)loginRongCloud:(NSString *)token
{
    //初始化融云SDK
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY_];
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        NSLog(@"userId================%@",userId);//selfID,guaidId
        //NSLog(@"===id%@==guainID%@===selfID%@",[XHUserInfo sharedUserInfo].ID,[XHUserInfo sharedUserInfo].guardianModel.guardianId,[XHUserInfo sharedUserInfo].selfId);
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        BOOL creat = [XHMessageUserInfo createTable];
        if (creat) {
            NSLog(@"表已存在");
        }else{
            NSLog(@"建表");
        }
        [self sendRCIMInfo];
        [self reloadIMBadge];
        NSLog(@"Login successfully with userId: %@.", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];
    
}
- (void)setJpushAlias:(NSString *)loginName
{
    [JPUSHService setTags:nil alias:loginName fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
        NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
    }];
}

#pragma mark==========刷新当前用户信息
- (void)sendRCIMInfo
{
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    XHUserInfo *user = [XHUserInfo sharedUserInfo];
    RCUserInfo *userInfo = [[RCUserInfo alloc] init];
    userInfo.userId = user.guardianModel.guardianId;
    userInfo.portraitUri = ALGetFileHeadThumbnail(user.guardianModel.headPic);
    userInfo.name = user.guardianModel.guardianName;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    [RCIM sharedRCIM].currentUserInfo = userInfo;
    [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:user.guardianModel.guardianId];
}
/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您"
                              @"的帐号在别的设备上登录，您被迫下线！"
                              delegate:self
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        //alert.delegate=self;
        [alert show];
        [[RCIM sharedRCIM] disconnect:NO];
        //跳转到登录页面
    }
    else if (status == ConnectionStatus_TOKEN_INCORRECT) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"Token已过期，请重新登录"
                                  delegate:self
                                  cancelButtonTitle:@"重新登录"
                                  otherButtonTitles:nil, nil];
           // alert.delegate=self;
            [alert show];
            [[RCIM sharedRCIM] disconnect:NO];
            //跳转到登录页面
        });
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"推送" message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
    [JPUSHService handleRemoteNotification:userInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noticeName" object:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noticeName" object:nil];
    // IOS 7 Support Required
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"推送" message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
    
    NSLog(@"--------收到通知  %@",userInfo);
    
    
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noticeName" object:nil];
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noticeName" object:nil];
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)didReceiveMessageNotification:(NSNotification *)notification{

    RCMessage *messgae = (RCMessage *)notification.object;
    RCUserInfo *user = messgae.content.senderUserInfo;
    XHMessageUserInfo *info = [[XHMessageUserInfo alloc] init];
    info.name = user.name;
    info.headPic = user.portraitUri;
    info.userId = user.userId;
    [info saveOrUpdateByColumnName:@"userId" AndColumnValue:user.userId];
    dispatch_async(dispatch_get_main_queue(),^{
        [self reloadIMBadge];
    });
}
- (void)reloadIMBadge
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noticeIM" object:nil];
}
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    XHMessageUserInfo *info = [XHMessageUserInfo findFirstByCriteria:[NSString stringWithFormat:@"WHERE userId = %@",userId]];
    if (info == nil)
    {
        completion(nil);
        return;
    }
    RCUserInfo *userInfo = [[RCUserInfo alloc] init];
    userInfo.name = info.name;
    userInfo.portraitUri = info.headPic;
    userInfo.userId = userId;
    completion(userInfo);
}
#pragma mark--弹出视图代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        XHLoginViewController *login=[[XHLoginViewController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
        [self.window setRootViewController:nav];
        [self.window makeKeyAndVisible];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.window endEditing:YES];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   [self reloadIMBadge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
