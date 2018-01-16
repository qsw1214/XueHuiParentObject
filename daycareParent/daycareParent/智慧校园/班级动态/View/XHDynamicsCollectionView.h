//
//  XHDynamicsCollectionView.h
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseCollectionView.h"
#import "XHDynamicsCollectionViewCell.h"

@protocol XHDynamicsCollectionViewDeletage <NSObject>

-(void)didselectItemModel:(XHPreviewModel*)model;


@end

@interface XHDynamicsCollectionView : BaseCollectionView <UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak)id itemDeletage;
@end
