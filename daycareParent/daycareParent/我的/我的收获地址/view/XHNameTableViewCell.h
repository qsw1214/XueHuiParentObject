//
//  XHNameTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHNameTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet XHBaseLabel *nameLabel;
@property (strong, nonatomic) IBOutlet XHBaseLabel *telephoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end
