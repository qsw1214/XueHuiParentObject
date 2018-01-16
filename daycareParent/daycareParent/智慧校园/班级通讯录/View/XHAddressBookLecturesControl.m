//
//  XHAddressBookLecturesControl.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookLecturesControl.h"
#import "XHAddressBookLecturesContentView.h"


@interface XHAddressBookLecturesControl ()

@property (nonatomic,strong) XHAddressBookLecturesContentView *contentView;
@end

@implementation XHAddressBookLecturesControl






- (instancetype)init
{
    self = [super initWithFrame:WindowScreen];
    if (self)
    {
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.7)];
        [self addSubview:self.contentView];
    }
    return self;
}


-(void)show
{
    [UIView animateWithDuration:0.3 animations:^{
        
        [kWindow addSubview:self];
        
    }];
}

-(void)dismiss
{
    [UIView animateWithDuration:0.15 animations:^{
        
        [self setContentView:nil];
        [self setHidden:YES];
        [self removeFromSuperview];
        
    }];
}


-(void)setItemFrame:(id)frame
{
    [self.contentView setItemFrame:frame];
}

-(void)setItemArray:(NSMutableArray *)array
{
    [self.contentView setItemArray:array];
}





#pragma mark - Getter / Setter
-(XHAddressBookLecturesContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHAddressBookLecturesContentView alloc]init];
        [_contentView.confirmControl addTarget:self action:@selector(confirmControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contentView;
}



-(void)confirmControlAction:(BaseButtonControl*)sender
{
    [self dismiss];
}






@end
