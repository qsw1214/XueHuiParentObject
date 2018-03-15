//
//  XHLoginTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLoginTableViewCell.h"

@implementation XHLoginTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(20, 12, (self.contentView.bounds.size.height-26)/2.0, 26)];
        [self.contentView addSubview:_titleImageView];
        _textFeild=[[UITextField alloc] initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH-120, self.contentView.bounds.size.height)];
        _textFeild.clearButtonMode=UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:_textFeild];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
