//
//  XHSyllabusCellContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSyllabusCellContentView.h"
#import "XHSyllabusBoardControl.h"


@interface XHSyllabusCellContentView ()

@property (nonatomic,strong) UILabel *monthLabel; //!< 时间标签
@property (nonatomic,strong) UILabel *mondayLabel; //!< 周一标签
@property (nonatomic,strong) UILabel *tuesdayLabel; //!< 周二标签
@property (nonatomic,strong) UILabel *wednesdayLabel; //!< 周三标签
@property (nonatomic,strong) UILabel *thursdayLabel; //!< 周四标签
@property (nonatomic,strong) UILabel *fridayLabel; //!< 周五标签

@property (nonatomic,strong) XHSyllabusBoardControl *monthBoard;
@property (nonatomic,strong) XHSyllabusBoardControl *mondayBoard;
@property (nonatomic,strong) XHSyllabusBoardControl *tuesdayBoard;
@property (nonatomic,strong) XHSyllabusBoardControl *wednesdayBoard;
@property (nonatomic,strong) XHSyllabusBoardControl *thursdayBoard;
@property (nonatomic,strong) XHSyllabusBoardControl *fridayBoard;







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
        
        [self addSubview:self.monthBoard];
        [self addSubview:self.mondayBoard];
        [self addSubview:self.tuesdayBoard];
        [self addSubview:self.wednesdayBoard];
        [self addSubview:self.thursdayBoard];
        [self addSubview:self.fridayBoard];
        
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setItemColor:NO];
    }
    return self;
}


