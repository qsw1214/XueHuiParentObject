//
//  XHLoginTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/15.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLoginTableViewCell.h"

#define kTitlePic @[@"ico_number",@"ico_password"]

@interface XHLoginTableViewCell()
@property(nonatomic,strong)ParentImageView *titleImageView;
@property(nonatomic,strong)ParentTextFeild *textFeild;
@end

@implementation XHLoginTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleImageView];
        [self.contentView addSubview:self.textFeild];
        [self.contentView addSubview:self.lineLabel];
        
    }
    return self;
}
-(void)setItemObject:(id)object withIndexPathRow:(NSInteger)row
{
    
    self.titleImageView.frame=CGRectMake(0, (self.contentView.frame.size.height-25)/2.0, 25, 25);
    self.textFeild.frame=CGRectMake(40, 0, SCREEN_WIDTH-125, self.contentView.frame.size.height);
    self.lineLabel.frame=CGRectMake(0, self.contentView.frame.size.height-0.5, SCREEN_WIDTH, 0.5);
    self.textFeild.placeholder=kTitle[row];
    self.titleImageView.image=[UIImage imageNamed:kTitlePic[row]];
    self.textFeild.tag=row+10086;
    if (row==1)
    {
        self.textFeild.secureTextEntry=YES;
    }
    else
    {
        self.textFeild.keyboardType=UIKeyboardTypeNumberPad;
    }
}
-(ParentImageView *)titleImageView
{
    if (_titleImageView==nil) {
        _titleImageView=[[ParentImageView alloc] init];
        
    }
    return _titleImageView;
}
-(ParentTextFeild *)textFeild
{
    if (_textFeild==nil) {
        _textFeild=[[ParentTextFeild alloc] init];
        
    }
    return _textFeild;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
