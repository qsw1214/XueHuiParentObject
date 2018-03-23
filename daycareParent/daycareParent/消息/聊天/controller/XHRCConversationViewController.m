//
//  XHRCConversationViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/10.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHRCConversationViewController.h"
@interface XHRCConversationViewController ()
@property(nonatomic,strong)UIView *navigationView;
@end

@implementation XHRCConversationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[RCIM sharedRCIM] setGlobalMessageAvatarStyle:RC_USER_AVATAR_CYCLE];//修改为圆形头像
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view setBackgroundColor:RGB(235.0, 235.0, 235.0)];
    [self.navigationController.navigationBar setHidden:YES];
    [self.view addSubview:self.navigationView];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor whiteColor];
    if ([[XHHelper sharedHelper]isIphoneX]) {
        self.view.frame=CGRectMake(0, 94, SCREEN_WIDTH, SCREEN_HEIGHT-94-50-34);
    }
    else
    {
       self.view.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-50);
    }
    
    self.conversationMessageCollectionView.frame=self.view.frame;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
}

-(UIView *)navigationView
{
    if (_navigationView == nil)
    {
        if ([[XHHelper sharedHelper]isIphoneX]) {
            _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 94.0)];
            ParentImageView *iconImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(10, 67, 10, 10)];
            iconImageView.image=[UIImage imageNamed:@"arr_back"];
            [_navigationView addSubview:iconImageView];
            UILabel *Label=[[UILabel alloc] initWithFrame:CGRectMake(20, 60, 50, 24)];
            Label.text=@"返回";
            Label.textColor=[UIColor blackColor];
            Label.font=FontLevel3;
            Label.textAlignment=NSTextAlignmentCenter;
            [_navigationView addSubview:Label];
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(10, 60, 50, 24)];
            [btn addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
            [_navigationView addSubview:btn];
            UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 93, SCREEN_WIDTH, 1)];
            bottomView.backgroundColor=LineViewColor;
            [_navigationView addSubview:bottomView];
        }
        else
        {
            _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64.0)];
            ParentImageView *iconImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(10, 37, 10, 10)];
            iconImageView.image=[UIImage imageNamed:@"arr_back"];
            [_navigationView addSubview:iconImageView];
            UILabel *Label=[[UILabel alloc] initWithFrame:CGRectMake(20, 30, 50, 24)];
            Label.text=@"返回";
            Label.textColor=[UIColor blackColor];
            Label.font=FontLevel3;
            Label.textAlignment=NSTextAlignmentCenter;
            [_navigationView addSubview:Label];
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(10, 30, 50, 24)];
            [btn addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
            [_navigationView addSubview:btn];
            UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
            bottomView.backgroundColor=LineViewColor;
            [_navigationView addSubview:bottomView];
        }
       
    }
    return _navigationView;
}
-(void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UILabel *)titleLabel
{
    if (_titleLabel==nil) {
       
        if ([[XHHelper sharedHelper]isIphoneX]) {
             _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(35, 60, SCREEN_WIDTH-70, 24)];
        }
        else
        {
             _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(35, 30, SCREEN_WIDTH-70, 24)];
        }
        _titleLabel.textColor=[UIColor blackColor];
        _titleLabel.font=FontLevel1;
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.navigationView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
