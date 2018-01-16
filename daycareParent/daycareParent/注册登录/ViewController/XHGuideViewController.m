//
//  XHGuideViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHGuideViewController.h"
#import "XHGuideViewContentView.h"



@interface XHGuideViewController ()

@property (nonatomic,strong) XHGuideViewContentView *contentView; //!< 滚动视图


@end




@implementation XHGuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self navtionHidden:YES];
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
        
        //添加数据源数据
        [self.contentView resetFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        for (int i = 0 ; i < 4; i++)
        {
            NSString *imageName = [NSString stringWithFormat:@"guid%d.png",i];
            [self.dataArray addObject:imageName];
        }
        [self.contentView setItemArray:self.dataArray];
    }
}



-(XHGuideViewContentView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHGuideViewContentView alloc]init];
    }
    return _contentView;
}



@end
