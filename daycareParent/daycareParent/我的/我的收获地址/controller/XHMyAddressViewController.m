//
//  XHMyAddressViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHMyAddressViewController.h"
#import "XHNameTableViewCell.h"
#import "XHAddressTableViewCell.h"
#import "XHAddressModel.h"
#import "BaseTableView.h"
#import "XHAddAdressViewController.h"
#import "XHComplieAddressViewController.h"
@interface XHMyAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _section;
}
@property (strong, nonatomic) BaseTableView *tableView;
@property(strong,nonatomic)UIView *CustomView;

@end

@implementation XHMyAddressViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavtionTitle:@"我的收货地址"];
    self.view.backgroundColor=RGB(239, 239, 244);
    _section=0;
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-124) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.sectionHeaderHeight=0;
    _tableView.sectionFooterHeight=0;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [_tableView registerNib:[UINib nibWithNibName:@"XHNameTableViewCell" bundle:nil] forCellReuseIdentifier:@"nameCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"addressCell"];
    [self.view addSubview:_tableView];
    [_tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeader)];
    [_tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
     [_tableView beginRefreshing];
    
}
-(void)refreshHeader
{
    [self reloadModel];
    [_tableView refreshReloadData];
}
-(void)reloadModel
{
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"userId"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_userAddress001" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSArray *arr=[object objectItemKey:@"object"];
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in arr) {
                XHAddressModel *model=[[XHAddressModel alloc] initWithDic:dic];
                [self.dataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView refreshReloadData];
                if (self.dataArray.count==0) {
                    self.CustomView.frame=CGRectMake(0, 64, SCREEN_WIDTH, 60);
                }
                else
                {
                    self.CustomView.frame=CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60);
                }
            });
        }
    } error:^(NSError *error) {
        [_tableView refreshReloadData];
        if (self.dataArray.count==0) {
            self.CustomView.frame=CGRectMake(0, 64, SCREEN_WIDTH, 60);
        }
        else
        {
            self.CustomView.frame=CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60);
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [_tableView tableTipViewWithArray:self.dataArray];
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    else
    {
        return 5;
    }
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
    if (indexPath.row==0) {
        XHNameTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"nameCell" forIndexPath:indexPath];
        XHAddressModel *model=self.dataArray[indexPath.section];
        cell.nameLabel.text=model.consignee;
        cell.telephoneLabel.text=model.telephone;
        if ([model.provinceName isEqualToString:model.cityName]) {
          cell.addressLabel.text=[NSString stringWithFormat:@"%@%@%@",model.cityName,model.areaName,model.addressDetail];
        }
        else
        {
             cell.addressLabel.text=[NSString stringWithFormat:@"%@%@%@%@",model.provinceName,model.cityName,model.areaName,model.addressDetail];
        }
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        XHAddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"addressCell" forIndexPath:indexPath];
        XHAddressModel *model=self.dataArray[indexPath.section];
        cell.selectBtn.selected=[model.isDefault boolValue];
        cell.defaultAdressBtn.tag=indexPath.section+100;
        [cell.defaultAdressBtn addTarget:self action:@selector(defaultAdressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.complieBtn.tag=indexPath.section+1000;
        [cell.complieBtn addTarget:self action:@selector(complieBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteBtn.tag=indexPath.section+10000;
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
#pragma mark-------设置默认地址按钮--------
-(void)defaultAdressBtnClick:(UIButton *)btn
{
    XHAddressModel *model=self.dataArray[btn.tag-100];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"userId"];
    [self.netWorkConfig setObject:model.addressId forKey:@"addressId"];
    [XHShowHUD showTextHud];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_userAddress004" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadModel];
            });
        }
        
    } error:^(NSError *error) {
         [self reloadModel];
    }];
   
   
}
#pragma mark-------编辑按钮--------
-(void)complieBtnClick:(UIButton *)btn
{
    XHComplieAddressViewController *complie=[XHComplieAddressViewController new];
    complie.model=self.dataArray[btn.tag-1000];
    [self.navigationController pushViewController:complie animated:YES];
}
#pragma mark-------删除按钮--------
-(void)deleteBtnClick:(UIButton *)btn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要删除该地址？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        XHAddressModel *model=self.dataArray[btn.tag-10000];
        [self.netWorkConfig setObject:model.addressId forKey:@"addressId"];
        [XHShowHUD showTextHud];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_userAddress005" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self reloadModel];
                    if (self.dataArray.count==0) {
                        self.CustomView.frame=CGRectMake(0, 64, SCREEN_WIDTH, 60);
                    }
                    else
                    {
                        self.CustomView.frame=CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60);
                    }
                });
            }
        } error:^(NSError *error) {
            [self reloadModel];
            if (self.dataArray.count==0) {
                self.CustomView.frame=CGRectMake(0, 64, SCREEN_WIDTH, 60);
            }
            else
            {
                self.CustomView.frame=CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60);
            }
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(UIView *)CustomView
{
    if (_CustomView==nil) {
        _CustomView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _CustomView.backgroundColor=RGB(239, 239, 239);
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        view.backgroundColor=RGB(224, 224, 224);
        [_CustomView addSubview:view];
        [self.view addSubview:_CustomView];
        BaseButtonControl *btn=[[BaseButtonControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2.0, 10, 150, 40)];
        [btn setNumberImageView:1];
        [btn setImageEdgeFrame:CGRectMake(0, 8, 24, 24) withNumberType:1 withAllType:YES];
        [btn setImage:@"ico_addaddress" withNumberType:1 withAllType:YES];
        [btn setNumberLabel:1];
        [btn setTitleEdgeFrame:CGRectMake(30, 5, 120, 30) withNumberType:1 withAllType:YES];
        [btn setText:@"添加收货地址" withNumberType:1 withAllType:YES];
        [btn setFont:FontLevel1 withNumberType:1 withAllType:YES];
        [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_CustomView addSubview:btn];
    }
    return _CustomView;
}
#pragma mark ---------添加收货地址按钮方法-----
-(void)addBtnClick
{
    XHAddAdressViewController *add=[[XHAddAdressViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
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
