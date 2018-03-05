//
//  XHAddTableViewCell.h
//  daycareParent
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHAddTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet XHBaseLabel *titleLab;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;
@end
