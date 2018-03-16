//
//  XHddressBookSwitchMenuView.m
//  daycareParent
//
//  Created by mac on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddressBookSwitchMenuView.h"
#import "XHAddressBookToolBar.h"
#import "XHddressBookMaskView.h"

#define AddressBookSwitchDuration 0.15

@interface XHAddressBookSwitchMenuView () <UIScrollViewDelegate>

@property (nonatomic,strong) XHAddressBookToolBar *toolBar;
@property (nonatomic,strong) XHddressBookMaskView *bookMaskView;
@property (nonatomic,strong) UIView *lineView;



@end

@implementation XHAddressBookSwitchMenuView


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
        
        [self setDelegate:self];
        
    }
    return self;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    if ([self.switchDelegate respondsToSelector:@selector(switchDraggMenuIndexPath:)])
    {
        [self.switchDelegate switchDraggMenuIndexPath:self.indexPath];
    }
    
    NSLog(@"开始拖拽");
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


-(void)setAddressBookFrame:(XHAddressBookFrame *)addressBookFrame
{
     _addressBookFrame = addressBookFrame;
    [self.bookMaskView setItemFrame:addressBookFrame];
    [self.toolBar setItemFrame:addressBookFrame];
    
    switch (addressBookFrame.model.modelType)
    {
        case XHAddressBookSelectType:
        {
            [UIView animateWithDuration:AddressBookSwitchDuration animations:^{
                
                [self setContentOffset:CGPointMake(SCREEN_WIDTH-80.0, 0)];
            }];
        }
            break;
        case XHAddressBookModelNormalType:
        {
            [UIView animateWithDuration:AddressBookSwitchDuration animations:^{
                
                [self setContentOffset:CGPointMake(0, 0)];
                
            }];
        }
            break;
    }
  
    
}

-(void)setIndexPath:(NSInteger)indexPath
{
    _indexPath = indexPath;
    
    [self.bookMaskView setIndexPath:indexPath];
    [self.toolBar setIndexPath:indexPath];
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
        [_bookMaskView.markImageView addTarget:self action:@selector(bookMaskAction:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)bookMaskAction:(BaseButtonControl*)sender
{
//    if ([self.switchDelegate respondsToSelector:@selector(switchDraggMenuIndexPath:)])
//    {
//        [self.switchDelegate switchDraggMenuIndexPath:self.indexPath];
//    }
}



@end
