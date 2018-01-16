//
//  XHAskforLeaveChargeTeacherControl.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHTeacherAddressBookFrame.h"


@interface XHAskforLeaveChargeTeacherControl : BaseControl

@property (nonatomic,strong) XHTeacherAddressBookFrame *teacherAddressBook;
@property (nonatomic,strong) UILabel *describeLabel; //!< 描述标题标签



/**
 重置内容
 */
-(void)reset;

/**
 设置图片

 @param image 图片对象
 */
-(void)setImaeg:(UIImage *)image;

/**
 设置标题

 @param title 标题
 */
-(void)setTitle:(NSString*)title;

@end
