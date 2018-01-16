//
//  XHAskforLeaveViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeaveViewController.h"
#import "XHLeaveRecordViewController.h"
#import "XHAskforLeaveContentView.h"



@interface XHAskforLeaveViewController ()

@property (nonatomic,strong) XHAskforLeaveContentView *contentView;


@end

@implementation XHAskforLeaveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"请假"];
    [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"请假记录"];
   
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
        [self.contentView resetFrame:CGRectMake(0, self. navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    }
}


#pragma mark - Action Method
-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    [[XHUserInfo sharedUserInfo].childListArry enumerateObjectsUsingBlock:^(XHChildListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         
         switch (obj.markType)
         {
             case ChildListSelectType:
             {
                 XHLeaveRecordViewController *leaveRecord = [[XHLeaveRecordViewController alloc]init];
                 [leaveRecord setModel:obj];
                 [self.navigationController pushViewController:leaveRecord animated:YES];
             }
                 break;
             case ChildListNormalType:
                 break;
         }
     }];
}


#pragma mark - Getter / Setter
-(XHAskforLeaveContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHAskforLeaveContentView alloc]initWithObject:self];
        
    }
    return _contentView;
}


@end
