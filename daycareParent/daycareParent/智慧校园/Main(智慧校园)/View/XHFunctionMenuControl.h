//
//  XHFunctionMenuControl.h
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//


#pragma mark 智慧校园主页->内容承载视图->功能视图




#import "BaseCollectionView.h"
#import "XHFunctionMenuCell.h"




@protocol XHFunctionMenuControlDeletage <NSObject>


-(void)functionDidSelectItemAtindexObject:(XHFunctionMenuFrame*)object;

@end







typedef void  (^BolckSelectItemAtIndex) (XHFunctionMenuFrame *itemFrame);



@interface XHFunctionMenuControl : BaseCollectionView


@property (nonatomic,copy) BolckSelectItemAtIndex bolckSelectItemAtIndex;


-(instancetype)init;

@property (nonatomic,weak) id <XHFunctionMenuControlDeletage> deletage;


-(void)resetFrame:(CGRect)frame;



@end
