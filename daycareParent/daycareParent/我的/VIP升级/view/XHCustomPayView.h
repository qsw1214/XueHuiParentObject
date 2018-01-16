//
//  XHCustomPayView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHvipInfo.h"
@protocol XHCustomPayViewDelegate <NSObject>

- (void)getPayment:(NSString *)payStr money:(NSString *)ID;

@end


@interface XHCustomPayView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_moneyImaV;
    NSArray *_moneyTitle;
    UITableView *_tableview;
    NSInteger _row;
    XHvipInfo *_model;
}
@property(nonatomic,strong)UIView *view;
@property(nonatomic,copy) NSString *moneyStr;
@property(nonatomic,assign) id <XHCustomPayViewDelegate> delegate;
@end
