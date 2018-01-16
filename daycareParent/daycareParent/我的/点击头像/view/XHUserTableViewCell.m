//
//  XHUserTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHUserTableViewCell.h"
@implementation XHUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        _frontLabel=[[XHBaseLabel alloc] init];
        [self.contentView addSubview:_frontLabel];
        _backLabel=[[XHBackLabel alloc] init];
        _backLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_backLabel];
        _headBtn=[[UIButton alloc] init];
        _headBtn.layer.cornerRadius=USER_HEARD/2.0;
        _headBtn.layer.masksToBounds=YES;
        [self.contentView addSubview:_headBtn];
        _famman=[[UIImageView alloc] init];
        _famman.image=[UIImage imageNamed:@"ico-famman"];
        [self.contentView addSubview:_famman];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
