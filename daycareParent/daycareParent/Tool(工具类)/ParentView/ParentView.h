//
//  ParentView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentView : UIView
@property(nonatomic,strong)UIView *baseView;
-(void)setItemObject:(id)object;
-(void)setItemObjectArry:(NSMutableArray *)arry;
@end
