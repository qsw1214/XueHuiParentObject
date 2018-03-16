//
//  XHAddBindPasswordViewController.m
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddBindPasswordViewController.h"

@interface XHAddBindPasswordViewController ()


@property (nonatomic,strong) BaseButtonControl *passwordControl;
@property (nonatomic,strong) BaseButtonControl *submitControl;


@end

@implementation XHAddBindPasswordViewController

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
        [self.view addSubview:self.passwordControl];
        [self.view addSubview:self.submitControl];
        
        [self.passwordControl resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 50.0)];
        [self.passwordControl setInputEdgeFrame:CGRectMake(10.0, 0, self.passwordControl.width-20.0, self.passwordControl.height) withNumberType:0 withAllType:NO];
        //!< 重置提交按钮
        [self.submitControl resetFrame:CGRectMake(40.0, self.passwordControl.bottom+30.0, self.passwordControl.width-80.0, 44.0)];
        [self.submitControl setTitleEdgeFrame:CGRectMake(0, 0, self.submitControl.width, self.submitControl.height) withNumberType:0 withAllType:NO];

    }
}



#pragma mark - Getter /  Setter
-(BaseButtonControl *)passwordControl
{
    if (!_passwordControl)
    {
        _passwordControl = [[BaseButtonControl alloc]init];
        [_passwordControl setNumberTextField:1];
        [_passwordControl setinputTextPlaceholder:@"设置绑定密码（6-20位英文、数字组合）" withNumberType:0 withAllType:NO];
    }
    return _passwordControl;
}

-(BaseButtonControl *)submitControl
{
    if (!_submitControl)
    {
        _submitControl = [[BaseButtonControl alloc]init];
        [_submitControl setNumberLabel:1];
        [_submitControl setText:@"完成" withNumberType:0 withAllType:NO];
        [_submitControl setBackgroundColor:MainColor];
        [_submitControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_submitControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_submitControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
    }
    return _submitControl;
}




@end
