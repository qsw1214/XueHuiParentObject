//
//  XHDynamicsCellContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseView.h"
#import "XHDynamicsFrame.h"
#import "XHVideoControl.h"
#import "XHDynamicsCollectionView.h"

@protocol XHDynamicsCellContentViewDeletage <NSObject>


-(void)videoPlayerAction:(XHDynamicsFrame*)frame;

@end


@interface XHDynamicsCellContentView : BaseView

@property (nonatomic,weak) id  deletage;



-(void)setItemFrame:(id)frame withIndexPath:(NSIndexPath*)indexPath;




@end
