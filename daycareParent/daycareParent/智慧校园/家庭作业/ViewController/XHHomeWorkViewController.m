//
//  XHHomeWorkViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkViewController.h"
#import "XHHomeWorkDetailsViewController.h" //!< 家庭作业详情


@interface XHHomeWorkViewController () <XHHomeWorkContentViewDeletage>

@property (nonatomic,strong) XHHomeWorkContentView *contentView;

@end

@implementation XHHomeWorkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"家庭作业"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
        
    }
}




#pragma mark - Deletage Method
#pragma mark  XHHomeWorkContentViewDeletage
-(void)didSelectAtIndex:(XHHomeWorkFrame *)frame
{
   
    
    
    XHHomeWorkDetailsViewController *homeWorkDetails = [[XHHomeWorkDetailsViewController alloc]init];
    [homeWorkDetails setItemObjet:frame];
    [self.navigationController pushViewController:homeWorkDetails animated:YES];
    
    homeWorkDetails.refeshBlock = ^(BOOL isRefesh)
    {
        if (isRefesh)
        {
            [self.contentView.tableView beginRefreshing];
        }
    };
}

#pragma mark - Getter / Setter
-(XHHomeWorkContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHHomeWorkContentView alloc]initWithDeletage:self];
    }
    return _contentView;
}



@end
