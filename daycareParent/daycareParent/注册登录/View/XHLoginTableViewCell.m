//
//  XHLoginTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLoginTableViewCell.h"

@interface XHLoginTableViewCell()

@end

@implementation XHLoginTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleImageView=[[ParentImageView alloc] initWithFrame:CGRectMake(0, (58-25)/2.0, 25, 25)];
        [self.contentView addSubview:_titleImageView];
        _textFeild=[[ParentTextFeild alloc] initWithFrame:CGRectMake(35, 0, SCREEN_WIDTH-120, 58)];
        [self.contentView addSubview:_textFeild];
         UILabel* lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 58-0.5, SCREEN_WIDTH, 0.5)];
        lineLabel.backgroundColor=LineViewColor;
        [self.contentView addSubview:lineLabel];
          
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
