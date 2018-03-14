//
//  XHSyllabusCellContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSyllabusCellContentView.h"


@interface XHSyllabusCellContentView ()

@property (nonatomic,strong) UILabel *monthLabel; //!< 时间标签
@property (nonatomic,strong) UILabel *mondayLabel; //!< 周一标签
@property (nonatomic,strong) UILabel *tuesdayLabel; //!< 周二标签
@property (nonatomic,strong) UILabel *wednesdayLabel; //!< 周三标签
@property (nonatomic,strong) UILabel *thursdayLabel; //!< 周四标签
@property (nonatomic,strong) UILabel *fridayLabel; //!< 周五标签

//@property (nonatomic,strong) UILabel *monthNumberLabel; //!< 时间标签
//@property (nonatomic,strong) UILabel *mondayLabel; //!< 周一标签
//@property (nonatomic,strong) UILabel *tuesdayLabel; //!< 周二标签
//@property (nonatomic,strong) UILabel *wednesdayLabel; //!< 周三标签
//@property (nonatomic,strong) UILabel *thursdayLabel; //!< 周四标签
//@property (nonatomic,strong) UILabel *fridayLabel; //!< 周五标签



@end



@implementation XHSyllabusCellContentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.monthLabel];
        [self addSubview:self.mondayLabel];
        [self addSubview:self.tuesdayLabel];
        [self addSubview:self.wednesdayLabel];
        [self addSubview:self.thursdayLabel];
        [self addSubview:self.fridayLabel];
        
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setItemColor:NO];
    }
    return self;
}


-(void)setItemFrame:(XHSyllabusFrame *)itemFrame
{
    [self setFrame:itemFrame.itemFrame];
    
    
#pragma mark - 重置Frame
    switch (itemFrame.model.modelType)
    {
        case SyllabusWeekType:
        {
            //!< 重置Frame
            [self.monthLabel setFrame:CGRectMake(0, 0, 30.0, 50.0)];
            [self.mondayLabel setFrame:CGRectMake(self.monthLabel.right, self.monthLabel.top, ((itemFrame.itemFrame.size.width-30.0)/5.0), self.monthLabel.height)];
            
            //!< 设置属性
            [self.monthLabel setFont:FontLevel2A];
            [self.mondayLabel setFont:FontLevel2A];
            [self.tuesdayLabel setFont:FontLevel2A];
            [self.wednesdayLabel setFont:FontLevel2A];
            [self.thursdayLabel setFont:FontLevel2A];
            [self.fridayLabel setFont:FontLevel2A];
        }
            break;
        case SyllabusContentType:
        {
            //!< 重置Frame
            [self.monthLabel setFrame:CGRectMake(0, 0, 30.0, 60.0)];
            [self.mondayLabel setFrame:CGRectMake(self.monthLabel.right, self.monthLabel.top, ((itemFrame.itemFrame.size.width-30.0)/5.0), self.monthLabel.height)];
            
            //!< 设置属性
            [self.monthLabel setFont:FontLevel2];
            [self.mondayLabel setFont:FontLevel2];
            [self.tuesdayLabel setFont:FontLevel2];
            [self.wednesdayLabel setFont:FontLevel2];
            [self.thursdayLabel setFont:FontLevel2];
            [self.fridayLabel setFont:FontLevel2];
        }
            break;
    }
    
    
    [self.tuesdayLabel setFrame:CGRectMake(self.mondayLabel.right, self.monthLabel.top, self.mondayLabel.width, self.monthLabel.height)];
    [self.wednesdayLabel setFrame:CGRectMake(self.tuesdayLabel.right, self.monthLabel.top, self.tuesdayLabel.width, self.monthLabel.height)];
    [self.thursdayLabel setFrame:CGRectMake(self.wednesdayLabel.right, self.monthLabel.top, self.wednesdayLabel.width, self.monthLabel.height)];
    [self.fridayLabel setFrame:CGRectMake(self.thursdayLabel.right, self.monthLabel.top, self.thursdayLabel.width, self.monthLabel.height)];
    
    
#pragma mark - 重新赋值
    [self.monthLabel setText:itemFrame.model.month];
    [self.mondayLabel setText:itemFrame.model.monday];
    [self.tuesdayLabel setText:itemFrame.model.tuesday];
    [self.wednesdayLabel setText:itemFrame.model.wednesday];
    [self.thursdayLabel setText:itemFrame.model.thursday];
    [self.fridayLabel setText:itemFrame.model.friday];
    
}


