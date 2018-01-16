//
//  XHDynamicsCell.h
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "XHDynamicsCellContentView.h"



@interface XHDynamicsCell : BaseTableViewCell

- (instancetype)initWithDeletage:(id)deletage;


-(void)setItemFrame:(id)frame withIndexPath:(NSIndexPath*)index;


@end
