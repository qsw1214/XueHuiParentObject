//
//  XHSelectTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSelectTableViewCell.h"

@implementation XHSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [self layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIControl *control in self.subviews) {
        if (![control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            continue;
        }
        
        for (UIView *subView in control.subviews) {
            if (![subView isKindOfClass: [UIImageView class]]) {
                continue;
            }
            
            UIImageView *imageView = (UIImageView *)subView;
            imageView.layer.cornerRadius=imageView.bounds.size.width/2.0;
            imageView.layer.masksToBounds=YES;
            if (self.selected) {
                imageView.image = [UIImage imageNamed:@"icoyiselect"]; // 选中时的图片
                
            }
            else {
                imageView.image = [UIImage imageNamed:@"icoweixuan"];   // 未选中时的图片
            }
        }
    }
}  
@end
