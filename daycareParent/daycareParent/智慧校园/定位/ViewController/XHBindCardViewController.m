//
//  XHBindCardViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/22.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHBindCardViewController.h"
#import "SGQRCode.h"
#import "XHSafeLocationViewController.h"
#import "XHSmartCampusViewController.h"
@interface XHBindCardViewController ()<SGQRCodeScanManagerDelegate, SGQRCodeAlbumManagerDelegate>
@property (nonatomic, strong) SGQRCodeScanManager *manager;
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation XHBindCardViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
    [_manager resetSampleBufferDelegate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
    [self removeFlashlightBtn];
    [_manager cancelSampleBufferDelegate];
}

- (void)dealloc {
    NSLog(@"SGQRCodeScanningVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scanningView];
    //[self setupNavigationBar];
    [self setupQRCodeScanning];
    [self.view addSubview:self.promptLabel];
    /// 为了 UI 效果
    [self.view addSubview:self.bottomView];
    [self setTitle:@"扫一扫"];
    [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"相册"];
    
}


- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[SGQRCodeScanningView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 0.9 * self.view.frame.size.height-64)];
       
    }
    return _scanningView;
}
- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

- (void)rightItemAction:(BaseNavigationControlItem *)sender
{
    SGQRCodeAlbumManager *manager = [SGQRCodeAlbumManager sharedManager];
    [manager readQRCodeFromAlbumWithCurrentController:self];
    manager.delegate = self;
    
    if (manager.isPHAuthorization == YES) {
        [self.scanningView removeTimer];
    }
}

- (void)setupQRCodeScanning {
    self.manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [_manager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    //    [manager cancelSampleBufferDelegate];
    _manager.delegate = self;
}

#pragma mark - - - SGQRCodeAlbumManagerDelegate
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(SGQRCodeAlbumManager *)albumManager {
    [self.view addSubview:self.scanningView];
}
- (void)QRCodeAlbumManager:(SGQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    [self bindCardMethod:result];
}

#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager palySoundName:@"SGQRCode.bundle/sound.caf"];
        [scanManager stopRunning];
        [scanManager videoPreviewLayerRemoveFromSuperlayer];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
         [self bindCardMethod:obj.stringValue];
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue {
    if (brightnessValue < - 1) {
        [self.view addSubview:self.flashlightBtn];
    } else {
        if (self.isSelectedFlashlightBtn == NO) {
            [self removeFlashlightBtn];
        }
    }
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        CGFloat promptLabelX = 0;
        CGFloat promptLabelY = 0.75 * self.view.frame.size.height;//0.73
        CGFloat promptLabelW = self.view.frame.size.width;
        CGFloat promptLabelH = 25;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _promptLabel.text = @"将二维码/条码放入框内, 即可自动扫描";
    }
    return _promptLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scanningView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.scanningView.frame))];
        _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _bottomView;
}

#pragma mark - - - 闪光灯按钮
- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        // 添加闪光灯按钮
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat flashlightBtnW = 20;
        CGFloat flashlightBtnH = 40;
        CGFloat flashlightBtnX = 0.5 * (self.view.frame.size.width - flashlightBtnW);
        CGFloat flashlightBtnY = 0.55 * self.view.frame.size.height;
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"ico-light"] forState:(UIControlStateNormal)];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"ico_close"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtn_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}

- (void)flashlightBtn_action:(UIButton *)button {
    if (button.selected == NO) {
        [SGQRCodeHelperTool SG_openFlashlight];
        self.isSelectedFlashlightBtn = YES;
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}

- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SGQRCodeHelperTool SG_CloseFlashlight];
        self.isSelectedFlashlightBtn = NO;
        self.flashlightBtn.selected = NO;
        [self.flashlightBtn removeFromSuperview];
    });
}
#pragma mark --------绑定卡片请求方法
-(void)bindCardMethod:(NSString *)code
{
    self.netWorkConfig.option=XHNetWorkOptionLocation;
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].loginName forKey:@"telNo"];
    [self.netWorkConfig setObject:code forKey:@"imei"];
    [self.netWorkConfig postWithUrl:@"/device-service-web/bindDevice" sucess:^(id object, BOOL verifyObject)
    {
        if (verifyObject) {
            
            NSArray *arry=self.navigationController.viewControllers;
            if ([arry[arry.count-2] isKindOfClass:[XHSmartCampusViewController class]])
            {
                XHSafeLocationViewController *safe=[XHSafeLocationViewController new];
                [self.navigationController pushViewController:safe animated:YES];
                safe.isRefresh = ^(BOOL ok) {
                    if (ok) {
                    [self setupQRCodeScanning];
                    }
                };
                return ;
            }
            if ([arry[arry.count-2] isKindOfClass:[XHSafeLocationViewController class]])
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            [self setupQRCodeScanning];
        }
    } error:^(NSError *error) {
         [self setupQRCodeScanning];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