-(void)setTextColor:(UIColor*)color
{
    
}

-(void)setFont:(UIFont*)font
{
    
}

-(void)setTime:(NSString*)time
{
    
}

-(void)setSubject:(NSString*)subject
{
    
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    
}





#pragma mark - Getter / Setter
-(UILabel *)monthLabel
{
    if (_monthLabel == nil)
    {
        _monthLabel = [[UILabel alloc]init];
        [_monthLabel setLayerBorderWidth:0.5];
        [_monthLabel setBorderColor:LineViewColor];
        [_monthLabel setTextAlignment:NSTextAlignmentCenter];
        [_monthLabel setNumberOfLines:0];
    }
    return _monthLabel;
}

-(UILabel *)mondayLabel
{
    if (_mondayLabel == nil)
    {
        _mondayLabel = [[UILabel alloc]init];
        [_mondayLabel setLayerBorderWidth:0.5];
        [_mondayLabel setBorderColor:LineViewColor];
        [_mondayLabel setTextAlignment:NSTextAlignmentCenter];
        [_mondayLabel setNumberOfLines:0];
    }
    return _mondayLabel;
}

-(UILabel *)tuesdayLabel
{
    if (_tuesdayLabel == nil)
    {
        _tuesdayLabel = [[UILabel alloc]init];
        [_tuesdayLabel setLayerBorderWidth:0.5];
        [_tuesdayLabel setBorderColor:LineViewColor];
        [_tuesdayLabel setTextAlignment:NSTextAlignmentCenter];
        [_tuesdayLabel setNumberOfLines:0];
    }
    return _tuesdayLabel;
}


-(UILabel *)wednesdayLabel
{
    if (_wednesdayLabel == nil)
    {
        _wednesdayLabel = [[UILabel alloc]init];
        [_wednesdayLabel setLayerBorderWidth:0.5];
        [_wednesdayLabel setBorderColor:LineViewColor];
        [_wednesdayLabel setTextAlignment:NSTextAlignmentCenter];
        [_wednesdayLabel setNumberOfLines:0];
    }
    return _wednesdayLabel;
}


-(UILabel *)thursdayLabel
{
    if (_thursdayLabel == nil)
    {
        _thursdayLabel = [[UILabel alloc]init];
        [_thursdayLabel setLayerBorderWidth:0.5];
        [_thursdayLabel setBorderColor:LineViewColor];
        [_thursdayLabel setTextAlignment:NSTextAlignmentCenter];
        [_thursdayLabel setNumberOfLines:0];
    }
    return _thursdayLabel;
}


-(UILabel *)fridayLabel
{
    if (_fridayLabel == nil)
    {
        _fridayLabel = [[UILabel alloc]init];
        [_fridayLabel setLayerBorderWidth:0.5];
        [_fridayLabel setBorderColor:LineViewColor];
        [_fridayLabel setTextAlignment:NSTextAlignmentCenter];
        [_fridayLabel setNumberOfLines:0];
    }
    return _fridayLabel;
}


-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.monthLabel setBackgroundColor:[UIColor orangeColor]];
        [self.mondayLabel setBackgroundColor:[UIColor purpleColor]];
        [self.tuesdayLabel setBackgroundColor:[UIColor yellowColor]];
        [self.wednesdayLabel setBackgroundColor:[UIColor magentaColor]];
        [self.thursdayLabel setBackgroundColor:[UIColor brownColor]];
        [self.fridayLabel setBackgroundColor:[UIColor orangeColor]];
    }
}



@end
