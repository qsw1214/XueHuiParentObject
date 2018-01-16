//
//  XHPayTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHPayTableViewCell.h"

@implementation XHPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [self.moneyImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.selectImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.selectImageView.layer.cornerRadius=10;
    self.selectImageView.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
