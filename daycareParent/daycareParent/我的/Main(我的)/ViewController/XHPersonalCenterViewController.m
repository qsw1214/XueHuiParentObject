//
//  XHPersonalCenterViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHPersonalCenterViewController.h"
#import "SDWebImage.h"
#import "XHSetTableViewCell.h"
#import "XHUserViewController.h"
#import "XHSetViewController.h"
#import "XHBindViewController.h"
#import "XHStudentInfoViewController.h"
#import "XHChildListModel.h"
#import "BaseTableView.h"
#import "XHChildCollectionView.h" //!<孩子列表展示
#import "XHFeedBackViewController.h"//!< 问题反馈视图
#import "XHSystemNotificViewController.h"//!< 系统通知
#import "XHShareView.h"//!< 分享视图

#define  kTitle @[@"联系客服",@"问题反馈",@"好友推荐",@"系统通知",@"设置"]
#define kTitlePic @[@"ico_mycontact",@"ico_myquestion",@"ico_myshare",@"ico_mynotice",@"ico_myset"]

@interface XHPersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *_h_btn;
    UILabel *_nameLabel;
}
@property(nonatomic,strong)UIView *h_view;
@property(nonatomic,strong)XHChildCollectionView *childCollectionView;//!<孩子列表展示
@property(nonatomic,strong)XHNetWorkConfig *getChildListNet;
@property(nonatomic,strong)NSMutableArray *childArry;
@property(nonatomic,strong)BaseTableView *tableView;
@property(nonatomic,strong)XHShareView *shareView;
@end

@implementation XHPersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navtionHidden:YES];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=self.h_view;
    [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    [self.tableView beginRefreshing];
    @WeakObj(self);
    self.isRefresh = ^(BOOL ok)
    {
        @StrongObj(self);
        if (ok)
        {
            [self getChildListNet];
            [self refreshUserInfo];
        }
    };
}
-(void)refreshHead
{
    [self refreshHeadView];
    [self getChildListNet];
    [self refreshUserInfo];
    [_tableView refreshReload];
}
#pragma mark----tableviewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kTitle.count;
}
- (UITableViewCell *)tableView:(BaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.setImageView.image=[UIImage imageNamed:kTitlePic[indexPath.row]];
    cell.setLabel.text=kTitle[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(BaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
            case 0:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0371-6778599"]];
        }
            break;
            case 1:
            {
                XHFeedBackViewController *feedBack=[[XHFeedBackViewController alloc] initHiddenWhenPushHidden];
                [self.navigationController pushViewController:feedBack animated:YES];
            }
            break;
            case 2:
        {
            [self.shareView show];
        }
            break;
            case 3:
        {
            XHSystemNotificViewController *system=[[XHSystemNotificViewController alloc] initHiddenWhenPushHidden];
            [self.navigationController pushViewController:system animated:YES];
        }
            break;
        case 4:
        {
            XHSetViewController *set=[XHSetViewController new];
            [set setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:set animated:YES];
        }
            break;
    }
    
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH ,15)];
    view.backgroundColor = RGB(239, 239, 239);
    return view;
}

#pragma mark------点击头像按钮方法
-(void)heardBtnClick
{
    XHUserViewController *userVC=[XHUserViewController new];
    [userVC setHidesBottomBarWhenPushed:YES];
    userVC.isRefresh = ^(BOOL ok)
    {
        if (ok)
        {
             [self refreshHeadView];
        }
    };
    [self.navigationController pushViewController:userVC animated:YES];
}

