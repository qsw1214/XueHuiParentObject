//
//  XHLeaveRecordViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHLeaveRecordViewController.h"
#import "XHAskforLeaveViewController.h"
@interface XHLeaveRecordViewController ()

@property (nonatomic,strong) XHLeaveRecordContentView *contentView; //!< 内容视图



@end

@implementation XHLeaveRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"请假记录"];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void)setModel:(XHChildListModel *)model
{
    [self.contentView setModel:model];
}

#pragma mark - Action Method
-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:(CGRect)CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    }
}



#pragma mark - Getter / Setter
-(XHLeaveRecordContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHLeaveRecordContentView alloc]init];
    }
    return _contentView;
}







@end
