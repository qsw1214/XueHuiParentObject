//
//  XHCommonAlertControl.m
//  daycareParent
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHCommonAlertControl.h"

@interface XHCommonAlertControl ()

@property (nonatomic,assign) XHCommonAlertControlType type;

@property (nonatomic,strong) id <XHCommonAlertControlDelegate> alertdelegeta;

@end

@implementation XHCommonAlertControl


-(instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle withType:(XHCommonAlertControlType)type
{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.3)];
        [self addSubview:self.alertBoard];
        [self setType:type];
        [self.alertBoard setWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle];
        [self.alertBoard setCenter:self.center];
        
        [self setAlertdelegeta:delegate];
    }
    return self;
}



#pragma mark - Getter /  Setter
-(XHCommonAlertBoardControl *)alertBoard
{
    if (!_alertBoard)
    {
        _alertBoard = [[XHCommonAlertBoardControl alloc]init];
        [_alertBoard.cancelControl addTarget:self action:@selector(alertBoardAction:) forControlEvents:UIControlEventTouchUpInside];
        [_alertBoard.confirmControl addTarget:self action:@selector(alertBoardAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alertBoard;
}

-(void)show
{
    [kWindow addSubview:self];
    [self.alertBoard setCenter:self.center];
    [self.alertBoard setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
    [self.alertBoard setAlpha:0.0];
    [UIView animateWithDuration:0.35 animations:^{
        [self.alertBoard setAlpha:1.0];
        [self.alertBoard setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        
    } completion:^(BOOL finished){}];
}

-(void)dismiss
{
    [self removeFromSuperview];
}


-(void)alertBoardAction:(BaseButtonControl*)sender
{
    
    switch (sender.tag)
    {
        case 1:
        {
            [self dismiss];
        }
            break;
        case 2:
        {
            switch (self.type)
            {
                case XHCommonAlertNormalType:
                {
                    [self dismiss];
                }
                    break;
                case XHCommonAlertAppStore:
                    break;
            }
            
            
            if ([self.alertdelegeta respondsToSelector:@selector(alertBoardAction:)])
            {
                [self.alertdelegeta alertBoardAction:sender];
            }
            
        }
            break;
    }
}





@end
