//
//  XHFamilyListViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/16.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHFamilyListViewController.h"
#import "XHUserTableViewCell.h"
#import "XHFamilyListModel.h"
#import "XHPersonalCenterViewController.h"
@interface XHFamilyListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation XHFamilyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"我的家庭列表"];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=50;
    [_tableView registerClass:[XHUserTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.bounces=NO;
    [self.view addSubview:_tableView];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
    [XHShowHUD showTextHud];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_student005" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSArray *arry=[object objectItemKey:@"object"];
            for (NSDictionary *dicc in arry) {
                NSDictionary *dic=[dicc objectItemKey:@"propValue"];
                XHFamilyListModel *model=[[XHFamilyListModel alloc] initWithDic:dic];
                [self.dataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
    } error:^(NSError *error) {
        [_tableView reloadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    XHFamilyListModel *model=self.dataArray[indexPath.row];
    cell.headBtn.frame=CGRectMake(10, 10, 30, 30);
    cell.headBtn.layer.cornerRadius=0;
    [cell.headBtn setBackgroundImage:[UIImage imageNamed:@"pxfamily"] forState:UIControlStateNormal];
    cell.frontLabel.frame=CGRectMake(60, 0, 120, cell.bounds.size.height);
    cell.frontLabel.text=model.nickName;
    cell.famman.frame=CGRectMake(SCREEN_WIDTH-45, 17, 16, 16);
    if ([model.isMajor integerValue]==1) {
        cell.famman.hidden=NO;
    }
    else
    {
         cell.famman.hidden=YES;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认将学生加入该家庭" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.netWorkConfig setObject:self.listModel.studentBaseId forKey:@"studentBaseId"];
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].guardianModel.familyId forKey:@"familyId"];
        [XHShowHUD showTextHud];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_student002" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject) {
                XHPersonalCenterViewController *person=self.navigationController.viewControllers[0];
                person.isRefresh(YES);
                [self.navigationController popToViewController:person animated:YES];
            }
        } error:^(NSError *error) {
            
        }];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
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
