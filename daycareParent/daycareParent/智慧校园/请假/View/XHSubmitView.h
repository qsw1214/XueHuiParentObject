//
//  XHSubmitView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHSubmitView : UIView
@property(nonatomic,strong)UIButton *submitButton;
-(void)resetFrame:(CGRect)frame;
-(void)setItemArry:(NSMutableArray *)arry;
@end
