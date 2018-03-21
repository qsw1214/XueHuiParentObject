//
//  XHChildCollectionViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHChildCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)ParentLabel *headLabel;
@property(nonatomic,strong)UIImageView *childImageView;
@property(nonatomic,strong)ParentLabel *childNameLabel;
@property(nonatomic,strong)ParentLabel *childClassLabel;
-(void)setHeadrPic:(NSString*)pic withName:(NSString*)name withType:(XHHeaderType)type;
@end
