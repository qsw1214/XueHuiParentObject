//
//  ParentTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentTableViewCell.h"

@implementation ParentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)setItemObject:(id)object
{
    
}
-(void)setItemObject:(id)object withIndexPathRow:(NSInteger)row
{
  
}
-(UILabel *)lineLabel
{
    if (_lineLabel==nil) {
        _lineLabel=[[UILabel alloc] init];
        _lineLabel.backgroundColor=LineViewColor;
    }
    return _lineLabel;
}
-(ParentImageView *)arrowImageView
{
    if (_arrowImageView==nil) {
        _arrowImageView=[[ParentImageView alloc] init];
        _arrowImageView.image=[UIImage imageNamed:@"ico_arrow"];
    }
    return _arrowImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
