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
@property (nonatomic,strong) XHddressBookMaskView *bookMaskView;
@property (nonatomic,strong) UIView *lineView;



@end

@implementation XHddressBookSwitchMenuView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.bookMaskView];
        [self addSubview:self.toolBar];
        [self addSubview:self.lineView];
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
    [self.bookMaskView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.toolBar resetFrame:CGRectMake(self.bookMaskView.right, self.bookMaskView.top, (self.bookMaskView.width - 80.0), self.bookMaskView.height)];
    [self.lineView setFrame:CGRectMake(0, frame.size.height-0.5, self.toolBar.right, 0.5)];
    [self setContentSize:CGSizeMake(self.lineView.width, frame.size.height)];
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


-(XHddressBookMaskView *)bookMaskView
{
    if (!_bookMaskView)
    {
        _bookMaskView = [[XHddressBookMaskView alloc]init];
    }
    return _bookMaskView;
}


-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}


@end
