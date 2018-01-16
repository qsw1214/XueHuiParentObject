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
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 590);
    [self.view addSubview:scrollView];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.center=CGPointMake(SCREEN_WIDTH/2.0, 64);
    imageView.layer.cornerRadius=20;
    imageView.layer.masksToBounds=YES;
    imageView.image=[UIImage imageNamed:@"tubiao"];
    [scrollView addSubview:imageView];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    UILabel *versionLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 40)];
    versionLabel.textAlignment=NSTextAlignmentCenter;
    versionLabel.text=[NSString stringWithFormat:@"%@%@",app_Name,app_Version];
    [scrollView addSubview:versionLabel];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH-20, 1)];
    label.backgroundColor=RGB(224, 224, 224);
    [scrollView addSubview:label];
    UIImageView *teleIV=[[UIImageView  alloc] initWithFrame:CGRectMake(10, 165, 20, 20)];
    teleIV.image=[UIImage imageNamed:@"ico-tel"];
    [scrollView addSubview:teleIV];
    UILabel *teleLabel=[[UILabel alloc] initWithFrame:CGRectMake(40, 160, 80, 30)];
    teleLabel.text=@"热线电话";
    [scrollView addSubview:teleLabel];
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(100, 160, 150, 30)];
    [btn setTitle:@"400-6778-599" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:MainColor forState:UIControlStateNormal];
    [scrollView addSubview:btn];
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH-20, 1)];
    label1.backgroundColor=RGB(224, 224, 224);
    [scrollView addSubview:label1];
    UIImageView *teleIV2=[[UIImageView  alloc] initWithFrame:CGRectMake(10, 215, 20, 25)];
    teleIV2.image=[UIImage imageNamed:@"ico-company"];
    [scrollView addSubview:teleIV2];
    UILabel *teleLabel2=[[UILabel alloc] initWithFrame:CGRectMake(40, 215, 80, 30)];
    teleLabel2.text=@"企业介绍";
    [scrollView addSubview:teleLabel2];
    UILabel *contentLab=[[UILabel alloc] initWithFrame:CGRectMake(40, 245, SCREEN_WIDTH-50, 160)];
    contentLab.numberOfLines=0;
    contentLab.text=@"北京学汇教育科技有限公司是一家集软、硬件研发、设计、生产及销售为一体的高科综合型企业。公司自成立以来，先后研发出了<园掌助手>、<I学汇>等产品，并将竭力打造集文明、高科、仁爱、诚信为一体的现代化企业。";
    [scrollView addSubview:contentLab];
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(10, 425, SCREEN_WIDTH-20, 1)];
    label2.backgroundColor=RGB(224, 224, 224);
    [scrollView addSubview:label2];
    UIImageView *teleIV3=[[UIImageView  alloc] initWithFrame:CGRectMake(10, 430, 20, 20)];
    teleIV3.image=[UIImage imageNamed:@"ico-erweima-blue"];
    [scrollView addSubview:teleIV3];
    UILabel *teleLabel3=[[UILabel alloc] initWithFrame:CGRectMake(40, 425, 80, 30)];
    teleLabel3.text=@"关注我们";
    [scrollView addSubview:teleLabel3];
    UIImageView *erweimaImg=[[UIImageView alloc] initWithFrame:CGRectMake(40, 460, 120, 120)];
    erweimaImg.image=[UIImage imageNamed:@"erweima"];
    [scrollView addSubview:erweimaImg];
}
-(void)btnClick
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-6778-599"]];
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
