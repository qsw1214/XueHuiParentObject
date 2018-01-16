//
//  BaseTableViewCell.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell


- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if (self)
    {
        [self.contentView setBackgroundColor:RGB(238.0, 238.0, 238.0)];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView setBackgroundColor:RGB(238.0, 238.0, 238.0)];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

-(void)setItemFrame:(id)frame
{
    
}

@end
