//
//  XHBindViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHBindViewController.h"
#import "XHChildListModel.h"
#import "XHStudentInfoViewController.h"
#import "XHBindViewContentView.h"
#import "XHAddBindPasswordViewController.h"


@interface XHBindViewController () <XHBindViewContentViewDelegate>

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


#pragma mark - Delertage Method
#pragma mark XHBindViewContentViewDelegate
-(void)submitControlAction:(XHNetWorkConfig*)sender
{
    [sender postWithUrl:@"zzjt-app-api_studentBinding001" sucess:^(id object, BOOL verifyObject)
    {
        if (verifyObject)
        {
            
            NSString *isBinding = @"";
            
            
            
        }
        
        
        
    } error:^(NSError *error)
     {
         
         
         
         
     }];
    
//    [self.navigationController pushViewController:[[XHAddBindPasswordViewController alloc]init] animated:YES];
////    [self.navigationController pushViewController:[[XHStudentInfoViewController alloc]init] animated:YES];
}

-(XHBindViewContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHBindViewContentView alloc]init];
        [_contentView setActionDeletgate:self];
    }
    return _contentView;
}


@end
