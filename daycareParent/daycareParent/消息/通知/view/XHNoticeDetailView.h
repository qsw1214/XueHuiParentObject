//
//  XHNoticeDetailView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/21.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHNoticeTableViewCell.h"

@protocol XHNoticeDetailViewDeletage <NSObject>


@optional

-(void)didSelectAtIndex:(XHNoticeFrame*)object;

@end

@interface XHNoticeDetailView : BaseControl

-(instancetype)initWithDeletage:(id)deletage;
@end
