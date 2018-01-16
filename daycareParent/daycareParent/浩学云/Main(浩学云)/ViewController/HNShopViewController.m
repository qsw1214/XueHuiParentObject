//
//  HNShopViewController.m
//  daycareManage
//
//  Created by 钧泰科技 on 2017/5/11.
//  Copyright © 2017年 wxc. All rights reserved.
//

#import "HNShopViewController.h"
#import "Pingpp.h"

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "WKWebViewJavascriptBridge.h"
#import <WebKit/WKFoundation.h>
@interface HNShopViewController ()<AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) NSData *charge;
@property (nonatomic, copy) WVJBResponseCallback callBackResult;
@property (nonatomic,strong) UIProgressView *progressView;
@end

@implementation HNShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self removeWebCache];
    [self.view addSubview:self.progressView];
    self.progressView.progress=0.1;
    //注册定位，等待JS调取
    [self.plugs.bridge registerHandler:@"usLocation" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self startLocation:responseCallback];
    }];
    //注册ping++，购买商品调起支付
    [self.plugs.bridge registerHandler:@"getPay" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"------------------%@",data);

        _charge = data;
//        _callBackResult = nil;
        _callBackResult = responseCallback;
        [self regiseterPay:responseCallback];
    }];
    
//    //注册ping++，升级会员调起支付
//    [self.plugs.bridge registerHandler:@"memberUpgrade" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSDictionary *dataDic = data;
//        
//        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:dataDic[@"msg"] cancelButtonTitle:@"取消" otherButtonTitles:@[@"去升级"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//            if (buttonIndex == 0) {
//                
//            }else{
//                HNUpVIPLevelViewController *up = [[HNUpVIPLevelViewController alloc] init];
//                up.pushType = isModel;
//                UINavigationController *nav = [[XCNavSettings sharedXCNavSettings] createDefNav:up];
//                [self presentViewController:nav animated:YES completion:nil];
//            }
//        }];
//        
//    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBackResult:) name:@"callBack" object:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    self.progressView.progress=0.7;
    [UIView commitAnimations];
}
//清除浏览器缓存
- (void)removeWebCache
{
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        NSLog(@"@22222"); 
    }];
}

- (void)startLocation:(WVJBResponseCallback)responseCallback
{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    //    [AMapServices sharedServices].apiKey = @"2c7804fec1be502acdb64d97a7afa387";
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    // 带逆地理（返回坐标和地址信息）
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"警告" message:@"获取位置信息失败,请检查你的定位服务是否打开!" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        if (regeocode)
        {
            NSString *address = [NSString stringWithFormat:@"%@%@%@%@",regeocode.province,regeocode.city,regeocode.district,regeocode.POIName];
            NSDictionary *dict =@{@"lng":@(location.coordinate.longitude),@"lat":@(location.coordinate.latitude),@"address":address};
            NSLog(@"+++++++++++%@",dict);
            responseCallback(dict);
        }
    }];
    
}

- (void)letfItemAction:(BaseNavigationControlItem *)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//调起ping++支付
- (void)regiseterPay:(WVJBResponseCallback)responseCallback
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_charge options:NSJSONWritingPrettyPrinted error:nil];
    NSString* data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData *getJsonData=[data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:nil];
    if ([[dic objectItemKey:@"id"] isEqualToString:@""]) {
        [XHShowHUD showNOHud:@"获取订单信息失败!"];
        return;
    }
    [Pingpp createPayment:data
           viewController:self
             appURLScheme:@"wxedbbf780e30b9bb5"
           withCompletion:^(NSString *result, PingppError *error)
    {
        if (error == nil) {
            NSLog(@"PingppError is nil");
        } else {
            NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
        }
        responseCallback(result);
    }];
}
- (void)callBackResult:(NSNotification *)result
{
    NSString *objects = [result object];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:objects,@"result", nil];
    if (_callBackResult == nil) {
        // [XHShowHUD showNOHud:@"应用信息异常"];
        return;
    }
    _callBackResult(dic);
    if ([objects isEqualToString:@"success"]) {
        [XHShowHUD showNOHud:@"支付成功"];
        [self.webView goBack];
        return;
    }
    if ([objects isEqualToString:@"cancel"]) {
        [XHShowHUD showNOHud:@"支付取消"];
        return;
    }
    else  {
        [XHShowHUD showNOHud:@"支付失败"];
        return;
    }
}
-(UIProgressView *)progressView
{
    if (_progressView==nil) {
        _progressView=[[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 100)];
        _progressView.progressViewStyle=UIProgressViewStyleBar;
        _progressView.tintColor=RGB(242, 172, 60);
    }
    return _progressView;
}
-(void)webViewDidFinishLoad:(XCWebView *)webView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    self.progressView.progress=1.0;
    [UIView commitAnimations];
    [self performSelector:@selector(aaaa) withObject:nil afterDelay:0.5];
    
}
-(void)aaaa
{
    [self.progressView removeFromSuperview];
}
-(void)dealloc{
    NSLog(@"观察者销毁了");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"callBack" object:nil];
}
@end
