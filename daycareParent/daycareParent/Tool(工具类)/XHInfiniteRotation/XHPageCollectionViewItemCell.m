//
//  XHPageCollectionViewItemCell.m
//  daycareParent
//
//  Created by mac on 2018/3/20.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPageCollectionViewItemCell.h"

@interface XHPageCollectionViewItemCell ()


@end





@implementation XHPageCollectionViewItemCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView setLayerCornerRadius:(frame.size.height/2.0)];
    }
    return self;
}


-(void)setModel:(XHPageModel *)model
{
    _model = model;
    
    switch (model.type)
    {
        case XHPageModelNormalType:
        {
            [self.contentView setBackgroundColor:LineViewColor];
        }
            break;
        case XHPageModelSelectType:
        {
            [self.contentView setBackgroundColor:MainColor];
        }
            break;
    }
}





@end
