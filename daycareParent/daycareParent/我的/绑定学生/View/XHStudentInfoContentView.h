//
//  XHStudentInfoContentView.h
//  daycareParent
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseScrollView.h"



@protocol XHStudentInfoContentViewDelegate <NSObject>


-(void)studentInfoControlAction:(NSInteger)sender;


@end



@interface XHStudentInfoContentView : BaseScrollView


@property (nonatomic,weak) id <XHStudentInfoContentViewDelegate> infoDelegate;

-(void)getChildInfo:(XHChildListModel*)model;


@end
