//
//  XHUserTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHUserTableViewCell.h"
#import "XHSystemModel.h"
@implementation XHUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        _frontLabel=[[ParentLabel alloc] init];
        [self.contentView addSubview:_frontLabel];
        _backLabel=[[ParentLabel alloc] init];
        _backLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_backLabel];
        _headBtn=[[UIButton alloc] init];
        _headBtn.layer.cornerRadius=USER_HEARD/2.0;
        _headBtn.layer.masksToBounds=YES;
        [self.contentView addSubview:_headBtn];
        _arrowsImageView=[[ParentImageView alloc] init];
        [self.contentView addSubview:_arrowsImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
