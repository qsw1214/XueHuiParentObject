//
//  XHAddressPickerView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressPickerView.h"
#import "AreaModel.h"
#import "CityModel.h"
#import "ProvinceModel.h"
@implementation XHAddressPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _str=[[NSMutableString alloc] initWithString:@""];
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        _view=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220)];
        _view.backgroundColor=[UIColor whiteColor];
        [self addSubview:_view];
        UIButton *cancleBtn=[[UIButton alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [cancleBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_view addSubview:cancleBtn];
        UIButton *sureBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 5, 45, 45)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitleColor:MainColor forState:UIControlStateNormal];
        [_view addSubview:sureBtn];
        [self loading];
    }
    return self;
}
- (void)loading
{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        [self prepareData];
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            [self uiConfig];
        });
        
    });
}
- (void)prepareData
{
    //area.plist是字典
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    _areaDic = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    
    //city.plist是数组
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *dataCity = [[NSMutableArray alloc] initWithContentsOfFile:plist];
    
    _provinceArr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in dataCity) {
        ProvinceModel *model  = [[ProvinceModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        model.citiesArr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in model.cities) {
            CityModel *cityModel = [[CityModel alloc]init];
            [cityModel setValuesForKeysWithDictionary:dic];
            [model.citiesArr addObject:cityModel];
        }
        [_provinceArr addObject:model];
    }
    
}
- (void)uiConfig
{
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,50, SCREEN_WIDTH, 170)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.backgroundColor=RGB(214, 214, 214);
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    [_view addSubview:_pickerView];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (0 == component)
    {
        return _provinceArr.count;
    }
    else if(1==component)
    {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        ProvinceModel *model =   _provinceArr[rowProvince];
        return model.citiesArr.count;
    }
    else
    {   NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        ProvinceModel *model = _provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr[rowCity];
        NSString *str = [cityModel.code description];
        NSArray *arr =  _areaDic[str];
        return arr.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == component)
    {
        ProvinceModel *model = _provinceArr[row];
        return model.name;
    }
    else if(1==component)
    {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        ProvinceModel *model = _provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr[row];
        return cityModel.name;
    }else
    {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        ProvinceModel *model = _provinceArr[rowProvince];
        CityModel *cityModel = model.citiesArr[rowCity];
        NSString *str = [cityModel.code description];
        NSArray *arr = _areaDic[str];
        AreaModel *areaModel = [[AreaModel alloc]init];
        [areaModel setValuesForKeysWithDictionary:arr[row]];
        return areaModel.name;
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(0 == component)
    {
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
    } if(1 == component)
    {
        [pickerView reloadComponent:2];
    }
    
    NSInteger selectOne = [pickerView selectedRowInComponent:0];
    NSInteger selectTwo = [pickerView selectedRowInComponent:1];
    NSInteger selectThree = [pickerView selectedRowInComponent:2];
    
    ProvinceModel *model = _provinceArr[selectOne];
    CityModel *cityModel = model.citiesArr[selectTwo];
    NSString *str = [cityModel.code description];
    NSArray *arr = _areaDic[str];
    AreaModel *areaModel = [[AreaModel alloc]init];
    [areaModel setValuesForKeysWithDictionary:arr[selectThree]];
    [_str setString:@""];
    NSLog(@"省:%@ 市:%@ 区:%@",model.name,cityModel.name,areaModel.name);
    [_str appendFormat:@"%@ %@ %@",model.name,cityModel.name,areaModel.name];
}
-(void)btnClick
{
    [self removeCustomView];
}
-(void)sureBtnClick
{
    [self removeCustomView];
    if ([_delegate respondsToSelector:@selector(getAddress:)]) {
        if (![[NSString safeString:_str] isEqualToString:@""]) {
           [_delegate getAddress:_str];
        }
        else
        {
           [_delegate getAddress:@"北京市 北京市 东城区"];
        }
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeCustomView];
}
-(void)removeCustomView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _view.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5f];
}
-(void)delayMethod
{
    [self removeFromSuperview];
}
@end
