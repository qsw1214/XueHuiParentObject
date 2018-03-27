//
//  XHShareView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHShareView.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import<ShareSDKExtension/ShareSDK+Extension.h>

#define kTitle      @[@"微信好友",@"朋友圈"]
#define kTitlePic  @[@"ico_wechat",@"ico_quan"]
@interface XHShareView()

@property(nonatomic,assign)id <XHShareViewDelagete> delegate;
@property(nonatomic,strong)BaseButtonControl *shareButton;
@property(nonatomic,strong)BaseButtonControl *wechatButton;
@property(nonatomic,strong)BaseButtonControl *wechatTimeLineButton;
@property(nonatomic,strong)BaseButtonControl *cancleShareButton;

@end

@implementation XHShareView
-(instancetype)initWithDelegate:(id)delegate
{
    if (self=[super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self setDelegate:delegate];
        self.backgroundColor=RGBAlpha(0, 0, 0, 0.6);
        self.baseView.frame=CGRectMake(0, SCREEN_HEIGHT-260, SCREEN_WIDTH, 260);
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.shareButton];
        [self.baseView addSubview:self.cancleShareButton];
        [self.cancleShareButton addTarget:self action:@selector(controlClickMethod:) forControlEvents:UIControlEventTouchUpInside];
        for (int i=0; i<2; i++) {
            BaseButtonControl *button=[[BaseButtonControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-120)/3.0*(i+1)+60*i, 50+(160-100)/2.0, 60, 100)];
            [button setNumberImageView:1];
            [button setNumberLabel:1];
            [button setImageEdgeFrame:CGRectMake(0, 0, 60, 60) withNumberType:0 withAllType:NO];
            [button setImage:kTitlePic[i] withNumberType:0 withAllType:NO];
            
            [button setTitleEdgeFrame:CGRectMake(-5, 70, 70, 30) withNumberType:0 withAllType:NO];
            [button setText:kTitle[i] withNumberType:0 withAllType:NO];
            [button setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
            [button setFont:kFont(16) withNumberType:0 withAllType:NO];
            [button setTag:i+10];
            [button addTarget:self action:@selector(controlClickMethod:) forControlEvents:UIControlEventTouchUpInside];
            [self.baseView addSubview:button];
        }
    }
    return self;
}
-(void)controlClickMethod:(UIControl *)control
{
    switch (control.tag) {
#pragma mark-----分享微信好友
        case 10:
        {
            [self share:SSDKPlatformSubTypeWechatSession];
        }
            break;
#pragma mark-----分享微信朋友圈
        case 11:
        {
            [self share:SSDKPlatformSubTypeWechatTimeline];
        }
            break;
#pragma mark-----取消分享
            case 12:
        {
            
        }
            break;
    }
    [self dissmiss];
}
-(void)show
{
    [kWindow addSubview:self];
    [UIView animateWithDuration:0.20 animations:^{
    self.baseView.frame=CGRectMake(0, SCREEN_HEIGHT-260, SCREEN_WIDTH, 260);
    } completion:^(BOOL finished) {}];
}
-(void)dissmiss
{
    [UIView animateWithDuration:0.20 animations:^{
        self.baseView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 260);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(BaseButtonControl *)shareButton
{
    if (_shareButton==nil) {
        _shareButton=[[BaseButtonControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        [_shareButton setNumberLabel:2];
        [_shareButton setTitleEdgeFrame:CGRectMake(0, 0, SCREEN_WIDTH, _shareButton.height-1) withNumberType:0 withAllType:NO];
        [_shareButton setText:@"分享到" withNumberType:0 withAllType:NO];
        [_shareButton setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_shareButton setTitleEdgeFrame:CGRectMake(0, _shareButton.height-1, SCREEN_WIDTH, 1) withNumberType:1 withAllType:NO];
        [_shareButton setTextBackGroundColor:LineViewColor withTpe:1 withAllType:NO];
    }
    return _shareButton;
}
-(BaseButtonControl *)cancleShareButton
{
    if (_cancleShareButton==nil) {
        _cancleShareButton=[[BaseButtonControl alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 50)];
        [_cancleShareButton setTag:12];
        [_cancleShareButton setNumberLabel:2];
        [_cancleShareButton setTitleEdgeFrame:CGRectMake(0, 1, SCREEN_WIDTH, _cancleShareButton.height-1) withNumberType:0 withAllType:NO];
        [_cancleShareButton setText:@"取消分享" withNumberType:0 withAllType:NO];
        [_cancleShareButton setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_cancleShareButton setTitleEdgeFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1) withNumberType:1 withAllType:NO];
        [_cancleShareButton setTextBackGroundColor:LineViewColor withTpe:1 withAllType:NO];
    }
    return _cancleShareButton;
}
- (void)share:(SSDKPlatformType)platformType
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"login_logo"]];
    [shareParams SSDKSetupShareParamsByText:@"Hi，欢迎使用学汇智慧校园，真正做到为学校提供交流沟通平台，为学校提供数字化校园，学汇您身边的教育专家。"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"https://itunes.apple.com/us/app/%E5%AD%A6%E6%B1%87-%E5%AE%B6%E9%95%BF/id1212759689"]
                                      title:@"学汇分享"
                                       type:SSDKContentTypeAuto];
    //优先使用平台客户端分享
    [shareParams SSDKEnableUseClientShare];
    //设置微博使用高级接口
    //2017年6月30日后需申请高级权限
    [shareParams SSDKEnableAdvancedInterfaceShare];
    //设置显示平台 只能分享视频的YouTube MeiPai 不显示
    [ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateBegin:
            {
                //设置UI等操作
                break;
            }
            case SSDKResponseStateSuccess:
            {

                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            case SSDKResponseStateCancel:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            default:
                break;
        }
    }];
    
}
@end

