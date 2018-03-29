//
//  XHBindPasswordViewController.m
//  daycareParent
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHBindPasswordViewController.h"

@interface XHBindPasswordViewController ()

@property (nonatomic,strong) BaseButtonControl *originallyPasswordControl;
@property (nonatomic,strong) BaseButtonControl *newPasswordControl;  //!< 新密码
@property (nonatomic,strong) BaseButtonControl *verifyPasswordControl;  //!< 验证密码
@property (nonatomic,strong) BaseButtonControl *verifyCodeControl; //!< 重新获取验证码按钮
@property (nonatomic,strong) BaseButtonControl *submitControl;  //!< 确认提交
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger timerInteger;



@end

@implementation XHBindPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"重置密码"];
    [self setTimerInteger:59];
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
        [self.view addSubview:self.originallyPasswordControl];
        [self.view addSubview:self.newPasswordControl];
        [self.view addSubview:self.verifyPasswordControl];
        [self.view addSubview:self.verifyCodeControl];
        [self.view addSubview:self.submitControl];
        
        //!< 重置新Frame
        //!< 原密码
        [self.originallyPasswordControl resetFrame:CGRectMake(0, (self.navigationView.bottom+20.0), SCREEN_WIDTH,50.0)];
        [self.originallyPasswordControl setTitleEdgeFrame:CGRectMake(10.0, 0, self.originallyPasswordControl.width-20.0, self.originallyPasswordControl.height) withNumberType:0 withAllType:NO];
        [self.originallyPasswordControl resetLineViewFrame:CGRectMake(0, (self.originallyPasswordControl.height-0.5), (self.originallyPasswordControl.width), 0.5) withNumberType:0 withAllType:NO];
        //!< 新密码
        [self.newPasswordControl resetFrame:CGRectMake(0, (self.originallyPasswordControl.bottom+20.0), SCREEN_WIDTH,50.0)];
        [self.newPasswordControl setInputEdgeFrame:CGRectMake(10.0, 0, self.newPasswordControl.width-20.0, self.newPasswordControl.height) withNumberType:0 withAllType:NO];
        [self.newPasswordControl resetLineViewFrame:CGRectMake(0, (self.newPasswordControl.height-0.5), (self.newPasswordControl.width), 0.5) withNumberType:0 withAllType:NO];
        //!< 重置验证新密码的Frame
        [self.verifyPasswordControl resetFrame:CGRectMake(0, self.newPasswordControl.bottom, self.newPasswordControl.width, self.newPasswordControl.height)];
        [self.verifyPasswordControl setInputEdgeFrame:CGRectMake(10.0, 0, (self.verifyPasswordControl.width/2.0+20.0), self.verifyPasswordControl.height) withNumberType:0 withAllType:NO];
        [self.verifyPasswordControl setTitleEdgeFrame:CGRectMake((self.verifyPasswordControl.width/2.0+50.0), 10.0,(self.verifyPasswordControl.width/2.0-70.0), self.verifyPasswordControl.height-20.0) withNumberType:0 withAllType:NO];
        [self.verifyPasswordControl resetLineViewFrame:CGRectMake(0, (self.newPasswordControl.height-0.5), (self.newPasswordControl.width), 0.5) withNumberType:0 withAllType:NO];
        //!< 重新获取验证码
        [self.verifyCodeControl resetFrame:CGRectMake((self.verifyPasswordControl.width/2.0+50.0), self.verifyPasswordControl.top, self.verifyPasswordControl.width/2.0-70.0, self.verifyPasswordControl.height)];
        [self.verifyCodeControl setTitleEdgeFrame:CGRectMake(0, 10.0,(self.verifyCodeControl.width), self.verifyCodeControl.height-20.0) withNumberType:0 withAllType:NO];
        [self.verifyCodeControl setLabelLayerCornerRadius:5.0 withNumberType:0 withAllType:NO];
        //!< 重置确定Frame
        [self.submitControl resetFrame:CGRectMake(40.0, self.verifyPasswordControl.bottom+40.0, SCREEN_WIDTH-80.0, 45.0)];
        [self.submitControl setTitleEdgeFrame:CGRectMake(0, 0, self.submitControl.width, self.submitControl.height) withNumberType:0 withAllType:NO];
        [self.submitControl setLayerCornerRadius:5.0];
        
        
        //!< 重新赋值
        
        NSString *phone = [XHUserInfo sharedUserInfo].telphoneNumber;
         [self.netWorkConfig setObject:phone forKey:@"telphoneNumber"];
        if ([XHUserInfo sharedUserInfo].telphoneNumber.length>=11)
        {
            NSMutableString *telphoneNumber = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@"
                                                                                 ,phone]];
            [telphoneNumber replaceCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
             [self.originallyPasswordControl setText:[NSString stringWithFormat:@"验证电话:%@",telphoneNumber] withNumberType:0 withAllType:NO];
        }
        else
        {
            NSMutableString *telphoneNumber = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@"
                                                                                 ,phone]];
            [telphoneNumber replaceCharactersInRange:NSMakeRange(3, 1)  withString:@"****"];
             [self.originallyPasswordControl setText:[NSString stringWithFormat:@"验证电话:%@",telphoneNumber] withNumberType:0 withAllType:NO];
        }
       
       
        
                                              
    }
}



