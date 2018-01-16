//
//  XHAddressPickerView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaModel.h"
#import "CityModel.h"
#import "ProvinceModel.h"
@protocol XHAddressPickerViewDelegate <NSObject>

- (void)getAddress:(NSString *)address;

@end

@interface XHAddressPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_pickerView;
    NSDictionary *_areaDic;
    NSMutableArray *_provinceArr;
    NSMutableString *_str;
}
@property(nonatomic,strong)UIView *view;
@property(nonatomic,assign)id <XHAddressPickerViewDelegate> delegate;
@end
