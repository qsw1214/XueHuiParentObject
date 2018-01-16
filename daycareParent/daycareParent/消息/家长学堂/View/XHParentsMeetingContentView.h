//
//  XHParentsMeetingContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 通知->家长学堂->家长学堂承载视图




#import "BaseControl.h"
#import "XHParentsMeetingCell.h"





@protocol XHParentsMeetingContentViewDeletage <NSObject>


-(void)didSelectItemObject:(XHParentsMeetingFrame*)frame;


@end




@interface XHParentsMeetingContentView : BaseControl


-(instancetype)initWithDeletage:(id)deletage;


@end