#pragma mark - 确定修改密码
-(void)submitControlAction:(BaseButtonControl*)sender
{
    NSString *newPassword = [self.newPasswordControl textFieldTitlewithNumberType:0];
    NSString *verifyCode = [self.verifyPasswordControl textFieldTitlewithNumberType:0];
    
    if ([newPassword isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"新密码不能为空!"];
    }
    else if ([verifyCode isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"手机验证不能为空!"];
    }
    else
    {
        [self.netWorkConfig setObject:newPassword forKey:@"bindingPassword"];
        [self.netWorkConfig setObject:verifyCode forKey:@"code"];
        [self.netWorkConfig setObject:self.model.studentBaseId forKey:@"studentBaseId"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_studentBinding007" sucess:^(id object, BOOL verifyObject)
         {
             if (verifyObject)
             {
                 [XHShowHUD showOKHud:@"修改成功！"];
                 [self.navigationController popViewControllerAnimated:YES];
             }
             
         } error:^(NSError *error)
         {
             
         }];
        
    }
}




#pragma mark - Private Method (获取验证码)
-(void)verifyPasswordControlAction:(BaseButtonControl*)sender
{
    [XHShowHUD showTextHud];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].telphoneNumber forKey:@"telephoneNumber"];
    [self.netWorkConfig setObject:@"1" forKey:@"type"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_personalCenter000" sucess:^(id object, BOOL verifyObject)
    {
        if (verifyObject)
        {
            [XHShowHUD showOKHud:@"验证码发送成功"];
            [self addTimer];
        }
    } error:^(NSError *error)
     {
         [XHShowHUD showOKHud:@"验证码发送失败，请重试!"];
     }];
}


-(void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

-(void)nextTime
{
    if (self.timerInteger<=0)
    {
        [self.timer invalidate];
        [self setTimerInteger:59];
        [self.verifyCodeControl setText:@"获取验证码" withNumberType:0 withAllType:NO];
        [self.verifyCodeControl setUserInteractionEnabled:YES];
        [self.verifyCodeControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
    }
    else
    {
        [self.verifyCodeControl setUserInteractionEnabled:NO];
        [self.verifyCodeControl setTextColor:LineViewColor withTpe:0 withAllType:NO];
        [self.verifyCodeControl setText:[NSString stringWithFormat:@"%zd秒重新获取",self.timerInteger] withNumberType:0 withAllType:NO];
        [self setTimerInteger:(self.timerInteger-1)];
    }
    
    
}



#pragma mark - Getter /  Setter


-(BaseButtonControl *)originallyPasswordControl
{
    if (!_originallyPasswordControl)
    {
        _originallyPasswordControl = [[BaseButtonControl alloc]init];
        [_originallyPasswordControl setNumberLabel:1];
        [_originallyPasswordControl setNumberLineView:1];
        [_originallyPasswordControl setFont:FontLevel1 withNumberType:0 withAllType:NO];
        [_originallyPasswordControl setTextColor:RGB(51.0, 51.0, 51.0) withTpe:0 withAllType:NO];
    }
    return _originallyPasswordControl;
}

-(BaseButtonControl *)newPasswordControl
{
    if (!_newPasswordControl)
    {
        _newPasswordControl = [[BaseButtonControl alloc]init];
        [_newPasswordControl setNumberTextField:1];
        [_newPasswordControl setNumberLineView:1];
        [_newPasswordControl  setInputSecureTextEntry:YES withNumberType:0 withAllType:NO];
        [_newPasswordControl setinputTextPlaceholder:@"请输入新密码(6-20位英文、数字组合)" withNumberType:0 withAllType:NO];
    }
    return _newPasswordControl;
}


-(BaseButtonControl *)verifyPasswordControl
{
    if (!_verifyPasswordControl)
    {
        _verifyPasswordControl = [[BaseButtonControl alloc]init];
        [_verifyPasswordControl setNumberTextField:1];
        [_verifyPasswordControl setNumberLineView:1];
        [_verifyPasswordControl setinputTextPlaceholder:@"请输入短信验证码" withNumberType:0 withAllType:NO];
        [_verifyPasswordControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
    }
    return _verifyPasswordControl;
}


-(BaseButtonControl *)verifyCodeControl
{
    if (!_verifyCodeControl)
    {
        _verifyCodeControl = [[BaseButtonControl alloc]init];
        [_verifyCodeControl setNumberLabel:1];
        [_verifyCodeControl setText:@"获取验证码" withNumberType:0 withAllType:NO];
        [_verifyCodeControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_verifyCodeControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_verifyCodeControl setTextBackGroundColor:MainColor withTpe:0 withAllType:NO];
        [_verifyCodeControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_verifyCodeControl addTarget:self action:@selector(verifyPasswordControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verifyCodeControl;
}



-(BaseButtonControl *)submitControl
{
    if (!_submitControl)
    {
        _submitControl = [[BaseButtonControl alloc]init];
        [_submitControl setNumberLabel:1];
        [_submitControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_submitControl setText:@"确认" withNumberType:0 withAllType:NO];
        [_submitControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_submitControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_submitControl setBackgroundColor:MainColor];
        [_submitControl addTarget:self action:@selector(submitControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitControl;
}





@end
