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
    _titleArry=@[@"头像",@"姓名"];
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom) style:UITableViewStyleGrouped];
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
    [cell.headBtn setHeadrPic:userInfo.headPic withName:userInfo.guardianModel.guardianName withType:XHTeacherType];
    if (indexPath.row==0) {
        cell.headBtn.hidden=NO;
        cell.backLabel.hidden=YES;
        cell.lineLabel.frame=CGRectMake(0, USER_HEARD+20-0.5, SCREEN_WIDTH, 0.5);
        [cell.contentView addSubview:cell.lineLabel];
        cell.arrowImageView.frame=CGRectMake(SCREEN_WIDTH-22, (USER_HEARD+6)/2.0, 8, 14);
        [cell.contentView addSubview:cell.arrowImageView];
    }
    else
    {
        cell.headBtn.hidden=YES;
        cell.backLabel.hidden=NO;
        cell.backLabel.text=userInfo.guardianModel.guardianName;
        cell.lineLabel.frame=CGRectMake(0, 50-0.5, SCREEN_WIDTH, 0.5);
        cell.arrowImageView.frame=CGRectMake(SCREEN_WIDTH-22, (50-14)/2.0, 8, 14);
        [cell.contentView addSubview:cell.arrowImageView];
    }
    [cell.headBtn addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            [self openImagePiker];
        }
            break;
            
        default:
        {
            XHChangeNameViewController *name=[[XHChangeNameViewController alloc] init];
            name.isRefresh = ^(BOOL ok) {
                if (ok) {
                    
                    XHUserTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.backLabel.text=[XHUserInfo sharedUserInfo].guardianModel.guardianName;
                    if (self.isRefresh) {
                       self.isRefresh(YES);
                    }
                }
            };
            [self.navigationController pushViewController:name animated:YES];
        }
            break;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return USER_HEARD+20;
        }
            break;
            
        default:
        {
            return 50;
        }
            break;
    }
   
}
#pragma mark-------修改头像
-(void)headClick
{
    [self openImagePiker];
}

-(void)openImagePiker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"选择相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
    {
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
