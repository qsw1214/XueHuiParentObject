//
//  XHAddBindPasswordViewController.m
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//



#pragma mark 设置绑定密码或者输入绑定密码



#import "XHAddBindPasswordViewController.h"
#import "MainRootControllerHelper.h"
#import "XHPersonalCenterViewController.h"



@interface XHAddBindPasswordViewController ()




@property (nonatomic,strong) BaseButtonControl *passwordControl;
@property (nonatomic,strong) BaseButtonControl *submitControl;


@end

@implementation XHAddBindPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"设置绑定密码"];
    

    switch (self.type)
    {
        case XHAddBindEnterPasswordType:
        {
            [self setNavtionTitle:@"请输入密码"];
            [self.passwordControl setinputTextPlaceholder:@"请输入密码（6-20位英文、数字组合）" withNumberType:0 withAllType:NO];
        }
            break;
        case XHAddBindSettingPasswordType:
        {
            [self setNavtionTitle:@"设置绑定密码"];
            [self.passwordControl setinputTextPlaceholder:@"设置绑定密码（6-20位英文、数字组合）" withNumberType:0 withAllType:NO];
        }
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Public Method
-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.passwordControl];
        [self.view addSubview:self.submitControl];
        
        //!< 重置密码
        [self.passwordControl resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 50.0)];
        [self.passwordControl setInputEdgeFrame:CGRectMake(15.0, 0, self.passwordControl.width-30.0, self.passwordControl.height) withNumberType:0 withAllType:NO];
        [self.passwordControl resetLineViewFrame:CGRectMake(0, self.passwordControl.height-0.5, self.passwordControl.width, 0.5) withNumberType:0 withAllType:NO];
        //!< 重置提交按钮
        [self.submitControl resetFrame:CGRectMake(40.0, self.passwordControl.bottom+30.0, self.passwordControl.width-80.0, 44.0)];
        [self.submitControl setTitleEdgeFrame:CGRectMake(0, 0, self.submitControl.width, self.submitControl.height) withNumberType:0 withAllType:NO];

    }
}



#pragma mark - Private Method
-(void)submitControlAction:(BaseButtonControl*)sender
{
    
    
    NSString *interface = @"";
    
    switch (self.type)
    {
        case XHAddBindEnterPasswordType:
        {
            interface = @"zzjt-app-api_studentBinding003";
        }
            break;
        case XHAddBindSettingPasswordType:
        {
            interface = @"zzjt-app-api_studentBinding002";
        }
            break;
    }
    
    NSString *password = [self.passwordControl textFieldTitlewithNumberType:0];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"userId"];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"guardianId"];
    [self.netWorkConfig setObject:password forKey:@"bindingPassword"];
    
    
    NSLog(@"%@",self.netWorkConfig.paramDictionary);
    
    [XHShowHUD showTextHud];
    [self.netWorkConfig postWithUrl:interface sucess:^(id object, BOOL verifyObject)
    {
        if (verifyObject)
        {
            
            //!< 绑定成功
            
            
            [XHShowHUD showOKHud:@"绑定成功!"];
            
            switch (self.enterType)
            {
                case XHRegisterAddEnterType:
                {
                    [[MainRootControllerHelper sharedRootHelperHelper] autoLoginWithWindow:kWindow];
                }
                    break;
                    
                case XHBindAddEnterType:
                {
                    if (self.isRefresh) {
                        self.isRefresh(YES);
                    }
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                    break;
            }
            
            
            
        }
        
    } error:^(NSError *error){
        
        
        
    }];
    
    
    
    
    
}


#pragma mark - Getter /  Setter
-(BaseButtonControl *)passwordControl
{
    if (!_passwordControl)
    {
        _passwordControl = [[BaseButtonControl alloc]init];
        [_passwordControl setNumberTextField:1];
        [_passwordControl setInputSecureTextEntry:YES withNumberType:0 withAllType:NO];
        [_passwordControl setNumberLineView:1];
    }
    return _passwordControl;
}

-(BaseButtonControl *)submitControl
{
    if (!_submitControl)
    {
        _submitControl = [[BaseButtonControl alloc]init];
        [_submitControl setNumberLabel:1];
        [_submitControl setText:@"完成" withNumberType:0 withAllType:NO];
        [_submitControl setBackgroundColor:MainColor];
        [_submitControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_submitControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_submitControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_submitControl setLayerCornerRadius:5.0];
        [_submitControl addTarget:self action:@selector(submitControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitControl;
}




@end
