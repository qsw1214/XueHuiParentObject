//
//  XHSubmitView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHSubmitViewDelegate <NSObject>

-(void)getItemObject:(NSString *)ItemObject;


@end

@interface XHSubmitView : UIView

@property(nonatomic,strong)UIButton *submitButton;
@property(nonatomic,copy)NSString *teacherId;
@property(nonatomic,copy)NSString *classid;
@property(nonatomic,assign)id <XHSubmitViewDelegate> delegate;
-(void)resetFrame:(CGRect)frame;
-(void)setItemArry:(NSMutableArray *)arry;

@end
