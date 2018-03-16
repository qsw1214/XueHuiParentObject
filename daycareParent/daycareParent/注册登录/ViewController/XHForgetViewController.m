//
//  XHForgetViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHForgetViewController.h"
#import "XHChageTelephoneTableViewCell.h"
#import "XHVerifyTableViewCell.h"
#define countDownStr(s) [NSString stringWithFormat:@"%ld秒后重发",s]
#define reviewTitle @"重新发送"
#define kPlaceTitle @[@"请输入手机号",@"请输入验证码",@"请输入新密码（6-20位英文、数字组合）"]
@interface XHForgetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger  _currentS;
    NSTimer *_timer;
    BOOL _ifSelect;
}
@property(nonatomic,strong)BaseTableView *tableView;
@property(nonatomic,strong)XHBaseBtn *sureButton;
@end

@implementation XHForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"忘记密码"];
    _currentS = 60;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.sureButton];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kPlaceTitle.count;
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        XHVerifyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"telephonecell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.chageTelePhoneTextField.placeholder=@"请输入验证码";
        cell.chageTelePhoneTextField.keyboardType=UIKeyboardTypeNumberPad;
        cell.chageTelePhoneTextField.tag=1+10086;
        [cell.chageTelePhoneTextField addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
        cell.verifyButton.backgroundColor=RGB(245, 245, 245);
        [cell.verifyButton setTitleColor:RGB(82, 82, 82) forState:UIControlStateNormal];
        cell.verifyButton.titleLabel.font=FontLevel3;
        cell.verifyButton.layer.cornerRadius=CORNER_BTN;
        [cell.verifyButton setTag:1];
        [cell.verifyButton addTarget:self action:@selector(BnttonClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        XHChageTelephoneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.chageTelePhoneTextField.placeholder=kPlaceTitle[indexPath.row];
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
- (void)BnttonClick:(UIButton *)btn
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
            break;
            
        case 2:
        {
           
            if (![UITextView verifyPhone:phonepwd.text]) {
                [XHShowHUD showNOHud:@"请输入正确手机号!"];
                return;
            }
            if (pwd.text.length<6) {
                [XHShowHUD showNOHud:@"密码至少6位!"];
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
            break;
    }
    
}
//开始倒计时
- (void)startCountdown
{
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    //找到对应的cell
    XHVerifyTableViewCell *Cell = [_tableView cellForRowAtIndexPath:indexPath];
    [Cell.verifyButton setTitle:countDownStr(_currentS) forState:UIControlStateNormal];
    _currentS--;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(timer) userInfo:nil repeats:YES];
}

- (void)timer
{
    _ifSelect=YES;
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
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
        [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [self.sureButton setTitleColor:LOGIN_BEFORE forState:UIControlStateNormal];
    }
}
-(BaseTableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.rowHeight=50;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[XHChageTelephoneTableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[XHVerifyTableViewCell class] forCellReuseIdentifier:@"telephonecell"];
    }
    return _tableView;
}
-(XHBaseBtn *)sureButton
{
    if (_sureButton==nil) {
        _sureButton=[[XHBaseBtn alloc] initWithFrame:CGRectMake(10, 180, SCREEN_WIDTH-20, LOGINBTN_HEIGHT)];
        [_sureButton setTitle:@"完成" forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(BnttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_sureButton setTag:2];
    }
    return _sureButton;
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
