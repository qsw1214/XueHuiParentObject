//
//  XHStudentInfoViewController.m
//  daycareParent
//
//  Created by mac on 2017/12/2.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHStudentInfoViewController.h"
#import "XHUserTableViewCell.h"
#import "XHCustomPickerView.h"
#import "XHFamilyModel.h"
@interface XHStudentInfoViewController ()<UITableViewDelegate,UITableViewDataSource,XHCustomPickerViewDelegate>
{
    NSArray *studentInfoArry;
    NSArray *familyArry;
    NSMutableArray *_familyArry;
    XHFamilyModel *_selfModel;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) XHCustomPickerView *customPickerViewerView;
@end

@implementation XHStudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavtionTitle:self.model.studentName];
    studentInfoArry=@[@"头像",@"姓名",@"性别",@"所在学校",@"所在班级"];
    _familyArry=[NSMutableArray array];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
   [_tableView registerClass:[XHUserTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.bounces=NO;
    [self.view addSubview:_tableView];
    [self.netWorkConfig setObject:self.model.familyId forKey:@"familyId"];
    [XHShowHUD showTextHud];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_student006" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSDictionary *dic=[object objectItemKey:@"object"];
            for (NSDictionary *Dic in dic) {
                XHFamilyModel *model=[[XHFamilyModel alloc] initWithDic:Dic];
                if (![[XHUserInfo sharedUserInfo].guardianModel.guardianId isEqualToString:model.guardianId])
                {
                    [_familyArry addObject:model];
                }
                else
                {
                    _selfModel=model;
                }
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
    } error:^(NSError *error) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_selfModel.isMajor integerValue]==1) {
        return 4;
    }
    else
    {
        return 3;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 5;
    }
    if (section==2) {
        return _familyArry.count+1;
    }
    else
    {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    else
    {
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return USER_HEARD+20;
    }
    if (indexPath.section==2&&indexPath.row==0) {
        return 40;
    }
    else
    {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    XHUserTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.frontLabel.frame=CGRectMake(10, 0, (SCREEN_WIDTH-40)/2, cell.bounds.size.height);
    cell.backLabel.frame=CGRectMake(10+(SCREEN_WIDTH-40)/2, 0, (SCREEN_WIDTH-40)/2, cell.bounds.size.height);
    cell.famman.frame=CGRectMake(SCREEN_WIDTH-80, 17, 16, 16);

    cell.headBtn.frame=CGRectMake(SCREEN_WIDTH-USER_HEARD-30, 10, USER_HEARD, USER_HEARD);
    [cell.headBtn sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(self.model.headPic)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
    if (indexPath.section==0) {
         cell.famman.hidden=YES;
        cell.frontLabel.text=studentInfoArry[indexPath.row];
        if (indexPath.row==1) {
            cell.backLabel.text=self.model.studentName;
        }
        if (indexPath.row==2) {
            cell.backLabel.text=self.model.sexName;
        }
        if (indexPath.row==3) {
            cell.backLabel.text=self.model.schoolName;
        }
        if (indexPath.row==4) {
            cell.backLabel.text=self.model.clazzName;
        }
         cell.accessoryType=UITableViewCellAccessoryNone;
    }
    if (indexPath.section==1) {
        cell.frontLabel.text=@"我与孩子的关系";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.backLabel.text=_selfModel.typeName;
        if ([_selfModel.isMajor integerValue]==1) {
            cell.famman.hidden=NO;
        }
        else
        {
            cell.famman.hidden=YES;
        }
    }
    if (indexPath.section==2) {
        cell.frontLabel.text=@"其他成员关系";
        if (indexPath.row==0) {
             cell.famman.hidden=YES;
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        else
        {
             XHFamilyModel *model=_familyArry[indexPath.row-1];
             cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.backLabel.text=model.typeName;
            cell.frontLabel.text=model.guardianName;
            if ([model.isMajor integerValue]==1) {
                cell.famman.hidden=NO;
            }
            else
            {
                cell.famman.hidden=YES;
            }
        }
       
    }
    if (indexPath.section==3) {
        cell.frontLabel.text=@"解除绑定孩子";
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.famman.hidden=YES;
    }
//    if (indexPath.section==4) {
//        cell.frontLabel.text=@"解散该家庭成员";
//        cell.accessoryType=UITableViewCellAccessoryNone;
//    }
    if (indexPath.section==3||indexPath.section==4) {
        cell.backLabel.hidden=YES;
        cell.headBtn.hidden=YES;
    }
    else
    {
        if (indexPath.row==0&&indexPath.section==0) {
            cell.backLabel.hidden=YES;
            cell.headBtn.hidden=NO;
        }
        else
        {
            cell.backLabel.hidden=NO;
            cell.headBtn.hidden=YES;
        }
       
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
    [self.view addSubview:self.customPickerViewerView];
    }
    if (indexPath.section==2&&indexPath.row!=0 ) {
        if ([_selfModel.isMajor integerValue]==1)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定要删除该监护人？" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                XHFamilyModel *model=_familyArry[indexPath.row-1];
                [self.netWorkConfig setObject:self.model.familyId forKey:@"familyId"];
                [self.netWorkConfig setObject:model.guardianId forKey:@"guardianId"];
                [XHShowHUD showTextHud];
                [self.netWorkConfig postWithUrl:@"zzjt-app-api_student010" sucess:^(id object, BOOL verifyObject) {
                    if (verifyObject) {
                        [_familyArry removeObject:model];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //一个section刷新
                            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                            [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                        });
                    }
                    
                } error:^(NSError *error) {
                    
                }];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"只有孩子的主监护人才能解绑其他成员关系！" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
       
    }
    if (indexPath.section==3) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定解除绑定该孩子？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
//            if ([_selfModel.isMajor integerValue]==1)
//            {
                //主监护人解绑孩子
                [self.netWorkConfig setObject:self.model.studentBaseId forKey:@"studentBaseId"];
                [XHShowHUD showTextHud];
                [self.netWorkConfig postWithUrl:@"zzjt-app-api_student008" sucess:^(id object, BOOL verifyObject) {
                    if (verifyObject) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.isRefresh(YES);
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    }
                } error:^(NSError *error) {
                    
                }];
//            }
//            else
//            {
//                [self.netWorkConfig setObject:_selfModel.familyId forKey:@"familyId"];
//                [self.netWorkConfig setObject:_selfModel.guardianId forKey:@"guardianId"];
//                [XHShowHUD showTextHud];
//                [self.netWorkConfig postWithUrl:@"zzjt-app-api_student010" sucess:^(id object, BOOL verifyObject) {
//                    if (verifyObject) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            self.isRefresh(YES);
//                           [self.navigationController popViewControllerAnimated:YES];
//                        });
//                    }
//
//                } error:^(NSError *error) {
//
//                }];
//            }
//
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
//    if (indexPath.section==4) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定解散该家庭？" preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        }]];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            XHNetWorkConfig *net=[XHNetWorkConfig new];
//            [net setObject:self.model.familyId forKey:@"familyId"];
//            [net postWithUrl:@"zzjt-app-api_student009" sucess:^(id object, BOOL verifyObject) {
//                if (verifyObject) {
//                    self.isRefresh(YES);
//                [self.navigationController popViewControllerAnimated:YES];
//                }
//            } error:^(NSError *error) {
//
//            }];
//        }]];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
}
-(XHCustomPickerView *)customPickerViewerView
{
    if (_customPickerViewerView==nil) {
        _customPickerViewerView=[[XHCustomPickerView alloc] initWithFrame:WindowScreen];
        _customPickerViewerView.delegate=self;
    }
    [self.view addSubview:_customPickerViewerView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _customPickerViewerView.view.frame=CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220);
    [UIView commitAnimations];
    return _customPickerViewerView;
}
#pragma mark-----------选择家属后回调代理方法----------
-(void)getFamily:(NSInteger)familyIndex
{
        [self.netWorkConfig setObject:_selfModel.ID forKey:@"id"];
        [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",familyIndex+1] forKey:@"type"];
        [XHShowHUD showTextHud];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_student007" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject) {
                NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
                //找到对应的cell
                XHUserTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
                cell.backLabel.text=FAMILY_TIES[familyIndex];
                 [XHUserInfo sharedUserInfo].guardianModel.type=[NSString stringWithFormat:@"%zd",familyIndex+1];
                [XHUserInfo sharedUserInfo].guardianModel.typeName=FAMILY_TIES[familyIndex];
            }
        } error:^(NSError *error) {
            
        }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
