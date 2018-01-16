//
//  BaseMenuControl.h
//  Object
//
//  Created by XueHui on 2017/10/24.
//  Copyright © 2017年 Object. All rights reserved.
//

#import "BaseMenuControl.h"
#import "BaseCollectionView.h"
#import "BaseMenuCell.h"


@protocol BaseMenuControlDeletage <NSObject>

-(void)didSelectItem:(BaseMenuModel*)object;

@end


@interface BaseMenuControl : BaseCollectionView


@property (nonatomic,weak) id <BaseMenuControlDeletage> menuDeletage;
@property (nonatomic,assign) CGFloat lineHeight; //!< 默认0.5
@property (nonatomic,assign) NSInteger selectIndex; //!< 默认为0

-(void)didSelectAtIndexItem:(NSInteger)index;




/**
 初始化方法

 @return 返回当前类对象
 */
- (instancetype)init;


/**
 设置数据源数据

 @param itemArray 数据源数组
 */
-(void)setItemArray:(NSMutableArray *)itemArray;

/**
 设置数据源
 
 
 @param itemSelectArray 数据源数组
 */

-(void)setItemSelectArray:(NSMutableArray *)itemSelectArray;
@end
