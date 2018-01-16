//
//  XHDatePickerControl.m
//  daycareParent
//
//  Created by Git on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDatePickerControl.h"

@interface XHDatePickerControl () <XHDatePickerViewDelegate>

@property (nonatomic,strong) XHDatePickerView *pcikerView; //!< 日期

@property (nonatomic,weak) id <XHDatePickerControlDeletage> deletage;
@end


@implementation XHDatePickerControl



static XHDatePickerControl *datePicker = nil;

-(instancetype)init
{
    self = [super init];
    return self;
}


+ (instancetype)sharedObject
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        datePicker = [[self alloc]initWithFrame:WindowScreen];
        [datePicker setBackgroundColor:RGBAlpha(0, 0, 0, 0.2)];
        
    });
    
    return datePicker;
}





/**
 显示日期
 */
-(void)showWithDeletage:(id<XHDatePickerControlDeletage>)deletage
{
    [datePicker setDeletage:deletage];
    
    [datePicker addSubview:datePicker.pcikerView];
    [kWindow addSubview:datePicker];
    
    
    [datePicker.pcikerView show];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [datePicker.pcikerView setFrame:CGRectMake(0, (SCREEN_HEIGHT-datePicker.pcikerView.height), SCREEN_WIDTH, datePicker.pcikerView.height)];
        
    }];
    
}


/**
 消失
 */
-(void)dismiss
{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [datePicker.pcikerView setFrame:CGRectMake(0, (SCREEN_HEIGHT), SCREEN_WIDTH, datePicker.pcikerView.height)];
        
    } completion:^(BOOL finished)
     {
         [datePicker setPcikerView:nil];
         [datePicker removeFromSuperview];
         
     }];
    
}


#pragma mark - Deletage Method
#pragma mark XHDatePickerViewDelegate
-(void)datePickerViewSaveBtnClickDelegate:(NSString *)timer
{
    if ([datePicker.deletage respondsToSelector:@selector(datePickerClickObject:)])
    {
        [datePicker.deletage datePickerClickObject:timer];
    }
    [datePicker dismiss];
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate
{
    [datePicker dismiss];
}





#pragma mark - Getter / Setter
-(XHDatePickerView *)pcikerView
{
    if (_pcikerView == nil)
    {
        _pcikerView = [[XHDatePickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,
                                                                        250.0)];
        [_pcikerView setTitle:@"请选择时间"];
        [_pcikerView setDelegate:datePicker];
    }
    return _pcikerView;
}




@end