-(void)setItemFrame:(XHSyllabusFrame *)itemFrame
{
    [self setFrame:itemFrame.itemFrame];
    
//    [self setLabelHidden:YES];
//    [self setBoardHidden:YES];
    
    
#pragma mark - 重置Frame
    switch (itemFrame.model.modelType)
    {
        case SyllabusWeekType:
        {
            [self setBoardHidden:NO];
            [self setLabelHidden:YES];
        
            //!< 重置星期标签
            [self.monthBoard resetFrame:CGRectMake(0, self.monthLabel.bottom, 30.0, 50.0)];
            [self.mondayBoard resetFrame:CGRectMake(self.monthBoard.right, self.monthBoard.top, ((itemFrame.itemFrame.size.width-30.0)/5.0), self.monthBoard.height)];
            [self.tuesdayBoard resetFrame:CGRectMake(self.mondayBoard.right, self.mondayBoard.top, self.mondayBoard.width, self.mondayBoard.height)];
            [self.wednesdayBoard resetFrame:CGRectMake(self.tuesdayBoard.right, self.tuesdayBoard.top, self.tuesdayBoard.width, self.tuesdayBoard.height)];
            [self.thursdayBoard resetFrame:CGRectMake(self.wednesdayBoard.right, self.wednesdayBoard.top, self.wednesdayBoard.width, self.wednesdayBoard.height)];
            [self.fridayBoard resetFrame:CGRectMake(self.thursdayBoard.right, self.thursdayBoard.top, self.thursdayBoard.width, self.thursdayBoard.height)];
            
            //!< 设置属性
            [self.monthLabel setFont:FontLevel2A];
            [self.mondayLabel setFont:FontLevel2A];
            [self.tuesdayLabel setFont:FontLevel2A];
            [self.wednesdayLabel setFont:FontLevel2A];
            [self.thursdayLabel setFont:FontLevel2A];
            [self.fridayLabel setFont:FontLevel2A];
            
            
            [self.mondayBoard setDescribeColor:MainColor];
            [self.tuesdayBoard setDescribeColor:MainColor];
            [self.wednesdayBoard setDescribeColor:MainColor];
            [self.thursdayBoard setDescribeColor:MainColor];
            [self.fridayBoard setDescribeColor:MainColor];
            
            
#pragma mark - 重新赋值
            [self.monthBoard setTitle:itemFrame.model.month];
            [self.mondayBoard setTitle:itemFrame.model.monday];
            [self.tuesdayBoard setTitle:itemFrame.model.tuesday];
            [self.wednesdayBoard setTitle:itemFrame.model.wednesday];
            [self.thursdayBoard setTitle:itemFrame.model.thursday];
            [self.fridayBoard setTitle:itemFrame.model.friday];
            
            [self.monthBoard setDescribe:itemFrame.model.monthDescribe];
            [self.mondayBoard setDescribe:itemFrame.model.mondayDescribe];
            [self.tuesdayBoard setDescribe:itemFrame.model.tuesdayDescribe];
            [self.wednesdayBoard setDescribe:itemFrame.model.wednesdayDescribe];
            [self.thursdayBoard setDescribe:itemFrame.model.thursdayDescribe];
            [self.fridayBoard setDescribe:itemFrame.model.fridayDescribe];
        }
            break;
        case SyllabusContentType:
        {
            [self setLabelHidden:NO];
            [self setBoardHidden:YES];
            //!< 重置Frame
            [self.monthLabel setFrame:CGRectMake(0, 0, 30.0, 60.0)];
            [self.mondayLabel setFrame:CGRectMake(self.monthLabel.right, self.monthLabel.top, ((itemFrame.itemFrame.size.width-30.0)/5.0), self.monthLabel.height)];
            [self.tuesdayLabel setFrame:CGRectMake(self.mondayLabel.right, self.monthLabel.top, self.mondayLabel.width, self.monthLabel.height)];
            [self.wednesdayLabel setFrame:CGRectMake(self.tuesdayLabel.right, self.monthLabel.top, self.tuesdayLabel.width, self.monthLabel.height)];
            [self.thursdayLabel setFrame:CGRectMake(self.wednesdayLabel.right, self.monthLabel.top, self.wednesdayLabel.width, self.monthLabel.height)];
            [self.fridayLabel setFrame:CGRectMake(self.thursdayLabel.right, self.monthLabel.top, self.thursdayLabel.width, self.monthLabel.height)];
            
            //!< 设置属性
            [self.monthLabel setFont:FontLevel2];
            [self.mondayLabel setFont:FontLevel2];
            [self.tuesdayLabel setFont:FontLevel2];
            [self.wednesdayLabel setFont:FontLevel2];
            [self.thursdayLabel setFont:FontLevel2];
            [self.fridayLabel setFont:FontLevel2];
            
            
#pragma mark - 重新赋值
            [self.monthLabel setText:itemFrame.model.month];
            [self.mondayLabel setText:itemFrame.model.monday];
            [self.tuesdayLabel setText:itemFrame.model.tuesday];
            [self.wednesdayLabel setText:itemFrame.model.wednesday];
            [self.thursdayLabel setText:itemFrame.model.thursday];
            [self.fridayLabel setText:itemFrame.model.friday];
            
            
            [self.monthBoard setDescribe:@"月"];
            [self.mondayBoard setDescribe:@"周1"];
            [self.tuesdayBoard setDescribe:@"周2"];
            [self.wednesdayBoard setDescribe:@"周3"];
            [self.thursdayBoard setDescribe:@"周4"];
            [self.fridayBoard setDescribe:@"周5"];
        }
            break;
    }
    
    
  
    
    

    
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



-(XHSyllabusBoardControl *)monthBoard
{
    if (_monthBoard == nil)
    {
        _monthBoard = [[XHSyllabusBoardControl alloc]init];
    }
    return _monthBoard;
}

-(XHSyllabusBoardControl *)mondayBoard
{
    if (_mondayBoard == nil)
    {
        _mondayBoard = [[XHSyllabusBoardControl alloc]init];
    }
    return _mondayBoard;
}

-(XHSyllabusBoardControl *)tuesdayBoard
{
    if (_tuesdayBoard == nil)
    {
        _tuesdayBoard = [[XHSyllabusBoardControl alloc]init];
    }
    return _tuesdayBoard;
}


-(XHSyllabusBoardControl *)wednesdayBoard
{
    if (_wednesdayBoard == nil)
    {
        _wednesdayBoard = [[XHSyllabusBoardControl alloc]init];
    }
    return _wednesdayBoard;
}


-(XHSyllabusBoardControl *)thursdayBoard
{
    if (_thursdayBoard == nil)
    {
        _thursdayBoard = [[XHSyllabusBoardControl alloc]init];
    }
    return _thursdayBoard;
}


-(XHSyllabusBoardControl *)fridayBoard
{
    if (_fridayBoard == nil)
    {
        _fridayBoard = [[XHSyllabusBoardControl alloc]init];
    }
    return _fridayBoard;
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
        
        
        [self.monthBoard setBackgroundColor:[UIColor purpleColor]];
         [self.mondayBoard setBackgroundColor:[UIColor orangeColor]];
          [self.tuesdayBoard setBackgroundColor:[UIColor magentaColor]];
           [self.wednesdayBoard setBackgroundColor:[UIColor brownColor]];
            [self.thursdayBoard setBackgroundColor:[UIColor orangeColor]];
             [self.fridayBoard setBackgroundColor:[UIColor yellowColor]];
    }
}


-(void)setLabelHidden:(BOOL)hidden
{
    [self.monthLabel setHidden:hidden];
    [self.mondayLabel setHidden:hidden];
    [self.tuesdayLabel setHidden:hidden];
    [self.wednesdayLabel setHidden:hidden];
    [self.thursdayLabel setHidden:hidden];
    [self.fridayLabel setHidden:hidden];
}


-(void)setBoardHidden:(BOOL)hidden
{
    [self.monthBoard setHidden:hidden];
    [self.mondayBoard setHidden:hidden];
    [self.tuesdayBoard setHidden:hidden];
    [self.wednesdayBoard setHidden:hidden];
    [self.thursdayBoard setHidden:hidden];
    [self.fridayBoard setHidden:hidden];
}





@end
