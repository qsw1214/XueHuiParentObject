//
//  XHDynamicsViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsViewController.h"
#import "XHDynamicsContentView.h"


@interface XHDynamicsViewController ()

@property (nonatomic,strong) XHDynamicsContentView *contentView; //!< 内容视图


@end

@implementation XHDynamicsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"班级动态"];

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
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    }
}


#pragma mark - Getter / Setter
-(XHDynamicsContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHDynamicsContentView alloc]initWithDeletage:self];
    }
    return _contentView;
}



@end
