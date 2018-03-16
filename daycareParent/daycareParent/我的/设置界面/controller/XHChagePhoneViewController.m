//
//  XHChagePhoneViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHChagePhoneViewController.h"
//#import "XHChagePhoneTableViewCell.h"
//#import "XHTelephoneTableViewCell.h"
#import "XHScuessViewController.h"
#import "XHChageTelephoneTableViewCell.h"
#import "XHVerifyTableViewCell.h"
#import "XHTipTableViewCell.h"
#define countDownStr(s) [NSString stringWithFormat:@"%ld秒后重发",s]
#define reviewTitle @"重新发送"
@interface XHChagePhoneViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger  _currentS;
    NSTimer *_timer;
    BOOL _ifSelect;
    NSInteger _count;
}
@property(nonatomic,strong)BaseTableView *tableView;
@property(nonatomic,strong)UIButton *sureButton;
@end

@implementation XHChagePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   [self setNavtionTitle:@"修改手机号"];
    _currentS = 60;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.sureButton];
//    XHNetWorkConfig *Net=[XHNetWorkConfig new];
//    [Net setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
//    [Net postWithUrl:@"zzjt-app-api_personalCenter004" sucess:^(id object, BOOL verifyObject) {
//    if (verifyObject) {
//             self.warnLabel.font=FontLevel3;
//             self.warnLabel.textColor=RGB(237, 135, 57);
//            _count=[[[object objectItemKey:@"object"] objectItemKey:@"remainingTimes"] integerValue];
//            self.warnLabel.text=[NSString stringWithFormat:@"请输入您需要绑定的手机号\n当日限制操作3次，还剩下%ld次机会，请谨慎操作",_count];
//        }
//
//    } error:^(NSError *error) {
//    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return 40;
        }
            break;
            
        default:
        {
            return 50;
        }
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        case 1:
        {
            XHTipTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"tipcell" forIndexPath:indexPath];
            switch (indexPath.row) {
                case 0:
                {
                    cell.tipLabel.text=@"提示，更换手机后，下次登录需使用新的手机号登录。";
                    cell.tipLabel.textColor=[UIColor orangeColor];
                    cell.tipLabel.font=kFont(13);
                }
                    break;
                    
                default:
                {
                    cell.tipLabel.text=@"当前手机号：13500000012";
                }
                    break;
            }
            
            return cell;
        }
            break;
            case 2:
        {
            XHChageTelephoneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.chageTelePhoneTextField addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
            return cell;
        }
            break;
        default:
        {
            XHVerifyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"telephonecell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.chageTelePhoneTextField addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
            [cell.verifyButton addTarget:self action:@selector(verifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;
    }
    
}
#pragma mark-----verifyButtonClickMethod
-(void)verifyBtnClick
{
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    if (![UITextView verifyPhone:phonepwd.text]) {
        [XHShowHUD showNOHud:@"请输入正确手机号!"];
        return;
    }
    if (_count==0) {
        //self.warnLabel.text=@"您的当日限制次数已经用完\n请明日再来吧";
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
                       // self.warnLabel.text=[NSString stringWithFormat:@"请输入您需要绑定的手机号\n当日限制操作3次，还剩下%ld次机会，请谨慎操作",_count];
                    }
                    
                } error:^(NSError *error) {
                }];
    }
   
}

#pragma mark-----sureBtnClickMethod
- (void)sureBtnClick:(UIButton *)button
{
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    UITextField *verrifypwd=[_tableView viewWithTag:10086+1];
    if (![UITextView verifyPhone:phonepwd.text]) {
        [XHShowHUD showNOHud:@"请输入正确手机号!"];
        return;
    }
    if (![UITextView verifyCodeMatch:verrifypwd.text]) {
        [XHShowHUD showNOHud:@"请输入正确的验证码!"];
        return;
    }
    XHNetWorkConfig *net=[XHNetWorkConfig new];
    [net setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
     [net setObject:phonepwd.text forKey:@"newLoginName"];
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
#pragma mark-----开始倒计时
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
#pragma mark-----textfeildChangeMethod
-(void)textChage
{
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    UITextField *verrifypwd=[_tableView viewWithTag:10086+1];
    if ([UITextView verifyPhone:phonepwd.text]&&[UITextView verifyCodeMatch:verrifypwd.text])
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
        _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom) style:UITableViewStyleGrouped];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[XHChageTelephoneTableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[XHVerifyTableViewCell class] forCellReuseIdentifier:@"telephonecell"];
        [_tableView registerClass:[XHTipTableViewCell class] forCellReuseIdentifier:@"tipcell"];
    }
    return _tableView;
}
-(UIButton *)sureButton
{
    if (_sureButton==nil) {
        _sureButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 220, SCREEN_WIDTH-20, 50)];
        [_sureButton setBackgroundColor:MainColor];
        [_sureButton setTitleColor:LOGIN_BEFORE forState:UIControlStateNormal];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        _sureButton.layer.cornerRadius=CORNER_BTN;
        [_sureButton addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
