//
//  XHPriviTableViewCell.h
//  daycareParent
//
//  Created by mac on 2017/12/3.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHPriviTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet XHBaseLabel *titleLab;
@property (strong, nonatomic) IBOutlet UIImageView *oneImageView;
@property (strong, nonatomic) IBOutlet XHBaseLabel *oneLabel;
@property (strong, nonatomic) IBOutlet UIImageView *twoImageView;
@property (strong, nonatomic) IBOutlet XHBaseLabel *twoLabel;
@property (strong, nonatomic) IBOutlet UIImageView *threeImageView;
@property (strong, nonatomic) IBOutlet XHBaseLabel *threeLabel;

@end
