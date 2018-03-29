//
//  XHSetTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSetTableViewCell.h"

#define kTitlePic @[@"ico_mycontact",@"ico_myquestion",@"ico_myshare",@"ico_mynotice",@"ico_myset"]

@interface XHSetTableViewCell()
@property(nonatomic,strong)ParentImageView *setImageView;
@property(nonatomic,strong)ParentLabel *setContentLabel;
@property(nonatomic,strong)ParentLabel *setLabel;
@end
@implementation XHSetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        _setImageView=[[ParentImageView alloc] init];
        [self.contentView addSubview:_setImageView];
        _setLabel=[[ParentLabel alloc] init];
        _setLabel.textColor=RGB(51, 51, 51);
        [self.contentView addSubview:_setLabel];
       
        [self.contentView addSubview:self.lineLabel];
        
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}
-(void)setItemObject:(id)object withIndexPathRow:(NSInteger)row
{
    _setImageView.frame=CGRectMake(15,(self.contentView.frame.size.height-30)/2.0, 30, 30);
    _setLabel.frame=CGRectMake(55, (self.contentView.frame.size.height-30)/2.0, SCREEN_WIDTH-193, 30);
    self.arrowImageView.frame=CGRectMake(SCREEN_WIDTH-22, (self.contentView.frame.size.height-14)/2.0, 8, 14);
    self.lineLabel.frame=CGRectMake(0, self.contentView.frame.size.height-0.5, SCREEN_WIDTH, 0.5);
    
    self.setImageView.image=[UIImage imageNamed:kTitlePic[row]];
    self.setLabel.text=kTitle[row];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
