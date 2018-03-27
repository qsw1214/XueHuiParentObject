//
//  XHUpdateHelper.m
//  daycareParent
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHUpdateHelper.h"


@interface XHUpdateHelper ()


@property (nonatomic,copy) NSString *appStoreUrl; //!< AppStore的Url地址


@end


@implementation XHUpdateHelper


/**
 版本升级
 */
-(void)updateVersionWithViewController:(UIViewController*)viewController
{
    
    XHNetWorkConfig *Net=[[XHNetWorkConfig alloc] init];
    [Net setObject:CFBundleShortVersionString forKey:@"localVersion"];////本地版本
    [Net setObject:@"ios" forKey:@"devType"];                                           //设备信息
    [Net setObject:@"1" forKey:@"appId"];//app的在iTunes的唯一标识符
    [Net postWithUrl:@"zzjt-app-api_appVersion001" sucess:^(id object, BOOL verifyObject)
     {
         if (verifyObject)
         {
             NSDictionary *dic = [object objectItemKey:@"object"];
             [self setAppStoreUrl:[dic objectItemKey:@"url"]];
             NSString *topVersion = [dic objectItemKey:@"topVersion"];
             NSString *description = [dic objectItemKey:@"description"];
             NSInteger isUpdate = [[dic objectItemKey:@"isUpdate"] integerValue];
             switch (isUpdate)
             {
#pragma mark  case 0 不需要升级
                 case 0:
                 {
                     
                 }
                     break;
#pragma mark  case 1 可以升级
                 case 1:
                 {
                     NSString *introduceStr = [NSString stringWithFormat:@"%@版本 \n更新的内容有：%@",topVersion,description];
                     
                     XHCommonAlertControl *alert = [[XHCommonAlertControl alloc]initWithTitle:@"发现新版本" message:introduceStr delegate:self cancelButtonTitle:@"跳过此版本" otherButtonTitle:@"前往 App Store" withType:XHCommonAlertAppStore];
                     [alert show];
                     
                 }
                     break;
#pragma mark  case 2 需要强制更新
                 case 2:
                 {
                    
                     
                     //!< 当前App版本号小于服务器版本就提示强制更新
                     if ([CFBundleShortVersionString compare:topVersion] == NSOrderedAscending)
                     {
                         XHCommonAlertControl *alert = [[XHCommonAlertControl alloc]initWithTitle:@"版本更新" message:description delegate:self cancelButtonTitle:nil otherButtonTitle:@"前往App Store" withType:XHCommonAlertAppStore];
                         [alert show];
                     }
                 }
                     break;
             }
         }
     } error:^(NSError *error){}];
}


#pragma mark - XHCommonAlertControlDelegate
-(void)alertBoardAction:(BaseButtonControl *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appStoreUrl]];
}



@end
