//
//  XHNoticeTableViewCell.h
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "XHNoticeFrame.h"
#import "XHNoticeCellContentView.h"

@interface XHNoticeTableViewCell : BaseTableViewCell

@property (nonatomic,strong) XHNoticeFrame *itemFrame;


-(instancetype)initWithDeletage:(id)deletage;

-(void)setItemFrame:(XHNoticeFrame *)itemFrame withIndexPath:(NSIndexPath*)indexPath;

@end
