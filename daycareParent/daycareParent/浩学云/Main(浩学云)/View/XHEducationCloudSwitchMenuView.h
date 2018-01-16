//
//  XHEducationCloudSwitchMenuView.h
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//
#pragma mark 浩学云->内容视图承载视图->切换菜单视图

#import "BaseView.h"
#import "XHEducationCloudFrame.h"
#import "BaseMenuControl.h"

@interface XHEducationCloudSwitchMenuView : BaseView

@property (nonatomic,strong) BaseMenuControl *menuControl; //!< 菜单
@property (nonatomic,strong) BaseButtonControl *moreControl; //!< 更多菜单


-(void)setItemArray:(NSMutableArray*)array;



@end
