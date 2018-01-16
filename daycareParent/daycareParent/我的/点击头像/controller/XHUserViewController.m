//
//  XHUserViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHUserViewController.h"
#import "XHUserTableViewCell.h"
#import "XHHelper.h"
#import "CameraManageViewController.h"
@interface XHUserViewController ()<UITableViewDelegate,UITableViewDataSource,CameraManageDeletage>
{
    UITableView *_tableView;
    NSArray *_titleArry;
}

@end

@implementation XHUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"个人信息"];
    [self setNavtionTitleColor:[UIColor whiteColor]];
    _titleArry=@[@"头像",@"昵称",@"性别",@"真实姓名",@"联系电话"];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerClass:[XHUserTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.bounces=NO;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHUserTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    XHUserInfo *userInfo=[XHUserInfo sharedUserInfo];
    cell.frontLabel.frame=CGRectMake(10, 0, 80, cell.bounds.size.height);
    cell.backLabel.frame=CGRectMake(90, 0, SCREEN_WIDTH-120, cell.bounds.size.height);
    cell.frontLabel.text=_titleArry[indexPath.row];
    cell.headBtn.frame=CGRectMake(SCREEN_WIDTH-USER_HEARD-30, 10, USER_HEARD, USER_HEARD);
    [cell.headBtn sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(userInfo.headPic)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
    if (indexPath.row==0) {
        cell.headBtn.hidden=NO;
        cell.backLabel.hidden=YES;
    }
    else
    {
          cell.headBtn.hidden=YES;
         cell.backLabel.hidden=NO;
        if (indexPath.row==1) {
            cell.backLabel.text=userInfo.nickName;
        }
        if (indexPath.row==2) {
            cell.backLabel.text=userInfo.sexName;
        }
        if (indexPath.row==3) {
            cell.backLabel.text=userInfo.guardianModel.guardianName;
        }
        if (indexPath.row==4) {
            cell.backLabel.text=userInfo.telphoneNumber;
        }
    }
    [cell.headBtn addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [self openImagePiker];
    }
    if (indexPath.row==1) {
        [self showAlertViewWithTitle:@"请输入昵称" Index:indexPath.row];
    }
    if (indexPath.row==2) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
            [self.netWorkConfig setObject:@"1" forKey:@"sex"];
            [self.netWorkConfig postWithUrl:@"zzjt-app-api_user004" sucess:^(id object, BOOL verifyObject) {
                if (verifyObject) {
                    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                    XHUserTableViewCell *nextCell = [tableView cellForRowAtIndexPath:indexPath];
                    nextCell.backLabel.text=@"男";
                    [XHUserInfo sharedUserInfo].sex=@"1";
                    [XHUserInfo sharedUserInfo].sexName=@"男";
                    self.isRefresh(YES);
                }
            } error:^(NSError *error) {
                
            }];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
            [self.netWorkConfig setObject:@"0" forKey:@"sex"];
            [self.netWorkConfig postWithUrl:@"zzjt-app-api_user004" sucess:^(id object, BOOL verifyObject) {
                if (verifyObject) {
                    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
                    XHUserTableViewCell *nextCell = [tableView cellForRowAtIndexPath:indexPath];
                    nextCell.backLabel.text=@"女";
                    [XHUserInfo sharedUserInfo].sex=@"0";
                    [XHUserInfo sharedUserInfo].sexName=@"女";
                    self.isRefresh(YES);
                }
            } error:^(NSError *error) {
                
            }];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    if (indexPath.row==3) {
        [self showAlertViewWithTitle:@"请输入真实姓名" Index:indexPath.row];
    }
    if (indexPath.row==4) {
        [self showAlertViewWithTitle:@"请输入联系电话" Index:indexPath.row];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return USER_HEARD+20;
    }
    else
    {
        return USER_HEARD-10;
    }
}
#pragma mark-------修改头像
-(void)headClick
{
    [self openImagePiker];
    
    
}
-(void)showAlertViewWithTitle:(NSString *)title Index:(NSInteger)index
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        if (index==4) {
            textField.keyboardType=UIKeyboardTypeNumberPad;
        }
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *feild=[alertController.textFields firstObject];
        if (![UITextView verifyPhone:feild.text]&&index==4)
        {
            [XHShowHUD showNOHud:@"请输入正确的手机号格式!"];
            return ;
        }
        if (feild.text.length==0)
        {
            [XHShowHUD showNOHud:@"请输入内容!"];
            return ;
        }
        if (feild.text.length>4&&index==3)
        {
            [XHShowHUD showNOHud:@"姓名最多为四个字!"];
            return ;
        }
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
        if (index==1) {
            [self.netWorkConfig setObject:feild.text forKey:@"nickName"];
        }
        if (index==3) {
            [self.netWorkConfig setObject:feild.text forKey:@"guardianName"];
        
        }
        if (index==4) {
            [self.netWorkConfig setObject:feild.text forKey:@"telphoneNumber"];
        }
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_user004" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject) {
                NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                //找到对应的cell
                XHUserTableViewCell *nextCell = [_tableView cellForRowAtIndexPath:indexPath];
                nextCell.backLabel.text=feild.text;
                NSDictionary *dic=[object objectItemKey:@"object"];
                [XHUserInfo sharedUserInfo].nickName=[dic objectItemKey:@"nickName"];
                 [XHUserInfo sharedUserInfo].guardianModel.guardianName=[dic objectItemKey:@"guardianName"];
                 [XHUserInfo sharedUserInfo].telphoneNumber=[dic objectItemKey:@"telphoneNumber"];
                 self.isRefresh(YES);
            }
        } error:^(NSError *error) {
            
        }];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)openImagePiker
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"选择相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeCamera setDeletate:self];
        [self.navigationController presentViewController:manager animated:YES completion:nil];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"选择相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeHeadPortraitSavedPhotosAlbum setDeletate:self];
        [self.navigationController presentViewController:manager animated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)imagePickerControllerdidFinishPickingMediaWithImage:(nonnull UIImage*)image
{
    MBProgressHUD *hud = [XHShowHUD showProgressHUD:@"更新头像..."];
    NSString *fileName = [XHHelper createGuid];
    [XHHelper uploadImage:image name:fileName uploadCallback:^(BOOL success, NSError *error) {
        if (success == YES)
        {
            [XHShowHUD hideHud];
            [self.netWorkConfig setObject:fileName forKey:@"headPic"];
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
            [self.netWorkConfig postWithUrl:@"zzjt-app-api_user004" sucess:^(id object, BOOL verifyObject) {
                if (verifyObject) {
                    [XHUserInfo sharedUserInfo].headPic=[[object objectItemKey:@"object"] objectItemKey:@"headPic"];
                    self.isRefresh(YES);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 这里的2和0可以根据需要求更改 这里就是第0段，第2行
                        NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                        //找到对应的cell
                        XHUserTableViewCell *nextCell = [_tableView cellForRowAtIndexPath:indexPath];
                        [nextCell.headBtn sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail([XHUserInfo sharedUserInfo].headPic)] forState:UIControlStateNormal placeholderImage:nil];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    });
                    
                }
            } error:^(NSError *error) {
                
            }];
            
            return;
        }
        
        [XHShowHUD showNOHud:@"头像上传失败!"];
    } withProgressCallback:^(float progress) {
        hud.progress = progress;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
