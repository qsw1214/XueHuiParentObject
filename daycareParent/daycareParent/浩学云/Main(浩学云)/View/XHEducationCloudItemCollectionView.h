//
//  XHEducationCloudItemCollectionView.h
//  daycareParent
//
//  Created by Git on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseCollectionView.h"
#import "XHEducationCloudItemCell.h"


@protocol XHEducationCloudItemCollectionViewDeletage <NSObject>

-(void)didSelectItemAtIndexObject:(XHEducationCloudFrame*)object;

@end




@interface XHEducationCloudItemCollectionView : BaseCollectionView

@property (nonatomic,weak) id <XHEducationCloudItemCollectionViewDeletage> educationCloudDeletage;


@end
