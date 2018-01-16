//
//  XHComplieAddressViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHComplieAddressViewController.h"
#import "XHUserTableViewCell.h"
#import "XHCustomTextField.h"
#import "XHAddressPickerView.h"
#import "XHAddTableViewCell.h"
#import "XHAddressModel.h"
#define TITLE_LIST @[@"收货人",@"手机号",@"",@"详细地址"]
@interface XHComplieAddressViewController ()<UITableViewDataSource,UITableViewDelegate,XHAddressPickerViewDelegate,UITextViewDelegate>
{
    XHBaseBtn *_sureBtn;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) XHAddressPickerView *customPickerViewerView;
@end

@implementation XHComplieAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavtionTitle:@"我的收获地址"];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    [_tableView registerClass:[XHUserTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHAddTableViewCell" bundle:nil] forCellReuseIdentifier:@"titleCell"];
    _sureBtn=[[XHBaseBtn alloc] initWithFrame:CGRectMake(15, 360, SCREEN_WIDTH-30, 50)];
    [_sureBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        return 80;
    }
    else
    {
        return 50;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHAddressModel *model=self.model;
    if (indexPath.row!=2) {
        XHAddTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
        cell.titleLab.text=TITLE_LIST[indexPath.row];
        cell.textView.tag=10086+indexPath.row;
        cell.textView.delegate=self;
        [cell.clearButton addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.clearButton.tag=indexPath.row+1008611;
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.textView.text=model.consignee;
        }
        if (indexPath.row==1) {
            cell.textView.keyboardType=UIKeyboardTypePhonePad;
             cell.textView.text=model.telephone;
        }
        if (indexPath.row==3) {
            cell.textView.text=model.addressDetail;
        }
        return cell;
    }
    else
    {
        XHUserTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.frontLabel.frame=CGRectMake(15, 0, 100, cell.bounds.size.height);
        cell.backLabel.frame=CGRectMake(110, 0, SCREEN_WIDTH-140, cell.bounds.size.height);
        cell.frontLabel.text=@"所在地区";
        if ([model.provinceName isEqualToString:model.cityName]) {
            cell.backLabel.text=[NSString stringWithFormat:@"%@%@",model.cityName,model.areaName];
        }
        else
        {
            cell.backLabel.text=[NSString stringWithFormat:@"%@%@%@",model.provinceName,model.cityName,model.areaName];
        }
        cell.headBtn.layer.cornerRadius=0;
        cell.headBtn.frame=CGRectMake(SCREEN_WIDTH-40, 15, 20, 20);
        cell.headBtn.userInteractionEnabled=NO;
        [cell.headBtn setBackgroundImage:[UIImage imageNamed:@"ico_nochose"] forState:UIControlStateNormal];
        [cell.headBtn setBackgroundImage:[UIImage imageNamed:@"ico_chose"] forState:UIControlStateSelected];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.headBtn.hidden=NO;
            cell.backLabel.hidden=YES;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.frontLabel.text=@"设为默认地址";
        }
        else
        {
            cell.headBtn.hidden=YES;
            cell.backLabel.hidden=NO;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView endEditing:YES];
    if (indexPath.row==2) {
        [self.view addSubview:self.customPickerViewerView];
    }
}
-(XHAddressPickerView *)customPickerViewerView
{
    if (_customPickerViewerView==nil) {
        _customPickerViewerView=[[XHAddressPickerView alloc] initWithFrame:WindowScreen];
        _customPickerViewerView.delegate=self;
    }
    [self.view addSubview:_customPickerViewerView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _customPickerViewerView.view.frame=CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220);
    [UIView commitAnimations];
    return _customPickerViewerView;
}
-(void)sureBtnClick
{
    XHCustomTextField *nameTF=[_tableView viewWithTag:10086];
    XHCustomTextField *teleTF=[_tableView viewWithTag:10086+1];
    XHCustomTextField *addressTF=[_tableView viewWithTag:10086+3];
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    //找到对应的cell
    XHUserTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    if (nameTF.text.length>4||nameTF.text.length==0) {
        [XHShowHUD showNOHud:@"请输入正确的名字!"];
        return ;
    }
    if (![XHCustomTextField verifyPhone:teleTF.text]) {
        [XHShowHUD showNOHud:@"请输入正确手机号!"];
        return;
    }
    if (cell.backLabel.text.length==0) {
        [XHShowHUD showNOHud:@"请选择正确的地区!"];
        return ;
    }
    if (addressTF.text.length==0) {
        [XHShowHUD showNOHud:@"请填写详细的地区!"];
        return ;
    }
    [self.netWorkConfig setObject:@"" forKey:@""];
    [self.netWorkConfig setObject:@"" forKey:@""];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"userId"];
    [self.netWorkConfig setObject:self.model.addressId forKey:@"addressId"];
    [self.netWorkConfig setObject:nameTF.text forKey:@"consignee"];
    [self.netWorkConfig setObject:teleTF.text forKey:@"telephone"];
    [self.netWorkConfig setObject:self.model.provinceId forKey:@"provinceId"];
    [self.netWorkConfig setObject:self.model.provinceName forKey:@"provinceName"];
    [self.netWorkConfig setObject:self.model.cityId forKey:@"cityId"];
    [self.netWorkConfig setObject:self.model.cityName forKey:@"cityName"];
    [self.netWorkConfig setObject:self.model.areaId forKey:@"areaId"];
    [self.netWorkConfig setObject:self.model.areaName forKey:@"areaName"];
    [self.netWorkConfig setObject:addressTF.text forKey:@"addressDetail"];
    [XHShowHUD showTextHud];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_userAddress003" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } error:^(NSError *error) {
        
    }];
   
}
#pragma mark-----------选择地址后回调代理方法----------
-(void)getAddress:(NSString *)address
{
    if (address) {
        NSArray *arr=[address componentsSeparatedByString:@" "];
        self.model.provinceName=[NSString safeString:arr[0]];
        self.model.cityName=[NSString safeString:arr[1]];
        self.model.areaName=[NSString safeString:arr[2]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //一个cell刷新
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
            
            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
        });
    }
   
}
#pragma mark-----------选择输入框代理方法----------
- (void)textViewDidChange:(UITextView *)textView
{
    XHCustomTextField *nameTF=[_tableView viewWithTag:10086];
    XHCustomTextField *teleTF=[_tableView viewWithTag:10086+1];
    XHCustomTextField *addressTF=[_tableView viewWithTag:10086+3];
    NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    //找到对应的cell
    XHUserTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    if (nameTF.text.length<5&&nameTF.text.length>0&&[XHCustomTextField verifyPhone:teleTF.text]&&cell.backLabel.text.length!=0&&addressTF.text.length!=0) {
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [_sureBtn setTitleColor:LOGIN_BEFORE forState:UIControlStateNormal];
    }
    NSIndexPath *  IndexPath = [NSIndexPath indexPathForRow:textView.tag-10086 inSection:0];
    //找到对应的cell
    XHAddTableViewCell *addCell = [_tableView cellForRowAtIndexPath:IndexPath];
    addCell.clearButton.hidden=NO;
}
-(void)clearBtnClick:(UIButton *)btn
{
    NSIndexPath *  IndexPath = [NSIndexPath indexPathForRow:btn.tag-1008611 inSection:0];
    //找到对应的cell
    XHAddTableViewCell *addCell = [_tableView cellForRowAtIndexPath:IndexPath];
    addCell.textView.text=@"";
    addCell.clearButton.hidden=YES;
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
