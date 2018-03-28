//
//  XHIMTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/28.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentTableViewCell.h"
#import "XHIMModel.h"
@interface XHIMTableViewCell : ParentTableViewCell
@property(nonatomic,strong)ParentImageView *headImageView;
@property(nonatomic,strong)ParentLabel *titleLab;
@property(nonatomic,strong)ParentBackLabel *ContentLab;
@property(nonatomic,strong)ParentBackLabel *detailLab;
@property(nonatomic,strong)UILabel *smallLab;
@property(nonatomic,strong)UILabel *bgLabel;
@property(nonatomic,strong)UIImageView *smalImage;
-(void)setItemObject:(XHIMModel *)model;
@end
