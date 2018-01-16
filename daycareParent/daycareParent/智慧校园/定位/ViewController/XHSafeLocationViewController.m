//
//  XHSafeLocationViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSafeLocationViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "XHLocationModel.h"
#import <AVFoundation/AVFoundation.h>
#import "XHBindCardViewController.h"
@interface XHSafeLocationViewController ()<AMapLocationManagerDelegate,MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotation;
@end

@implementation XHSafeLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"绑定新卡"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getDeviceLocation];
    if (self.isRefresh) {
      self.isRefresh(YES);
    }
    
}




-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.mapView];
    }
}

-(void)getDeviceLocation
{
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].loginName forKey:@"tel"];
    [self.netWorkConfig setOption:XHNetWorkOptionLocation];
    [self.netWorkConfig postWithUrl:@"/device-service-web/deviceLocation" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSArray *arr=[object objectItemKey:@"object"];
            if (arr.count==0) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"还没绑定相关卡片" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
                return ;
            }
            for (NSDictionary *dic in arr) {
                XHLocationModel *model=[[XHLocationModel alloc] initWithDic:dic];
                [self creatPointAnnotationWith:model];
            }
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - Getter / Setter
-(MAMapView *)mapView
{
    if (!_mapView)
    {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
        [_mapView setDelegate:self];
        [_mapView setShowsCompass:NO];
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        //自定义图层  标注  精度圈
        [_mapView setZoomLevel:16.1 animated:YES];
    }
    return _mapView;
}



-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        XHBindCardViewController *vc = [[XHBindCardViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    
                } else {
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            XHBindCardViewController *vc = [[XHBindCardViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - 学汇家长] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}
#pragma mark------获取孩子的实时位置-----
- (void)creatPointAnnotationWith:(XHLocationModel *)coor2D
{
        _pointAnnotation = [[MAPointAnnotation alloc] init];
        [_mapView addAnnotation:_pointAnnotation];
      _pointAnnotation.coordinate = CLLocationCoordinate2DMake(coor2D.Latitude, coor2D.Longitude);
      _pointAnnotation.title = [NSString stringWithFormat:@"%@",coor2D.DeviceName];
     _mapView.centerCoordinate = CLLocationCoordinate2DMake(coor2D.Latitude, coor2D.Longitude);
}

@end
