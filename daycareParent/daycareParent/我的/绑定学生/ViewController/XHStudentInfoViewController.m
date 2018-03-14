//
//  XHStudentInfoViewController.m
//  daycareParent
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHStudentInfoViewController.h"
#import "XHStudentInfoContentView.h"


@interface XHStudentInfoViewController ()

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


#pragma mark - Getter /  Setter
-(XHStudentInfoContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHStudentInfoContentView alloc]init];
    }
    return _contentView;
}

@end
