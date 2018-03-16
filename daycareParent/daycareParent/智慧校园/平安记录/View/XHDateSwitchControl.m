//
//  XHDateSwitchControl.m
//  daycareParent
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDateSwitchControl.h"


@interface XHDateSwitchControl ()

@property (nonatomic,strong) BaseButtonControl *leftArrowControl; //!< 左侧箭头
@property (nonatomic,strong) UILabel *titleLabel; //!< 显示日期标签
@property (nonatomic,strong) BaseButtonControl *rightArrowControl;  //!< 右侧箭头

@property (nonatomic,assign) NSInteger dateSwitchYear;  //!<  年
@property (nonatomic,assign) NSInteger dateSwitchMonther;  //!<  月
@property (nonatomic,assign) NSInteger dateSwitchDay;  //!<  天
@property (nonatomic,assign) NSInteger unitDay; //!< 当天


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
        [self setUnitDay:0];
        [self setItemColor:NO];
        
    }
    return self;
}



#pragma mark - Private Method
-(void)dateSwitchControlAction:(BaseButtonControl*)sender
{
    [self.titleLabel setText:[self swithDateWithType:sender.tag]];
    NSString *date = [NSString stringWithFormat:@"%zd-%zd-%zd",self.dateSwitchYear,self.dateSwitchMonther,self.dateSwitchDay];
    
    if ([self.delegate respondsToSelector:@selector(dateSwitchAction:)])
    {
        [self.delegate dateSwitchAction:date];
    }
    
    
    
}


-(NSString*)swithDateWithType:(NSInteger)type
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
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
   
    
    NSDate *newdate = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    

    components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:newdate];
    
    
    [self setDateSwitchYear:[components year]];
    [self setDateSwitchMonther:[components month]];
    [self setDateSwitchDay:[components day]];
    
    
    NSString *dateFormatter = [self getNonceDateFormatter:YES];
    NSArray *dateArray = [dateFormatter componentsSeparatedByString:@"-"];

    NSInteger year = [[dateArray objectAtIndex:0] integerValue];
    NSInteger month = [[dateArray objectAtIndex:1] integerValue];
    NSInteger day = [[dateArray objectAtIndex:2] integerValue];
    
    if (self.dateSwitchYear >= year)
    {
        [self setDateSwitchYear:year];
    }
    
    if (self.dateSwitchMonther >= month)
    {
        [self setDateSwitchMonther:month];
    }
    
    if (self.dateSwitchDay >= day)
    {
        [self setDateSwitchDay:day];
    }
    
    NSString *yearMontherDay = [NSString stringWithFormat:@"%zd年%zd月%zd日",self.dateSwitchYear,self.dateSwitchMonther,self.dateSwitchDay];
    
    NSLog(@"%@",yearMontherDay);
    
    
    return yearMontherDay;
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
        
        yearMontherDay = [NSString stringWithFormat:@"%zd年%zd月%zd日",self.dateSwitchYear,self.dateSwitchMonther,self.dateSwitchDay];
        
        NSLog(@"%@",yearMontherDay);
        
    }
    else
    {
        yearMontherDay = [NSString stringWithFormat:@"%zd-%zd-%zd日",self.dateSwitchYear,self.dateSwitchMonther,self.dateSwitchDay];
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
}



@end
