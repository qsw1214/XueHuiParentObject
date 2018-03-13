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
    }
    return self;
}


-(void)setItemFrame:(XHSyllabusFrame *)itemFrame
{
    [self resetFrame:itemFrame.itemFrame];
    
    //赋值
    [self addSubview:self.monthLabel];
    [self addSubview:self.mondayLabel];
    [self addSubview:self.tuesdayLabel];
    [self addSubview:self.wednesdayLabel];
    [self addSubview:self.thursdayLabel];
    [self addSubview:self.fridayLabel];

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
    }
    return _monthLabel;
}

-(UILabel *)tuesdayLabel
{
    if (_tuesdayLabel == nil)
    {
        _tuesdayLabel = [[UILabel alloc]init];
        [_tuesdayLabel setLayerBorderWidth:0.5];
        [_tuesdayLabel setBorderColor:LineViewColor];
        [_tuesdayLabel setTextAlignment:NSTextAlignmentCenter];
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
    }
    return _monthLabel;
}


-(UILabel *)fridayLabel
{
    if (_fridayLabel == nil)
    {
        _fridayLabel = [[UILabel alloc]init];
        [_fridayLabel setLayerBorderWidth:0.5];
        [_fridayLabel setBorderColor:LineViewColor];
        [_fridayLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _fridayLabel;
}



@end
