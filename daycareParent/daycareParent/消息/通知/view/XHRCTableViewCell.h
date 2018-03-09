//
//  XHRCTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface XHRCTableViewCell : RCConversationBaseCell
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)XHBaseLabel *titleLab;
@property(nonatomic,strong)XHBackLabel *ContentLab;
@property(nonatomic,strong)XHBackLabel *detailLab;
@property(nonatomic,strong)UILabel *smallLab;
@property(nonatomic,strong)UIImageView *smalImage;
-(void)setItemObject:(RCConversationModel *)model;
@end
