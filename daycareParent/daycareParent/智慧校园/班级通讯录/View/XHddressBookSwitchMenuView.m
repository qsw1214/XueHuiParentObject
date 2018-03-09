//
//  XHddressBookSwitchMenuView.m
//  daycareParent
//
//  Created by mac on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHddressBookSwitchMenuView.h"
#import "XHAddressBookToolBar.h"
#import "XHddressBookMaskView.h"



@interface XHddressBookSwitchMenuView ()

@property (nonatomic,strong) XHAddressBookToolBar *toolBar;
@property (nonatomic,strong) XHddressBookMaskView *maskView;




@end

@implementation XHddressBookSwitchMenuView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.maskView];
        [self addSubview:self.toolBar];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setPagingEnabled:YES];
        
    }
    return self;
}



#pragma mark - Public Method
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.maskView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.toolBar resetFrame:CGRectMake(self.maskView.right, self.maskView.top, self.maskView.width, self.maskView.height)];
    [self setContentSize:CGSizeMake(self.maskView.right+200.0, frame.size.height)];
}


#pragma mark - Getter /  Setter
-(XHAddressBookToolBar *)toolBar
{
    if (!_toolBar)
    {
        _toolBar = [[XHAddressBookToolBar alloc]init];
    }
    return _toolBar;
}


-(XHddressBookMaskView *)maskView
{
    if (!_maskView)
    {
        _maskView = [[XHddressBookMaskView alloc]init];
    }
    return _maskView;
}



@end
