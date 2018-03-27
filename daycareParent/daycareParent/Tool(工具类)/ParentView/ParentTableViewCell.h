//
//  ParentTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentImageView.h"
@interface ParentTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)ParentImageView *arrowImageView;
-(void)setItemObject:(id)object;
-(void)setItemObject:(id)object withIndexPathRow:(NSInteger)row;
@end
