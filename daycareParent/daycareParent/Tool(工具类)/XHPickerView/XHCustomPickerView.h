//
//  XHCustomPickerView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHCustomPickerViewDelegate <NSObject>

- (void)getItemObject:(NSString *)itemObject atItemIndex:(NSInteger )index;

@end

@interface XHCustomPickerView : ParentView

-(id)initWithDelegate:(id)delegate itemArry:(NSArray *)itemArry;
-(void)show;
@end
