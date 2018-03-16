//
//  XHUserTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHUserTableViewCell : ParentTableViewCell
@property(nonatomic,strong)XHBaseLabel *frontLabel;
@property(nonatomic,strong)XHBackLabel *backLabel;
@property(nonatomic,strong)ParentImageView *arrowsImageView;
@property(nonatomic,strong)UIButton *headBtn;
@end
