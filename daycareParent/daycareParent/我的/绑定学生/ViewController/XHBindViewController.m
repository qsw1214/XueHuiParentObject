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
#import "XHBindViewContentView.h"


@interface XHBindViewController ()

@property (nonatomic,strong) XHBindViewContentView *contentView;  //!< 内容视图



@end

@implementation XHBindViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"绑定学生"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Public Method
-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, CONTENT_HEIGHT)];
    }
}


-(XHBindViewContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHBindViewContentView alloc]init];
    }
    return _contentView;
}


@end
