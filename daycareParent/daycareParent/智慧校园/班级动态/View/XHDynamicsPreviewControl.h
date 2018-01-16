//
//  XHDynamicsPreviewControl.h
//  daycareParent
//
//  Created by Git on 2017/12/22.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "BaseCollectionView.h"
#import "XHDynamicsPreviewCollectionViewCell.h"


@interface XHDynamicsPreviewControl : BaseControl




/**
 显示
 */
-(void)show;

/**
 消失
 */
-(void)dismiss;




/**
 设置数据数组

 @param array 数据源数组
 */
-(void)setItemArray:(NSMutableArray <XHPreviewModel*> *)array;



@end
