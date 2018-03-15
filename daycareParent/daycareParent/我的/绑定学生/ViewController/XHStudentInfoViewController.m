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
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, CONTENT_HEIGHT)];
    }
}



#pragma mark - Delegate Method
#pragma mark XHStudentInfoContentViewDelegate
-(void)studentInfoControlAction:(BaseButtonControl *)sender
{
    switch (sender.tag)
    {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[[XHBindPasswordViewController alloc]init] animated:YES];
        }
            break;
        case 3:
        {
            
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
