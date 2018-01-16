//
//  XHCustomPickerView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHCustomPickerViewDelegate <NSObject>

- (void)getFamily:(NSInteger )familyIndex;

@end

@interface XHCustomPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray *itemArry;
    NSInteger _row;
}
@property(nonatomic,strong)UIView *view;
@property(nonatomic,assign)id <XHCustomPickerViewDelegate> delegate;
@end
