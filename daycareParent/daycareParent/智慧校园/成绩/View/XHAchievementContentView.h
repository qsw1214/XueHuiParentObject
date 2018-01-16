//
//  XHAchievementContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHXHAchievementCell.h"
#import "XHChildListModel.h"
@interface XHAchievementContentView : BaseControl

@property(nonatomic,strong)XHChildListModel *childModel;
-(void)getModel:(XHChildListModel *)model;


@end
