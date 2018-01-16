//
//  XHDatePickerControl.h
//  daycareParent
//
//  Created by Git on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"

#import "XHDatePickerView.h"


@protocol XHDatePickerControlDeletage <NSObject>

-(void)datePickerClickObject:(NSString*)date;

@optional
-(void)componentsYear:(NSString*)yer month:(NSString*)month day:(NSString*)day hour:(NSString*)hour minute:(NSString*)minute second:(NSString*)second;

@end




@interface XHDatePickerControl : BaseControl


+ (instancetype)sharedObject;

-(void)showWithDeletage:(id<XHDatePickerControlDeletage>)deletage; //!< 显示
-(void)dismiss; //!< 消失


@end
