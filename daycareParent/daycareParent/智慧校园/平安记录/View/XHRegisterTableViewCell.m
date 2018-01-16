//
//  XHRegisterTableViewCell.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHRegisterTableViewCell.h"
#import "XHRegisterItemControl.h"




#define TIMESOLT  12.0
@interface XHRegisterTableViewCell ()


@property (nonatomic,strong) XHRegisterItemControl *titleControl;  //!< 标题 “王小虎  10-11”
@property (nonatomic,strong) XHRegisterItemControl *contentControl;  //!< 标题 “王小虎  10-11”
@end


@implementation XHRegisterTableViewCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.titleControl];
        [self.contentView addSubview:self.contentControl];
    }
    return self;
}



-(void)setItemFrame:(XHRegisterFrame *)itemFrame
{
    _itemFrame = itemFrame;
    
    
    //设置每个空间的Frame
    [self.titleControl resetFrame:CGRectMake(10, 0, (itemFrame.itemFrame.size.width-20.0), 40.0)];
    [self.contentControl resetFrame:CGRectMake(self.titleControl.left, self.titleControl.bottom, self.titleControl.width, (itemFrame.itemFrame.size.height-self.titleControl.height))];
    //设置“titleControl”的每个空间中子控件的位置Frame
    [self.titleControl setTitleEdgeFrame:CGRectMake(0, 0, self.titleControl.width/2.0, self.titleControl.height) withNumberType:0 withAllType:NO];
    [self.titleControl setTitleEdgeFrame:CGRectMake(self.titleControl.width/2.0, 0, self.titleControl.width/2.0, self.titleControl.height) withNumberType:1 withAllType:NO];
    //设置“contentControl”的每个空间中子控件的位置Frame
    //签到时间
    [self.contentControl setTitleEdgeFrame:CGRectMake((self.contentControl.width/4.0)*0, (self.contentControl.height/2.0), (self.contentControl.width/4.0), (self.contentControl.height/2.0)) withNumberType:0 withAllType:NO];
    [self.contentControl setTitleEdgeFrame:CGRectMake((self.contentControl.width/4.0)*1, 0, (self.contentControl.width/4.0), (self.contentControl.height/2.0)) withNumberType:1 withAllType:NO];
    [self.contentControl setTitleEdgeFrame:CGRectMake((self.contentControl.width/4.0)*2, (self.contentControl.height/2.0), (self.contentControl.width/4.0), (self.contentControl.height/2.0)) withNumberType:2 withAllType:NO];
    [self.contentControl setTitleEdgeFrame:CGRectMake((self.contentControl.width/4.0)*3, 0, (self.contentControl.width/4.0), (self.contentControl.height/2.0)) withNumberType:3 withAllType:NO];
    //签到原点
    [self.contentControl setImageEdgeFrame:CGRectMake(((self.contentControl.width-TIMESOLT)/8.0)*1, ((self.contentControl.height-TIMESOLT)/2.0), TIMESOLT, TIMESOLT) withNumberType:0 withAllType:NO];
    [self.contentControl setImageEdgeFrame:CGRectMake(((self.contentControl.width-TIMESOLT)/8.0)*3, ((self.contentControl.height-TIMESOLT)/2.0), TIMESOLT, TIMESOLT) withNumberType:1 withAllType:NO];
    [self.contentControl setImageEdgeFrame:CGRectMake(((self.contentControl.width-TIMESOLT)/8.0)*5, ((self.contentControl.height-TIMESOLT)/2.0), TIMESOLT, TIMESOLT) withNumberType:2 withAllType:NO];
    [self.contentControl setImageEdgeFrame:CGRectMake(((self.contentControl.width-TIMESOLT)/8.0)*7, ((self.contentControl.height-TIMESOLT)/2.0), TIMESOLT, TIMESOLT) withNumberType:3 withAllType:NO];
    [self.contentControl setImageLayerCornerRadius:(TIMESOLT/2.0) withNumberType:0 withAllType:YES];
    //签到中间分割线
    [self.contentControl resetLineViewFrame:CGRectMake(0,(self.contentControl.height-1.0)/2.0 , self.contentControl.width, 1.0) withNumberType:0 withAllType:NO];
    
    
    //赋值
    [self.titleControl setText:itemFrame.model.userName withNumberType:0 withAllType:NO];
    [self.titleControl setText:itemFrame.model.registerDate withNumberType:1 withAllType:NO];
    //签到时间赋值
    [self.contentControl setTimeSoltImageWithType:itemFrame.model.oneTimeSoltTyp withTitle:itemFrame.model.oneTimeSolt withNumber:0];
    [self.contentControl setTimeSoltImageWithType:itemFrame.model.twoTimeSoltType withTitle:itemFrame.model.twoTimeSolt withNumber:1];
    [self.contentControl setTimeSoltImageWithType:itemFrame.model.threeTimeSoltType withTitle:itemFrame.model.threeTimeSolt withNumber:2];
    [self.contentControl setTimeSoltImageWithType:itemFrame.model.fourTimeSoltType withTitle:itemFrame.model.fourTimeSolt withNumber:3];

}


#pragma mark - Getter / Setter
-(XHRegisterItemControl *)titleControl
{
    if (_titleControl == nil)
    {
        _titleControl = [[XHRegisterItemControl alloc]init];
        [_titleControl setNumberLabel:2];
        [_titleControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_titleControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_titleControl setFont:[UIFont systemFontOfSize:16.0] withNumberType:0 withAllType:YES];
        [_titleControl setTextColor:[UIColor grayColor] withTpe:0 withAllType:YES];
        [_titleControl setBackgroundColor:[UIColor clearColor]];
    }
    return _titleControl;
}


-(XHRegisterItemControl *)contentControl
{
    if (_contentControl == nil)
    {
        _contentControl = [[XHRegisterItemControl alloc]init];
        [_contentControl setNumberLineView:1];
        [_contentControl setNumberLabel:4];
        [_contentControl setNumberImageView:4];
        [_contentControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:YES];
        [_contentControl setIconImageViewBackGroundColor:[UIColor redColor] withNumberType:0 withAllType:YES];
        [_contentControl setBackgroundColor:[UIColor whiteColor]];
        [_contentControl.layer setBorderColor:[[UIColor grayColor] CGColor]];
        [_contentControl.layer setMasksToBounds:YES];
        [_contentControl.layer setCornerRadius:5.0];
        [_contentControl.layer setBorderWidth:0.5];
    }
    return _contentControl;
}







@end
