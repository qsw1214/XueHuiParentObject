//
//  XHEducationCloudMenuView.m
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHEducationCloudMenuView.h"
#import "XHEducationCloudMenuCell.h"
#import "BaseCollectionView.h"


@interface XHEducationCloudMenuView () <UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation XHEducationCloudMenuView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];  //RGB(247, 247, 247)
        [self registerClass:[XHEducationCloudMenuCell class] forCellWithReuseIdentifier:CellIdentifier];
        [self setDelegate:self];
        [self setDataSource:self];
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

- (XHEducationCloudMenuCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHEducationCloudMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.menuDeletage respondsToSelector:@selector(didSelectItemAtIndex:)])
    {
        [self.menuDeletage didSelectItemAtIndex:[self.dataArray objectAtIndex:indexPath.row]];
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
