//
//  XHSystemNoticeTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentTableViewCell.h"

@interface XHSystemNoticeTableViewCell : ParentTableViewCell
@property(nonatomic,strong)ParentImageView *titleImageView;
@property(nonatomic,strong)ParentLabel *titleLabel;
@property(nonatomic,strong)ParentLabel *dateLabel;
@property(nonatomic,strong)ParentLabel *contentLabel;
@end
