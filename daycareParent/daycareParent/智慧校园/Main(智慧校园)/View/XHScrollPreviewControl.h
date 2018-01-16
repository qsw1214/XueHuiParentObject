//
//  XHScrollPreviewControl.h
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 智慧校园主页->内容承载视图->广告预览视图->滚动广告



#import <UIKit/UIKit.h>
#import "BaseCollectionView.h"
#import "XHFunctionMenuFrame.h"


@protocol XHScrollPreviewControlDeletage <NSObject>

-(void)scrollPreviewDidSelectItemAtindexObject:(XHFunctionMenuFrame*)object;

@end



@interface XHScrollPreviewControl : BaseCollectionView

@property (nonatomic,weak) id <XHScrollPreviewControlDeletage> deletage;

-(void)setItemArray:(NSMutableArray*)itemArray;


@end
