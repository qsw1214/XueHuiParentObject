//
//  XHCustomPickerView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCustomPickerView.h"

@interface XHCustomPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger _row;
}

@property(nonatomic,strong) NSMutableArray *itemArry;//!< 数据源

@property(nonatomic,strong) UIPickerView *pickerView;//!< 选择器

@property(nonatomic,strong) UIView *bgView;//!< 背景视图

@property(nonatomic,assign)id <XHCustomPickerViewDelegate> delegate;

@end


@implementation XHCustomPickerView

-(id)initWithDelegate:(id)delegate itemArry:(NSArray *)itemArry
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [self addSubview:self.bgView];
        [self.itemArry setArray:itemArry];
        UIButton *cancleBtn=[[UIButton alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cancleBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [self.bgView addSubview:cancleBtn];
        UIButton *sureBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 5, 45, 45)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [self.bgView addSubview:sureBtn];
        [self.bgView addSubview:self.pickerView];
        
        [self setDelegate:delegate];
    }
    return self;
}

-(void)show
{
    [kWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        
      _bgView.frame=CGRectMake(0, SCREEN_HEIGHT-240, SCREEN_WIDTH, 240);
        
    } completion:^(BOOL finished){
        
        for(UIView *speartorView in self.pickerView.subviews)
        {
            if (speartorView.frame.size.height < 1)//取出分割线view
            {
                speartorView.backgroundColor = LineViewColor;//修改分割线颜色
            }
        }
    }];
}
-(void)dismiss
{
    [UIView animateWithDuration:0.20 animations:^{
        
    _bgView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    } completion:^(BOOL finished)
     {
         [self removeFromSuperview];
     }];
}
-(void)setItemObjectArry:(NSMutableArray *)arry
{
    [self.itemArry setArray:arry];
    [self.pickerView reloadAllComponents];
}
#pragma mark  pickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.itemArry.count;
}

#pragma mark pickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.itemArry objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    _row=row;
}
#pragma mark  修改字体颜色和大小等属性
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.font =kFont(19.0);
    genderLabel.text = self.itemArry[row];
    return genderLabel;
}
-(void)cancleBtnClick
{
    [self dismiss];
}
-(void)sureBtnClick
{
    if ([_delegate respondsToSelector:@selector(getItemObject:atItemIndex:)]) {
        [_delegate getItemObject:self.itemArry[_row] atItemIndex:_row];
    }
    
    [self dismiss];
}

-(UIPickerView *)pickerView
{
    if (_pickerView==nil) {
        _pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0,50, SCREEN_WIDTH, 190)];
        _pickerView.delegate=self;
        _pickerView.dataSource=self;
    }
    return _pickerView;
}
-(UIView *)bgView
{
    if (_bgView==nil) {
        _bgView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-240, SCREEN_WIDTH, 240)];
        _bgView.backgroundColor=[UIColor whiteColor];
    }
    return _bgView;
}
-(NSMutableArray *)itemArry
{
    if (_itemArry==nil)
    {
        _itemArry=[[NSMutableArray alloc] init];
    }
    return _itemArry;
}
@end
