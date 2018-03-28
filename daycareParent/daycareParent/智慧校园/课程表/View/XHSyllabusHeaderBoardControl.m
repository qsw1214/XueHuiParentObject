//
//  XHSyllabusHeaderBoardControl.m
//  daycareParent
//
//  Created by mac on 2018/3/21.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSyllabusHeaderBoardControl.h"
#import "XHSyllabusBoardControl.h"

@interface XHSyllabusHeaderBoardControl ()

@property (nonatomic,strong) XHSyllabusBoardControl *monthBoard;
@property (nonatomic,strong) XHSyllabusBoardControl *mondayBoard;
@property (nonatomic,strong) XHSyllabusBoardControl *tuesdayBoard;
@property (nonatomic,strong) XHSyllabusBoardControl *wednesdayBoard;
@property (nonatomic,strong) XHSyllabusBoardControl *thursdayBoard;
@property (nonatomic,strong) XHSyllabusBoardControl *fridayBoard;

@end

@implementation XHSyllabusHeaderBoardControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.monthBoard];
        [self addSubview:self.mondayBoard];
        [self addSubview:self.tuesdayBoard];
        [self addSubview:self.wednesdayBoard];
        [self addSubview:self.thursdayBoard];
        [self addSubview:self.fridayBoard];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    //!< 重置星期标签
    [self.monthBoard resetFrame:CGRectMake(0, 0, 30.0, 50.0)];
    [self.mondayBoard resetFrame:CGRectMake(self.monthBoard.right, self.monthBoard.top, ((frame.size.width-30.0)/5.0), self.monthBoard.height)];
    [self.tuesdayBoard resetFrame:CGRectMake(self.mondayBoard.right, self.mondayBoard.top, self.mondayBoard.width, self.mondayBoard.height)];
    [self.wednesdayBoard resetFrame:CGRectMake(self.tuesdayBoard.right, self.tuesdayBoard.top, self.tuesdayBoard.width, self.tuesdayBoard.height)];
    [self.thursdayBoard resetFrame:CGRectMake(self.wednesdayBoard.right, self.wednesdayBoard.top, self.wednesdayBoard.width, self.wednesdayBoard.height)];
    [self.fridayBoard resetFrame:CGRectMake(self.thursdayBoard.right, self.thursdayBoard.top, self.thursdayBoard.width, self.thursdayBoard.height)];
    
    //!< 设置属性
    
    [self.mondayBoard setDescribeColor:MainColor];
    [self.tuesdayBoard setDescribeColor:MainColor];
    [self.wednesdayBoard setDescribeColor:MainColor];
    [self.thursdayBoard setDescribeColor:MainColor];
    [self.fridayBoard setDescribeColor:MainColor];
    
    [self.mondayBoard setTitleColor:RGB(104.0, 111.0, 121.0)];
    [self.tuesdayBoard setTitleColor:RGB(104.0, 111.0, 121.0)];
    [self.wednesdayBoard setTitleColor:RGB(104.0, 111.0, 121.0)];
    [self.thursdayBoard setTitleColor:RGB(104.0, 111.0, 121.0)];
    [self.fridayBoard setTitleColor:RGB(104.0, 111.0, 121.0)];
}


-(void)setItemFrame:(XHSyllabusFrame*)itemFrame
{
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
    
    
    
    
    
    
    switch (itemFrame.model.markType)
    {
        case 1:
        {
            [self.mondayBoard setTitleColor:[UIColor whiteColor]];
            [self.mondayBoard setDescribeColor:[UIColor whiteColor]];
            [self.mondayBoard setBackgroundColor:MainColor];
        }
            break;
        case 2:
        {
            [self.tuesdayBoard setTitleColor:[UIColor whiteColor]];
            [self.tuesdayBoard setDescribeColor:[UIColor whiteColor]];
            [self.tuesdayBoard setBackgroundColor:MainColor];
        }
            break;
        case 3:
        {
            [self.wednesdayBoard setTitleColor:[UIColor whiteColor]];
            [self.wednesdayBoard setDescribeColor:[UIColor whiteColor]];
            [self.wednesdayBoard setBackgroundColor:MainColor];
        }
            break;
        case 4:
        {
            [self.thursdayBoard setTitleColor:[UIColor whiteColor]];
            [self.thursdayBoard setDescribeColor:[UIColor whiteColor]];
            [self.thursdayBoard setBackgroundColor:MainColor];
        }
            break;
        case 5:
        {
            [self.fridayBoard setTitleColor:[UIColor whiteColor]];
            [self.fridayBoard setDescribeColor:[UIColor whiteColor]];
            [self.fridayBoard setBackgroundColor:MainColor];
        }
            break;
        default:
            break;
    }
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
        [self.monthBoard setBackgroundColor:[UIColor purpleColor]];
        [self.mondayBoard setBackgroundColor:[UIColor orangeColor]];
        [self.tuesdayBoard setBackgroundColor:[UIColor magentaColor]];
        [self.wednesdayBoard setBackgroundColor:[UIColor brownColor]];
        [self.thursdayBoard setBackgroundColor:[UIColor orangeColor]];
        [self.fridayBoard setBackgroundColor:[UIColor yellowColor]];
    }
}






@end
