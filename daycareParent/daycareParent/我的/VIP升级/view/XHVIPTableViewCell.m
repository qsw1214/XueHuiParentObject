//
//  XHVIPTableViewCell.m
//  daycareParent
//
//  Created by mac on 2017/12/3.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHVIPTableViewCell.h"

@implementation XHVIPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.mouthBtn.layer.cornerRadius=14;
    self.mouthBtn.layer.borderWidth=1;
    self.mouthBtn.layer.borderColor=[[UIColor orangeColor] CGColor];
    self.yearBtn.layer.cornerRadius=14;
    self.yearBtn.layer.borderWidth=1;
    self.yearBtn.layer.borderColor=[[UIColor orangeColor] CGColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
