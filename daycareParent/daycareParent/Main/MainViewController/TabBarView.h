//
//  TabBarView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabBarViewDelegate <NSObject>

-(void)setItemSelectIndex:(NSInteger )selectIndex;

@end

@interface TabBarView : UIView

@property(nonatomic,assign)id <TabBarViewDelegate> delegate;

@end
