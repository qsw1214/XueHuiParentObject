//
//  XHRegisterViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHRegisterViewController.h"
#import "XHChageTelephoneTableViewCell.h"
#import "XHVerifyTableViewCell.h"
#import "XHProtocolViewController.h"
#import "AppDelegate.h"
#import "MainRootControllerHelper.h"
#import "XHBindViewController.h"
#define countDownStr(s) [NSString stringWithFormat:@"%ld秒后重发",s]
#define reviewTitle @"重新发送"
#define kTitle @[@"请输入手机号",@"请输入验证码",@"请输入密码"]
@interface XHRegisterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arry;
    NSArray *placeArry;
    NSInteger  _currentS;
    NSTimer *_timer;
    BOOL _ifSelect;
    UIButton *_selectBtn;
}
@property(nonatomic,strong)BaseTableView *tableView;
@property(nonatomic,strong)UIButton *registButton;
@property(nonatomic,strong)BaseButtonControl *selectButton;
@property(nonatomic,strong)UIButton *protocolButton;
@end

@implementation XHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"注册页面"];
    _currentS = 60;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.selectButton];
    [self.tableView addSubview:self.protocolButton];
    [self.tableView addSubview:self.registButton];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        XHVerifyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.chageTelePhoneTextField.placeholder=kTitle[indexPath.row];
        cell.chageTelePhoneTextField.keyboardType=UIKeyboardTypeNumberPad;
        cell.chageTelePhoneTextField.tag=indexPath.row+10086;
        [cell.chageTelePhoneTextField addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
        cell.verifyButton.backgroundColor=MainColor;
        cell.verifyButton.titleLabel.font=FontLevel3;
        cell.verifyButton.layer.cornerRadius=CORNER_BTN;
        [cell.verifyButton setTag:1];
        [cell.verifyButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        XHChageTelephoneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"telephonecell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.chageTelePhoneTextField.placeholder=kTitle[indexPath.row];
        cell.chageTelePhoneTextField.tag=indexPath.row+10086;
        [cell.chageTelePhoneTextField addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
        if (indexPath.row==0) {
            cell.chageTelePhoneTextField.keyboardType=UIKeyboardTypeNumberPad;
        }
        else
        {
            cell.chageTelePhoneTextField.secureTextEntry=YES;
        }
        return cell;
    }
    
}


- (void)buttonClick:(UIButton *)btn
{
    
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    UITextField *verrifypwd=[_tableView viewWithTag:10086+1];
    UITextField *pwd=[_tableView viewWithTag:10086+2];
    switch (btn.tag) {
        case 1:
        {
            if (![UITextView verifyPhone:phonepwd.text]) {
                [XHShowHUD showNOHud:@"请输入正确手机号!"];
                return;
            }
            if (_ifSelect==NO) {
                XHNetWorkConfig *net=[XHNetWorkConfig new];
                [net setObject:phonepwd.text forKey:@"telephoneNumber"];
                [net setObject:@"0" forKey:@"type"];
                [XHShowHUD showTextHud];
                [net postWithUrl:@"zzjt-app-api_personalCenter000" sucess:^(id object, BOOL verifyObject) {
                    if (verifyObject) {
                        [self startCountdown];
                    }
                } error:^(NSError *error) {
                }];
            }
        }
            break;
            case 2:
        {
            if (self.selectButton.selected==NO) {
                [self.selectButton setImage:@"ico-right" withNumberType:0 withAllType:NO];
                self.selectButton.selected=YES;
            }
            else
            {
                 [self.selectButton setImage:@"box-check" withNumberType:0 withAllType:NO];
                self.selectButton.selected=NO;
            }
        }
            break;
            case 3:
        {
            XHProtocolViewController *potocol=[XHProtocolViewController new];
            [self.navigationController pushViewController:potocol animated:YES];
        }
            break;
        case 4:
        {
            XHBindViewController *bind=[[XHBindViewController alloc] init];
            [self.navigationController pushViewController:bind animated:YES];
//
//            if (![UITextView verifyPhone:phonepwd.text]) {
//                [XHShowHUD showNOHud:@"请输入正确手机号!"];
//                return;
//            }
//            if (pwd.text.length<6) {
//                [XHShowHUD showNOHud:@"密码至少6位!"];
//                return;
//            }
//            if (![UITextView verifyCodeMatch:verrifypwd.text]) {
//                [XHShowHUD showNOHud:@"请输入正确的验证码!"];
//                return;
//            }
//            if (_selectBtn.selected==NO) {
//                [XHShowHUD showNOHud:@"请勾选同意用户协议！"];
//                return;
//            }
//            XHNetWorkConfig *net=[XHNetWorkConfig new];
//            [net setObject:phonepwd.text forKey:@"telphoneNumber"];
//            [net setObject:pwd.text forKey:@"password"];
//            [net setObject:@"3" forKey:@"userType"];
//            [net setObject:verrifypwd.text forKey:@"smsCode"];
//            [XHShowHUD showTextHud];
//            [net postWithUrl:@"zzjt-app-api_user001" sucess:^(id object, BOOL verifyObject) {
//                if (verifyObject) {
//                    XHStudentInfoViewController *studentInfo=[[XHStudentInfoViewController alloc] init];
//                    [self.navigationController pushViewController:studentInfo animated:YES];
//                }
//
//            } error:^(NSError *error) {
//            }];
        }
            break;
    }
   
    
}
//开始倒计时
- (void)startCountdown
{
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    //找到对应的cell
    XHVerifyTableViewCell *Cell = [_tableView cellForRowAtIndexPath:indexPath];
    [Cell.verifyButton setTitle:countDownStr(_currentS) forState:UIControlStateNormal];
    _currentS--;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(timer) userInfo:nil repeats:YES];
}

