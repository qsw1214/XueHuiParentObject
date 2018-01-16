//
//  XHCustomView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/20.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHChildListModel.h"

@protocol XHCustomViewDelegate <NSObject>

- (void)getChildModel:(XHChildListModel *)childModel;

@end

@interface XHCustomView : UIView
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)id <XHCustomViewDelegate> delegate;
@property(nonatomic,assign)BOOL isExist;

//-(id)initWithArry:(NSMutableArray *)arry;
@end
