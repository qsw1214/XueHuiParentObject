//
//  XHNoticeContentView.h
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//


#import "BaseControl.h"
#import "XHNoticeTableViewCell.h"

@protocol XHNoticeContentViewDeletage <NSObject>


@optional

-(void)didSelectAtIndex:(XHNoticeFrame*)object;

@end

@interface XHNoticeContentView : BaseControl

-(instancetype)initWithDeletage:(id)deletage;





@end
