//
//  XHStudentInfoContentView.m
//  daycareParent
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHStudentInfoContentView.h"

@interface XHStudentInfoContentView ()


@property (nonatomic,strong) UILabel *baseLabel; //!< 基本信息标签
@property (nonatomic,strong) UILabel *parentInformationLabel; //!< 家长信息标签
@property (nonatomic,strong) UILabel *tipLabel; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *headerControl; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *nameControl; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *schoolControl; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *classControl; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *sexControl; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *birthdayControl; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *passwordControl; //!< 密码重置按钮
@property (nonatomic,strong) BaseButtonControl *unBindControl; //!< 解除绑定按钮

@end




@implementation XHStudentInfoContentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.baseLabel];
        [self addSubview:self.headerControl];
        [self addSubview:self.nameControl];
        [self addSubview:self.schoolControl];
        [self addSubview:self.classControl];
        [self addSubview:self.sexControl];
        [self addSubview:self.birthdayControl];
        [self addSubview:self.parentInformationLabel];
        [self addSubview:self.tipLabel];
        [self addSubview:self.passwordControl];
        [self addSubview:self.unBindControl];
    }
    return self;
}




#pragma mark - Getter /  Setter
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    //!< 设置基本信息标签Frame
    [self.baseLabel setFrame:CGRectMake(10.0, 0, (frame.size.width-20.0), 40.0)];
    //!< 头像的Frame
    [self.headerControl resetFrame:CGRectMake(0, self.baseLabel.bottom, frame.size.width, 60.0)];
    [self.headerControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.headerControl.height) withNumberType:0 withAllType:NO];
    [self.headerControl setImageEdgeFrame:CGRectMake(frame.size.width-60.0, (self.headerControl.height-50.0)/2.0, 50.0, 50.0) withNumberType:0 withAllType:NO];
    [self.headerControl resetLineViewFrame:CGRectMake(0, self.headerControl.height-0.5, self.headerControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 设置姓名
    [self.nameControl resetFrame:CGRectMake(0, self.headerControl.bottom, frame.size.width, 50.0)];
    [self.nameControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.nameControl.height) withNumberType:0 withAllType:NO];
    [self.nameControl setTitleEdgeFrame:CGRectMake((frame.size.width)/2.0, 0, (frame.size.width-20.0)/2.0, self.nameControl.height) withNumberType:1 withAllType:NO];
    [self.nameControl resetLineViewFrame:CGRectMake(0, self.nameControl.height-0.5, self.nameControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 设置学校
    [self.schoolControl resetFrame:CGRectMake(0, self.nameControl.bottom, frame.size.width, self.nameControl.height)];
    [self.schoolControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.schoolControl.height) withNumberType:0 withAllType:NO];
    [self.schoolControl setTitleEdgeFrame:CGRectMake((frame.size.width)/2.0, 0, (frame.size.width-20.0)/2.0, self.schoolControl.height) withNumberType:1 withAllType:NO];
    [self.schoolControl resetLineViewFrame:CGRectMake(0, self.nameControl.height-0.5, self.nameControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 设置班级
    [self.classControl resetFrame:CGRectMake(0, self.schoolControl.bottom, frame.size.width, self.schoolControl.height)];
    [self.classControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.classControl.height) withNumberType:0 withAllType:NO];
    [self.classControl setTitleEdgeFrame:CGRectMake((frame.size.width)/2.0, 0, (frame.size.width-20.0)/2.0, self.classControl.height) withNumberType:1 withAllType:NO];
    [self.classControl resetLineViewFrame:CGRectMake(0, self.classControl.height-0.5, self.classControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 设置性别
    [self.sexControl resetFrame:CGRectMake(0, self.classControl.bottom, frame.size.width, self.classControl.height)];
    [self.sexControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.sexControl.height) withNumberType:0 withAllType:NO];
    [self.sexControl setTitleEdgeFrame:CGRectMake((frame.size.width)/2.0, 0, (frame.size.width-20.0)/2.0, self.sexControl.height) withNumberType:1 withAllType:NO];
    [self.sexControl resetLineViewFrame:CGRectMake(0, self.sexControl.height-0.5, self.sexControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 设置生日
    [self.birthdayControl resetFrame:CGRectMake(0, self.sexControl.bottom, frame.size.width, self.sexControl.height)];
    [self.birthdayControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.birthdayControl.height) withNumberType:0 withAllType:NO];
    [self.birthdayControl setTitleEdgeFrame:CGRectMake((frame.size.width)/2.0, 0, (frame.size.width-20.0)/2.0, self.birthdayControl.height) withNumberType:1 withAllType:NO];
    [self.birthdayControl resetLineViewFrame:CGRectMake(0, self.birthdayControl.height-0.5, self.birthdayControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 设置家长信息
    [self.parentInformationLabel setFrame:CGRectMake(10.0, self.birthdayControl.bottom, self.baseLabel.width,self.baseLabel.height)];
    //!< 设置密码
    [self.passwordControl resetFrame:CGRectMake(0, self.parentInformationLabel.bottom, self.birthdayControl.width, self.birthdayControl.height)];
    [self.passwordControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.passwordControl.height) withNumberType:0 withAllType:NO];
    [self.passwordControl setTitleEdgeFrame:CGRectMake((frame.size.width)/2.0, 0, ((frame.size.width-20.0)/2.0)-30.0, self.passwordControl.height) withNumberType:1 withAllType:NO];
    [self.passwordControl setImageEdgeFrame:CGRectMake((self.passwordControl.width-30.0), (self.passwordControl.height-20.0)/2.0, 20.0, 20.0) withNumberType:0 withAllType:NO];
    [self.passwordControl resetLineViewFrame:CGRectMake(0, self.passwordControl.height-0.5, self.passwordControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 设置提醒信息
    [self.tipLabel setFrame:CGRectMake(10.0, self.passwordControl.bottom, self.baseLabel.width,self.baseLabel.height)];
    //!< 设置解绑
    [self.unBindControl resetFrame:CGRectMake(0, self.tipLabel.bottom, frame.size.width, 50.0)];
    [self.unBindControl setTitleEdgeFrame:CGRectMake(0, 0, self.unBindControl.width, self.unBindControl.height) withNumberType:0 withAllType:NO];
    
    
    [self setContentSize:CGSizeMake(frame.size.width, self.unBindControl.bottom+20.0)];
}



-(UILabel *)baseLabel
{
    if (!_baseLabel)
    {
        _baseLabel = [[UILabel alloc]init];
        [_baseLabel setTextColor:RGB(81,200,162)];
        [_baseLabel setFont:FontLevel2];
        [_baseLabel setText:@"学生信息"];
    }
    return _baseLabel;
}

-(UILabel *)parentInformationLabel
{
    if (!_parentInformationLabel)
    {
        _parentInformationLabel = [[UILabel alloc]init];
        [_parentInformationLabel setTextColor:RGB(81,200,162)];
        [_parentInformationLabel setFont:FontLevel2];
        [_parentInformationLabel setText:@"家长信息"];
    }
    return _parentInformationLabel;
}

-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setTextColor:RGB(244,128,5)];
        [_tipLabel setFont:FontLevel3A];
        [_tipLabel setText:@"提示：此密码为绑定学生密码"];
    }
    return _tipLabel;
}

-(BaseButtonControl *)headerControl
{
    if (!_headerControl)
    {
        _headerControl = [[BaseButtonControl alloc]init];
        [_headerControl setNumberLabel:1];
        [_headerControl setNumberLineView:1];
        [_headerControl setNumberImageView:1];
        [_headerControl setText:@"头像" withNumberType:0 withAllType:NO];
        [_nameControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_nameControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
    }
    return _headerControl;
}

-(BaseButtonControl *)nameControl
{
    if (!_nameControl)
    {
        _nameControl = [[BaseButtonControl alloc]init];
        [_nameControl setNumberLabel:2];
        [_nameControl setNumberLineView:1];
        [_nameControl setText:@"名字" withNumberType:0 withAllType:NO];
        [_nameControl setText:@"姚立志" withNumberType:1 withAllType:NO];
        [_nameControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_nameControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_nameControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_nameControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
       
    }
    return _nameControl;
}



-(BaseButtonControl *)schoolControl
{
    if (!_schoolControl)
    {
        _schoolControl = [[BaseButtonControl alloc]init];
        [_schoolControl setNumberLabel:2];
        [_schoolControl setNumberLineView:1];
        [_schoolControl setText:@"学校" withNumberType:0 withAllType:NO];
        [_schoolControl setText:@"北京大学" withNumberType:1 withAllType:NO];
        [_schoolControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_schoolControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_schoolControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_schoolControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
    }
    return _schoolControl;
}

-(BaseButtonControl *)classControl
{
    if (!_classControl)
    {
        _classControl = [[BaseButtonControl alloc]init];
        [_classControl setNumberLabel:2];
        [_classControl setNumberLineView:1];
        [_classControl setText:@"班级" withNumberType:0 withAllType:NO];
        [_classControl setText:@"三年级二班" withNumberType:1 withAllType:NO];
        [_classControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_classControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_classControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_classControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
    }
    return _classControl;
}

-(BaseButtonControl *)sexControl
{
    if (!_sexControl)
    {
        _sexControl = [[BaseButtonControl alloc]init];
        [_sexControl setNumberLabel:2];
        [_sexControl setNumberLineView:1];
        [_sexControl setText:@"性别" withNumberType:0 withAllType:NO];
        [_sexControl setText:@"男" withNumberType:1 withAllType:NO];
        [_sexControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_sexControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_sexControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_sexControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
    }
    return _sexControl;
}

-(BaseButtonControl *)birthdayControl
{
    if (!_birthdayControl)
    {
        _birthdayControl = [[BaseButtonControl alloc]init];
        [_birthdayControl setNumberLabel:2];
        [_birthdayControl setNumberLineView:1];
        [_birthdayControl setText:@"生日" withNumberType:0 withAllType:NO];
        [_birthdayControl setText:@"11/12" withNumberType:1 withAllType:NO];
        [_birthdayControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_birthdayControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_birthdayControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_birthdayControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
    }
    return _birthdayControl;
}


-(BaseButtonControl *)passwordControl
{
    if (!_passwordControl)
    {
        _passwordControl = [[BaseButtonControl alloc]init];
        [_passwordControl setNumberLabel:2];
        [_passwordControl setNumberLineView:1];
        [_passwordControl setNumberImageView:1];
        [_passwordControl setText:@"主家长密码" withNumberType:0 withAllType:NO];
        [_passwordControl setText:@"重置密码" withNumberType:1 withAllType:NO];
        [_passwordControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_passwordControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_passwordControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_passwordControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_passwordControl setImage:@"arr_accessory" withNumberType:0 withAllType:NO];
        
    }
    return _passwordControl;
}

-(BaseButtonControl *)unBindControl
{
    if (!_unBindControl)
    {
        _unBindControl = [[BaseButtonControl alloc]init];
        [_unBindControl setNumberLabel:1];
        [_unBindControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_unBindControl setText:@"解除绑定" withNumberType:0 withAllType:NO];
        [_unBindControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_unBindControl setBackgroundColor:RGB(255,87,87)];
    }
    return _unBindControl;
}








@end
