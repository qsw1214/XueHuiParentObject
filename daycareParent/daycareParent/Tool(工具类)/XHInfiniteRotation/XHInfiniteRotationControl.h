//
//  XHInfiniteRotationControl.h
//  daycareParent
//
//  Created by mac on 2018/3/20.
//  Copyright © 2018年 XueHui. All rights reserved.
//

typedef NS_ENUM(NSInteger,XHInfiniteRotationType)
{
    XHInfiniteRotationInsideType = 1,
    XHInfiniteRotationBottomType = 2,
};



#import <UIKit/UIKit.h>
#import "BaseControl.h"

@interface XHInfiniteRotationControl : BaseControl



@property (nonatomic,assign) XHInfiniteRotationType type; //!< 类型 必须在设置 “resetFrame” 之前设置该值


-(void)setInfiniteRotationItemArray:(NSMutableArray *)array;
-(void)setPageItemArray:(NSMutableArray *)array;


@end
