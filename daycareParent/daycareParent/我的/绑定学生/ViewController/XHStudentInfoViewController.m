//
//  XHStudentInfoViewController.m
//  daycareParent
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHStudentInfoViewController.h"
#import "XHStudentInfoContentView.h"
#import "XHBindPasswordViewController.h"



@interface XHStudentInfoViewController () <XHStudentInfoContentViewDelegate>

@property (nonatomic,strong) XHStudentInfoContentView *contentView;
@property (nonatomic,strong) XHChildListModel *model;

@end

@implementation XHStudentInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"学生信息"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom)];
    }
}


-(void)getChildInfo:(XHChildListModel*)model
{
    [self.contentView getChildInfo:model];
    [self setModel:model];
    
    
    
    
}


#pragma mark - Delegate Method
#pragma mark XHStudentInfoContentViewDelegate
-(void)studentInfoControlAction:( NSInteger)sender
{
    switch (sender)
    {
#pragma mark - case 3 修改密码
        case 1:
        {
            
        }
            break;
#pragma mark - case 3 修改密码
        case 2:
        {
            XHBindPasswordViewController *bindPassword = [[XHBindPasswordViewController alloc]init];
            [bindPassword setModel:self.model];
            [self.navigationController pushViewController:bindPassword animated:YES];
        }
            break;
#pragma mark - case 3 解除绑定
        case 3:
        {
            if (self.isRefresh)
            {
                self.isRefresh(YES);
            }
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
            break;
    }
}




#pragma mark - Getter /  Setter
-(XHStudentInfoContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHStudentInfoContentView alloc]init];
        [_contentView setInfoDelegate:self];
    }
    return _contentView;
}

@end
