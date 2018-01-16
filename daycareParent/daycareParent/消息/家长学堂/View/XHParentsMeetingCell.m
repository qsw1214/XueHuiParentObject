//
//  XHParentsMeetingCell.m
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHParentsMeetingCell.h"
#import "XHParentsMeetingCellContentView.h"


@interface XHParentsMeetingCell ()

@property (nonatomic,strong) BaseButtonControl *dateControl; //!< 日期标签
@property (nonatomic,strong) XHParentsMeetingCellContentView *cellContentView;

@end



@implementation XHParentsMeetingCell


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.contentView addSubview:self.dateControl];
        [self.contentView addSubview:self.cellContentView];
    }
    return self;
}


-(void)setItemFrame:(XHParentsMeetingFrame*)frame
{
    //设置日期的Frame
    [self.dateControl resetFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.0)];
    [self.dateControl setTitleEdgeFrame:CGRectMake(((self.dateControl.width-150.0)/2.0), 12.5, 150.0, 25.0) withNumberType:0 withAllType:NO];
    [self.dateControl setLabelLayerCornerRadius:(25.0/2.0) withNumberType:0 withAllType:NO];
    [self.dateControl setText:frame.model.date withNumberType:0 withAllType:NO];
    
    //设置内容视图的Frame
    [self.cellContentView resetFrame:CGRectMake(10.0, self.dateControl.bottom, frame.itemFrame.size.width, frame.itemFrame.size.height-self.dateControl.height)];
    [self.cellContentView setItemFrame:frame];
}




#pragma mark - Getter / Setter
-(BaseButtonControl *)dateControl
{
    if (_dateControl == nil)
    {
        _dateControl = [[BaseButtonControl alloc]init];
        [_dateControl setNumberLabel:1];
        [_dateControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_dateControl setTextColor:RGB(31, 31, 31) withTpe:0 withAllType:NO];
        [_dateControl setFont:FontLevel4 withNumberType:0 withAllType:NO];
        [_dateControl setTextBackGroundColor:RGB(224, 224, 224) withTpe:0 withAllType:NO];
    }
    return _dateControl;
}


-(XHParentsMeetingCellContentView *)cellContentView
{
    if (_cellContentView == nil)
    {
        _cellContentView = [[XHParentsMeetingCellContentView alloc]init];
        [_cellContentView setBackgroundColor:[UIColor whiteColor]];
        [_cellContentView setLayerBorderWidth:1.0];
        [_cellContentView setBorderColor:RGB(210, 210, 210)];
        [_cellContentView setLayerCornerRadius:5.0];
    }
    return _cellContentView;
}



@end
