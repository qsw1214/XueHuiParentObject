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
@property (nonatomic,strong) BaseButtonControl *submitControl;  //!< 确认提交


@end

@implementation XHBindPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"修改绑定密码"];
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
        [self.view addSubview:self.submitControl];
        
        //!< 重置新Frame
        //!< 原密码
        [self.originallyPasswordControl resetFrame:CGRectMake(0, (self.navigationView.bottom+20.0), SCREEN_WIDTH,50.0)];
        [self.originallyPasswordControl setInputEdgeFrame:CGRectMake(10.0, 0, self.originallyPasswordControl.width-20.0, self.originallyPasswordControl.height) withNumberType:0 withAllType:NO];
        [self.originallyPasswordControl resetLineViewFrame:CGRectMake(0, (self.originallyPasswordControl.height-0.5), (self.originallyPasswordControl.width), 0.5) withNumberType:0 withAllType:NO];
        //!< 新密码
        [self.newPasswordControl resetFrame:CGRectMake(0, (self.originallyPasswordControl.bottom+20.0), SCREEN_WIDTH,50.0)];
        [self.newPasswordControl setInputEdgeFrame:CGRectMake(10.0, 0, self.newPasswordControl.width-20.0, self.newPasswordControl.height) withNumberType:0 withAllType:NO];
        [self.newPasswordControl resetLineViewFrame:CGRectMake(0, (self.newPasswordControl.height-0.5), (self.newPasswordControl.width), 0.5) withNumberType:0 withAllType:NO];
        //!< 重置验证新密码的Frame
        [self.verifyPasswordControl resetFrame:CGRectMake(0, self.newPasswordControl.bottom, self.newPasswordControl.width, self.newPasswordControl.height)];
        [self.verifyPasswordControl setInputEdgeFrame:CGRectMake(10.0, 0, self.verifyPasswordControl.width-20.0, self.verifyPasswordControl.height) withNumberType:0 withAllType:NO];
        [self.verifyPasswordControl resetLineViewFrame:CGRectMake(0, (self.newPasswordControl.height-0.5), (self.newPasswordControl.width), 0.5) withNumberType:0 withAllType:NO];
        //!< 重置确定Frame
        [self.submitControl resetFrame:CGRectMake(40.0, self.verifyPasswordControl.bottom+40.0, SCREEN_WIDTH-80.0, 45.0)];
        [self.submitControl setTitleEdgeFrame:CGRectMake(0, 0, self.submitControl.width, self.submitControl.height) withNumberType:0 withAllType:NO];
    }
}

-(void)submitControlAction:(BaseButtonControl*)sender
{
    NSString *o = [self.originallyPasswordControl textFieldTitlewithNumberType:0];
    NSString *n = [self.newPasswordControl textFieldTitlewithNumberType:0];
    NSString *v = [self.verifyPasswordControl textFieldTitlewithNumberType:0];
    
    if ([o isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"原密码不能为空!"];
    }
    else if ([n isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"新密码不能为空!"];
    }
    else if ([v isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"验证密码不能为空!"];
    }
    else if ([n isEqualToString:v])
    {
        [self.netWorkConfig setObject:o forKey:@"studentBaseId"];
        [self.netWorkConfig setObject:o forKey:@"oldBindingPassword"];
        [self.netWorkConfig setObject:v forKey:@"newBindingPassword"];
        [self.netWorkConfig postWithUrl:@"" sucess:^(id object, BOOL verifyObject)
        {
            if (verifyObject)
            {
                
                
                
            }
            
        } error:^(NSError *error)
         {
             
         }];
        
        
    }
    else
    {
        [XHShowHUD showNOHud:@"两次新密码不一致!"];
    }
    
    
    
    
    
}


#pragma mark - NetWork Mthod
-(void)aas
{
//    zzjt-app-api_studentBinding007
    
    
    [self.netWorkConfig setObject:@"" forKey:@""];
    
}


#pragma mark - Getter /  Setter


-(BaseButtonControl *)originallyPasswordControl
{
    if (!_originallyPasswordControl)
    {
        _originallyPasswordControl = [[BaseButtonControl alloc]init];
        [_originallyPasswordControl setNumberTextField:1];
        [_originallyPasswordControl setNumberLineView:1];
        [_originallyPasswordControl setinputTextPlaceholder:@"请输入原密码" withNumberType:0 withAllType:NO];
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
        [_newPasswordControl setinputTextPlaceholder:@"请输入新密码（6-20位英文、数字组合）" withNumberType:0 withAllType:NO];
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
        [_verifyPasswordControl setinputTextPlaceholder:@"请确认新密码（6-20位英文、数字组合）" withNumberType:0 withAllType:NO];
    }
    return _verifyPasswordControl;
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
