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
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "XHChangeNameViewController.h"
#import "XHCustomPickerView.h"
@interface XHUserViewController ()<UITableViewDelegate,UITableViewDataSource,CameraManageDeletage,XHCustomPickerViewDelegate>
{
    UITableView *_tableView;
    NSArray *_titleArry;
}
@property(nonatomic,strong)XHCustomPickerView *pickerView;
@end

@implementation XHUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"个人信息"];
    _titleArry=@[@"头像",@"姓名",@"我与孩子的关系"];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerClass:[XHUserTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHUserTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    XHUserInfo *userInfo=[XHUserInfo sharedUserInfo];
    cell.frontLabel.frame=CGRectMake(10, 0, 120, cell.bounds.size.height);
    cell.backLabel.frame=CGRectMake(130, 0, SCREEN_WIDTH-160, cell.bounds.size.height);
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
            cell.backLabel.text=userInfo.guardianModel.guardianName;
        }
        if (indexPath.row==2) {
            cell.backLabel.text=@"其它";
        }
//        if (indexPath.row==3) {
//            cell.backLabel.text=userInfo.guardianModel.guardianName;
//        }
//        if (indexPath.row==4) {
//            cell.backLabel.text=userInfo.telphoneNumber;
//        }
    }
    [cell.headBtn addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        [self openImagePiker];
    }
//    if (indexPath.row==1) {
//        [self showAlertViewWithTitle:@"请输入姓名" Index:indexPath.row];
//    }
//    if (indexPath.row==2) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
//            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
//            [self.netWorkConfig setObject:@"1" forKey:@"sex"];
//            [self.netWorkConfig postWithUrl:@"zzjt-app-api_user004" sucess:^(id object, BOOL verifyObject) {
//                if (verifyObject) {
//                    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
//                    XHUserTableViewCell *nextCell = [tableView cellForRowAtIndexPath:indexPath];
//                    nextCell.backLabel.text=@"男";
//                    [XHUserInfo sharedUserInfo].sex=@"1";
//                    [XHUserInfo sharedUserInfo].sexName=@"男";
//                    self.isRefresh(YES);
//                }
//            } error:^(NSError *error) {
//
//            }];
//        }]];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
//            [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
//            [self.netWorkConfig setObject:@"0" forKey:@"sex"];
//            [self.netWorkConfig postWithUrl:@"zzjt-app-api_user004" sucess:^(id object, BOOL verifyObject) {
//                if (verifyObject) {
//                    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
//                    XHUserTableViewCell *nextCell = [tableView cellForRowAtIndexPath:indexPath];
//                    nextCell.backLabel.text=@"女";
//                    [XHUserInfo sharedUserInfo].sex=@"0";
//                    [XHUserInfo sharedUserInfo].sexName=@"女";
//                    self.isRefresh(YES);
//                }
//            } error:^(NSError *error) {
//
//            }];
//        }]];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//        }]];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
    if (indexPath.row==1) {
        XHChangeNameViewController *name=[[XHChangeNameViewController alloc] init];
        [self.navigationController pushViewController:name animated:YES];
        //[self showAlertViewWithTitle:@"请输入真实姓名" Index:indexPath.row];
    }
    if (indexPath.row==2) {
        [self.pickerView show];
        [self.pickerView setItemObjectArry:(NSMutableArray *)kFamilyList];
    }
//    if (indexPath.row==4) {
//        [self showAlertViewWithTitle:@"请输入联系电话" Index:indexPath.row];
//    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return USER_HEARD+20;
    }
    else
    {
        return USER_HEARD-20;
    }
}
#pragma mark-------修改头像
-(void)headClick
{
    [self openImagePiker];
}
#pragma mark-----pickerViewDelegate
-(void)getItemObject:(NSString *)itemObject atItemIndex:(NSInteger)index
{
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    //找到对应的cell
    XHUserTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    cell.backLabel.text=itemObject;
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
//        if (![UITextView verifyPhone:feild.text]&&index==4)
//        {
//            [XHShowHUD showNOHud:@"请输入正确的手机号格式!"];
//            return ;
//        }
        if (feild.text.length==0)
        {
            [XHShowHUD showNOHud:@"请输入内容!"];
            return ;
        }
        if (feild.text.length>4&&index==1)
        {
            [XHShowHUD showNOHud:@"姓名最多为四个字!"];
            return ;
        }
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
//        if (index==1) {
//            [self.netWorkConfig setObject:feild.text forKey:@"nickName"];
//        }
        if (index==1) {
            [self.netWorkConfig setObject:feild.text forKey:@"guardianName"];
        
        }
//        if (index==4) {
//            [self.netWorkConfig setObject:feild.text forKey:@"telphoneNumber"];
//        }
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
    [alertController addAction:[UIAlertAction actionWithTitle:@"选择相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
    {
        
//        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
//
//            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - 学汇家长] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
//            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//
//            }];
//
//            [alertC addAction:alertA];
//            [self presentViewController:alertC animated:YES completion:nil];
//        }
        
        
        
        
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
-(XHCustomPickerView *)pickerView
{
    if (_pickerView==nil) {
        _pickerView=[[XHCustomPickerView alloc] initWithDelegate:self];
    }
    return _pickerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
