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
@property (nonatomic,copy) NSString *date; //!< 日期

@end

@implementation XHDatePicker



- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        [self addSubview:self.datePickerBoard];
        [self.datePickerBoard.cancleControl setTag:1];
        [self.datePickerBoard.cancleControl addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.datePickerBoard.confirmControl setTag:2];
        [self.datePickerBoard.confirmControl addTarget:self action:@selector(confirmControlAction) forControlEvents:UIControlEventTouchUpInside];
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
    self.date = [NSDate getDateStrWithDateFormatter:YY_DEFAULT_TIME_FORM Date:[NSDate date]];
    [kWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        [self.datePickerBoard setFrame:CGRectMake(0, SCREEN_HEIGHT-self.datePickerBoard.height, SCREEN_WIDTH, self.datePickerBoard.height)];
    } completion:^(BOOL finished) {}];
}


-(void)confirmControlAction
{
    if ([self.delegate respondsToSelector:@selector(datePickerAction:)])
    {
        [self.delegate datePickerAction:self.date];
    }
      [self dismiss];
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

-(void)datePickerAction:(UIDatePicker*)picker
{
    self.date = [NSDate getDateStrWithDateFormatter:YY_DEFAULT_TIME_FORM Date:picker.date];
    
}

#pragma mark - Getter /  Setter
-(XHDatePickerBoard *)datePickerBoard
{
    if (!_datePickerBoard)
    {
        _datePickerBoard = [[XHDatePickerBoard alloc]init];
        [_datePickerBoard.datePicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePickerBoard;
}
-(NSString *)date
{
    if (_date==nil) {
        _date=[[NSString alloc] init];
    }
    return _date;
}
-(void)setMaximumDate:(NSDate *)maximumDate
{
    self.datePickerBoard.datePicker.maximumDate=maximumDate;
}

@end
