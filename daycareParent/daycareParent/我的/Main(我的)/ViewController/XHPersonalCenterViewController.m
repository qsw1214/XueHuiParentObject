//
//  XHPersonalCenterViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHPersonalCenterViewController.h"
#import "SDWebImage.h"
#import "XHListTableViewCell.h"
#import "XHChildTableViewCell.h"
#import "XHSetTableViewCell.h"
#import "XHUserViewController.h"
#import "XHSetViewController.h"
#import "XHBindViewController.h"
#import "XHStudentInfoViewController.h"
#import "XHChildListModel.h"
#import "XHEducationCloudWebViewController.h"
#import "BaseTableView.h"

@interface XHPersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_HeaderView;
    BaseTableView *_tableView;
    NSArray *arry;
    NSArray *contentArry;
    NSMutableArray *_ChildArry;
    UIButton *_h_btn;
    UILabel *_nameLabel;
    UILabel *_sigerLabel;
}
@property(nonatomic,strong)UIView *h_view;
@property(nonatomic,strong)XHNetWorkConfig *getChildListNet;
@end

@implementation XHPersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navtionHidden:YES];
     arry=@[@"联系客服"];
    contentArry=@[@"ico_service"];
    _ChildArry=[NSMutableArray arrayWithArray:[XHUserInfo sharedUserInfo].childListArry];
    [_ChildArry addObject:@""];
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, USER_HEARD+53, SCREEN_WIDTH, SCREEN_HEIGHT-49-USER_HEARD-53) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.sectionHeaderHeight=0;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.showsVerticalScrollIndicator=NO;
     [_tableView registerClass:[XHChildTableViewCell class] forCellReuseIdentifier:@"childcell"];
      [_tableView registerClass:[XHListTableViewCell class] forCellReuseIdentifier:@"listcell"];
     [_tableView registerClass:[XHSetTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];

     [self.view addSubview:self.h_view];
   [_tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [_tableView beginRefreshing];
    @WeakObj(self);
    self.isRefresh = ^(BOOL ok) {
        @StrongObj(self);
        if (ok) {
            [self getChildListNet];
            [self refreshUserInfo];
        }
    };
    //去掉留白方法
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(void)refreshHead
{
    [self refreshHeadView];
    [self getChildListNet];
    [self refreshUserInfo];
    [_tableView refreshReload];
}
#pragma mark----tableviewDelegate------
- (NSInteger)numberOfSectionsInTableView:(BaseTableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}
- (UITableViewCell *)tableView:(BaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        if (indexPath.section==0)
        {
            XHChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"childcell" forIndexPath:indexPath];
            [cell setItemArray:_ChildArry];
            @WeakObj(self);
            cell.selectBlock = ^(NSInteger index,NSString *childName) {
                @StrongObj(self);
                if (index==_ChildArry.count-1) {
#pragma mark -------------跳转到绑定孩子界面------=============
                    XHBindViewController *bind=[[XHBindViewController alloc] initHiddenWhenPushHidden];
                    [self.navigationController pushViewController:bind animated:YES];
                }
                else
                {
#pragma mark -------------跳转到绑定孩子详情界面------=============
                    @StrongObj(self);
                    XHStudentInfoViewController *student=[[XHStudentInfoViewController alloc] initHiddenWhenPushHidden];
                      student.model=[XHUserInfo sharedUserInfo].childListArry[index];
                    student.isRefresh = ^(BOOL ok) {
                        if (ok) {
                            [self getChildListNet];
                        }
                    };
                    [self.navigationController pushViewController:student animated:YES];
                }
            };
            return cell;
        }
//        if (indexPath.section==1) {
//            XHListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listcell" forIndexPath:indexPath];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            @WeakObj(self);
//            cell.selectListBlock = ^(NSInteger index) {
//                //跳转到哪个界面
//#pragma mark -------------跳转学习记录或者我的课程等界面------=============
//                @StrongObj(self);
//                XHStudyRecordViewController *study=[[XHStudyRecordViewController alloc] initHiddenWhenPushHidden];
//                study.index=index;
//                [self.navigationController pushViewController:study animated:YES];
//            };
//            return cell;
//        }
        else
        {
            XHSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.setImageView.image=[UIImage imageNamed:contentArry[indexPath.row]];
            cell.setLabel.text=arry[indexPath.row];
            cell.setContentLabel.text=@"400-6778-599";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
- (CGFloat)tableView:(BaseTableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0;
    
}
-(CGFloat)tableView:(BaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return USER_HEARD*2+20;
    }
    else
    {
        return USER_HEARD;
    }
}
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1)
    {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-6778-599"]];
    }
   
}
#pragma mark----导航栏视图
-(UIView *)h_view
{
    if (_h_view==nil) {
        _h_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, USER_HEARD+70)];
        BaseButtonControl *setBtn = [[BaseButtonControl alloc]init];
        [setBtn setNumberImageView:1];
        [setBtn resetFrame:CGRectMake(SCREEN_WIDTH-60, 20, 44, 44)];
        [setBtn setImageEdgeFrame:CGRectMake((44-20.0)/2.0, (44-20.0)/2.0, 20, 20) withNumberType:0 withAllType:NO];
        [setBtn setImage:@"ico_set" withNumberType:0 withAllType:NO];
        [setBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_h_view addSubview:setBtn];
        _h_btn=[[UIButton alloc] initWithFrame:CGRectMake(10, 10+50, USER_HEARD, USER_HEARD)];
        _h_btn.layer.cornerRadius=USER_HEARD/2.0;
        _h_btn.layer.masksToBounds=YES;
        [_h_btn addTarget:self action:@selector(heardBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _h_btn.backgroundColor=[UIColor whiteColor];
        _h_view.backgroundColor=MainColor;
        [_h_view addSubview:_h_btn];
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(USER_HEARD+20,10+50, SCREEN_WIDTH-USER_HEARD-70, USER_HEARD/2)];
        _nameLabel.font=FontLevel1;
        _nameLabel.textColor=[UIColor whiteColor];
        [ _h_view addSubview:_nameLabel];
        _sigerLabel=[[UILabel alloc] initWithFrame:CGRectMake(USER_HEARD+23,10+USER_HEARD/2.0+40, SCREEN_WIDTH-USER_HEARD*2, SCREEN_WIDTH/8)];
        _sigerLabel.textColor=[UIColor whiteColor];
        _sigerLabel.font=FontLevel2;
        [ _h_view addSubview:_sigerLabel];
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(USER_HEARD+30,10+USER_HEARD/2.0+50, SCREEN_WIDTH-USER_HEARD*2, SCREEN_WIDTH/8)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [ _h_view addSubview:btn];
        [self refreshHeadView];
    }
        return _h_view;
}
#pragma mark------setbtnClick----
-(void)setBtnClick
{
    XHSetViewController *set=[XHSetViewController new];
     [set setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:set animated:YES];
}
#pragma mark------heardBtnClick----
-(void)heardBtnClick
{
    XHUserViewController *userVC=[XHUserViewController new];
    [userVC setHidesBottomBarWhenPushed:YES];
    userVC.isRefresh = ^(BOOL ok) {
        if (ok) {
             [self refreshHeadView];
        }
    };
    [self.navigationController pushViewController:userVC animated:YES];
}
#pragma mark---------签名按钮绑定方法-------
-(void)signBtnClick:(XHBaseBtn *)btn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请设置你的个性签名" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[alertController.textFields firstObject].text isEqualToString:@""]) {
            [XHShowHUD showNOHud:@"请输入签名内容！"];
            return ;
        }
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
        [self.netWorkConfig setObject:[alertController.textFields firstObject].text forKey:@"signature"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_user004" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _sigerLabel.text=[alertController.textFields firstObject].text;
                    [XHUserInfo sharedUserInfo].signature=[alertController.textFields firstObject].text;
                });
              
            }
        } error:^(NSError *error) {
            
        }];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark---------刷新导航栏视图
