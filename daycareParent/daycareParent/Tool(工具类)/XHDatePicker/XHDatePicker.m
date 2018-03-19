//
//  XHDatePicker.m
//  daycareParent
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDatePicker.h"
#import "XHDatePickerBoard.h"


@interface XHDatePicker ()

@property (nonatomic,strong) XHDatePickerBoard *datePickerBoard; //!< 日期模块


@end

@implementation XHDatePicker



- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        [self addSubview:self.datePickerBoard];
        [self.datePickerBoard.cancleControl addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.datePickerBoard.confirmControl addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.datePickerBoard resetFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 200.0)];
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.3)];
        [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}



-(void)setPickerType:(UIDatePickerMode)type;
{
    [self.datePickerBoard setPickerType:type];
}



#pragma mark - Public Method
-(void)show
{
    
    [kWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.datePickerBoard setFrame:CGRectMake(0, SCREEN_HEIGHT-self.datePickerBoard.height, SCREEN_WIDTH, self.datePickerBoard.height)];
        
        
    } completion:^(BOOL finished) {}];
}



-(void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.datePickerBoard setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.datePickerBoard.height)];
        
        
    } completion:^(BOOL finished)
    {
        [self removeFromSuperview];
        [self setDatePickerBoard:nil];
    }];
}




#pragma mark - Getter /  Setter
-(XHDatePickerBoard *)datePickerBoard
{
    if (!_datePickerBoard)
    {
        _datePickerBoard = [[XHDatePickerBoard alloc]init];
        [_datePickerBoard.datePicker addTarget:self action:@selector(a) forControlEvents:UIControlEventValueChanged];
    }
    return _datePickerBoard;
}



@end
