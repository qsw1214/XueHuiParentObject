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

@property(nonatomic,strong) NSMutableArray *itemArry;
@property(nonatomic,strong) UIPickerView *pickerView;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,assign)id <XHCustomPickerViewDelegate> delegate;
@end


@implementation XHCustomPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithDelegate:(id)delegate
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        _bgView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220)];
        _bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_bgView];
        UIButton *cancleBtn=[[UIButton alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cancleBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_bgView addSubview:cancleBtn];
        UIButton *sureBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 5, 45, 45)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_bgView addSubview:sureBtn];
        [_bgView addSubview:self.pickerView];
        self.delegate=delegate;
    }
    return self;
}

-(void)show
{
    [kWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        
      _bgView.frame=CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220);
        
    } completion:^(BOOL finished){}];
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
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1; // 返回1表明该控件只包含1列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法返回teams.count，表明teams包含多少个元素，该控件就包含多少行
    return self.itemArry.count;
}


// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView
// 中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    
    return [self.itemArry objectAtIndex:row];
}

// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    _row=row;
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
        _pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0,50, SCREEN_WIDTH, 170)];
        _pickerView.delegate=self;
        _pickerView.dataSource=self;
    }
    return _pickerView;
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
