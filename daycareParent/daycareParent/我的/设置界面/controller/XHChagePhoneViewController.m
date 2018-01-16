//
//  XHChagePhoneViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHChagePhoneViewController.h"
#import "XHChagePhoneTableViewCell.h"
#import "XHTelephoneTableViewCell.h"
#import "XHScuessViewController.h"
#define countDownStr(s) [NSString stringWithFormat:@"%ld秒后重发",s]
#define reviewTitle @"重新发送"
@interface XHChagePhoneViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arry;
    NSArray *placeArry;
    NSInteger  _currentS;
    NSTimer *_timer;
    BOOL _ifSelect;
    NSInteger _count;
}
@end

@implementation XHChagePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   [self setNavtionTitle:@"更改安全电话"];
    _currentS = 60;
    arry=@[@"手机号",@"密码"];
    placeArry=@[@"请输入新手机号",@"请输入登录密码"];
    _tableView.rowHeight=50;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    [_tableView registerNib:[UINib nibWithNibName:@"XHChagePhoneTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHTelephoneTableViewCell" bundle:nil] forCellReuseIdentifier:@"telephonecell"];
    XHNetWorkConfig *Net=[XHNetWorkConfig new];
    [Net setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
    [Net postWithUrl:@"zzjt-app-api_personalCenter004" sucess:^(id object, BOOL verifyObject) {
    if (verifyObject) {
             self.warnLabel.font=FontLevel3;
             self.warnLabel.textColor=RGB(237, 135, 57);
            _count=[[[object objectItemKey:@"object"] objectItemKey:@"remainingTimes"] integerValue];
            self.warnLabel.text=[NSString stringWithFormat:@"请输入您需要绑定的手机号\n当日限制操作3次，还剩下%ld次机会，请谨慎操作",_count];
        }
        
    } error:^(NSError *error) {
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        XHChagePhoneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text=@"验证码";
        cell.textFD.placeholder=@"请输入验证码";
        cell.textFD.keyboardType=UIKeyboardTypeNumberPad;
        cell.textFD.tag=2+10086;
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
    if (_count==0) {
        self.warnLabel.text=@"您的当日限制次数已经用完\n请明日再来吧";
        return ;
    }
    if (_ifSelect==NO) {
       
            XHNetWorkConfig *net=[XHNetWorkConfig new];
            [net setObject:phonepwd.text forKey:@"telephoneNumber"];
            [net setObject:@"2" forKey:@"type"];
            [XHShowHUD showTextHud];
            [net postWithUrl:@"zzjt-app-api_personalCenter000" sucess:^(id object, BOOL verifyObject) {
                    if (verifyObject) {
                        [self startCountdown];
                        _count--;
                        self.warnLabel.text=[NSString stringWithFormat:@"请输入您需要绑定的手机号\n当日限制操作3次，还剩下%ld次机会，请谨慎操作",_count];
                    }
                    
                } error:^(NSError *error) {
                }];
    }
   
}
//开始倒计时
- (void)startCountdown
{
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    //找到对应的cell
    XHChagePhoneTableViewCell *Cell = [_tableView cellForRowAtIndexPath:indexPath];
    [Cell.verifyBtn setTitle:countDownStr(_currentS) forState:UIControlStateNormal];
    _currentS--;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(timer) userInfo:nil repeats:YES];
}

- (void)timer
{
    _ifSelect=YES;
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
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
- (IBAction)sureBtnClick:(id)sender {
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    UITextField *pwd=[_tableView viewWithTag:10086+1];
    UITextField *verrifypwd=[_tableView viewWithTag:10086+2];
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
    [net setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
     [net setObject:phonepwd.text forKey:@"newLoginName"];
     [net setObject:pwd.text forKey:@"password"];
    [net setObject:verrifypwd.text forKey:@"code"];
    [XHShowHUD showTextHud];
    [net postWithUrl:@"zzjt-app-api_personalCenter002" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            XHScuessViewController *success=[XHScuessViewController new];
            success.telephoneStr=phonepwd.text;
            [self.navigationController pushViewController:success animated:YES];
        }
    } error:^(NSError *error) {
        
    }];
 
}
-(void)textChage
{
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    UITextField *pwd=[_tableView viewWithTag:10086+1];
    UITextField *verrifypwd=[_tableView viewWithTag:10086+2];
    if ([UITextView verifyPhone:phonepwd.text]&&pwd.text.length>5&&[UITextView verifyCodeMatch:verrifypwd.text])
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
