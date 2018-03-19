//
//  XHBindViewContentView.m
//  daycareParent
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHBindViewContentView.h"

@interface XHBindViewContentView ()


@property (nonatomic,strong) BaseButtonControl *nameControl; //!< 名称
@property (nonatomic,strong) BaseButtonControl *LearningNumberControl; //!< 学号
@property (nonatomic,strong) BaseButtonControl *parentNameControl;  //!< 家长姓名
@property (nonatomic,strong) BaseButtonControl *identityControl;  //!< 身份
@property (nonatomic,strong) BaseButtonControl *submitControl;

@end




@implementation XHBindViewContentView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.nameControl];
        [self addSubview:self.LearningNumberControl];
        [self addSubview:self.parentNameControl];
        [self addSubview:self.identityControl];
        [self addSubview:self.submitControl];
        
        
        [self setItemColor:NO];
    }
    return self;
}


#pragma mark - Getter /  Setter
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    
    //!< 重置名称Frame
    [self.nameControl resetFrame:CGRectMake(0, 0, frame.size.width, 50.0)];
    [self.nameControl setTitleEdgeFrame:CGRectMake(10.0, 0, 100.0, self.nameControl.height) withNumberType:0 withAllType:NO];
    [self.nameControl setInputEdgeFrame:CGRectMake(110.0, 0, (self.nameControl.width-120.0), self.nameControl.height) withNumberType:0 withAllType:NO];
    [self.nameControl resetLineViewFrame:CGRectMake(0, (self.nameControl.height-0.5), self.nameControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 重置学号Frame
    [self.LearningNumberControl resetFrame:CGRectMake(0, self.nameControl.bottom, self.nameControl.width, self.nameControl.height)];
    [self.LearningNumberControl setTitleEdgeFrame:CGRectMake(10.0, 0, 100.0, self.LearningNumberControl.height) withNumberType:0 withAllType:NO];
    [self.LearningNumberControl setInputEdgeFrame:CGRectMake(110.0, 0, (self.LearningNumberControl.width-120.0), self.LearningNumberControl.height) withNumberType:0 withAllType:NO];
    [self.LearningNumberControl resetLineViewFrame:CGRectMake(0, (self.LearningNumberControl.height-0.5), self.LearningNumberControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 重置父母名称Frame
    [self.parentNameControl resetFrame:CGRectMake(0, self.LearningNumberControl.bottom, self.LearningNumberControl.width, self.LearningNumberControl.height)];
    [self.parentNameControl setTitleEdgeFrame:CGRectMake(10.0, 0, 100.0, self.parentNameControl.height) withNumberType:0 withAllType:NO];
    [self.parentNameControl setInputEdgeFrame:CGRectMake(110.0, 0, (self.parentNameControl.width-120.0), self.parentNameControl.height) withNumberType:0 withAllType:NO];
    [self.parentNameControl resetLineViewFrame:CGRectMake(0, (self.parentNameControl.height-0.5), self.parentNameControl.width, 0.5) withNumberType:0 withAllType:NO];
    
    //!< 身份Frame
    [self.identityControl resetFrame:CGRectMake(0, self.parentNameControl.bottom, self.parentNameControl.width, self.parentNameControl.height)];
    [self.identityControl setTitleEdgeFrame:CGRectMake(10.0, 0, ((frame.size.width-20.0)/2.0), self.identityControl.height) withNumberType:0 withAllType:NO];
    [self.identityControl setTitleEdgeFrame:CGRectMake((frame.size.width/2.0), 0, (((frame.size.width-20.0)/2.0)-40.0), self.identityControl.height) withNumberType:1 withAllType:NO];
    [self.identityControl setImageEdgeFrame:CGRectMake((frame.size.width-30.0), (self.identityControl.height-15.0)/2.0, 15.0, 15.0) withNumberType:0 withAllType:NO];
    
    
    //!< 重置提交Frame
    [self.submitControl resetFrame:CGRectMake(40.0, (self.identityControl.bottom+40.0), (frame.size.width-80.0), 44.0)];
    [self.submitControl setTitleEdgeFrame:CGRectMake(0, 0, self.submitControl.width, self.submitControl.height) withNumberType:0 withAllType:NO];
    
    
    
    [self setContentSize:CGSizeMake(frame.size.width, self.submitControl.bottom+20.0)];
    
}




#pragma mark - Getter /  Setter
-(BaseButtonControl *)nameControl
{
    if (!_nameControl)
    {
        _nameControl = [[BaseButtonControl alloc]init];
        [_nameControl setNumberLabel:1];
        [_nameControl setNumberTextField:1];
        [_nameControl setNumberLineView:1];
        [_nameControl setText:@"学生姓名" withNumberType:0 withAllType:NO];
        [_nameControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_nameControl setTextColor:RGB(153,153,153) withTpe:0 withAllType:NO];
        [_nameControl setInputTintColor:MainColor withNumberType:0 withAllType:NO];
        
    }
    return _nameControl;
}

-(BaseButtonControl *)LearningNumberControl
{
    if (!_LearningNumberControl)
    {
        _LearningNumberControl = [[BaseButtonControl alloc]init];
        [_LearningNumberControl setNumberLabel:1];
        [_LearningNumberControl setNumberTextField:1];
        [_LearningNumberControl setNumberLineView:1];
        [_LearningNumberControl setText:@"请输入学号" withNumberType:0 withAllType:NO];
        [_LearningNumberControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_LearningNumberControl setTextColor:RGB(153,153,153) withTpe:0 withAllType:NO];
        [_LearningNumberControl setInputTintColor:MainColor withNumberType:0 withAllType:NO];
        
    }
    return _LearningNumberControl;
}

-(BaseButtonControl *)parentNameControl
{
    if (!_parentNameControl)
    {
        _parentNameControl = [[BaseButtonControl alloc]init];
        [_parentNameControl setNumberLabel:1];
        [_parentNameControl setNumberTextField:1];
        [_parentNameControl setNumberLineView:1];
        [_parentNameControl setText:@"家长姓名" withNumberType:0 withAllType:NO];
        [_parentNameControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_parentNameControl setTextColor:RGB(153,153,153) withTpe:0 withAllType:NO];
        [_parentNameControl setInputTintColor:MainColor withNumberType:0 withAllType:NO];
    }
    return _parentNameControl;
}

-(BaseButtonControl *)identityControl
{
    if (!_identityControl)
    {
        _identityControl = [[BaseButtonControl alloc]init];
        [_identityControl setNumberLabel:2];
        [_identityControl setNumberImageView:1];
        [_identityControl setText:@"您的身份" withNumberType:0 withAllType:NO];
        [_identityControl setText:@"爸爸" withNumberType:1 withAllType:NO];
        [_identityControl setImage:@"ico_identity" withNumberType:0 withAllType:NO];
        [_identityControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_identityControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_identityControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_identityControl setTextColor:RGB(51,51,51) withTpe:1 withAllType:NO];
    }
    return _identityControl;
}

-(BaseButtonControl *)submitControl
{
    if (!_submitControl)
    {
        _submitControl = [[BaseButtonControl alloc]init];
        [_submitControl setNumberLabel:1];
        [_submitControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_submitControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_submitControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_submitControl setText:@"确定" withNumberType:0 withAllType:NO];
        [_submitControl setBackgroundColor:MainColor];
        [_submitControl setLayerCornerRadius:5.0];
        [_submitControl addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitControl;
}


-(void)setItemColor:(BOOL)color
{
    [self.nameControl setItemColor:color];
    [self.LearningNumberControl setItemColor:color];
    [self.parentNameControl setItemColor:color];
    [self.identityControl setItemColor:color];
    [self.submitControl setItemColor:color];
}


-(void)submitAction:(BaseButtonControl*)sender
{
    
    NSString *archiveId = [NSString safeString:[self.LearningNumberControl textFieldTitlewithNumberType:0]];
    NSString *studentName = [NSString safeString:[self.nameControl textFieldTitlewithNumberType:0]];
    NSString *parentName = [NSString safeString:[self.parentNameControl textFieldTitlewithNumberType:0]];
    XHNetWorkConfig *netWorkConfig = [[XHNetWorkConfig alloc]init];
    if ([studentName isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"学生姓名不能为空"];
    }
    else if ([archiveId isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"学号不能为空"];
    }
    else if ([parentName isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"家长姓名不能为空"];
    }
    else
    {
        [netWorkConfig setObject:studentName forKey:@"studentName"]; //!< 学生姓名
        [netWorkConfig setObject:archiveId forKey:@"archiveId"];  //!< 学生学号
        [netWorkConfig setObject:parentName forKey:@"nickName"];
        
        if ([self.actionDeletgate respondsToSelector:@selector(submitControlAction:)])
        {
            [self.actionDeletgate submitControlAction:netWorkConfig];
        }
    }
    
    
    
    
    
    
    
   
}




@end
