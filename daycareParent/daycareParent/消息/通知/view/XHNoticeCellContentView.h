//
//  XHNoticeCellContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "XHNoticeFrame.h"
#import "XHVideoControl.h"




@protocol XHNoticeCellContentViewDeletage <NSObject>


@optional

-(void)videoPlayerAction:(XHNoticeFrame*)object;

@end

@interface XHNoticeCellContentView : BaseView

@property (nonatomic,weak) id <XHNoticeCellContentViewDeletage> deletage;

-(void)setItemFrame:(XHNoticeFrame*)itemFrame withIndexPath:(NSIndexPath*)indexPath;



@end
