//
//  XHDateSwitchControl.m
//  daycareParent
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDateSwitchControl.h"
#import "XHDatePicker.h"



@interface XHDateSwitchControl () <XHDatePickerDelegate>

@property (nonatomic,strong) BaseButtonControl *leftArrowControl; //!< 左侧箭头
@property (nonatomic,strong) UILabel *titleLabel; //!< 显示日期标签
@property (nonatomic,strong) BaseButtonControl *rightArrowControl;  //!< 右侧箭头


@property (nonatomic,copy) NSString *yearMontherDay;
@property (nonatomic,assign) NSInteger dateSwitchYear;  //!<  年
@property (nonatomic,assign) NSInteger dateSwitchMonther;  //!<  月
@property (nonatomic,assign) NSInteger dateSwitchDay;  //!<  天
@property (nonatomic,assign) NSInteger unitDay; //!< 当天


@property (nonatomic,assign) NSInteger currentYear;  //!<  年
@property (nonatomic,assign) NSInteger currentMonther;  //!<  月
@property (nonatomic,assign) NSInteger currentDay;  //!<  天
@property (nonatomic,strong) NSDate *currentDate;


@end




@implementation XHDateSwitchControl

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.leftArrowControl];
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightArrowControl];
        [self.titleLabel setText:[self getNonceDate:YES]];
        [self setYearMontherDay:self.titleLabel.text];
        [self setUnitDay:0];
        [self setItemColor:NO];
        
        [self getCurrentYearMonthDay];
        
        [self addTarget:self action:@selector(dateAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //!< 先设置当前的日期
        [self setCurrentDate:[NSDate date]];
        
        
        
        
        
    }
    return self;
}


#pragma mark XHDatePickerDelegate （用户选择日期）
-(void)datePickerAction:(NSString*)date
{
    [self setUnitDay:0];
    NSArray *separatedDate = [date componentsSeparatedByString:@"-"];
    
    NSString *year = [separatedDate objectAtIndex:0];
    NSString *month = [separatedDate objectAtIndex:1];
    NSString *day = [separatedDate objectAtIndex:2];
    NSString *yearmonthday = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
    
    
    
    
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYY-MM-dd"];
    // 设置日期格式 为了转换成功
    // NSString * -> NSDate *
    NSDate *formatdata = [format dateFromString:date];
    [self userSelectedDate:formatdata];
    [self setCurrentDate:formatdata];
    
     [self.titleLabel setText:yearmonthday];
    if ([self.delegate respondsToSelector:@selector(dateSwitchAction:)])
    {
        [self.delegate dateSwitchAction:date];
    }
}

#pragma mark - Private Method
#pragma mark 用户点击了前进和后退按钮
-(void)dateSwitchControlAction:(BaseButtonControl*)sender
{
    NSString *date = @"";
    switch (sender.tag)
    {
        case 1:
        {
            [self.titleLabel setText:[self swithDateWithType:sender.tag]];
            if ([self verifyCurrentYearMonthDay])
            {
                
                date = [NSString stringWithFormat:@"%@-%@-%@",[self formatterNumer:self.dateSwitchYear],[self formatterNumer:self.dateSwitchMonther],[self formatterNumer:self.dateSwitchDay]];
                if ([self.delegate respondsToSelector:@selector(dateSwitchAction:)])
                {
                    [self.delegate dateSwitchAction:date];
                }
            }
        }
            break;
        case 2:
        {
            if ([self verifyCurrentYearMonthDay])
            {
                [self.titleLabel setText:[self swithDateWithType:sender.tag]];
                date = [NSString stringWithFormat:@"%@-%@-%@",[self formatterNumer:self.dateSwitchYear],[self formatterNumer:self.dateSwitchMonther],[self formatterNumer:self.dateSwitchDay]];
                if ([self.delegate respondsToSelector:@selector(dateSwitchAction:)])
                {
                    [self.delegate dateSwitchAction:date];
                }
            }
        }
            break;
    }
    
   
    
   
    
}


#pragma mark 用户点击了日期标签
-(void)dateAction:(BaseControl*)sender
{
    XHDatePicker *datePicker = [[XHDatePicker alloc]init];
    [datePicker setDelegate:self];
    [datePicker show];
    
  
}


