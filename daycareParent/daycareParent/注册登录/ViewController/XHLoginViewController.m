//
//  XHLoginViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHLoginViewController.h"
#import "MainRootControllerHelper.h"
#import "XHLoginTableViewCell.h"
#import "XHRegisterViewController.h"
#import "XHForgetViewController.h"
#import "XHLoginModel.h"
#import "MianTabBarViewController.h"
#import "AppDelegate.h"
#import "XHChildListModel.h"
#import "XHNewUserInfoViewController.h"
#define kTitle @[@"请输入手机号",@"请输入密码"]
#define kTitlePic @[@"ico_number",@"ico_password"]
@interface XHLoginViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ParentImageView *bgImageView;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)UIButton *registButton;
@property(nonatomic,strong)UIButton *forgetButton;
@end

@implementation XHLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navtionHidden:YES];
    //[self.view addSubview:self.scrollView];
    ParentImageView *imageView=[[ParentImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.center=CGPointMake(SCREEN_WIDTH/2.0, 125);
    imageView.image=[UIImage imageNamed:@"login_logo"];
    [self.view addSubview:imageView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registButton];
    [self.view addSubview:self.forgetButton];
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHLoginTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textFeild.placeholder=kTitle[indexPath.row];
    cell.titleImageView.image=[UIImage imageNamed:kTitlePic[indexPath.row]];
    cell.textFeild.tag=indexPath.row+10086;
    if (indexPath.row==1) {
        cell.textFeild.secureTextEntry=YES;
    }
    else
    {
        cell.textFeild.keyboardType=UIKeyboardTypeNumberPad;
    }
    [cell.textFeild addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
    return cell;
}
- (void)buttonClickMethod:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        {
            UITextField *telePhone=[_tableView viewWithTag:10086];
            UITextField *pwd=[_tableView viewWithTag:10086+1];
            if (![UITextView verifyPhone:telePhone.text]) {
                [XHShowHUD showNOHud:@"请输入正确手机号!"];
                return;
            }
            if ([pwd.text length]<6)
            {
                [XHShowHUD showNOHud:@"密码至少6位!"];
                return;
            }
            XHNetWorkConfig *net=[[XHNetWorkConfig alloc] init];
            [net setObject:telePhone.text forKey:@"loginName"];
            [net setObject:pwd.text forKey:@"pwd"];
            [net setObject:@"3" forKey:@"type"];
            [XHShowHUD showTextHud];
            [net postWithUrl:@"zzjt-app-api_login" sucess:^(id object, BOOL verifyObject) {
                if (verifyObject)
                {
                    XHLoginModel *loginModel=[[XHLoginModel alloc] init];
                    loginModel.loginName=telePhone.text;
                    loginModel.pwd=pwd.text;
                    loginModel.type=[@"3" integerValue];
                    [[XHUserInfo sharedUserInfo] setItemObject:[object objectItemKey:@"object"]];
                    if ([[XHUserInfo sharedUserInfo].guardianModel.guardianId isEqualToString:@""]) {
                        [XHShowHUD showNOHud:@"登录失败！"];
                        return ;
                    }
                    [NSUserDefaults  saveLocalObject:loginModel forKey:AutoLogin];
                    XHNetWorkConfig *netWork=[[XHNetWorkConfig alloc] init];
                    [netWork setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
                    [XHShowHUD showTextHud];
                    [netWork postWithUrl:@"zzjt-app-api_smartCampus011" sucess:^(id object, BOOL verifyObject) {
                        if (verifyObject) {
                            
                            NSMutableArray *tempChildArray = [NSMutableArray array];
                            for (NSDictionary *dic in [object objectItemKey:@"object"]) {
                                XHChildListModel *model=[[XHChildListModel alloc] initWithDic:dic];
                                [tempChildArray addObject:model];
                            }
                            [[XHUserInfo sharedUserInfo].childListArry setArray:tempChildArray];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
                                [app loginRongCloud:[XHUserInfo sharedUserInfo].token];
                                [app setJpushAlias:[XHUserInfo sharedUserInfo].loginName];
                                if ([[XHUserInfo sharedUserInfo].nickName isEqualToString:@""]) {
                                    //跳转补全信息界面
                                    XHNewUserInfoViewController *newUser = [[XHNewUserInfoViewController alloc]init];
                                    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:newUser];
                                    [kWindow setRootViewController:nav];
                                }
                                else
                                {
                                    MianTabBarViewController *main=[MianTabBarViewController new];
                                    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:main];
                                    [kWindow setRootViewController:navigationController];
                                }
                                
                            });
                            
                        }
                        
                    } error:^(NSError *error) {
                        
                    }];
                    
                }
            } error:^(NSError *error) {
                
            }];
        }
            break;
            
        case 2:
        {
            XHForgetViewController *forget=[XHForgetViewController new];
            [self.navigationController pushViewController:forget animated:YES];
        }
            break;
            case 3:
        {
            XHRegisterViewController *regist=[XHRegisterViewController new];
            [self.navigationController pushViewController:regist animated:YES];
        }
            break;
    }
    
    
}
-(void)textChage
{
    UITextField *telePhone=[_tableView viewWithTag:10086];
    UITextField *pwd=[_tableView viewWithTag:10086+1];
    if ([UITextView verifyPhone:telePhone.text]&&pwd.text.length>5)
    {
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [self.loginButton setTitleColor:LOGIN_BEFORE forState:UIControlStateNormal];
    }
}

-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(20, 210, SCREEN_WIDTH-50, 100)];
        //_tableView.center=CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0-40);
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.bounces=NO;
        _tableView.rowHeight=50;
        [_tableView registerClass:[XHLoginTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
-(UIButton *)loginButton
{
    if (_loginButton==nil) {
        _loginButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 370, SCREEN_WIDTH-20, 50)];
        _loginButton.layer.cornerRadius=8;
        _loginButton.layer.masksToBounds=YES;
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"btn_logn"] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTag:1];
        [_loginButton addTarget:self action:@selector(buttonClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
-(UIButton *)forgetButton
{
    if (_forgetButton==nil) {
        _forgetButton=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 320, 82, 30)];
        [_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font=FontLevel2;
        [_forgetButton setTitleColor:MainColor forState:UIControlStateNormal];
        [_forgetButton setTag:2];
        [_forgetButton addTarget:self action:@selector(buttonClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}
-(UIButton *)registButton
{
    if (_registButton==nil) {
        _registButton=[[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 30)];
        [_registButton setTitle:@"立即注册" forState:UIControlStateNormal];
        [_registButton setTag:3];
        [_registButton addTarget:self action:@selector(buttonClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registButton;
}
-(ParentImageView *)bgImageView
{
    if (_bgImageView==nil) {
        _bgImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60)];
        _bgImageView.image=[UIImage imageNamed:@"bg_logn"];
    }
    return _bgImageView;
}
-(UIScrollView *)scrollView
{
    if (_scrollView==nil) {
        
        _scrollView=[[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _scrollView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
