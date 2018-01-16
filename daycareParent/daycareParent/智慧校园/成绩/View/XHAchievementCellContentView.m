//
//  XHAchievementCellContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAchievementCellContentView.h"

@interface XHAchievementCellContentView ()

@property (nonatomic,strong) UILabel *subjectLabel; //!< 科目
@property (nonatomic,strong) UILabel *batchLabel; //!< 批次
@property (nonatomic,strong) UILabel *scoreLabel; //!< 分数


@end


@implementation XHAchievementCellContentView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.subjectLabel];
        [self addSubview:self.batchLabel];
        [self addSubview:self.scoreLabel];
        
    }
    return self;
}

-(void)setTextColor:(UIColor*)color
{
    [self.subjectLabel setTextColor:color];
    [self.batchLabel setTextColor:color];
    [self.scoreLabel setTextColor:color];
}

-(void)setFont:(UIFont*)font
{
    [self.subjectLabel setFont:font];
    [self.batchLabel setFont:font];
    [self.scoreLabel setFont:font];
}
-(void)setSubject:(NSString*)subject
{
    [self.subjectLabel setText:subject];
}
-(void)setBatch:(NSString*)batch
{
    [self.batchLabel setText:batch];
}

-(void)setScore:(NSString*)score
{
    [self.scoreLabel setText:score];
}




-(void)setItemFrame:(XHAchievementFrame*)frame
{
    [self resetFrame:frame.itemFrame];
    
    switch (frame.model.contentType)
    {
        case XHAchievementTitleType:
        {
            [self setBackgroundColor:RGB(198.0, 253, 242)];
        }
            break;
        case XHAchievementContentType:
        {
            [self setBackgroundColor:[UIColor whiteColor]];
        }
            break;
    }
    
    //!< 赋值
    [self.subjectLabel setText:frame.model.subject];
    [self.batchLabel setText:frame.model.batch];
    [self.scoreLabel setText:frame.model.score];
    
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    
    [self.subjectLabel setFrame:CGRectMake(0, 0, frame.size.width/4.0, frame.size.height)];
    [self.batchLabel setFrame:CGRectMake(self.subjectLabel.right, 0, self.subjectLabel.width*2, self.subjectLabel.height)];
    [self.scoreLabel setFrame:CGRectMake(self.batchLabel.right, self.subjectLabel.top, self.subjectLabel.width, self.subjectLabel.height)];
}


#pragma mark - Getter / Setter
-(UILabel *)subjectLabel
{
    if (_subjectLabel == nil)
    {
        _subjectLabel = [[UILabel alloc]init];
        [_subjectLabel setTextAlignment:NSTextAlignmentCenter];
        [_subjectLabel setNumberOfLines:0];
        [_subjectLabel setLayerBorderWidth:0.5];
        [_subjectLabel setBorderColor:LineViewColor];
    }
    return _subjectLabel;
}

-(UILabel *)batchLabel
{
    if (_batchLabel == nil)
    {
        _batchLabel = [[UILabel alloc]init];
        [_batchLabel setTextAlignment:NSTextAlignmentCenter];
        [_batchLabel setNumberOfLines:0];
        [_batchLabel setLayerBorderWidth:0.5];
        [_batchLabel setBorderColor:LineViewColor];
        
    }
    return _batchLabel;
}


-(UILabel *)scoreLabel
{
    if (_scoreLabel == nil)
    {
        _scoreLabel = [[UILabel alloc]init];
        [_scoreLabel setTextAlignment:NSTextAlignmentCenter];
        [_scoreLabel setNumberOfLines:0];
        [_scoreLabel setLayerBorderWidth:0.5];
        [_scoreLabel setBorderColor:LineViewColor];
    }
    return _scoreLabel;
}


@end
