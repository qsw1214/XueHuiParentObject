//
//  XHTipTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHTipTableViewCell.h"

@implementation XHTipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _tipLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, self.contentView.bounds.size.height)];
        _tipLabel.numberOfLines=0;
        [self.contentView addSubview:_tipLabel];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
