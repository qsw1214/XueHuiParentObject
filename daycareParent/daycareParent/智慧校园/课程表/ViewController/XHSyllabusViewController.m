//
//  XHSyllabusViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSyllabusViewController.h"
#import "XHSyllabusContentView.h"
#import "XHChildListModel.h"
@interface XHSyllabusViewController ()<XHCustomViewDelegate>

@property (nonatomic,strong) XHSyllabusContentView *contentView; //!< 内容视图
@end

@implementation XHSyllabusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"课程表"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([XHUserInfo sharedUserInfo].childListArry.count>1)
    {
        XHChildListModel *childModel=[XHUserInfo sharedUserInfo].childListArry[0];
        [self setItemContentType:NavigationIconAndTitle withItemType:NavigationItemRightype withIconName:@"ico-dorpdown" withTitle:[childModel studentName]];
        [self.contentView getModel:childModel];
    }
    else if ([XHUserInfo sharedUserInfo].childListArry.count==1)
    {
        XHChildListModel *childModel=[XHUserInfo sharedUserInfo].childListArry[0];
        [self.contentView getModel:childModel];
    }
    else
    {
        [self.contentView.tableView beginRefreshing];
    }
    
    
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
        [self setChildListArry:[XHUserInfo sharedUserInfo].childListArry];
    }
}


#pragma mark - Getter / Setter
-(XHSyllabusContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHSyllabusContentView alloc]init];
    }
    return _contentView;
}

-(void)getChildModel:(XHChildListModel *)childModel
{
     [self setRightItemTitle:[childModel studentName]];
    
    [self.contentView getModel:childModel];
    
}
#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
    if (self.childListView.isExist==NO) {
         self.childListView.delegate=self;
        [self.view addSubview:self.childListView];
        self.childListView.isExist=YES;
    }
    else
    {
        [self.childListView removeFromSuperview];
        self.childListView.isExist=NO;
    }
}



@end