- (void)timer
{
    _ifSelect=YES;
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    //找到对应的cell
    XHVerifyTableViewCell *Cell = [_tableView cellForRowAtIndexPath:indexPath];
    --_currentS;
    if (_currentS == 0)
    {
        _currentS = 60;
        [_timer invalidate];
        
        _ifSelect=NO;
        [Cell.verifyButton setTitle:reviewTitle forState:UIControlStateNormal];
        
        return;
    }
    [Cell.verifyButton setTitle:countDownStr(_currentS) forState:UIControlStateNormal];
}
-(void)textChage
{
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    UITextField *verrifypwd=[_tableView viewWithTag:10086+1];
    UITextField *pwd=[_tableView viewWithTag:10086+2];
    if ([UITextView verifyPhone:phonepwd.text]&&pwd.text.length>5&&[UITextView verifyCodeMatch:verrifypwd.text])
    {
        [self.registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [self.registButton setTitleColor:LOGIN_BEFORE forState:UIControlStateNormal];
    }
}

-(BaseTableView *)tableView
{
    if (_tableView==nil) {
       // _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 150)];
        _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableView.rowHeight=50;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[XHChageTelephoneTableViewCell class] forCellReuseIdentifier:@"telephonecell"];
        [_tableView registerClass:[XHVerifyTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
-(BaseButtonControl *)selectButton
{
    if (_selectButton==nil) {
        
        _selectButton=[[BaseButtonControl alloc] initWithFrame:CGRectMake(20, 160, 120,30)];
        [_selectButton setNumberImageView:1];
        [_selectButton setNumberLabel:1];
        [_selectButton setImageEdgeFrame:CGRectMake(0, 8, 14, 14) withNumberType:0 withAllType:NO];
        [_selectButton setImage:@"box-check" withNumberType:0 withAllType:NO];
        [_selectButton setTitleEdgeFrame:CGRectMake(18, 6, 100, 18) withNumberType:0 withAllType:NO];
        [_selectButton setText:@"我已阅读并同意" withNumberType:0 withAllType:NO];
        [_selectButton setFont:kFont(14) withNumberType:0 withAllType:NO];
        [_selectButton setTag:2];
        [_selectButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}
-(UIButton *)protocolButton
{
    if (_protocolButton==nil) {
        _protocolButton=[[UIButton alloc] initWithFrame:CGRectMake(132, 165, 160, 18)];
        [_protocolButton setTitle:@"《学汇校灵通用户协议》" forState:UIControlStateNormal];
        [_protocolButton setTitleColor:MainColor forState:UIControlStateNormal];
        _protocolButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_protocolButton setTag:3];
        [_protocolButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protocolButton;
}
-(UIButton *)registButton
{
    if (_registButton==nil) {
        _registButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 210, SCREEN_WIDTH-20, LOGINBTN_HEIGHT)];
        _registButton.backgroundColor=MainColor;
        _registButton.layer.cornerRadius=8;
        _registButton.layer.masksToBounds=YES;
        [_registButton setTitleColor:LOGIN_BEFORE  forState:UIControlStateNormal];
        [_registButton setTitle:@"确定" forState:UIControlStateNormal];
        [_registButton setTag:4];
        [_registButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registButton;
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
