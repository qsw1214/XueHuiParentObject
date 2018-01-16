//
//  XHAddTableViewCell.m
//  daycareParent
//
//  Created by mac on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddTableViewCell.h"

@implementation XHAddTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    _clearBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width-10, (self.contentView.bounds.size.height-10)/2.0, 10, 10)];
//    _clearBtn.layer.cornerRadius=5;
//    _clearBtn.layer.masksToBounds=YES;
//    _clearBtn.backgroundColor=[UIColor redColor];
//    [_clearBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
//    [self.contentView addSubview:_clearBtn];
    _clearButton.layer.cornerRadius=7.5;
    _clearButton.layer.masksToBounds=YES;
    _clearButton.hidden=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
