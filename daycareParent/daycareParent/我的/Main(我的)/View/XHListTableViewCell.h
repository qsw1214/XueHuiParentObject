//
//  XHListTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XHListTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
    NSArray *_arry;
    NSArray *_listArry;
}
@property(nonatomic,copy)void(^selectListBlock)(NSInteger );
@end
