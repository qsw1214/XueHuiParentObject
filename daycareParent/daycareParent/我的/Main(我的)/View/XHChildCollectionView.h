//
//  XHChildCollectionView.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark  孩子列表展示
@interface XHChildCollectionView : UIView
@property(nonatomic,copy)void(^selectBlock)(NSInteger ,NSString *,XHChildListModel *model);
@property(nonatomic,strong)UICollectionView *collectionView;
-(void)setItemArray:(NSMutableArray *)array;
@end
