//
//  XHAlertControl.h
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHAlertBoardControl.h"

@protocol XHAlertControlDelegate <NSObject>

-(void)alertBoardControlAction:(XHAlertModel*)sender;

@end


@interface XHAlertControl : BaseControl


@property (nonatomic,weak) id <XHAlertControlDelegate> delegate;


-(instancetype)initWithDelegate:(id<XHAlertControlDelegate>)delegate;

-(void)show;
-(void)dismiss;
-(void)setTitle:(NSString*)title;
-(void)setBoardType:(XHAlertBoardType)type;








@end
