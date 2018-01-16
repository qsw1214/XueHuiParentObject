//
//  XHHomeWorkContentView.h
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//




#import "BaseControl.h"
#import "XHHomeWorkTableViewCell.h"

@protocol XHHomeWorkContentViewDeletage <NSObject>


@optional

-(void)didSelectAtIndex:(XHHomeWorkFrame*)frame;

@end

@interface XHHomeWorkContentView : BaseControl


-(instancetype)initWithDeletage:(id)deletage;





@end
