//
//  XHBindViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHBindViewController.h"
#import "XHPassWordTableViewCell.h"
#import "XHChildListModel.h"
#import "XHStudentDetailViewController.h"
@interface XHBindViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *frontArry;
    NSArray *placeArry;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet XHBaseBtn *sureBtn;

@end

@implementation XHBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavtionTitle:@"绑定学生"];
    frontArry=@[@"名称",@"学号"];
    placeArry=@[@"请输入学生名称",@"请输入学生学号"];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=50;
    _tableView.bounces=NO;
    [_tableView registerNib:[UINib nibWithNibName:@"XHPassWordTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHPassWordTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLb.text=frontArry[indexPath.row];
    if (indexPath.row==1) {
        cell.textFD.keyboardType=UIKeyboardTypeNumberPad;
    }
    cell.textFD.tag=indexPath.row+10086;
    [cell.textFD addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
    cell.textFD.placeholder=placeArry[indexPath.row];
    return cell;
}
-(void)textChage
{
    UITextField *childName=[_tableView viewWithTag:10086];
    UITextField *studyNumber=[_tableView viewWithTag:10086+1];
    if (childName.text.length>1&&studyNumber.text.length>0)
    {
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [_sureBtn setTitleColor:LOGIN_BEFORE forState:UIControlStateNormal];
    }
}
- (IBAction)sureBtnClick:(id)sender {
    UITextField *childName=[_tableView viewWithTag:10086];
    UITextField *studyNumber=[_tableView viewWithTag:10086+1];
    if (childName.text.length>4) {
        [XHShowHUD showNOHud:@"姓名最多为四个字!"];
        return;
    }
    if (studyNumber.text.length==0) {
        [XHShowHUD showNOHud:@"请输入正确的学号!"];
        return;
    }
    XHNetWorkConfig *net=[XHNetWorkConfig new];
    [net setObject:childName.text forKey:@"studentName"];
    [net setObject:studyNumber.text forKey:@"archiveId"];
    [XHShowHUD showTextHud];
    [net postWithUrl:@"zzjt-app-api_student001" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSDictionary *dic=[object objectItemKey:@"object"];
            XHChildListModel *model=[[XHChildListModel alloc] initWithDic:dic];
            XHStudentDetailViewController *detail=[XHStudentDetailViewController new];
            detail.listModel=model;
            [self.navigationController pushViewController:detail animated:YES];
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
