//
//  XHAlertControl.m
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAlertControl.h"
#import "XHAlertBoardControl.h"



@interface XHAlertControl () <XHAlertBoardControlDelegate>


@property (nonatomic,strong) XHAlertBoardControl *alertBoard;

@property (nonatomic,strong) XHAlertModel *alerModel;  //!< 学汇弹出框的数据模型




@end

@implementation XHAlertControl

- (instancetype)initWithDelegate:(id<XHAlertControlDelegate>)delegate
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        [self setDelegate:delegate];
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.3)];
        [self addSubview:self.alertBoard];
        [self.alertBoard resetFrame:CGRectMake(30.0, 100.0, SCREEN_WIDTH-60.0, 300.0)];
    }
    return self;
}


#pragma mark - Public Method
-(void)setBoardType:(XHAlertBoardType)type
{
    [self.alertBoard setBoardTyp:type];
}

-(void)setItemArray:(NSMutableArray *)array
{
    [self.alertBoard setItemArray:array];
}


-(void)setTitle:(NSString*)title
{
    [self.alertBoard setTitle:title];
}



#pragma mark - Private Method
-(void)alertBoardControlAction:(BaseButtonControl*)sender
{
    [self dismiss];
    switch (sender.tag)
    {
        case 2:
        {
            switch (self.alertBoard.boardTyp)
            {
                case XHAlertBoardNormalType:
                {
                    if ([self.delegate respondsToSelector:@selector(alertBoardControlAction:)])
                    {
                        [self.delegate alertBoardControlAction:self.alerModel];
                    }
                }
                    break;
                case XHAlertBoardOptionType:
                {
                    if (self.alerModel)
                    {
                        if ([self.delegate respondsToSelector:@selector(alertBoardControlAction:)])
                        {
                            [self.delegate alertBoardControlAction:self.alerModel];
                        }
                    }
                    else
                    {
                        [XHShowHUD showNOHud:@"请指定主监护人!"];
                    }
                }
                    break;
                case XHAlertBoardKindType:
                {
                    if (self.alerModel)
                    {
                        if ([self.delegate respondsToSelector:@selector(alertBoardControlAction:)])
                        {
                            [self.delegate alertBoardControlAction:self.alerModel];
                        }
                    }
                    else
                    {
                        [XHShowHUD showNOHud:@"请选择您与孩子关系"];
                    }
                }
            }
            
        }
            break;
    }
}



-(void)show
{
    [kWindow addSubview:self];
    [self.alertBoard setCenter:self.center];
    [self.alertBoard setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
    [self.alertBoard setAlpha:0.0];
    [UIView animateWithDuration:0.35 animations:^{
        [self.alertBoard setAlpha:1.0];
        [self.alertBoard setTransform:CGAffineTransformMakeScale(1.0, 1.0)];

    } completion:^(BOOL finished){}];
}



-(void)dismiss
{
    [self removeFromSuperview];
}




#pragma mark - Delegate Method
#pragma mark XHAlertBoardControlDelegate
-(void)didSelectItem:(XHAlertModel *)mdoel
{
    [self setAlerModel:mdoel];
}


#pragma mark - Getter /  Setter
-(XHAlertBoardControl *)alertBoard
{
    if (!_alertBoard)
    {
        _alertBoard = [[XHAlertBoardControl alloc]init];
        [_alertBoard setBackgroundColor:[UIColor whiteColor]];
        [_alertBoard.cancelControl addTarget:self action:@selector(alertBoardControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_alertBoard.cancelControl setTag:1];
        [_alertBoard.confirmControl addTarget:self action:@selector(alertBoardControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_alertBoard.confirmControl setTag:2];
        [_alertBoard setDelegate:self];
    }
    return _alertBoard;
}



@end


