//
//  XHEducationCloudSwitchMenuView.m
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHEducationCloudSwitchMenuView.h"




@implementation XHEducationCloudSwitchMenuView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.menuControl];
        [self addSubview:self.moreControl];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    
    [self.menuControl resetFrame:CGRectMake(10.0, 0, 100.0, 40.0)];
    [self.moreControl resetFrame:CGRectMake((frame.size.width-110.0), 0, 100, 40.0)];
    [self.moreControl setTitleEdgeFrame:CGRectMake(0, 0, self.moreControl.width, self.moreControl.height) withNumberType:0 withAllType:NO];
    
}



-(void)setItemArray:(NSMutableArray*)array;
{
    [self.menuControl setItemArray:array];
}

#pragma mark - Getter / Setter
-(BaseMenuControl *)menuControl
{
    if (!_menuControl)
    {
        _menuControl = [[BaseMenuControl alloc]init];
    }
    return _menuControl;
}


-(BaseButtonControl *)moreControl
{
    if (!_moreControl)
    {
        _moreControl = [[BaseButtonControl alloc]init];
        [_moreControl setNumberLabel:1];
        [_moreControl setFont:FontLevel4 withNumberType:0 withAllType:NO];
        [_moreControl setTextAlignment:NSTextAlignmentRight withNumberType:0 withAllType:NO];
        [_moreControl setTextColor:[UIColor grayColor] withTpe:0 withAllType:NO];
        [_moreControl setText:@"发现更多>>" withNumberType:0 withAllType:NO];
    }
    return _moreControl;
}





@end
