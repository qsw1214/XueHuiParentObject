//
//  XHStudentDetailViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/16.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHStudentDetailViewController.h"
#import "XHUserTableViewCell.h"
#import "XHPersonalCenterViewController.h"
#import "XHFamilyListViewController.h"
@interface XHStudentDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_titleArry;
}
@property (strong, nonatomic) IBOutlet XHBaseBtn *sureBtn;

@end

@implementation XHStudentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavtionTitle:@"学生信息列表"];
    _titleArry=@[@"头像",@"姓名",@"性别",@"年龄",@"学校",@"班级"];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    [_tableView registerClass:[XHUserTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 80;
    }
    else
    {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHUserTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.frontLabel.frame=CGRectMake(20, 0, 80, cell.bounds.size.height);
    cell.backLabel.frame=CGRectMake(100, 0, SCREEN_WIDTH-120, cell.bounds.size.height);
    cell.frontLabel.text=_titleArry[indexPath.row];
    cell.headBtn.frame=CGRectMake(SCREEN_WIDTH-80, 5, 70, 70);
    cell.headBtn.layer.cornerRadius=35;
    [cell.headBtn sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(self.listModel.headPic)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
    if (indexPath.row==0) {
        cell.headBtn.hidden=NO;
        cell.backLabel.hidden=YES;
    }
    else
    {
        cell.headBtn.hidden=YES;
        cell.backLabel.hidden=NO;
        switch (indexPath.row) {
            case 1:
                cell.backLabel.text=self.listModel.studentName;
                break;
            case 2:
                cell.backLabel.text=self.listModel.sexName;
                break;
            case 3:
                cell.backLabel.text=self.listModel.age;
                break;
            case 4:
                cell.backLabel.text=self.listModel.schoolName;
                break;
            case 5:
                cell.backLabel.text=self.listModel.clazzName;
                break;
                
            default:
                break;
        }
    }
    return cell;
}
- (IBAction)sureBtnClick:(id)sender {
   
    if ([self.listModel.familyId isEqualToString:@""]) {
        XHNetWorkConfig *net=[XHNetWorkConfig new];
        [net setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
        [XHShowHUD showTextHud];
        [net postWithUrl:@"zzjt-app-api_student005" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject) {
                NSArray *arr=[object objectItemKey:@"object"];
                if (arr.count==0) {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否为您创建新的家庭并绑定孩子？" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self makeNewFamily];
                    }]];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                    for ( NSDictionary *dic in arr) {
                        NSDictionary *Dic=[dic objectItemKey:@"propValue"];
                        if ([[Dic objectItemKey:@"isMajor"] integerValue]==1) {
                            XHFamilyListViewController *list=[XHFamilyListViewController new];
                            list.listModel=self.listModel;
                            [self.navigationController pushViewController:list animated:YES];
                            return ;
                        }
                    }
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择创建家庭" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"创建新家庭并绑定孩子" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self makeNewFamily];
                    }]];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"邀请孩子加入家长家庭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                         XHFamilyListViewController *list=[XHFamilyListViewController new];
                         list.listModel=self.listModel;
                         [self.navigationController pushViewController:list animated:YES];
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }
        } error:^(NSError *error) {
            
        }];
        
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该学生已经有主要监护人，您需要输入家庭密码加入该家庭，获取监护权" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.keyboardType=UIKeyboardTypeNumberPad;
        }];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.netWorkConfig setObject:self.listModel.familyId forKey:@"familyId"];
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"guardianId"];
            [self.netWorkConfig setObject:alertController.textFields.firstObject.text forKey:@"familyPassword"];
            [XHShowHUD showTextHud];
            [self.netWorkConfig postWithUrl:@"zzjt-app-api_student003" sucess:^(id object, BOOL verifyObject) {
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
}
-(void)makeNewFamily
{
    XHNetWorkConfig *net=[XHNetWorkConfig new];
    [net setObject:self.listModel.studentBaseId forKey:@"studentBaseId"];
    [net setObject:[XHUserInfo sharedUserInfo].telphoneNumber forKey:@"telphoneNumber"];
    [net setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianName forKey:@"guardianName"];
    [net setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
    [XHShowHUD showTextHud];
    [net postWithUrl:@"zzjt-app-api_student004" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            XHPersonalCenterViewController *person=self.navigationController.viewControllers[0];
            person.isRefresh(YES);
            [self.navigationController popToViewController:person animated:YES];
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
