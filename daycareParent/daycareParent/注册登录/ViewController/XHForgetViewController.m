//
//  XHForgetViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHForgetViewController.h"
#import "XHChagePhoneTableViewCell.h"
#import "XHTelephoneTableViewCell.h"
#define countDownStr(s) [NSString stringWithFormat:@"%ld秒后重发",s]
#define reviewTitle @"重新发送"
@interface XHForgetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arry;
    NSArray *placeArry;
    NSInteger  _currentS;
    NSTimer *_timer;
    BOOL _ifSelect;
    UITableView *_tableView;
    XHBaseBtn *_sureBtn;
}

@end

@implementation XHForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"找回密码"];
    _currentS = 60;
    arry=@[@"帐号",@"验证码",@"新密码",@"新密码"];
    placeArry=@[@"请输入手机号",@"请输入验证码",@"请输入密码",@"请确认密码"];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200)];
    _tableView.rowHeight=50;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    [_tableView registerNib:[UINib nibWithNibName:@"XHChagePhoneTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHTelephoneTableViewCell" bundle:nil] forCellReuseIdentifier:@"telephonecell"];
    [self.view addSubview:_tableView];
    _sureBtn=[[XHBaseBtn alloc] initWithFrame:CGRectMake(10, 290, SCREEN_WIDTH-20, LOGINBTN_HEIGHT)];
    [_sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        XHChagePhoneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text=@"验证码";
        cell.textFD.placeholder=@"请输入验证码";
        cell.textFD.keyboardType=UIKeyboardTypeNumberPad;
        cell.textFD.tag=1+10086;
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
        [net setObject:@"1" forKey:@"type"];
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
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    //找到对应的cell
    XHChagePhoneTableViewCell *Cell = [_tableView cellForRowAtIndexPath:indexPath];
    [Cell.verifyBtn setTitle:countDownStr(_currentS) forState:UIControlStateNormal];
    _currentS--;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(timer) userInfo:nil repeats:YES];
}

- (void)timer
{
    _ifSelect=YES;
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
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
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    UITextField *pwd=[_tableView viewWithTag:10086+2];
    UITextField *surePwd=[_tableView viewWithTag:10086+3];
    UITextField *verrifypwd=[_tableView viewWithTag:10086+1];
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
    XHNetWorkConfig *net=[XHNetWorkConfig new];
    [net setObject:phonepwd.text forKey:@"telphoneNumber"];
    [net setObject:pwd.text forKey:@"password"];
    [net setObject:verrifypwd.text forKey:@"verificationCode"];
     [XHShowHUD showTextHud];
    [net postWithUrl:@"zzjt-app-api_user002" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } error:^(NSError *error) {
    }];
}
-(void)textChage
{
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    UITextField *pwd=[_tableView viewWithTag:10086+2];
    UITextField *surePwd=[_tableView viewWithTag:10086+3];
    UITextField *verrifypwd=[_tableView viewWithTag:10086+1];
    if ([UITextView verifyPhone:phonepwd.text]&&pwd.text.length>5&&surePwd.text.length>5&&[UITextView verifyCodeMatch:verrifypwd.text])
    {
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [_sureBtn setTitleColor:LOGIN_BEFORE forState:UIControlStateNormal];
    }
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
