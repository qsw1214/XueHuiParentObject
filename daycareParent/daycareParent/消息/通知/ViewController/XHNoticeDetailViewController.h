//
//  XHNoticeDetailViewController.h
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 消息->通知列表->列表详情





#import "BaseViewController.h"
#import "XHNoticeContentView.h"



typedef void (^BackRefeshBlock) (BOOL isRefesh);

@interface XHNoticeDetailViewController : BaseViewController
@property (nonatomic,copy) BackRefeshBlock refeshBlock;

-(void)setItemObjet:(XHNoticeFrame*)objet;


@end
