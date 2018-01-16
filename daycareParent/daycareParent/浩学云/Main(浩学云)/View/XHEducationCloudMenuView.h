//
//  XHEducationCloudMenuView.h
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//


#pragma mark 浩学云->内容视图承载视图->六宫格菜单图





#import "BaseCollectionView.h"
#import "XHEducationCloudFrame.h"


@protocol XHEducationCloudMenuViewDeletage <NSObject>

-(void)didSelectItemAtIndex:(XHEducationCloudFrame*)itemObject;

@end


@interface XHEducationCloudMenuView : BaseCollectionView

@property (nonatomic,strong) id <XHEducationCloudMenuViewDeletage> menuDeletage;


@end
