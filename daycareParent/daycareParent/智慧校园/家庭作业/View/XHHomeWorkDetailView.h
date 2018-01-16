//
//  XHHomeWorkDetailView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/21.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHHomeWorkTableViewCell.h"

@protocol XHHomeWorkDetailViewDeletage <NSObject>


@optional

-(void)didSelectAtIndex:(XHHomeWorkFrame*)object;

@end

@interface XHHomeWorkDetailView : BaseControl

-(instancetype)initWithDeletage:(id)deletage;
@end
