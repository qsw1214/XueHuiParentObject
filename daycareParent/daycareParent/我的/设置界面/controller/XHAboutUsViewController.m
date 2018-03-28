//
//  XHAboutUsViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAboutUsViewController.h"
@interface XHAboutUsViewController ()

@end

@implementation XHAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"关于我们"];
    self.view.backgroundColor=[UIColor whiteColor];
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom)];
    [self.view addSubview:scrollView];
    ParentImageView *logo_imageView=[[ParentImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-120)/2.0, 10, 120, 120)];
    logo_imageView.image=[UIImage imageNamed:@"about_logo"];
    [scrollView addSubview:logo_imageView];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, logo_imageView.bottom+10, SCREEN_WIDTH-20, 0.5)];
    label.backgroundColor=LineViewColor;
    [scrollView addSubview:label];
    
    
    ParentLabel *teleLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(10, logo_imageView.bottom+20, 90, 30)];
    teleLabel.text=@"联系电话：";
    [scrollView addSubview:teleLabel];
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(80, teleLabel.top, 150, 30)];
    [btn setTitle:@"0371-6778599" forState:UIControlStateNormal];
    btn.titleLabel.font=kFont(16.0);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scrollView addSubview:btn];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(10, btn.bottom+10, SCREEN_WIDTH-20, 0.5)];
    label1.backgroundColor=LineViewColor;
    [scrollView addSubview:label1];
    ParentLabel *teleLabel2=[[ParentLabel alloc] initWithFrame:CGRectMake(10, label1.bottom, 120, 30)];
    teleLabel2.text=@"公司介绍：";
    [scrollView addSubview:teleLabel2];
    ParentLabel *contentLab=[[ParentLabel alloc] initWithFrame:CGRectMake(10, teleLabel2.bottom, SCREEN_WIDTH-20, 195)];
    contentLab.font=kFont(15.0);
    contentLab.numberOfLines=0;
    contentLab.text=@"       学汇教育专注 <共享+AI智能教育> 大数据学情分析和多元实时交互，致力于打造一站式教育服务生态平台，针对幼儿园、中小学以及第三方教辅机构，核心提供同步学习、实时互动、智慧校园、教育物联等圈层交互式专业服务。通过科学严谨的大数据学情分析，为学生提供量身定制的学习指导方案，为学校量身搭建智慧校园管理运营系统，为教育部门提供客观数据以供决策参考。";
    [contentLab setParagraph:contentLab.text];
    [scrollView addSubview:contentLab];
   scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, contentLab.bottom+20);
}
-(void)btnClick
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0371-6778599"]];
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
