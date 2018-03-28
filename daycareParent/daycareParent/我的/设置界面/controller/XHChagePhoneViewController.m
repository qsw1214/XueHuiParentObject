//
//  XHChagePhoneViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHChagePhoneViewController.h"
#import "XHLoginViewController.h"
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
}
@property(nonatomic,strong)BaseTableView *tableView;
@property(nonatomic,strong)XHBaseBtn *sureButton;
@end

@implementation XHChagePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   [self setNavtionTitle:@"修改手机号"];
    _currentS = 60;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.sureButton];
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
                    cell.tipLabel.frame=CGRectMake(20, 0, SCREEN_WIDTH-40, 40);
                    cell.tipLabel.text=@"提示，更换手机后，下次登录需使用新的手机号登录。";
                    cell.tipLabel.textColor=[UIColor orangeColor];
                    cell.tipLabel.font=kFont(13);
                    cell.lineLabel.frame=CGRectMake(0, 40-0.5, SCREEN_WIDTH, 0.5);
                    [cell.contentView addSubview:cell.lineLabel];
                }
                    break;
                    
                default:
                {
                    cell.tipLabel.frame=CGRectMake(20, 0, SCREEN_WIDTH-40, 50);
                    cell.tipLabel.text=kFormat(@"当前手机号：%@",[XHUserInfo sharedUserInfo].loginName);
                    cell.lineLabel.frame=CGRectMake(0, 50-0.5, SCREEN_WIDTH, 0.5);
                    [cell.contentView addSubview:cell.lineLabel];
                }
                    break;
            }
            
            return cell;
        }
            break;
            case 2:
        {
            XHChageTelephoneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.modelType=XHVerifyFoundType;
            [cell setItemObject:nil withIndexPathRow:indexPath.row];
          
            return cell;
        }
            break;
        default:
        {
            XHVerifyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"telephonecell" forIndexPath:indexPath];
            cell.modelType=XHVerifyFoundType;
            [cell setItemObject:nil withIndexPathRow:indexPath.row];
            [cell.verifyButton setTag:1];
            [cell.verifyButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;
    }
    
}

#pragma mark-----btnClickMethod
- (void)buttonClick:(UIButton *)button
{
    UITextField *phonepwd=[_tableView viewWithTag:10086];
    UITextField *verrifypwd=[_tableView viewWithTag:10086+1];
    switch (button.tag) {
        case 1:
        {
            
            if (![UITextView verifyPhone:phonepwd.text]) {
                [XHShowHUD showNOHud:@"请输入正确手机号!"];
                return;
            }
            if (_ifSelect==NO) {
                
                XHNetWorkConfig *net=[XHNetWorkConfig new];
                [net setObject:phonepwd.text forKey:@"telephoneNumber"];
                [net setObject:@"2" forKey:@"type"];
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
                    XHLoginViewController *login=[[XHLoginViewController alloc] init];
                    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
                    [kWindow setRootViewController:nav];
                }
            } error:^(NSError *error) {
                
            }];
        }
            break;
    }
    
}
#pragma mark-----开始倒计时
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

-(BaseTableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[XHChageTelephoneTableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[XHVerifyTableViewCell class] forCellReuseIdentifier:@"telephonecell"];
        [_tableView registerClass:[XHTipTableViewCell class] forCellReuseIdentifier:@"tipcell"];
    }
    return _tableView;
}
-(XHBaseBtn *)sureButton
{
    if (_sureButton==nil) {
        _sureButton=[[XHBaseBtn alloc] initWithFrame:CGRectMake(40, 220, SCREEN_WIDTH-80, 44)];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTag:2];
        [_sureButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
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
