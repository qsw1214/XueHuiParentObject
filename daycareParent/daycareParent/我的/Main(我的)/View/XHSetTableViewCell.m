//
//  XHSetTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSetTableViewCell.h"

@implementation XHSetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _setImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(15,10, 30, 30)];
        [self.contentView addSubview:_setImageView];
        _setLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(55, 10, SCREEN_WIDTH-193, 30)];
        _setLabel.textColor=RGB(51, 51, 51);
        [self.contentView addSubview:_setLabel];
        self.lineLabel.frame=CGRectMake(0, 49, SCREEN_WIDTH, 0.5);
        [self.contentView addSubview:self.lineLabel];
        self.arrowImageView.frame=CGRectMake(SCREEN_WIDTH-22, (50-14)/2.0, 8, 14);
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
