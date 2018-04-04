//
//  XHSetViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSetViewController.h"
#import "XHUserTableViewCell.h"
#import "XHChagePhoneViewController.h"
#import "XHAboutUsViewController.h"
#import <RongIMLib/RongIMLib.h>
#import "XHLoginViewController.h"
#import "JPUSHService.h"
#import "XHSystemModel.h"

@interface XHSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)  UIButton *outButton;
@property(nonatomic,assign) float fileSize;
@end

@implementation XHSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"设置"];
    [self.view addSubview:self.tableView];
    [self.tableView  addSubview:self.outButton];
    [self.outButton addTarget:self action:@selector(logOutClick) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark----tableviewDelegate------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kTitle.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.modelType=XHUserTableViewCellSetType;
    [cell setItemObject:nil withIndexPathRow:indexPath.row];
    if (indexPath.row==2)
    {
        cell.backLabel.text=[NSString stringWithFormat:@"清理缓存(%.2fM)",self.fileSize];
    }
    return cell;
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            case 0:
        {
            XHChagePhoneViewController *chagephone=[XHChagePhoneViewController new];
            [self.navigationController pushViewController:chagephone animated:YES];
        }
            break;
           case 1:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
            break;
        case 2:
        {
            [XHShowHUD showTextHud];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [XHShowHUD showOKHud:@"清除完成!"];
                self.fileSize=0;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                });
            }];
        }
            break;
            case 3:
        {
            XHAboutUsViewController *about=[XHAboutUsViewController new];
            [self.navigationController pushViewController:about animated:YES];
        }
            
            break;
        
    }
    
    
}

-(void)logOutClick
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要退出登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        XHNetWorkConfig *net=[XHNetWorkConfig new];
        [net setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
        [net postWithUrl:@"zzjt-app-api_logOut" sucess:^(id object, BOOL verifyObject) {
             [XHShowHUD hideHud];
            if (verifyObject) {
            }
        } error:^(NSError *error) {
             [XHShowHUD hideHud];
        }];
        [[RCIMClient sharedRCIMClient] disconnect:YES];
        [JPUSHService setTags:nil alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){}];
        [NSUserDefaults removeObjectItemForKey:AutoLogin];
        XHLoginViewController *login=[XHLoginViewController new];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
        [kWindow setRootViewController:nav];
       
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.fileSize= (float)[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    [self.tableView reloadData];
}
-(NSString *)DocumentsTruePath
{
    return  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}
-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0,self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom) style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.rowHeight=50;
        [_tableView registerClass:[XHUserTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
-(UIButton *)outButton
{
    if (_outButton==nil) {
       _outButton=[[UIButton alloc] initWithFrame:CGRectMake(40, 280, SCREEN_WIDTH-80, 44)];
        _outButton.backgroundColor=MainColor;
        [_outButton setTitle:@"退出" forState:UIControlStateNormal];
        [_outButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _outButton.layer.cornerRadius=CORNER_BTN;
        _outButton.layer.masksToBounds=YES;
    }
    return _outButton;
    
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
