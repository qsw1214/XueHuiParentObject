//
//  XHLoginViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHLoginViewController.h"
#import "MainRootControllerHelper.h"
#import "XHPassWordTableViewCell.h"
#import "XHRegisterViewController.h"
#import "XHForgetViewController.h"
#import "XHLoginModel.h"
#import "MianTabBarViewController.h"
#import "AppDelegate.h"
#import "XHChildListModel.h"
#import "XHNewUserInfoViewController.h"
@interface XHLoginViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *frontArry;
    NSArray *placeArry;
    XHBaseBtn *_sureBtn;
}
@end

@implementation XHLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navtionHidden:YES];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.center=CGPointMake(SCREEN_WIDTH/2.0, 125);
    imageView.layer.cornerRadius=20;
    imageView.layer.masksToBounds=YES;
    imageView.image=[UIImage imageNamed:@"tubiao"];
    [self.view addSubview:imageView];
    frontArry=@[@"帐号",@"密码"];
    placeArry=@[@"请输入手机号",@"请输入密码"];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 100)];
    //_tableView.center=CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0-40);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    _tableView.rowHeight=LOGINBTN_HEIGHT;
    [_tableView registerNib:[UINib nibWithNibName:@"XHPassWordTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    _sureBtn=[[XHBaseBtn alloc] initWithFrame:CGRectMake(10, 340, SCREEN_WIDTH-20, LOGINBTN_HEIGHT)];
    //_sureBtn.center=CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0+70);
    _sureBtn.backgroundColor=RGB(228, 133, 19);
    [_sureBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
    UIButton *registBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    registBtn.center=CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT-80);
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    registBtn.titleLabel.font=FontLevel2;
    [registBtn setTitleColor:RGB(228, 133, 19) forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    UIButton *forgetBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 82, 30)];
    forgetBtn.center=CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT-40);
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font=FontLevel2;
    [forgetBtn setTitleColor:RGB(228, 133, 19) forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHPassWordTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLb.text=frontArry[indexPath.row];
    cell.textFD.tag=indexPath.row+10086;
    if (indexPath.row==1) {
        cell.textFD.secureTextEntry=YES;
    }
    else
    {
        cell.textFD.keyboardType=UIKeyboardTypeNumberPad;
    }
    [cell.textFD addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
    cell.textFD.placeholder=placeArry[indexPath.row];
    return cell;
}
- (void)sureBtnClick{
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
            
            if (![[object objectItemKey:@"object"] isKindOfClass:[NSDictionary class]]) {

                [XHShowHUD showNOHud:@"登录失败,请重试!"];
                return ;
            }
            if ([[object objectItemKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                if ([[object objectForKey:@"object"] allKeys].count<2) {
                    [XHShowHUD showNOHud:@"登录失败,请重试!"];
                    return;
                }
            }
            [[XHUserInfo sharedUserInfo] setItemObject:[object objectItemKey:@"object"]];
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
                            [kWindow setRootViewController:main];
                        }
                       
                    });
                    
                }
                
            } error:^(NSError *error) {
                
            }];
            
        }
    } error:^(NSError *error) {
        
    }];
    
}
-(void)textChage
{
    UITextField *telePhone=[_tableView viewWithTag:10086];
    UITextField *pwd=[_tableView viewWithTag:10086+1];
    if ([UITextView verifyPhone:telePhone.text]&&pwd.text.length>5)
    {
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [_sureBtn setTitleColor:LOGIN_BEFORE forState:UIControlStateNormal];
    }
}
-(void)registBtnClick
{
    XHRegisterViewController *regist=[XHRegisterViewController new];
    [self.navigationController pushViewController:regist animated:YES];
}
-(void)forgetBtnClick
{
    XHForgetViewController *forget=[XHForgetViewController new];
    [self.navigationController pushViewController:forget animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
