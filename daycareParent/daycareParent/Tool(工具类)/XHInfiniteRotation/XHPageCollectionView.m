//
//  XHPageCollectionView.m
//  daycareParent
//
//  Created by mac on 2018/3/20.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHPageCollectionView.h"

@implementation XHPageCollectionView


- (instancetype)initWithType:(UICollectionViewScrollDirection)type
{
    self = [super initWithType:type];
    if (self)
    {
        [self setDelegate:self];
        [self setDataSource:self];
        [self registerClass:[XHPageCollectionViewItemCell class] forCellWithReuseIdentifier:CellIdentifier];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void)setItemArray:(NSMutableArray *)itemArray
{
    [self.dataArray setArray:itemArray];
    [self reloadData];
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
}

#pragma mark - Delegate Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}




- (XHPageCollectionViewItemCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHPageCollectionViewItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setModel:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark UICollectionViewDelegate
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XHPageModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return CGSizeMake(model.itemSize.width,model.itemSize.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(6.0, 0, 6.0, 0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHAlertModel *obj, NSUInteger idx, BOOL *stop)
     {
         if (idx == indexPath.row)
         {
             [obj setModelType:XHAlertSelectType];
         }
         else
         {
             [obj setModelType:XHAlertNormalType];
         }
     }];
    
    [collectionView reloadData];
}


@end
