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

@interface XHRCTableViewCell()
@property(nonatomic,strong)UILabel *lineLabel;
@end

@implementation XHRCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _headImageView=[[ParentImageView alloc] init];
        [self.contentView addSubview:_headImageView];
        _smallLab=[[UILabel alloc] init];
        _smallLab.textAlignment=NSTextAlignmentCenter;
        _smallLab.font=[UIFont systemFontOfSize:14.0f];
        _smallLab.textColor=[UIColor whiteColor];
        _smallLab.layer.masksToBounds=YES;
        _smallLab.backgroundColor=[UIColor redColor];
        _smallLab.layer.cornerRadius=7.5;
        [self.contentView addSubview:_smallLab];
        
        _titleLab=[[ParentLabel alloc] init];
        _titleLab.font=kFont(15.0);
        //_titleLab.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:_titleLab];
        
        _detailLab=[[ParentBackLabel alloc] init];
        _detailLab.font=kFont(12.0);
        _detailLab.textColor=RGB(143, 143, 143);
        _detailLab.textAlignment=NSTextAlignmentRight;
        //_detailLab.backgroundColor=[UIColor blueColor];
        [self.contentView addSubview:_detailLab];
        
        _ContentLab=[[ParentBackLabel alloc] init];
        _ContentLab.font=kFont(14.0);
        //_ContentLab.backgroundColor=[UIColor orangeColor];
        [self.contentView addSubview:_ContentLab];
        
        _bgLabel=[[UILabel alloc] init];
        _bgLabel.backgroundColor=RGB(244, 244, 244);
        [self.contentView addSubview:_bgLabel];
    }
    return self;
}
-(void)setItemObject:(XHRCModel *)model
{
    [self resetFrame:model];
    _titleLab.text=model.RCtitle;
    _headImageView.image=[UIImage imageNamed:model.RCtitlePic];
    if ([[NSString safeString:model.RCtitlePic] isEqualToString:@""]) {
        _headImageView.image=[UIImage imageNamed:@"addman"];
    }
    _detailLab.text=[NSDate dateStr:model.createTime FromFormatter:ALL_DEFAULT_TIME_FORM ToFormatter:DEFAULT_TIME_FORM1];
}
-(void)resetFrame:(XHRCModel *)model
{
    
}
-(CGFloat)getCustomWidth:(NSString *)str
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(22, 22) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    if (str.length==0)
    {
        return 0;
    }
    if (str.length==1)
    {
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