-(NSString*)swithDateWithType:(NSInteger)type
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    switch (type)
    {
        case 1:
        {
            [self setDateSwitchDay:(self.dateSwitchDay-1)];
        }
            break;
        case 2:
        {
            [self setDateSwitchDay:(self.dateSwitchDay+1)];
        }
            break;
    }
    
   [self dateSwitchDayithType:type withCalendar:calendar withNSDateComponents:components];
    
    

    
   return self.yearMontherDay;
}








#pragma mark - Getter /  Setter
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    //!< 重置左侧按钮Frame
    [self.leftArrowControl resetFrame:CGRectMake(0, 0, (frame.size.width/3.0)-20.0, frame.size.height)];
    [self.leftArrowControl setImageEdgeFrame:CGRectMake(((self.leftArrowControl.width-20.0)/2.0), ((self.leftArrowControl.height-20.0)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
    
    //!< 重置中间标题Frame
    [self.titleLabel setFrame:CGRectMake(self.leftArrowControl.right, 0, (frame.size.width/3.0)+40.0,self.leftArrowControl.height)];
    
    //!< 重置右侧按钮Frame
    [self.rightArrowControl resetFrame:CGRectMake(self.titleLabel.right, 0, self.leftArrowControl.width, self.titleLabel.height)];
    [self.rightArrowControl setImageEdgeFrame:CGRectMake(((self.rightArrowControl.width-20.0)/2.0), ((self.rightArrowControl.height-20.0)/2.0), 20.0, 20.0) withNumberType:0 withAllType:NO];
}


-(BaseButtonControl *)leftArrowControl
{
    if (!_leftArrowControl)
    {
        _leftArrowControl = [[BaseButtonControl alloc]init];
        [_leftArrowControl setNumberImageView:1];
        [_leftArrowControl setImage:@"ico_arr_l" withNumberType:0 withAllType:NO];
        [_leftArrowControl addTarget:self action:@selector(dateSwitchControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftArrowControl setTag:1];
        [_leftArrowControl setBackgroundColor:[UIColor clearColor]];
    }
    return _leftArrowControl;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [_titleLabel setTextColor:MainColor];
        [_titleLabel setText:@"2018年12月11日"];
    }
    return _titleLabel;
}

-(BaseButtonControl *)rightArrowControl
{
    if (!_rightArrowControl)
    {
        _rightArrowControl = [[BaseButtonControl alloc]init];
        [_rightArrowControl setNumberImageView:1];
        [_rightArrowControl setImage:@"ico_arr_r" withNumberType:0 withAllType:NO];
        [_rightArrowControl addTarget:self action:@selector(dateSwitchControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightArrowControl setTag:2];
        [_rightArrowControl setBackgroundColor:[UIColor clearColor]];
    }
    return _rightArrowControl;
}


-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.leftArrowControl setItemColor:color];
        [self.titleLabel setBackgroundColor:[UIColor orangeColor]];
        [self.rightArrowControl setItemColor:color];
    }
}



//方式一：XXXX年-XX月-XX日  XX时:XX分:XX秒的格式
- (void)LoginAction:(UIButton *)sender

{
    
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
    
}








#pragma mark 字符串日期换成NSDate格式
-(NSDate*)dateFromString:(NSString*)dateString
{
    // 日期格式化类
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    [formatter setDateFormat:@"YYYY-MM-dd"];
    // NSString * -> NSDate *
    NSDate *date = [formatter dateFromString:dateString];
    
    return date;
}



#pragma mark 获取当前日期字符串格式
-(NSString*)getNonceDate:(BOOL)nonce
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
    
    [self setDateSwitchYear:[components year]];
    [self setDateSwitchMonther:[components month]];
    [self setDateSwitchDay:[components day]];
    NSString *yearMontherDay = @"";
    
    if (nonce)
    {
        
        yearMontherDay = [NSString stringWithFormat:@"%@年%@月%@日",[self formatterNumer:self.dateSwitchYear],[self formatterNumer:self.dateSwitchMonther],[self formatterNumer:self.dateSwitchDay]];
        
        NSLog(@"%@",yearMontherDay);
        
    }
    else
    {
        yearMontherDay = [NSString stringWithFormat:@"%@-%@-%@",[self formatterNumer:self.dateSwitchYear],[self formatterNumer:self.dateSwitchMonther],[self formatterNumer:self.dateSwitchDay]];
    }
   
    return yearMontherDay;
}


