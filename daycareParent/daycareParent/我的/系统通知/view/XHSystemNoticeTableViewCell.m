//
//  XHSystemNoticeTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSystemNoticeTableViewCell.h"
#import "XHSystemModel.h"
@implementation XHSystemNoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}
-(void)setItemObject:(XHSystemModel *)model
{
    [self.titleImageView setFrame:CGRectMake(15, 10, 20, 20)];
    [self.titleLabel setFrame:CGRectMake(self.titleImageView.right+10, self.titleImageView.top, (SCREEN_WIDTH-self.titleImageView.right-30)/2.0, self.titleImageView.height)];
    [self.dateLabel setFrame:CGRectMake(self.titleLabel.right+10, self.titleImageView.top, (SCREEN_WIDTH-self.titleImageView.right-30)/2.0, self.titleImageView.height)];
    [self.contentLabel setFrame:CGRectMake(10, self.titleImageView.bottom+5, SCREEN_WIDTH-20,self.contentView.frame.size.height- self.titleImageView.bottom-10)];
    switch (model.modelType)
    {
        case XHSystemNoticeType:
            {
                self.titleImageView.image=[UIImage imageNamed:@"ico_notice"];
            }
            break;
            
        case XHSystemOtherType:
        {
            self.titleImageView.image=[UIImage imageNamed:@"ico_active"];
        }
            break;
    }
    self.titleLabel.text=model.title;
    self.dateLabel.text=[NSDate dateStr:model.date FromFormatter:ALL_DEFAULT_TIME_FORM ToFormatter:DEFAULT_TIME_FORM1];
    self.contentLabel.text=model.content;
   // [self.contentLabel setParagraph:[NSString safeString:model.content]];
    [self.contentLabel setLabelSpace:self.contentLabel withValue:[NSString safeString:model.content] withFont:kFont(16.0) withlineSpacing:6 withAttributeName:kFont(1.5)];
}
-(ParentImageView *)titleImageView
{
    if (_titleImageView==nil) {
        _titleImageView=[[ParentImageView alloc] init];
    }
    return _titleImageView;
}
-(UILabel *)titleLabel
{
    if (_titleLabel==nil) {
        _titleLabel=[[ParentLabel alloc] init];
        _titleLabel.font=kFont(17.0);
    }
    return _titleLabel;
}
-(UILabel *)dateLabel
{
    if (_dateLabel==nil) {
        _dateLabel=[[ParentLabel alloc] init];
        _dateLabel.textAlignment=NSTextAlignmentRight;
        _dateLabel.textColor=DEFAULTCOLOR;
        
    }
    return _dateLabel;
}
-(UILabel *)contentLabel
{
    if (_contentLabel==nil) {
        _contentLabel=[[ParentLabel alloc] init];
        _contentLabel.numberOfLines=0;
        _contentLabel.font=kFont(15.0);
        
    }
    return _contentLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
