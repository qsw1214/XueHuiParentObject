//
//  XHLiveContentView.h
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHLiveTableViewCell.h"


@protocol XHLiveContentViewDeletage <NSObject>


-(void)didSelectRowAtIndexPath:(XHLiveFrame*)object;

@end

@interface XHLiveContentView : BaseControl <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,weak) id <XHLiveContentViewDeletage> deletage;






@end
