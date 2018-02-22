//
//  XHAskforLeaveContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHAskforLeaveAddPhotoControl.h" //!< 添加图片

@interface XHAskforLeaveContentView : UIScrollView


@property (nonatomic,strong) XHAskforLeaveAddPhotoControl *addPhotoControl;   //!< 添加照片选项
@property (nonatomic,strong) XHNetWorkConfig *netWorkConfig; //!< 网络请求

-(instancetype)initWithObject:(BaseViewController*)object;

-(void)resetFrame:(CGRect)frame;


@end
