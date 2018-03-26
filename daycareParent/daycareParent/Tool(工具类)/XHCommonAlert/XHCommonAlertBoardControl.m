//
//  HCommonAlertBoardControl.m
//  daycareParent
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHCommonAlertBoardControl.h"


#define CommonAlertconfirmHeight 50.0

@interface XHCommonAlertBoardControl ()


@property (nonatomic,strong) UILabel *tipLabel; //!< 提示标签
@property (nonatomic,strong) UILabel *contentLabel; //!< 内容标签
@property (nonatomic,strong) UIView *lineView; //!< 分割线




@end




@implementation XHCommonAlertBoardControl


-(void)setWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitle:(nullable NSString *)otherButtonTitle
{
    CGSize contentSize = [XHHelper contentSizeWithTitle:message withFontOfSize:[UIFont systemFontOfSize:14.0] withWidth:(SCREEN_WIDTH-60.0)];
    CGFloat contentHeight = (contentSize.height > 20.0 ? contentSize.height : 20.0);
    [self setFrame:CGRectMake(10.0, (SCREEN_HEIGHT-110.0)/2.0, (SCREEN_WIDTH-40.0), (CommonAlertconfirmHeight+30.0+20.0+20.0))];
    [self.tipLabel setFrame:CGRectMake(0, 0, (SCREEN_WIDTH-40.0), 30.0)];
    [self.contentLabel setFrame:CGRectMake(10.0, self.tipLabel.bottom+10.0, self.tipLabel.width-20.0, contentHeight)];
    [self.lineView setFrame:CGRectMake(self.tipLabel.left, (self.contentLabel.bottom+10.0), self.tipLabel.width, 0.5)];
    
    
    
    
    
    //!<赋值
    [self.tipLabel setText:title];
    [self.contentLabel setText:message];
    
    if (cancelButtonTitle && otherButtonTitle)
    {
        [self.cancelControl resetFrame:CGRectMake(0, self.lineView.bottom, self.frame.size.width/2.0, CommonAlertconfirmHeight)];
        [self.cancelControl setTitleEdgeFrame:CGRectMake(0, 0, self.cancelControl.width, self.cancelControl.height) withNumberType:0 withAllType:NO];
        [self.confirmControl resetFrame:CGRectMake(self.cancelControl.right, self.cancelControl.top, self.cancelControl.width, self.cancelControl.height)];
        [self.confirmControl setTitleEdgeFrame:CGRectMake(0, 0, self.cancelControl.width, self.cancelControl.height) withNumberType:0 withAllType:NO];
        [self.cancelControl setText:cancelButtonTitle withNumberType:0 withAllType:NO];
        [self.confirmControl setText:otherButtonTitle withNumberType:0 withAllType:NO];
    }
    else if (otherButtonTitle)
    {
        [self.confirmControl resetFrame:CGRectMake(0, self.contentLabel.bottom+10.0, self.frame.size.width, CommonAlertconfirmHeight)];
        [self.confirmControl setTitleEdgeFrame:CGRectMake(0, 0, self.confirmControl.width, self.confirmControl.height) withNumberType:0 withAllType:NO];
        [self.confirmControl setText:otherButtonTitle withNumberType:0 withAllType:NO];
    }
    else
    {
        [XHShowHUD showNOHud:@"确定按钮不能为空"];
    }
    
    
    [self resetFrame:CGRectMake(20.0, (SCREEN_HEIGHT-110.0)/2.0, (SCREEN_WIDTH-40.0), (110.0+contentSize.height))];
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:self.tipLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.cancelControl];
        [self addSubview:self.confirmControl];
    }
    return self;
}





#pragma mark - Getter /  Setter
-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setTextAlignment:NSTextAlignmentCenter];
        [_tipLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [_tipLabel setBackgroundColor:[UIColor greenColor]];
    }
    return _tipLabel;
}


-(UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [_contentLabel setNumberOfLines:0];
    }
    return _contentLabel;
}


- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}


-(BaseButtonControl *)cancelControl
{
    if (!_cancelControl)
    {
        _cancelControl = [[BaseButtonControl alloc]init];
        [_cancelControl setNumberLabel:1];
        [_cancelControl setTextColor:LineViewColor withTpe:0 withAllType:NO];
        [_cancelControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_cancelControl setTag:1];
    }
    return _cancelControl;
}


-(BaseButtonControl *)confirmControl
{
    if (!_confirmControl)
    {
        _confirmControl = [[BaseButtonControl alloc]init];
        [_confirmControl setNumberLabel:1];
        [_confirmControl setTextColor:MainColor withTpe:0 withAllType:NO];
        [_confirmControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_confirmControl setTag:2];
        [_confirmControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
    }
    return _confirmControl;
}










@end
