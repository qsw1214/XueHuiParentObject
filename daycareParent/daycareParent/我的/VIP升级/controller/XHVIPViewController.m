//
//  XHVIPViewController.m
//  daycareParent
//
//  Created by mac on 2017/12/3.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHVIPViewController.h"
#import "XHVIPTableViewCell.h"
#import "XHPriviTableViewCell.h"
#import "XHCustomPayView.h"
#import "BaseTableView.h"
#import "XHvipInfo.h"
#import "Pingpp.h"
@interface XHVIPViewController ()<UITableViewDelegate,UITableViewDataSource,XHCustomPayViewDelegate>
{
    NSArray *_titleArry;
    NSArray *_mouthArry;
    NSArray *_yearArry;
}
@property (strong, nonatomic) IBOutlet BaseTableView *tableView;
@property(strong,nonatomic)XHCustomPayView *payView;
@end

@implementation XHVIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavtionTitle:@"VIP中心"];
    self.dataArray=[NSMutableArray array];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=50;
    _tableView.bounces=NO;
    _tableView.tableHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN )];
    _tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN )];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHVIPTableViewCell" bundle:nil] forCellReuseIdentifier:@"vipCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"XHPriviTableViewCell" bundle:nil] forCellReuseIdentifier:@"priviCell"];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
    [XHShowHUD showTextHud];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_vipInfo001" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSArray *arr=[object objectItemKey:@"object"];
            for (NSDictionary *dic in arr) {
                NSDictionary *Dic=[dic objectItemKey:@"propValue"];
                XHvipInfo *vip=[[XHvipInfo alloc] initWithDic:Dic];
                [self.dataArray addObject:vip];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
            
        }
    } error:^(NSError *error) {
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBackResult:) name:@"callBack" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callBackResult:) name:@"VIPUp" object:nil];
}
-(NSInteger)numberOfSectionsInTableView:(BaseTableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(BaseTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    else
    {
        return 5;
    }
}
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.dataArray.count/2 +1;
    }
    else
    {
        return 2;
    }
}
-(CGFloat)tableView:(BaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 40;
    }
    else
    {
        return 150;
    }
}
- (UITableViewCell *)tableView:(BaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (indexPath.section==0) {
        if (indexPath.row==0){
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text=@"会员套餐";
        cell.textLabel.font=FontLevel2;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        }
        else
        {
            XHVIPTableViewCell *vipCell=[tableView dequeueReusableCellWithIdentifier:@"vipCell" forIndexPath:indexPath];
             vipCell.selectionStyle = UITableViewCellSelectionStyleNone;
            vipCell.mouthBtn.tag=indexPath.row+10086;
            [vipCell.mouthBtn addTarget:self action:@selector(mouthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            vipCell.yearBtn.tag=indexPath.row+1008611;
            [vipCell.yearBtn addTarget:self action:@selector(yearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                vipCell.titleLab.text=[self.dataArray[(indexPath.row-1)*2] name];
            vipCell.firstLabel.text=[self.dataArray[(indexPath.row-1)*2] unitName];
            vipCell.twoLabel.text=[self.dataArray[indexPath.row*2-1] unitName];
                vipCell.mouthLabel.text=[NSString stringWithFormat:@"%@/年",[self.dataArray[(indexPath.row-1)*2] price]];
                vipCell.yearLabel.text=[NSString stringWithFormat:@"%@/月",[self.dataArray[indexPath.row*2-1] price]];
            return vipCell;
        }
        
    }
    else
    {
          XHPriviTableViewCell *priviCell=[tableView dequeueReusableCellWithIdentifier:@"priviCell" forIndexPath:indexPath];
         priviCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            priviCell.titleLab.text=@"白金会员特权";
            priviCell.oneImageView.image=[UIImage imageNamed:@"ico_teachvido"];
            priviCell.oneLabel.text=@"教学视频";
            priviCell.twoImageView.image=[UIImage imageNamed:@"ico_free"];
            priviCell.twoLabel.text=@"会员免费";
            priviCell.threeImageView.image=[UIImage imageNamed:@"ico_discount"];
            priviCell.threeLabel.text=@"享原价的折扣";
        }
        else
        {
            priviCell.titleLab.text=@"黄金会员附加视频";
            priviCell.oneImageView.image=[UIImage imageNamed:@"ico_download"];
            priviCell.oneLabel.text=@"无限下载";
            priviCell.twoImageView.image=[UIImage imageNamed:@"ico_need"];
            priviCell.twoLabel.text=@"提课程需求";
            priviCell.threeImageView.image=nil;
            priviCell.threeLabel.text=nil;
        }
        return priviCell;
    }
    

}
#pragma mark------------开通年会员=======
-(void)mouthBtnClick:(UIButton *)btn
{
    [self.view addSubview:self.payView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"money" object:self.dataArray[(btn.tag-10086-1)*2]];
}
#pragma mark------------开通月会员=======
-(void)yearBtnClick:(UIButton *)btn
{
    [self.view addSubview:self.payView];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"money" object:self.dataArray[(btn.tag-1008611)*2-1]];
}
#pragma mark----------支付代理方法返回付款方式和金额
-(void)getPayment:(NSString *)payStr money:(NSString *)ID
{
    [self.netWorkConfig setObject:ID forKey:@"vipInfoId"];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"userId"];
    [self.netWorkConfig setObject:payStr forKey:@"paymentMethod"];
    [XHShowHUD showTextHud];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_vipInfo002" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSData *ddd = [object objectItemKey:@"object"];
            dispatch_async(dispatch_get_main_queue(), ^{
               [self payOrderWithData:ddd];
            });
        }
    } error:^(NSError *error) {
        
    }];

}
-(XHCustomPayView *)payView
{
    if (_payView==nil) {
        _payView=[[XHCustomPayView alloc] initWithFrame:WindowScreen];
        _payView.delegate=self;
    }
    
     [self.view addSubview:_payView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _payView.view.frame=CGRectMake(0, SCREEN_HEIGHT-280, SCREEN_WIDTH, 280);
    [UIView commitAnimations];
    return _payView;
}
- (void)payOrderWithData:(NSData *)data
{
    XHVIPViewController * __weak weakSelf = self;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    NSString* dataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [Pingpp createPayment:dataStr
           viewController:weakSelf
             appURLScheme:@"wxedbbf780e30b9bb5"
           withCompletion:^(NSString *result, PingppError *error)
     {
         if (error == nil) {
             NSLog(@"PingppError is nil");
         } else {
             NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
         }
         NSLog(@"%@",result);
     }];
}
-(void)callBackResult:(NSNotification *)payResult
{
    NSString *result=payResult.object;
  
    if ([result isEqualToString:@"success"]) {
        [XHShowHUD showOKHud:@"支付成功!"];
        self.isRefresh(YES);
        [self.navigationController popViewControllerAnimated:YES];
    }
   else if ([result isEqualToString:@"cancel"]) {
        [XHShowHUD showNOHud:@"支付取消!"];
    }
   else{
        [XHShowHUD showNOHud:@"支付失败!"];
   }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
