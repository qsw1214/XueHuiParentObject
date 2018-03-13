//
//  XHRCTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHRCTableViewCell.h"
#import "XHMessageUserInfo.h"
#import "XHRCModel.h"
@implementation XHRCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
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
        _bgLabel=[[UILabel alloc] init];
        _bgLabel.backgroundColor=RGB(239, 239, 239);
        [self.contentView addSubview:_bgLabel];
    }
    return self;
}
-(void)setItemObject:(XHRCModel *)model atIndex:(NSInteger)Index
{
    _titleLab.text=model.RCtitle;
    _headImageView.frame=CGRectMake(15, 15, 40, 40);
    _headImageView.layer.cornerRadius=0;
    _headImageView.image=[UIImage imageNamed:model.RCtitlePic];
    _ContentLab.frame=CGRectMake(80, 35, SCREEN_WIDTH-95, 30);
    _ContentLab.text=model.RCContent;
    _bgLabel.frame=CGRectMake(0, self.contentView.bottom-15, SCREEN_WIDTH, 15);
    _smallLab.text=@"10";
    _smallLab.frame=CGRectMake(50, 7, [self getCustomWidth:_smallLab.text], 15);
    _smallLab.layer.cornerRadius=7.5;
    if (Index==2)
    {
        self.bgLabel.hidden=NO;
    }
    
    else
    {
        self.bgLabel.hidden=YES;
        self.backgroundColor=[UIColor whiteColor];
    }
}
-(CGFloat)getCustomWidth:(NSString *)str
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(22, 22) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    if (str.length==0) {
        return 0;
    }
    if (str.length==1) {
        return 15;
    }
    else
    {
        return textSize.width+8;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
