//
//  XHNotifceTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/10.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XHNotifceTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)ParentLabel *titleLab;
@property(nonatomic,strong)ParentLabel *ContentLab;
@property(nonatomic,strong)ParentLabel *detailLab;
@property(nonatomic,strong)UILabel *smallLab;
@property(nonatomic,strong)UIImageView *smalImage;
@end
