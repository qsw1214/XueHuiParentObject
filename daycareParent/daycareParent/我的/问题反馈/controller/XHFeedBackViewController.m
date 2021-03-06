//
//  XHFeedBackViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHFeedBackViewController.h"

@interface XHFeedBackViewController ()<BaseTextViewDeletage>
@property(nonatomic,strong)BaseTextView *questionTextView;//!<字数限制
@property(nonatomic,strong)UIView *limitBackGroudView;//!<字数限制背景
@property(nonatomic,strong)UILabel *limitLabel;//!< 实时显示字数

@property(nonatomic,strong)UIButton *sureButton;//!< 提交按钮

@end

@implementation XHFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"问题反馈"];
    [self.questionTextView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 200)];
    [self.view addSubview:self.questionTextView];
    
    [self.limitBackGroudView setFrame:CGRectMake(0, self.questionTextView.bottom, SCREEN_WIDTH, 30)];
      [self.view addSubview:self.limitBackGroudView];
                                                 
    [self.limitLabel setFrame:CGRectMake(0, self.questionTextView.bottom, SCREEN_WIDTH-10, 30)];
    [self.view addSubview:self.limitLabel];
    [self.sureButton setFrame:CGRectMake(40, self.limitLabel.bottom+40, SCREEN_WIDTH-80, 44)];
    [self.sureButton addTarget:self action:@selector(sureBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureButton];
}
#pragma mark-----提交问题按钮方法
-(void)sureBtnMethod
{
    if ([self.questionTextView.text isEqualToString:@""]) {
        [XHShowHUD showNOHud:@"反馈内容不能为空！"];
        return;
    }
    [XHShowHUD showTextHud];
    [self.netWorkConfig setObject:self.questionTextView.text forKey:@"content"];
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"userId"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_saveFeedBack" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            [XHShowHUD showOKHud:@"提交成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - Deletage Method
#pragma mark BaseTextViewDeletage
- (void)textViewDidChange:(UITextView *)textView
{
    //实时显示字数
    [self.limitLabel setText:[NSString stringWithFormat:@"%lu/500", (unsigned long)textView.text.length]];
    
    //字数限制操作
    if (textView.text.length >= 500)
    {
        textView.text = [textView.text substringToIndex:500];
        [self.limitLabel setText:@"500/500"];
        
    }
}
#pragma mark 请输入反馈内容
-(BaseTextView *)questionTextView
{
    if (_questionTextView == nil)
    {
        _questionTextView = [[BaseTextView alloc]init];
        [_questionTextView setPlaceholder:@"请输入反馈内容"];
        [_questionTextView setTintColor:MainColor];
        [_questionTextView setTextDeletage:self];
    }
    return _questionTextView;
}
#pragma mark 字数限制
-(UILabel *)limitLabel
{
    if (_limitLabel == nil)
    {
        _limitLabel = [[UILabel alloc]init];
        _limitLabel.backgroundColor=[UIColor whiteColor];
        [_limitLabel setTextAlignment:NSTextAlignmentRight];
        [_limitLabel setFont:FontLevel4];
        [_limitLabel setTextColor:RGB(64, 64, 64)];
        [_limitLabel setText:@"0/500"];
    }
    return _limitLabel;
}
-(UIView *)limitBackGroudView
{
    if (_limitBackGroudView==nil) {
        _limitBackGroudView = [[UIView alloc]init];
        _limitBackGroudView.backgroundColor=[UIColor whiteColor];
    }
    return _limitBackGroudView;
}
-(UIButton *)sureButton
{
    if (_sureButton==nil) {
        _sureButton=[[UIButton alloc] init];
        [_sureButton setBackgroundColor:MainColor];
        [_sureButton setTitle:@"提交" forState:UIControlStateNormal];
        [_sureButton setLayerCornerRadius:5.0];
        _sureButton.layer.masksToBounds=YES;
    }
    return _sureButton;
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
