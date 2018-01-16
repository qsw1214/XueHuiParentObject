//
//  XHScuessViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHScuessViewController.h"
#import "XHLoginViewController.h"
@interface XHScuessViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet XHBaseLabel *titleLabel;
@property (strong, nonatomic) IBOutlet XHBaseBtn *sureBtn;

@end

@implementation XHScuessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self setNavtionTitle:@"更改安全电话"];
     [self navtionItemHidden:NavigationItemLeftType];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"新手机号登录名设置成功\n下次请使用%@登录\n登录密码不变",self.telephoneStr]]; // 改变特定范围颜色大小要用的
    [attributedString addAttribute:NSForegroundColorAttributeName value:MainColor range:NSMakeRange(17,11)];
    _titleLabel.attributedText=attributedString;
}
- (IBAction)sureBtn:(id)sender {
    //跳转到登录页面
    XHLoginViewController *login=[[XHLoginViewController alloc] init];
    [NSUserDefaults removeObjectItemForKey:AutoLogin];
    [self.navigationController pushViewController:login animated:YES];
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
