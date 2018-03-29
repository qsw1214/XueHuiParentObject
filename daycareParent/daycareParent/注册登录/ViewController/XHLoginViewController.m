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
@interface XHLoginViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)ParentImageView *imageView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ParentImageView *bgImageView;
@property(nonatomic,strong)XHBaseBtn *loginButton;
@property(nonatomic,strong)UIButton *registButton;
@property(nonatomic,strong)UIButton *forgetButton;
@end

@implementation XHLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self navtionHidden:YES];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.scrollView addSubview:self.tableView];
    [self.scrollView addSubview:self.loginButton];
    [self.scrollView addSubview:self.forgetButton];
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.registButton];
    self.scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT/2.0+110);
    [self scrollViewAddGesture];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kTitle.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHLoginTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setItemObject:nil withIndexPathRow:indexPath.row];
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
                    [netWork postWithUrl:@"zzjt-app-api_studentBinding008" sucess:^(id object, BOOL verifyObject) {
                        if (verifyObject) {
                            
                            NSMutableArray *tempChildArray = [NSMutableArray array];
                            NSArray *itemArry=[object objectItemKey:@"object"];
                            if (itemArry) {
                                for (NSDictionary *dic in itemArry) {
                                    XHChildListModel *model=[[XHChildListModel alloc] initWithDic:dic];
                                    [tempChildArray addObject:model];
                                }
                            }
                            [[XHUserInfo sharedUserInfo].childListArry setArray:tempChildArray];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
                                [app loginRongCloud:[XHUserInfo sharedUserInfo].token];
                                [app setJpushAlias:[XHUserInfo sharedUserInfo].loginName];
                                
                                MianTabBarViewController *main=[MianTabBarViewController new];
                                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:main];
                                [kWindow setRootViewController:navigationController];
                                
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

-(UIScrollView *)scrollView
{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-70)];
        _scrollView.bounces=YES;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
    }
    return _scrollView;
}

-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(40, 210, SCREEN_WIDTH-80, 116)];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.center=CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.bounces=NO;
        [_tableView registerClass:[XHLoginTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
-(XHBaseBtn *)loginButton
{
    if (_loginButton==nil) {
        _loginButton=[[XHBaseBtn alloc] initWithFrame:CGRectMake(40, SCREEN_HEIGHT/2.0+110, SCREEN_WIDTH-80, 44)];
        [_loginButton setBackgroundColor:[UIColor clearColor]];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"btn_logn"] forState:UIControlStateNormal];
        [_loginButton setTitle:@"没错，就是我！" forState:UIControlStateNormal];
        [_loginButton setTag:1];
        [_loginButton addTarget:self action:@selector(buttonClickMethod:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
-(UIButton *)forgetButton
{
    if (_forgetButton==nil) {
        _forgetButton=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-122, SCREEN_HEIGHT/2.0+60, 82, 30)];
        [_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font=kFont(15.0);
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
       
        if ([[XHHelper iphoneType] isEqualToString:@"iPhone 4"]||[[XHHelper iphoneType] isEqualToString:@"iPhone 4S"])
        {
            _bgImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        }
        else if ([[XHHelper iphoneType] isEqualToString:@"iPhone 6 Plus"]||[[XHHelper iphoneType] isEqualToString:@"iPhone 6s Plus"]||[[XHHelper iphoneType] isEqualToString:@"iPhone 7 Plus"]||[[XHHelper iphoneType] isEqualToString:@"iPhone 8 Plus"]||[[XHHelper iphoneType] isEqualToString:@"iPhone X"])
        {
            _bgImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-120, SCREEN_WIDTH, 120)];
        }
        else
        {
            _bgImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100)];
        }
        [_bgImageView setContentMode:UIViewContentModeScaleAspectFill];
        _bgImageView.image=[UIImage imageNamed:@"bg_logn"];
    }
    return _bgImageView;
}
-(ParentImageView *)imageView
{
    if (_imageView==nil) {
        _imageView=[[ParentImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-130)/2.0, (SCREEN_HEIGHT/2.0-130)/2.0, 130, 130)];
        _imageView.image=[UIImage imageNamed:@"login_logo"];
    }
    return _imageView;
}
//失去第一响应者
- (void)scrollViewAddGesture{
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)]];
}
- (void)tapScrollView
{
    
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
