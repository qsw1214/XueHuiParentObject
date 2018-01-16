//
//  XHAskforLeavePreviewToolBar.m
//  daycareParent
//
//  Created by Git on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeavePreviewToolBar.h"







@implementation XHAskforLeavePreviewToolBar

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.deleteControl];
        [self addSubview:self.confirmControl];
        
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.3)];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    
    [self.deleteControl resetFrame:CGRectMake(0, 0, frame.size.height, frame.size.height)];
    [self.confirmControl resetFrame:CGRectMake((frame.size.width-frame.size.height), 0, frame.size.height, frame.size.height)];
    
    [self.deleteControl setImageEdgeFrame:CGRectMake(((self.deleteControl.width-40.0)/2.0), ((self.deleteControl.height-40.0)/2.0), 40.0, 40.0) withNumberType:0 withAllType:NO];
    [self.confirmControl setImageEdgeFrame:CGRectMake(((self.deleteControl.width-40.0)/2.0), ((self.deleteControl.height-40.0)/2.0), 40.0, 40.0) withNumberType:0 withAllType:NO];
    
    
}



#pragma mark - Getter / Setter
-(BaseButtonControl *)deleteControl
{
    if (!_deleteControl)
    {
        _deleteControl = [[BaseButtonControl alloc]init];
        [_deleteControl setNumberImageView:1];
        [_deleteControl setImage:@"askforleave_delete" withNumberType:0 withAllType:NO];
        [_deleteControl setTag:1];
    }
    return _deleteControl;
}


-(BaseButtonControl *)confirmControl
{
    if (!_confirmControl)
    {
        _confirmControl = [[BaseButtonControl alloc]init];
        [_confirmControl setNumberImageView:1];
        [_confirmControl setImage:@"askforleave_mark" withNumberType:0 withAllType:NO];
        [_confirmControl setTag:2];
    }
    return _confirmControl;
}

@end
