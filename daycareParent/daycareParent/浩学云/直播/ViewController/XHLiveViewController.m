//
//  XHLiveViewController.m
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLiveViewController.h"
#import "XHLiveContentView.h"


@interface XHLiveViewController ()


@property (nonatomic,strong) XHLiveContentView *contentView;


@end

@implementation XHLiveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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


-(XHLiveContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHLiveContentView alloc]init];
    }
    return _contentView;
}


@end
