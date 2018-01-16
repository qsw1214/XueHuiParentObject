//
//  XHSelectTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHSelectTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *titleImagV;
@property (strong, nonatomic) IBOutlet XHBaseLabel *contentLab;
@property (strong, nonatomic) IBOutlet XHBackLabel *detailLab;

@end
