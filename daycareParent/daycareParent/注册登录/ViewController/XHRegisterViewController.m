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
    XHBaseBtn *_sureBtn;
    UIButton *_selectBtn;
}
@property(nonatomic,strong)BaseTableView *tableView;
@end

@implementation XHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"注册页面"];
    _currentS = 60;

    [self.view addSubview:self.tableView];
    _selectBtn=[[UIButton alloc] initWithFrame:CGRectMake(20, 168, 14,14)];
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"box-check"] forState:UIControlStateNormal];
    [_selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_selectBtn];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(40, 165, 100, 18)];
    label.text=@"我已阅读并同意";
    label.font=[UIFont systemFontOfSize:14];
    [self.tableView addSubview:label];
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(132, 165, 100, 18)];
    [btn setTitle:@"《i学汇用户》" forState:UIControlStateNormal];
    [btn setTitleColor:MainColor forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(btnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:btn];
    _sureBtn=[[XHBaseBtn alloc] initWithFrame:CGRectMake(10, 210, SCREEN_WIDTH-20, LOGINBTN_HEIGHT)];
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_sureBtn];
    
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
        cell.chageTelePhoneTextField.tag=3+10086;
        [cell.chageTelePhoneTextField addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
        cell.verifyButton.backgroundColor=MainColor;
        cell.verifyButton.titleLabel.font=FontLevel3;
        cell.verifyButton.layer.cornerRadius=CORNER_BTN;
        [cell.verifyButton addTarget:self action:@selector(verifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
