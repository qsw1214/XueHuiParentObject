//
//  XHBindPasswordViewController.m
//  daycareParent
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHBindPasswordViewController.h"

@interface XHBindPasswordViewController ()

@property (nonatomic,strong) BaseButtonControl *newPasswordControl;  //!< 新密码
@property (nonatomic,strong) BaseButtonControl *verifyPasswordControl;  //!< 验证密码
@property (nonatomic,strong) BaseButtonControl *submitControl;  //!< 确认提交


@end

@implementation XHBindPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Public Method
-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.newPasswordControl];
        [self.view addSubview:self.verifyPasswordControl];
        [self.view addSubview:self.submitControl];
        
        //!< 重置新Frame
        [self.newPasswordControl resetFrame:CGRectMake(0, (self.navigationView.bottom+20.0), SCREEN_WIDTH,50.0)];
        [self.newPasswordControl setInputEdgeFrame:CGRectMake(10.0, 0, self.newPasswordControl.width-20.0, self.newPasswordControl.height) withNumberType:0 withAllType:NO];
        [self.newPasswordControl resetLineViewFrame:CGRectMake(0, (self.newPasswordControl.height-0.5), (self.newPasswordControl.width), 0.5) withNumberType:0 withAllType:NO];
        //!< 重置验证新密码的Frame
        [self.verifyPasswordControl resetFrame:CGRectMake(0, self.newPasswordControl.bottom, self.newPasswordControl.width, self.newPasswordControl.height)];
        [self.verifyPasswordControl setInputEdgeFrame:CGRectMake(10.0, 0, self.verifyPasswordControl.width-20.0, self.verifyPasswordControl.height) withNumberType:0 withAllType:NO];
        [self.verifyPasswordControl resetLineViewFrame:CGRectMake(0, (self.newPasswordControl.height-0.5), (self.newPasswordControl.width), 0.5) withNumberType:0 withAllType:NO];
        //!< 重置确定Frame
        [self.submitControl resetFrame:CGRectMake(40.0, self.verifyPasswordControl.bottom+40.0, SCREEN_WIDTH-80.0, 45.0)];
        [self.submitControl setTitleEdgeFrame:CGRectMake(0, 0, self.submitControl.width, self.submitControl.height) withNumberType:0 withAllType:NO];
    }
}



#pragma mark - Getter /  Setter
-(BaseButtonControl *)newPasswordControl
{
    if (!_newPasswordControl)
    {
        _newPasswordControl = [[BaseButtonControl alloc]init];
        [_newPasswordControl setNumberTextField:1];
        [_newPasswordControl setNumberLineView:1];
        [_newPasswordControl setinputTextPlaceholder:@"请输入新密码（6-20位英文、数字组合）" withNumberType:0 withAllType:NO];
    }
    return _newPasswordControl;
}


-(BaseButtonControl *)verifyPasswordControl
{
    if (!_verifyPasswordControl)
    {
        _verifyPasswordControl = [[BaseButtonControl alloc]init];
        [_verifyPasswordControl setNumberTextField:1];
        [_verifyPasswordControl setNumberLineView:1];
        [_verifyPasswordControl setinputTextPlaceholder:@"请确认新密码（6-20位英文、数字组合）" withNumberType:0 withAllType:NO];
    }
    return _verifyPasswordControl;
}

-(BaseButtonControl *)submitControl
{
    if (!_submitControl)
    {
        _submitControl = [[BaseButtonControl alloc]init];
        [_submitControl setNumberLabel:1];
        [_submitControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_submitControl setText:@"确认" withNumberType:0 withAllType:NO];
        [_submitControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_submitControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_submitControl setBackgroundColor:MainColor];
    }
    return _submitControl;
}





@end
