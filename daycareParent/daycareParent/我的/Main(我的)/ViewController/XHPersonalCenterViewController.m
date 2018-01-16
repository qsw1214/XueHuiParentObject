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
#import "XHVIPViewController.h"
#import "XHStudyRecordViewController.h"
#import "XHMyAddressViewController.h"
#import "XHDiscuntViewController.h"
#import "XHChildListModel.h"
#import "XHVIPModel.h"
#import "XHEducationCloudWebViewController.h"
#import "BaseTableView.h"
#import "HNShopViewController.h"
#define TITLE_LIST @[@"学习记录",@"收藏资源",@"下载记录",@"我的课程"]

@interface XHPersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_HeaderView;
    BaseTableView *_tableView;
    NSArray *arry;
    NSArray *contentArry;
    NSMutableArray *_ChildArry;
    UIButton *_h_btn;
    UILabel *_nameLabel;
    UIImageView* _vipbImageView;
    UILabel* _conditionLabel;
    UILabel *_sigerLabel;
    UIButton *_vipBtn;
}
@property(nonatomic,strong)UIView *h_view;
@property(nonatomic,strong)XHNetWorkConfig *getVIPNet;
@property(nonatomic,strong)XHNetWorkConfig *getChildListNet;
@end

@implementation XHPersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self navtionHidden:YES];
    if ([[XHUserInfo sharedUserInfo].ifOK integerValue]==0) {
        arry=@[@"课程/辅导",@"我的收货地址",@"联系客服"];
        contentArry=@[@"ico_order",@"ico_location",@"ico_service"];
    }
    else
    {
        arry=@[@"课程/辅导",@"VIP升级",@"我的优惠券",@"我的收货地址",@"联系客服"];
        contentArry=@[@"ico_order",@"ico_vip",@"ico_coupon",@"ico_location",@"ico_service"];
    }
    _ChildArry=[NSMutableArray arrayWithArray:[XHUserInfo sharedUserInfo].childListArry];
    [_ChildArry addObject:@""];
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, USER_HEARD+70, SCREEN_WIDTH, SCREEN_HEIGHT-49-USER_HEARD-70) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.sectionHeaderHeight=15;
    //_tableView.bounces=NO;
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
    
    if ([[NSUserDefaults objectItemForKey:@"appVersion123"] isEqualToString:CFBundleShortVersionString])
    {
        [XHUserInfo sharedUserInfo].ifOK=@"1";
        arry=@[@"课程/辅导",@"VIP升级",@"我的优惠券",@"我的收货地址",@"联系客服"];
    contentArry=@[@"ico_order",@"ico_vip",@"ico_coupon",@"ico_location",@"ico_service"];
         [self getVIPNet];
        [self refreshHeadView];
        [self getChildListNet];
        [self refreshUserInfo];
        [_tableView refreshReload];
    }
    else
    {
       [self getIfSuccess];
    }
    
}
#pragma mark----tableviewDelegate------
- (NSInteger)numberOfSectionsInTableView:(BaseTableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==1) {
        return 1;
    }
    else
    {
        if ([[XHUserInfo sharedUserInfo].ifOK integerValue]==0) {
            return 3;
        }
        else
        {
          return 5;
        }
        
    }
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
        if (indexPath.section==1) {
            XHListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listcell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            @WeakObj(self);
            cell.selectListBlock = ^(NSInteger index) {
                //跳转到哪个界面
#pragma mark -------------跳转学习记录或者我的课程等界面------=============
                @StrongObj(self);
                XHStudyRecordViewController *study=[[XHStudyRecordViewController alloc] initHiddenWhenPushHidden];
                study.index=index;
                [self.navigationController pushViewController:study animated:YES];
            };
            return cell;
        }
        else
        {
            XHSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.setImageView.image=[UIImage imageNamed:contentArry[indexPath.row]];
            cell.setLabel.text=arry[indexPath.row];
            if (indexPath.row==0||indexPath.row==4) {
                cell.setContentLabel.hidden=NO;
            }
            else
            {
                cell.setContentLabel.hidden=YES;
            }
            cell.setContentLabel.text=indexPath.row==0?@"我的全部订单":@"400-6778-599";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
- (CGFloat)tableView:(BaseTableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 15;
    
}
-(CGFloat)tableView:(BaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return USER_HEARD*2+20;
    }
    if (indexPath.section==1) {
        return SCREEN_WIDTH/4;
    }
    else
    {
        return USER_HEARD;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 15;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else
        if(scrollView.contentOffset.y >= sectionHeaderHeight){
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
}
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2&&indexPath.row==0) {//http://h5.mall.ixuehui.cn?tel=13500000012#/order
//         NSString *webUrl = [NSString stringWithFormat:@"%@?tel=%@#/order",OrderBaseUrl,[XHUserInfo sharedUserInfo].loginName];
//        XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
//        [webView setWebViewUrl:webUrl];
//        [webView setNavtionTitle:@"我的订单"];
//        [self.navigationController pushViewController:webView animated:YES];
        HNShopViewController *shop = [[HNShopViewController alloc] initHiddenWhenPushHidden];
        shop.initLoad = ^(XCWebView *webView, XCWebViewBridgeViewController *controller) {
            
           NSString *webUrl = [NSString stringWithFormat:@"%@?tel=%@#/order",OrderBaseUrl,[XHUserInfo sharedUserInfo].loginName];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0f]];
            
        };
        [shop setNavtionTitle:@"我的订单"];
        [self.navigationController pushViewController:shop animated:YES];
    }
    if ([[XHUserInfo sharedUserInfo].ifOK integerValue]==1) {
        if (indexPath.section==2&&indexPath.row==1) {
            XHVIPViewController *vip=[[XHVIPViewController alloc] initHiddenWhenPushHidden];
            vip.isRefresh = ^(BOOL ok) {
                if (ok) {
                    [self getVIPNet];
                    [self refreshHeadView];
                }
            };
            [self.navigationController pushViewController:vip animated:YES];
        }
        if (indexPath.section==2&&indexPath.row==2) {
            XHDiscuntViewController *discunt=[[XHDiscuntViewController alloc] initHiddenWhenPushHidden];
            [self.navigationController pushViewController:discunt animated:YES];
            
        }
        if (indexPath.section==2&&indexPath.row==3) {
            XHMyAddressViewController *address=[[XHMyAddressViewController alloc] initHiddenWhenPushHidden];
            [self.navigationController pushViewController:address animated:YES];
        }
        
        if (indexPath.section==2&&indexPath.row==4) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-6778-599"]];
            
        }
    }
    if ([[XHUserInfo sharedUserInfo].ifOK integerValue]==0)
    {
        if (indexPath.section==2&&indexPath.row==1) {
            XHMyAddressViewController *address=[[XHMyAddressViewController alloc] initHiddenWhenPushHidden];
            [self.navigationController pushViewController:address animated:YES];
        }
        
        if (indexPath.section==2&&indexPath.row==2) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-6778-599"]];
            
        }
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
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(USER_HEARD+20,10+50, 90, USER_HEARD/2)];
        _nameLabel.font=FontLevel1;
        
        [_nameLabel setFrame:CGRectMake(USER_HEARD+20, 10+50, [self getCustomWidth].width, USER_HEARD/2)];
        _nameLabel.textColor=[UIColor whiteColor];
        [ _h_view addSubview:_nameLabel];
        _vipbImageView=[[UIImageView alloc] initWithFrame:CGRectMake(_nameLabel.right+5, 18+50, USER_HEARD/2-18, USER_HEARD/2.0-18)];
        [_h_view addSubview:_vipbImageView];
        _conditionLabel=[[UILabel alloc] initWithFrame:CGRectMake(_vipbImageView.right+5,10+50, SCREEN_WIDTH*0.7-115, USER_HEARD/2.0)];
        _conditionLabel.textColor=[UIColor whiteColor];
        _conditionLabel.font=FontLevel4;
        [_h_view addSubview:_conditionLabel];
        _sigerLabel=[[UILabel alloc] initWithFrame:CGRectMake(USER_HEARD+20,10+USER_HEARD/2.0+40, SCREEN_WIDTH-USER_HEARD*2, SCREEN_WIDTH/8)];
        _sigerLabel.textColor=[UIColor whiteColor];
        _sigerLabel.font=FontLevel2;
        [ _h_view addSubview:_sigerLabel];
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(USER_HEARD+30,10+USER_HEARD/2.0+50, SCREEN_WIDTH-USER_HEARD*2, SCREEN_WIDTH/8)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [ _h_view addSubview:btn];
       _vipBtn=[[UIButton alloc] initWithFrame:CGRectMake(_vipbImageView.left, 10+50, SCREEN_WIDTH*0.8-135, USER_HEARD/2.0)];
        [_vipBtn addTarget:self action:@selector(vipbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_h_view addSubview:_vipBtn];
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
#pragma mark------vipbtnClick----
-(void)vipbtnClick
{
    XHVIPViewController *vip=[[XHVIPViewController alloc] initHiddenWhenPushHidden];
    vip.isRefresh = ^(BOOL ok) {
        if (ok) {
            [self getVIPNet];
             [self refreshHeadView];
        }
    };
    [self.navigationController pushViewController:vip animated:YES];
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
#pragma mark---------刷新导航栏视图vip等级
-(void)refreshHeadView
{
    XHUserInfo *userInfo=[XHUserInfo sharedUserInfo];
    if ([[XHUserInfo sharedUserInfo].ifOK integerValue]==0) {
        _vipbImageView.hidden=YES;
        _conditionLabel.hidden=YES;
        _vipBtn.hidden=YES;
    }
    else
    {
        _vipbImageView.hidden=NO;
        _conditionLabel.hidden=NO;
        _vipBtn.hidden=NO;
    }
    [_h_btn sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(userInfo.headPic)]forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addman"]];
    if (![userInfo.nickName isEqualToString:@""]) {
        _nameLabel.text=userInfo.nickName;
    }
    else
    {
        _nameLabel.text=@"昵称";
    }
     [_nameLabel setFrame:CGRectMake(USER_HEARD+20, 10+50, [self getCustomWidth].width, USER_HEARD/2)];
     _vipbImageView.frame=CGRectMake(_nameLabel.right+5, 18+50, USER_HEARD/2-18, USER_HEARD/2.0-18);
     _conditionLabel.frame=CGRectMake(_vipbImageView.right+5,10+50, SCREEN_WIDTH*0.7-115, USER_HEARD/2.0);
    _vipBtn.frame=CGRectMake(_vipbImageView.left, 10+50, SCREEN_WIDTH*0.8-135, USER_HEARD/2.0);
    if (![userInfo.signature isEqualToString:@""]) {
        _sigerLabel.text=userInfo.signature;
    }
    else
    {
        _sigerLabel.text=@"无签名，不个性";
    }
}
-(NSMutableAttributedString *)chageTextColor:(NSString *)text fontColor:(UIColor *)fontColor
{
    NSString *labelStr = text; //初始化string为传入label.text的值
    NSCharacterSet *nonDigits = [[NSCharacterSet decimalDigitCharacterSet]invertedSet];//创建一个字符串过滤参数,decimalDigitCharacterSet为过滤小数,过滤某个关键词,只需改变 decimalDigitCharacterSet类型  在将此方法增加一个 NSString参数即可
    NSInteger remainSeconde = [[labelStr stringByTrimmingCharactersInSet:nonDigits]intValue];//获取过滤出来的数值
    NSString *stringRange = [NSString stringWithFormat:@"%ld",(long)remainSeconde];//将过滤出来的Integer的值转换成String
    NSRange range = [labelStr rangeOfString:stringRange];//获取过滤出来的数值的位置
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:text];//创建一个带属性的string
    [attrStr addAttribute:NSForegroundColorAttributeName value:fontColor range:range];//给带属性的string添加属性,attrubute:添加的属性类型（颜色\文字大小\字体等等）,value:改变成的属性参数,range:更改的位置
    [attrStr addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0,5)];
    return attrStr;
}
-(void)getIfSuccess
{
    XHNetWorkConfig *net=[XHNetWorkConfig new];
    [net setObject:CFBundleShortVersionString forKey:@"version"];
    [net postWithUrl:@"zzjt-app-api_appVersion002" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSDictionary *dic=[object objectItemKey:@"object"];
            [XHUserInfo sharedUserInfo].ifOK=[dic objectItemKey:@"isSuccess"];
            if ([[XHUserInfo sharedUserInfo].ifOK integerValue]==0) {
                [_tableView refreshReload];
            }
            else
            {
                arry=@[@"课程/辅导",@"VIP升级",@"我的优惠券",@"我的收货地址",@"联系客服"];
            contentArry=@[@"ico_order",@"ico_vip",@"ico_coupon",@"ico_location",@"ico_service"];
                [self getVIPNet];
                [self refreshHeadView];
                [self getChildListNet];
                [self refreshUserInfo];
                [_tableView refreshReload];
                [NSUserDefaults setItemObject:CFBundleShortVersionString forKey:@"appVersion123"];
            }
        }
        {
            [_tableView refreshReload];
        }
    } error:^(NSError *error) {
        [_tableView refreshReload];
    }];
}
-(XHNetWorkConfig *)getVIPNet
{
    
    if (_getVIPNet==nil) {
        _getVIPNet=[[XHNetWorkConfig alloc] init];
    }
    [_getVIPNet setObject:[XHUserInfo sharedUserInfo].ID forKey:@"userId"];
    [_getVIPNet postWithUrl:@"zzjt-app-api_vipInfo004" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            id  dic=[object objectItemKey:@"object"];
            if (![dic isEqual:@""]) {
                XHVIPModel *model=[[XHVIPModel alloc] initWithDic:[dic objectItemKey:@"propValue"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([model.expireType intValue]==0) {
                        _conditionLabel.attributedText = [self chageTextColor:@"开通VIP" fontColor:KAITONG_VIPCOLOR];
                        _vipbImageView.image=[UIImage imageNamed:@"ico_novip"];
                    }
                    if ([model.expireType intValue]==2) {
                        _conditionLabel.attributedText = [self chageTextColor:@"续费VIP会员已过期" fontColor:KAITONG_VIPCOLOR];
                        _vipbImageView.image=[UIImage imageNamed:@"ico_novip"];
                    }
                    if ([model.expireType intValue]==1) {
                        if ([model.level intValue]==1) {
                            _conditionLabel.attributedText = [self chageTextColor:[NSString stringWithFormat:@"白金VIP剩余%@天",model.day] fontColor:BAIJIN_VIPCOLOR];
                            _vipbImageView.image=[UIImage imageNamed:@"ico_platinumvip"];
                        }
                        else
                        {
                            _conditionLabel.attributedText = [self chageTextColor:[NSString stringWithFormat:@"黄金VIP剩余%@天",model.day] fontColor:HUANGJIN_VIPCOLOR];
                            _vipbImageView.image=[UIImage imageNamed:@"ico_vip"];
                        }
                    }
                });
            }
            
        }
    } error:^(NSError *error) {
        
    }];
    return _getVIPNet;
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
    [XHShowHUD showTextHud];
    [net postWithUrl:@"zzjt-app-api_login" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject)
        {
            XHGuardianInfo *guardianModel=[[XHGuardianInfo alloc] initWithDic:[[[object objectItemKey:@"object"] objectItemKey:@"propValue"] objectItemKey:@"guardian"]];
            [XHUserInfo sharedUserInfo].guardianModel=guardianModel;
        }
       
    } error:^(NSError *error) {
        
    }];
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
