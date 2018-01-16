//
//  XHEducationCloudItemCollectionView.m
//  daycareParent
//
//  Created by Git on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHEducationCloudItemCollectionView.h"


@interface XHEducationCloudItemCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation XHEducationCloudItemCollectionView


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self registerClass:[XHEducationCloudItemCell class] forCellWithReuseIdentifier:CellIdentifier];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setDelegate:self];
        [self setDataSource:self];
        [self setPagingEnabled:YES];
        [self setBounces:NO];
    }
    return self;
}



-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
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




- (XHEducationCloudItemCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHEducationCloudItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.educationCloudDeletage respondsToSelector:@selector(didSelectItemAtIndexObject:)])
    {
        [self.educationCloudDeletage didSelectItemAtIndexObject:[self.dataArray objectAtIndex:indexPath.row]];
    }
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHEducationCloudFrame *frame = [self.dataArray objectAtIndex:indexPath.row];
    return CGSizeMake(frame.itemSize.width,frame.itemSize.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
@end
