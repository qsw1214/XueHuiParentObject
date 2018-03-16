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

/**
 设置弹框的类型
 注意：如果是 XHAlertBoardOptionType 类型的，必须使用“-(void)setItemArray:(NSMutableArray *)array”方法先填充数据

 @param type XHAlertBoardType 类型
 */
-(void)setBoardType:(XHAlertBoardType)type;








@end
