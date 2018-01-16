//
//  XHDynamicsCollectionView.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsCollectionView.h"
#import "XHPreviewModel.h"
#import "XHDynamicsPreviewControl.h"


@implementation XHDynamicsCollectionView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setDelegate:self];
        [self setDataSource:self];
        [self registerClass:[XHDynamicsCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
}


#pragma mark - Getter / Setter


-(void)setItemArray:(NSMutableArray*)array
{
    [self.dataArray setArray:array];
    [self reloadData];
}



#pragma mark - Deletage Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}




- (XHDynamicsCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHDynamicsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemObject:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHDynamicsPreviewControl *dynamicsPreview = [[XHDynamicsPreviewControl alloc]init];
    [dynamicsPreview show];
    [dynamicsPreview setItemArray:self.dataArray];
    if ([self.itemDeletage respondsToSelector:@selector(didselectItemModel:)])
    {
        [self.itemDeletage didselectItemModel:self.dataArray[indexPath.row]];
    }
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHPreviewModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return CGSizeMake(model.itemSize.width,model.itemSize.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 2, 5, 2);
}




@end
