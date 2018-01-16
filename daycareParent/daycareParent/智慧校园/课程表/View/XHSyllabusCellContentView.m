//
//  XHSyllabusCellContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSyllabusCellContentView.h"


@interface XHSyllabusCellContentView ()

@property (nonatomic,strong) UILabel *timeLabel; //!< 时间标签
@property (nonatomic,strong) UILabel *subjectLabel; //!< 科目标签


@end



@implementation XHSyllabusCellContentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.timeLabel];
        [self addSubview:self.subjectLabel];
    }
    return self;
}


-(void)setItemFrame:(XHSyllabusFrame *)itemFrame
{
    [self resetFrame:itemFrame.itemFrame];
    
    //赋值
    [self.timeLabel setText:itemFrame.model.time];
    [self.subjectLabel setText:itemFrame.model.subject];

}


-(void)setTextColor:(UIColor*)color
{
    [self.timeLabel setTextColor:color];
    [self.subjectLabel setTextColor:color];
}

-(void)setFont:(UIFont*)font
{
    [self.timeLabel setFont:font];
    [self.subjectLabel setFont:font];
}

-(void)setTime:(NSString*)time
{
    [self.timeLabel setText:time];
}

-(void)setSubject:(NSString*)subject
{
    [self.subjectLabel setText:subject];
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.timeLabel setFrame:CGRectMake(0, 0, frame.size.width/2.0, frame.size.height)];
    [self.subjectLabel setFrame:CGRectMake(self.timeLabel.right, self.timeLabel.top, self.timeLabel.width, self.timeLabel.height)];
    
}





#pragma mark - Getter / Setter
-(UILabel *)timeLabel
{
    if (_timeLabel == nil)
    {
        _timeLabel = [[UILabel alloc]init];
        [_timeLabel setLayerBorderWidth:0.5];
        [_timeLabel setBorderColor:LineViewColor];
        [_timeLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _timeLabel;
}

-(UILabel *)subjectLabel
{
    if (_subjectLabel == nil)
    {
        _subjectLabel = [[UILabel alloc]init];
        [_subjectLabel setLayerBorderWidth:0.5];
        [_subjectLabel setBorderColor:LineViewColor];
        [_subjectLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _subjectLabel;
}

@end
