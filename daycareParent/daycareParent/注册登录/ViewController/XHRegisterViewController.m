//
//  XHRegisterViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHRegisterViewController.h"
#import "XHChagePhoneTableViewCell.h"
#import "XHTelephoneTableViewCell.h"
#import "XHProtocolViewController.h"
#import "AppDelegate.h"
#import "MainRootControllerHelper.h"
#define countDownStr(s) [NSString stringWithFormat:@"%ld秒后重发",s]
#define reviewTitle @"重新发送"
@interface XHRegisterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arry;
    NSArray *placeArry;
    NSInteger  _currentS;
    NSTimer *_timer;
    BOOL _ifSelect;
    UITableView *_tableView;
    XHBaseBtn *_sureBtn;
    UIButton *_selectBtn;
}

@end

@implementation XHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"注册页面"];
    _currentS = 60;
    arry=@[@"帐号",@"密码",@"密码",@"验证码"];
    placeArry=@[@"请输入手机号",@"请输入密码",@"请确认密码",@"请输入验证码"];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200)];
    _tableView.rowHeight=50;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    [_tableView registerNib:[UINib nibWithNibName:@"XHChagePhoneTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHTelephoneTableViewCell" bundle:nil] forCellReuseIdentifier:@"telephonecell"];
    [self.view addSubview:_tableView];
    _selectBtn=[[UIButton alloc] initWithFrame:CGRectMake(20, 282, 14,14)];
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"box-check"] forState:UIControlStateNormal];
    [_selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectBtn];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(40, 280, 100, 18)];
    label.text=@"我已阅读并同意";
    label.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(132, 280, 100, 18)];
    [btn setTitle:@"《i学汇用户》" forState:UIControlStateNormal];
    [btn setTitleColor:MainColor forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(btnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    _sureBtn=[[XHBaseBtn alloc] initWithFrame:CGRectMake(10, 318, SCREEN_WIDTH-20, LOGINBTN_HEIGHT)];
    [_sureBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        XHChagePhoneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text=@"验证码";
        cell.textFD.placeholder=@"请输入验证码";
        cell.textFD.keyboardType=UIKeyboardTypeNumberPad;
        cell.textFD.tag=3+10086;
        [cell.textFD addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
        cell.verifyBtn.backgroundColor=RGB(245, 245, 245);
        [cell.verifyBtn setTitleColor:RGB(82, 82, 82) forState:UIControlStateNormal];
        cell.verifyBtn.titleLabel.font=FontLevel3;
        cell.verifyBtn.layer.cornerRadius=CORNER_BTN;
        [cell.verifyBtn addTarget:self action:@selector(verifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        XHTelephoneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"telephonecell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.telephoneLabel.text=arry[indexPath.row];
        cell.telephoneTF.placeholder=placeArry[indexPath.row];
        cell.telephoneTF.tag=indexPath.row+10086;
        [cell.telephoneTF addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
        if (indexPath.row==0) {
            cell.telephoneTF.keyboardType=UIKeyboardTypeNumberPad;
        }
        else
        {
            cell.telephoneTF.secureTextEntry=YES;
        }
        return cell;
    }
    
}
-(void)verifyBtnClick
{
   
    UITextField *phonepwd=[_tableView viewWithTag:10086];
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
//开始倒计时
- (void)startCountdown
{
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    //找到对应的cell
    XHChagePhoneTableViewCell *Cell = [_tableView cellForRowAtIndexPath:indexPath];
    [Cell.verifyBtn setTitle:countDownStr(_currentS) forState:UIControlStateNormal];
    _currentS--;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(timer) userInfo:nil repeats:YES];
}

- (void)timer
{
    _ifSelect=YES;
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    //找到对应的cell
    XHChagePhoneTableViewCell *Cell = [_tableView cellForRowAtIndexPath:indexPath];
    --_currentS;
    if (_currentS == 0)
    {
        _currentS = 60;
        [_timer invalidate];
        
        _ifSelect=NO;
        [Cell.verifyBtn setTitle:reviewTitle forState:UIControlStateNormal];
        
        return;
    }
    [Cell.verifyBtn setTitle:countDownStr(_currentS) forState:UIControlStateNormal];
}
- (void)sureBtnClick {
    
    [[MainRootControllerHelper sharedRootHelperHelper] autoLoginWithWindow:kWindow];
    
    
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    UITextField *pwd=[_tableView viewWithTag:10086+1];
     UITextField *surePwd=[_tableView viewWithTag:10086+2];
    UITextField *verrifypwd=[_tableView viewWithTag:10086+3];
    if (![UITextView verifyPhone:phonepwd.text]) {
        [XHShowHUD showNOHud:@"请输入正确手机号!"];
        return;
    }
    if (pwd.text.length<6||surePwd.text.length<6) {
        [XHShowHUD showNOHud:@"密码至少6位!"];
        return;
    }
    if (![pwd.text isEqualToString:surePwd.text]) {
        [XHShowHUD showNOHud:@"确认密码不符!"];
        return;
    }
    if (![UITextView verifyCodeMatch:verrifypwd.text]) {
        [XHShowHUD showNOHud:@"请输入正确的验证码!"];
        return;
    }
    if (_selectBtn.selected==NO) {
        [XHShowHUD showNOHud:@"请勾选同意用户协议！"];
        return;
    }
    XHNetWorkConfig *net=[XHNetWorkConfig new];
    [net setObject:phonepwd.text forKey:@"telphoneNumber"];
     [net setObject:pwd.text forKey:@"password"];
     [net setObject:@"3" forKey:@"userType"];
     [net setObject:verrifypwd.text forKey:@"smsCode"];
     [XHShowHUD showTextHud];
    [net postWithUrl:@"zzjt-app-api_user001" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            
            [[MainRootControllerHelper sharedRootHelperHelper] autoLoginWithWindow:kWindow];
        }
        
    } error:^(NSError *error) {
    }];
    
}
-(void)textChage
{
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    UITextField *pwd=[_tableView viewWithTag:10086+1];
    UITextField *surePwd=[_tableView viewWithTag:10086+2];
    UITextField *verrifypwd=[_tableView viewWithTag:10086+3];
    if ([UITextView verifyPhone:phonepwd.text]&&pwd.text.length>5&&surePwd.text.length>5&&[UITextView verifyCodeMatch:verrifypwd.text])
    {
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [_sureBtn setTitleColor:LOGIN_BEFORE forState:UIControlStateNormal];
    }
}
-(void)selectBtnClick
{
    if (_selectBtn.selected==NO) {
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"ico-right"] forState:UIControlStateNormal];
        _selectBtn.selected=YES;
    }
    else
    {
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"box-check"] forState:UIControlStateNormal];
        _selectBtn.selected=NO;
    }
}
-(void)btnMethod
{
    XHProtocolViewController *potocol=[XHProtocolViewController new];
    [self.navigationController pushViewController:potocol animated:YES];
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
