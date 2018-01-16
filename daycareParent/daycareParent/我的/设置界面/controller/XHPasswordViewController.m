//
//  XHPasswordViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHPasswordViewController.h"
#import "XHPassWordTableViewCell.h"
#import "XHLoginViewController.h"
@interface XHPasswordViewController()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *frontArry;
    NSArray *placeArry;
}
@end

@implementation XHPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavtionTitle:@"修改密码"];
    frontArry=@[@"旧密码",@"新密码",@"新密码"];
    placeArry=@[@"请输入旧密码",@"请输入新密码",@"请确认新密码"];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    _tableView.rowHeight=LOGINBTN_HEIGHT;
    [_tableView registerNib:[UINib nibWithNibName:@"XHPassWordTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHPassWordTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLb.text=frontArry[indexPath.row];
    cell.textFD.tag=indexPath.row+10086;
    cell.textFD.secureTextEntry=YES;
    [cell.textFD addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
    cell.textFD.placeholder=placeArry[indexPath.row];
    return cell;
}
- (IBAction)sureBtnClick:(id)sender {
    UITextField *oldpwd=[_tableView viewWithTag:10086];
    UITextField *newpwd=[_tableView viewWithTag:10086+1];
    UITextField *surepwd=[_tableView viewWithTag:10086+2];
    if ([oldpwd.text length]<6||[newpwd.text length]<6||[surepwd.text length]<6)
    {
        [XHShowHUD showNOHud:@"密码至少6位!"];
        return;
    }
    if (![newpwd.text isEqualToString:surepwd.text])
    {
        [XHShowHUD showNOHud:@"确认密码不符!"];
        return;
    }
    XHNetWorkConfig *net=[XHNetWorkConfig new];
    [net setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
    [net setObject:oldpwd.text forKey:@"oldPwd"];
    [net setObject:newpwd.text forKey:@"newPwd"];
    [net setObject:surepwd.text forKey:@"confirmPwd"];
    [XHShowHUD showTextHud];
    [net postWithUrl:@"zzjt-app-api_personalCenter001" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:AutoLogin];
            XHLoginViewController *login=[XHLoginViewController new];
            [self.navigationController pushViewController:login animated:YES];
        }
    } error:^(NSError *error) {
        
    }];
}
-(void)textChage
{
    UITextField *oldpwd=[_tableView viewWithTag:10086];
    UITextField *newpwd=[_tableView viewWithTag:10086+1];
    UITextField *surepwd=[_tableView viewWithTag:10086+2];
    if (oldpwd.text.length>5&&newpwd.text.length>5&&surepwd.text.length>5)
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
