//
//  XHCookBookHeader.m
//  daycareParent
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHCookBookHeader.h"
#import "XHCookBookHeaderItemCell.h"



@interface XHCookBookHeader () <UICollectionViewDelegate,UICollectionViewDataSource>

@end



@implementation XHCookBookHeader

- (instancetype)init
{
    self = [super initWithType:UICollectionViewScrollDirectionHorizontal];
    if (self)
    {
        [self setDelegate:self];
        [self setDataSource:self];
        [self registerClass:[XHCookBookHeaderItemCell class] forCellWithReuseIdentifier:CellIdentifier];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}



-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
}



#pragma mark - Public Method
-(void)setItemArray:(NSMutableArray *)array
{
    [self.dataArray setArray:array];
    [self reloadData];
}


#pragma mark - Private Method


#pragma mark - Delertage Method
#pragma mark - Deletage Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}




- (XHCookBookHeaderItemCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHCookBookHeaderItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark UICollectionViewDelegate
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XHCookBookFrame *bookFrame = [self.dataArray objectAtIndex:indexPath.row];
    return CGSizeMake(bookFrame.itemSize.width,bookFrame.itemSize.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return (SCREEN_WIDTH-250.0-40.0)/4.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 20.0, 0, 20.0);
}




@end
