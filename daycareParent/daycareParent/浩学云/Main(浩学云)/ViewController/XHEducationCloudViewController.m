//
//  XHEducationCloudViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//






#pragma mark 浩学云(教育云)


#import "XHEducationCloudViewController.h"
#import "XHEducationCloudContentView.h"
#import "XHEducationCloudFrame.h"
#import "BaseMenuModel.h"



@interface XHEducationCloudViewController () 

@property (nonatomic,strong)  XHEducationCloudContentView *contentView;







@end

@implementation XHEducationCloudViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"浩学云"];
    [self navtionItemHidden:NavigationItemLeftType];
    [self setItemContentType:NavigationIconype withItemType:NavigationItemRightype withIconName:@"个人中心_S" withTitle:@"我的"];
    [self setItemTextColor:[UIColor yellowColor] withItemType:NavigationItemRightype];
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
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height-50.0)];
        [self.contentView addSwitchModel:YES];
        
    }
}






#pragma mark - Getter / Setter
-(XHEducationCloudContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHEducationCloudContentView alloc]initWithDeletage:self];
    }
    return _contentView;
}








@end
