//
//  XHHomeWorkCollectionView.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkCollectionView.h"
#import "XHHomeWorkContentViwCell.h"
#import "XHDynamicsPreviewControl.h"



@implementation XHHomeWorkCollectionView

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self registerClass:[XHHomeWorkContentViwCell class] forCellWithReuseIdentifier:CellIdentifier];
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




- (XHHomeWorkContentViwCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHHomeWorkContentViwCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   
    [cell setItemObject:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XHDynamicsPreviewControl *dynamicsPreview = [[XHDynamicsPreviewControl alloc]init];
    [dynamicsPreview show];
    [dynamicsPreview setItemArray:self.dataArray];
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHPreviewModel *frame = [self.dataArray objectAtIndex:indexPath.row];
    return CGSizeMake(frame.itemSize.width,frame.itemSize.height);
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
    return UIEdgeInsetsMake(5, 5, 5, 5);
}




@end
