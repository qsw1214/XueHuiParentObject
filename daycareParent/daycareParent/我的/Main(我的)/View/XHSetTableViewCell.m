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
        _setImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(15,(self.contentView.bounds.size.height-30)/2.0+8, 30, 30)];
        [self.contentView addSubview:_setImageView];
        _setLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(48, (self.contentView.bounds.size.height-30), SCREEN_WIDTH-193, 30)];
        [self.contentView addSubview:_setLabel];
        _setContentLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-145, (self.contentView.bounds.size.height-30), 120, 30)];
        [self.contentView addSubview:_setContentLabel];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
