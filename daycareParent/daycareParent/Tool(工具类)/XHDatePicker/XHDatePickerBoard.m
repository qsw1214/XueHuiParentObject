//
//  XHDatePickerBoard.m
//  daycareParent
//
//  Created by mac on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDatePickerBoard.h"


@interface XHDatePickerBoard ()


@property (nonatomic,strong) UILabel *tipLabel; //!< 提示标签


@end

@implementation XHDatePickerBoard



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.datePicker];
        [self addSubview:self.cancleControl];
        [self addSubview:self.tipLabel];
        [self addSubview:self.confirmControl];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        
        [self setItemColor:NO];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.cancleControl resetFrame:CGRectMake(0, 0, frame.size.width/3.0, 30.0)];
    [self.cancleControl setTitleEdgeFrame:CGRectMake(20.0, 0, (self.cancleControl.width-40.0), self.cancleControl.height) withNumberType:0 withAllType:NO];
    [self.tipLabel setFrame:CGRectMake(self.cancleControl.right, self.cancleControl.top, self.cancleControl.width, self.cancleControl.height)];
    [self.confirmControl resetFrame:CGRectMake(self.tipLabel.right, self.tipLabel.top, self.tipLabel.width, self.tipLabel.height)];
    [self.confirmControl setTitleEdgeFrame:CGRectMake(20.0, 0, (self.cancleControl.width-40.0), self.cancleControl.height) withNumberType:0 withAllType:NO];
    [self.datePicker setFrame:CGRectMake(0, self.tipLabel.bottom, frame.size.width, (frame.size.height-self.tipLabel.height))];
    
}



-(void)setPickerType:(UIDatePickerMode)type
{
    [self.datePicker setDatePickerMode:type];
}


#pragma mark - Getter /  Setter
-(UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc]init];
        //设置背景颜色
        [_datePicker setBackgroundColor:[UIColor clearColor]];
        //datePicker.center = self.center;
        //设置本地化支持的语言（在此是中文)
        [_datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh"]];
        [_datePicker setMaximumDate:[NSDate date]];
        //显示方式是只显示年月日
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        [_datePicker setDate:[NSDate date] animated:YES];
    }
    return _datePicker;
}

-(BaseButtonControl *)cancleControl
{
    if (!_cancleControl)
    {
        _cancleControl = [[BaseButtonControl alloc]init];
        [_cancleControl setNumberLabel:1];
        [_cancleControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_cancleControl setFont:FontLevel1 withNumberType:0 withAllType:NO];
        [_cancleControl setTextColor:[UIColor grayColor] withTpe:0 withAllType:NO];
        [_cancleControl setText:@"取消" withNumberType:0 withAllType:NO];
        [_cancleControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
    }
    return _cancleControl;
}


-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setTextColor:[UIColor grayColor]];
        [_tipLabel setTextAlignment:NSTextAlignmentCenter];
        [_tipLabel setText:@"请选择日期"];
        [_tipLabel setFont:FontLevel2];
        
    }
    return _tipLabel;
}

-(BaseButtonControl *)confirmControl
{
    if (!_confirmControl)
    {
        _confirmControl = [[BaseButtonControl alloc]init];
        [_confirmControl setNumberLabel:1];
        [_confirmControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_confirmControl setFont:FontLevel1 withNumberType:0 withAllType:NO];
        [_confirmControl setTextColor:MainColor withTpe:0 withAllType:NO];
        [_confirmControl setText:@"确定" withNumberType:0 withAllType:NO];
        [_confirmControl setTextAlignment:NSTextAlignmentRight withNumberType:0 withAllType:NO];
    }
    return _confirmControl;
}


-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.tipLabel setBackgroundColor:[UIColor orangeColor]];
        [self.cancleControl setItemColor:color];
        [self.confirmControl setItemColor:color];
    }
}
@end
