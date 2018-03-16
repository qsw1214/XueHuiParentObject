//
//  XHAlertControl.m
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAlertControl.h"
#import "XHAlertBoardControl.h"



@interface XHAlertControl ()


@property (nonatomic,strong) XHAlertBoardControl *alertBoard;



@end

@implementation XHAlertControl

- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.3)];
        [self addSubview:self.alertBoard];
        [self.alertBoard resetFrame:CGRectMake(50.0, 100.0, SCREEN_WIDTH-100.0, 300.0)];
        
        [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


#pragma mark - Public Method
-(void)show
{
    [kWindow addSubview:self];
    
//    [UIView animateWithDuration:0.35 animations:^{
//
//        [self.alertBoard setTransform:CGAffineTransformMakeScale(1.5, 1.5)];
//        [self.alertBoard setTransform:CGAffineTransformMakeScale(0.5, 0.5)];
//
//    } completion:^(BOOL finished)
//     {
//        [self.alertBoard setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
//     }];
    
    
//    self.alertBoard.layer.position = self.center;
//    self.alertBoard.transform = CGAffineTransformMakeScale(0.60, 0.60);
//    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.alertBoard.transform = CGAffineTransformMakeScale(1.0, 1.0);
//    } completion:^(BOOL finished)
//    {
//    }];
    
    
    
    self.alertBoard.alpha = 0;
    self.alertBoard.transform = CGAffineTransformScale(self.transform,0.1,0.1);
    [UIView animateWithDuration:AlertTime animations:^{
        self.alertBoard.transform = CGAffineTransformIdentity;
        self.alertBoard.alpha = 1;
    }];
    
}



-(void)dismiss
{
    [self removeFromSuperview];
}




#pragma mark - Getter /  Setter
-(XHAlertBoardControl *)alertBoard
{
    if (!_alertBoard)
    {
        _alertBoard = [[XHAlertBoardControl alloc]init];
        [_alertBoard setBackgroundColor:[UIColor greenColor]];
    }
    return _alertBoard;
}



@end


