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
#import <RongIMKit/RongIMKit.h>
#import "XHLoginViewController.h"
#import "JPUSHService.h"
#import "XHSystemModel.h"
#define kTitle @[@"修改手机号",@"开启消息推送",@"清除缓存",@"关于我们",@"版本更新"]
@interface XHSetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float fileSize;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)  UIButton *outButton;
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
       cell.frontLabel.frame=CGRectMake(10, (cell.bounds.size.height-40)/2.0, 120, 40);
        cell.backLabel.frame=CGRectMake(120, (cell.bounds.size.height-40)/2.0, SCREEN_WIDTH-150, 40);
        cell.frontLabel.text=kTitle[indexPath.row];
    cell.headBtn.frame=CGRectMake(SCREEN_WIDTH-60, (cell.bounds.size.height-30)/2.0, 50, 30);
    cell.headBtn.layer.cornerRadius=0;
    BOOL select =[self noticeJupsh];
    if (!select)
    {
          [cell.headBtn setBackgroundImage:[UIImage imageNamed:@"ico_set_close"] forState:UIControlStateNormal];
    }
    else
    {
          [cell.headBtn setBackgroundImage:[UIImage imageNamed:@"ico_set_open"] forState:UIControlStateNormal];
    }
        if (indexPath.row==1)
        {
            cell.headBtn.hidden=NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else
        {
            cell.headBtn.hidden=YES;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row==2)
            {
                cell.backLabel.text=[NSString stringWithFormat:@"清理缓存(%.2fM)",fileSize];
            }
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
                fileSize=0;
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
        case 4:
        {
            [self updateVersion];
            
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
    fileSize= (float)[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    [self.tableView reloadData];
}
-(NSString *)DocumentsTruePath
{
    return  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}
-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom) style:UITableViewStyleGrouped];
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
        _outButton.backgroundColor=[UIColor redColor];
        [_outButton setTitle:@"退出" forState:UIControlStateNormal];
        [_outButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _outButton.layer.cornerRadius=CORNER_BTN;
        _outButton.layer.masksToBounds=YES;
    }
    return _outButton;
    
}
-(BOOL)noticeJupsh
{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0f) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            NSLog(@"推送关闭");
            return NO;
        }else{
            NSLog(@"推送打开");
            return YES;
        }
    }else
    {
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone == type)
        {
            NSLog(@"推送关闭");
            return NO;
        }else{
            NSLog(@"推送打开");
            return YES;
        }
    }
}
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
                kNSLog(dic[@"url"]);
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
