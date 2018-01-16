//
//  XHNotifceTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/10.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNotifceTableViewCell.h"

@implementation XHNotifceTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headImageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
        _headImageView.layer.cornerRadius=30;
        _headImageView.layer.masksToBounds=YES;
        [self.contentView addSubview:_headImageView];
        _smallLab=[[UILabel alloc] init];
        _smallLab.textAlignment=NSTextAlignmentCenter;
        _smallLab.font=[UIFont systemFontOfSize:14.0f];
        _smallLab.textColor=[UIColor whiteColor];
        CGSize Size=[_smallLab.text contentSizeWithTitle:_smallLab.text withFontOfSize:[UIFont systemFontOfSize:14.0] withWidth:20];
        _smallLab.frame=CGRectMake(45, 6, Size.height, 16);
        _smallLab.layer.cornerRadius=8;
        _smallLab.layer.masksToBounds=YES;
        _smallLab.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:_smallLab];
        _titleLab=[[XHBaseLabel alloc] initWithFrame:CGRectMake(80, 0, 90, 30)];
         [self.contentView addSubview:_titleLab];
        _detailLab=[[XHBackLabel alloc] initWithFrame:CGRectMake(170, 0, SCREEN_WIDTH-180, 30)];
        _detailLab.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_detailLab];
        _ContentLab=[[XHBackLabel alloc] init];
        [self.contentView addSubview:_ContentLab];

    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