#pragma mark---------刷新个人信息视图
-(void)refreshHeadView
{
    XHUserInfo *userInfo=[XHUserInfo sharedUserInfo];
    [_h_btn setHeadrPic:userInfo.headPic withName:userInfo.guardianModel.guardianName withType:XHTeacherType];
    if (![userInfo.guardianModel.guardianName isEqualToString:@""])
    {
        _nameLabel.text=userInfo.guardianModel.guardianName;
    }
    else
    {
        _nameLabel.text=@"姓名";
    }
}
-(void)refreshUserInfo
{
    if (![[XHUserInfo sharedUserInfo].guardianModel.familyId isEqualToString:@""])
    {
        
        return ;
    }
    XHLoginModel *model=[NSUserDefaults getLoginModel];
    XHNetWorkConfig *net=[XHNetWorkConfig new];
    [net setObject:model.loginName forKey:@"loginName"];
    [net setObject:model.pwd forKey:@"pwd"];
    [net setObject:@"3" forKey:@"type"];
    [net postWithUrl:@"zzjt-app-api_login" sucess:^(id object, BOOL verifyObject)
    {
        if (verifyObject)
        {
            XHGuardianInfo *guardianModel=[[XHGuardianInfo alloc] initWithDic:[[[object objectItemKey:@"object"] objectItemKey:@"propValue"] objectItemKey:@"guardian"]];
            [XHUserInfo sharedUserInfo].guardianModel=guardianModel;
        }
        
    } error:^(NSError *error) {}];
}
#pragma mark----导航栏视图
-(UIView *)h_view
{
    if (_h_view==nil) {
        _h_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, USER_HEARD*2+200)];
        _h_view.layer.masksToBounds=YES;
        UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, _h_view.bottom-SCREEN_WIDTH/2.0, SCREEN_WIDTH*2, SCREEN_WIDTH)];
        bgView.center=CGPointMake(SCREEN_WIDTH/2.0, SCREEN_WIDTH+USER_HEARD+20);//60
        bgView.layer.cornerRadius=SCREEN_WIDTH;
        bgView.backgroundColor=RGB(239, 239, 239);
        [_h_view addSubview:bgView];
        _h_btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, USER_HEARD+10, USER_HEARD+10)];
        _h_btn.center=CGPointMake(SCREEN_WIDTH/2.0, USER_HEARD/2.0+65);
        _h_btn.layer.cornerRadius=USER_HEARD/2.0+5;
        _h_btn.layer.masksToBounds=YES;
        [_h_btn addTarget:self action:@selector(heardBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _h_btn.backgroundColor=[UIColor whiteColor];
        _h_view.backgroundColor=MainColor;
        [_h_view addSubview:_h_btn];
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10,_h_btn.bottom, SCREEN_WIDTH-20 , 40)];
        _nameLabel.numberOfLines=0;
        _nameLabel.font=FontLevel1;
        _nameLabel.textColor=[UIColor whiteColor];
        [ _h_view addSubview:_nameLabel];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _h_view.backgroundColor=RGB(69, 191, 145);
        [self refreshHeadView];
        self.childCollectionView=[[XHChildCollectionView alloc] initWithFrame:CGRectMake(10, _nameLabel.bottom+10, SCREEN_WIDTH-20, _h_view.bottom-(_nameLabel.bottom+10))];
        [_h_view addSubview:self.childCollectionView];
        [self.childCollectionView setItemArray:self.childArry];
        @WeakObj(self);
        self.childCollectionView.selectBlock = ^(NSInteger index,NSString *childName,XHChildListModel *model)
        {
            @StrongObj(self);
            if (index==self.childArry.count)
            {
#pragma mark -----跳转到绑定孩子界面
                XHBindViewController *bind=[[XHBindViewController alloc] initHiddenWhenPushHidden];
                [bind setEnterType:XHBindEnterType];
                bind.isRefresh = ^(BOOL ok)
                {
                    if (ok)
                    {
                        [self getChildListNet];
                    }
                };
                [self.navigationController pushViewController:bind animated:YES];
            }
            else
            {
#pragma mark -----跳转到绑定孩子详情界面
                @StrongObj(self);
                XHStudentInfoViewController *student=[[XHStudentInfoViewController alloc] initHiddenWhenPushHidden];
                student.isRefresh = ^(BOOL ok)
                {
                    if (ok)
                    {
                        [self getChildListNet];
                    }
                };
                [student getChildInfo:model];
                [self.navigationController pushViewController:student animated:YES];
            }
        };
    }
    return _h_view;
}
-(XHNetWorkConfig *)getChildListNet
{
    if (_getChildListNet==nil) {
        _getChildListNet=[[XHNetWorkConfig alloc] init];
    }
    [_getChildListNet setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
    [_getChildListNet postWithUrl:@"zzjt-app-api_studentBinding008" sucess:^(id object, BOOL verifyObject)
    {
        if (verifyObject)
        {
            [self.childArry removeAllObjects];
            NSArray *itemArry=[object objectItemKey:@"object"];
            if (itemArry)
            {
                for (NSDictionary *dic in itemArry)
                {
                    XHChildListModel *model=[[XHChildListModel alloc] initWithDic:dic];
                    [self.childArry addObject:model];
                }
            }
            
            [[XHUserInfo sharedUserInfo].childListArry setArray:self.childArry];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView refreshReload];
                [self.childCollectionView setItemArray:self.childArry];
            });

        }

    } error:^(NSError *error) {
        [_tableView refreshReload];
    }];
    return _getChildListNet;
}


-(BaseTableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        _tableView.showsVerticalScrollIndicator=NO;
        [_tableView registerClass:[XHSetTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
-(XHShareView *)shareView
{
    if (_shareView==nil) {
        _shareView=[[XHShareView alloc] initWithDelegate:self];
    }
    return _shareView;
}
-(NSMutableArray *)childArry
{
    if (_childArry==nil) {
        _childArry=[NSMutableArray arrayWithArray:[XHUserInfo sharedUserInfo].childListArry];
    }
    return _childArry;
}
-(CGSize)getCustomWidth
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20.0]};
    CGSize textSize = [[XHUserInfo sharedUserInfo].nickName boundingRectWithSize:CGSizeMake(90, USER_HEARD/2) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    return textSize;
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
