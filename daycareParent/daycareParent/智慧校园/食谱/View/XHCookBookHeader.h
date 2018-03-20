//
//  XHCookBookHeader.h
//  daycareParent
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//



#pragma mark 这个是食谱的头部切换视图


#import "BaseCollectionView.h"
#import "XHCookBookFrame.h"


@protocol XHCookBookHeaderDeletage <NSObject>


-(void)didSelectItemObject:(XHCookBookFrame*)model;

@end

@interface XHCookBookHeader : BaseCollectionView


-(instancetype)initWithDelegate:(id <XHCookBookHeaderDeletage>)delegate;


@end
