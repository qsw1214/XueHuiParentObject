//
//  XHVIPTableViewCell.h
//  daycareParent
//
//  Created by mac on 2017/12/3.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHVIPTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet XHBaseLabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *mouthLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UIButton *mouthBtn;
@property (strong, nonatomic) IBOutlet UIButton *yearBtn;
@property (strong, nonatomic) IBOutlet XHBaseLabel *firstLabel;
@property (strong, nonatomic) IBOutlet XHBaseLabel *twoLabel;

@end
