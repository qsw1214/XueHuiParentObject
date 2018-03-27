//
//  XHChangeNameViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHChangeNameViewController.h"

@interface XHChangeNameViewController ()
@property(nonatomic,strong)UITextField *textFeild;
@end

@implementation XHChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"修改姓名"];
    [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"完成"];
    [self setItemTextColor:MainColor withItemType:NavigationItemRightype];
    [self.view addSubview:self.textFeild];
}

-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    if (self.textFeild.text.length==0)
    {
        [XHShowHUD showNOHud:@"请输入内容!"];
        return ;
    }
    if (self.textFeild.text.length>4)
    {
        [XHShowHUD showNOHud:@"姓名最多为四个字!"];
        return ;
    }
    [XHShowHUD showTextHud];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"id"];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"selfId"];
    [self.netWorkConfig setObject:self.textFeild.text forKey:@"guardianName"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_user004" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSDictionary *dic=[object objectItemKey:@"object"];
            [XHUserInfo sharedUserInfo].guardianModel.guardianName=[dic objectItemKey:@"guardianName"];
            [self.navigationController popViewControllerAnimated:YES];
            if (self.isRefresh) {
                self.isRefresh(YES);
            }
            
        }
    } error:^(NSError *error) {
        
    }];
}
-(UITextField *)textFeild
{
    if (_textFeild==nil) {
        _textFeild=[[UITextField alloc] initWithFrame:CGRectMake(10, self.navigationView.bottom+10,SCREEN_WIDTH-20 , 50)];
        _textFeild.placeholder=@"请输入姓名";
        _textFeild.clearButtonMode=UITextFieldViewModeWhileEditing;
        UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, _textFeild.top, SCREEN_WIDTH, _textFeild.height)];
        bgView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:bgView];
    }
    return _textFeild;
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
