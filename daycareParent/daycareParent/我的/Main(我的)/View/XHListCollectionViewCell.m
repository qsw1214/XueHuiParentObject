//
//  XHListCollectionViewCell.m
//  daycareParent
//
//  Created by mac on 2017/12/2.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHListCollectionViewCell.h"

@implementation XHListCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
         _listImageView=[[UIImageView alloc] initWithFrame:CGRectMake((self.contentView.frame.size.width-27)/2, 13, 27, 27)];         [self.contentView addSubview:_listImageView];
         _listLabel=[[XHBaseLabel alloc] initWithFrame:CGRectMake(5, 40, self.contentView.frame.size.width-10,self.contentView.frame.size.height-50)];
         _listLabel.font=FontLevel3;
         _listLabel.textAlignment=NSTextAlignmentCenter;
         [self.contentView addSubview:_listLabel];
    }
    return self;
}
@end