#pragma mark 获取当前日期字符串格式
-(NSString*)getNonceDateFormatter:(BOOL)nonce
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    
    NSString *yearMonthDa = [NSString stringWithFormat:@"%zd-%zd-%zd",year,month,day];
    return yearMonthDa;
}


#pragma mark - 重置日期
-(void)resetDate:(BOOL)nocnce
{
    [self.titleLabel setText:[self getNonceDate:nocnce]];
    [self getCurrentYearMonthDay];
}



/**
 格式化数字

 @param number 传入的数字如果小于10的话（0-9）
 @return 格式化后的数字字符串（01，02，03...09）
 */
-(NSString*)formatterNumer:(NSInteger)number
{
    NSString *formatterNumber = @"";
    if (number < 10)
    {
        formatterNumber = [NSString stringWithFormat:@"0%zd",number];
    }
    else
    {
        formatterNumber = [NSString stringWithFormat:@"%zd",number];
    }
    return formatterNumber;
}


-(BOOL)verifyCurrentYearMonthDay
{
    if ((self.dateSwitchYear >= self.currentYear) && (self.dateSwitchMonther >= self.currentMonther) && (self.dateSwitchDay >= self.currentDay))
    {
        [XHShowHUD showNOHud:@"不能超过当前日期"];
        return NO;
    }
    else
    {
        return YES;
    }
}




#pragma mark 获取当前年月日
-(void)getCurrentYearMonthDay
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *newdate = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:newdate];
    
    
    [self setCurrentYear:[components year]];
    [self setCurrentMonther:[components month]];
    [self setCurrentDay:[components day]];
    
    [self setDateSwitchYear:[components year]];
    [self setDateSwitchMonther:[components month]];
    [self setDateSwitchDay:[components day]];
    
    //!< 重置到当前日期
    [self setCurrentDate:[NSDate date]];
    [self setUnitDay:0];
}

#pragma mark 用户选择了日期
-(void)userSelectedDate:(NSDate*)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *newdate = [calendar dateByAddingComponents:components toDate:date options:0];
    components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:newdate];

    
    [self setDateSwitchYear:[components year]];
    [self setDateSwitchMonther:[components month]];
    [self setDateSwitchDay:[components day]];
}



-(void)dateSwitchDayithType:(NSInteger)type withCalendar:(NSCalendar*)calendar withNSDateComponents:(NSDateComponents*)components
{
    switch (type)
    {
            
        case 1:
        {
            [self setUnitDay:(self.unitDay-1)];
            [components setDay:self.unitDay];
        }
            break;
        case 2:
        {
            [self setUnitDay:(self.unitDay+1)];
            [components setDay:self.unitDay];
        }
            break;
    }
    
    NSDate *newdate = [calendar dateByAddingComponents:components toDate:self.currentDate options:0];
    components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:newdate];
    
    
    [self setDateSwitchYear:[components year]];
    [self setDateSwitchMonther:[components month]];
    [self setDateSwitchDay:[components day]];
    
    if (self.dateSwitchYear >= self.currentYear)
    {
        if (self.dateSwitchMonther >= self.currentMonther)
        {
            if (self.dateSwitchYear <= self.currentYear)
            {
                if (self.dateSwitchYear >= self.currentYear)
                {
                    [self setDateSwitchYear:self.currentYear];
                }
                
                if (self.dateSwitchMonther >= self.currentMonther)
                {
                    [self setDateSwitchMonther:self.currentMonther];
                }
                
                if (self.dateSwitchDay >= self.currentDay)
                {
                    [self setDateSwitchDay:self.currentDay];
                }
            }
        }
    }
    
    
    
    
 
     [self setYearMontherDay:[NSString stringWithFormat:@"%@年%@月%@日",[self formatterNumer:self.dateSwitchYear],[self formatterNumer:self.dateSwitchMonther],[self formatterNumer:self.dateSwitchDay]]];
}


@end