-(void)refreshHeadView
{
    XHUserInfo *userInfo=[XHUserInfo sharedUserInfo];
    [_h_btn sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(userInfo.headPic)]forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
    if (![userInfo.nickName isEqualToString:@""]) {
        _nameLabel.text=userInfo.nickName;
    }
    else
    {
        _nameLabel.text=@"昵称";
    }
    if (![userInfo.signature isEqualToString:@""]) {
        _sigerLabel.text=userInfo.signature;
    }
    else
    {
        _sigerLabel.text=@"无签名，不个性";
    }
}

-(XHNetWorkConfig *)getChildListNet
{
    if (_getChildListNet==nil) {
        _getChildListNet=[[XHNetWorkConfig alloc] init];
    }
    [_getChildListNet setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
    [_getChildListNet postWithUrl:@"zzjt-app-api_smartCampus011" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            [_ChildArry removeAllObjects];
            for (NSDictionary *dic in [object objectItemKey:@"object"]) {
                XHChildListModel *model=[[XHChildListModel alloc] initWithDic:dic];
                [_ChildArry addObject:model];
            }
            [[XHUserInfo sharedUserInfo].childListArry setArray:_ChildArry];
            [_ChildArry addObject:@""];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView refreshReload];
            });

        }

    } error:^(NSError *error) {
        [_tableView refreshReload];
    }];
    return _getChildListNet;
}

-(void)refreshUserInfo
{
    if (![[XHUserInfo sharedUserInfo].guardianModel.familyId isEqualToString:@""]) {
        return ;
    }
    XHLoginModel *model=[NSUserDefaults getLoginModel];
    XHNetWorkConfig *net=[XHNetWorkConfig new];
    [net setObject:model.loginName forKey:@"loginName"];
    [net setObject:model.pwd forKey:@"pwd"];
    [net setObject:@"3" forKey:@"type"];
    [net postWithUrl:@"zzjt-app-api_login" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject)
        {
            XHGuardianInfo *guardianModel=[[XHGuardianInfo alloc] initWithDic:[[[object objectItemKey:@"object"] objectItemKey:@"propValue"] objectItemKey:@"guardian"]];
            [XHUserInfo sharedUserInfo].guardianModel=guardianModel;
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
