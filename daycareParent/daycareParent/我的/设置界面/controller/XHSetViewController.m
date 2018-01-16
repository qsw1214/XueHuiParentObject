//
//  XHSetViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSetViewController.h"
#import "XHUserTableViewCell.h"
#import "XHPasswordViewController.h"
#import "XHChagePhoneViewController.h"
#import "XHAboutUsViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "XHLoginViewController.h"
#import "JPUSHService.h"
@interface XHSetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *arry;
    float fileSize;
}
@end

@implementation XHSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"设置"];
    arry=@[@"修改密码",@"更换安全电话",@"关于我们",@"当前版本",@"清除缓存"];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
     _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=50;
    [_tableView registerClass:[XHUserTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.bounces=NO;
    [self.view addSubview:_tableView];
    XHBaseBtn *btn=[[XHBaseBtn alloc] initWithFrame:CGRectMake(10, 340, SCREEN_WIDTH-20, 50)];
    btn.backgroundColor=[UIColor redColor];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logOutClick) forControlEvents:UIControlEventTouchUpInside];
     [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view  addSubview:btn];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    fileSize= (float)[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    [_tableView reloadData];
}
-(NSString *)DocumentsTruePath
{
    return  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}
#pragma mark----tableviewDelegate------



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        XHUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
       cell.frontLabel.frame=CGRectMake(10, 0, 120, cell.bounds.size.height);
        cell.backLabel.frame=CGRectMake(120, 0, SCREEN_WIDTH-150, cell.bounds.size.height);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.frontLabel.text=arry[indexPath.row];
    switch (indexPath.row) {
            case 3:
                cell.backLabel.text=CFBundleShortVersionString;
                break;
            case 4:
                cell.backLabel.text=[NSString stringWithFormat:@"清理缓存(%.2fM)",fileSize];
                break;
        }
        return cell;
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            XHPasswordViewController *password=[XHPasswordViewController new];
            [self.navigationController pushViewController:password animated:YES];
        }
            
            break;
            case 1:
        {
            XHChagePhoneViewController *chagephone=[XHChagePhoneViewController new];
            [self.navigationController pushViewController:chagephone animated:YES];
        }
            
            break;
            case 2:
        {
            XHAboutUsViewController *about=[XHAboutUsViewController new];
            [self.navigationController pushViewController:about animated:YES];
        }
            
            break;
        case 3:
        {
           // [self updateVersion];
            
        }
            
            break;
        case 4:
        {
            [XHShowHUD showTextHud];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [XHShowHUD showOKHud:@"清除完成!"];
                fileSize=0;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }];
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
        [[RCIM sharedRCIM]disconnect];
        [JPUSHService setTags:nil alias:nil fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
        }];
        [NSUserDefaults removeObjectItemForKey:AutoLogin];
        XHLoginViewController *login=[XHLoginViewController new];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
        [kWindow setRootViewController:nav];
       
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
/*
-(void)updateVersion
{
    XHNetWorkConfig *Net=[[XHNetWorkConfig alloc] init];
    [Net setObject:CFBundleShortVersionString forKey:@"localVersion"];////本地版本
    [Net setObject:@"ios" forKey:@"devType"];                                           //设备信息
    [Net setObject:@"1" forKey:@"appId"];//app的在iTunes的唯一标识符
    [Net postWithUrl:@"zzjt-app-api_appVersion001" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSDictionary *dic=[object objectItemKey:@"object"];
            //不需要升级
            if ([dic[@"isUpdate"] intValue]== 0) {
                [XHShowHUD showOKHud:@"当前已是最新版本！"];
                return;
            }
            //判断NSUserDefaults忽略版本跟version是否相同
            if ([[NSUserDefaults  objectItemForKey:hUMtypeVersion] isEqualToString:dic[@"topVersion"]]) {
                if ([dic[@"isUpdate"] intValue] != 2) {
                    return;
                }
            }
            //升级，可跳过升级
            if ([dic[@"isUpdate"] intValue]== 1) {
                NSString *introduceStr = [NSString stringWithFormat:@"%@版本 \n更新的内容有：%@",dic[@"topVersion"],dic[@"description"]];
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"发现新版本" message:introduceStr  preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"跳过此版本" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [NSUserDefaults setItemObject:dic[@"topVersion"] forKey:hUMtypeVersion];
                }];
                
                UIAlertAction *alertB = [UIAlertAction actionWithTitle:@"前往此版本" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"url"]]];
                        [NSUserDefaults  removeObjectItemForKey:hUMtypeVersion];
                    });
                    
                }];
                
                [alertC addAction:alertA];
                [alertC addAction:alertB];
                [self presentViewController:alertC animated:YES completion:nil];
                return;
            }
            //强制升级
            if ([dic[@"isUpdate"] intValue] == 2) {
                NSString *introduceStr = [NSString stringWithFormat:@"新版本更新的内容有：%@",dic[@"description"]];
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"版本更新" message:introduceStr  preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"前往App Store" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [NSUserDefaults  removeObjectItemForKey:hUMtypeVersion];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"url"]]];
                    });
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                return;
            }
        }
    } error:^(NSError *error) {
        
    }];
}
*/
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
