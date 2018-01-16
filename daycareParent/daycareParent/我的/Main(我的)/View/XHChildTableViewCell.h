//
//  XHChildTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark-------绑定学生界面------------

@interface XHChildTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_childListArry;
}
@property(nonatomic,copy)void(^selectBlock)(NSInteger ,NSString *);
@property(nonatomic,strong)UICollectionView *collectionView;
-(void)setItemArray:(NSMutableArray *)array;
@end
