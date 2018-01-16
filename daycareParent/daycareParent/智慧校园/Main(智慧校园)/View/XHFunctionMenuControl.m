//
//  XHFunctionMenuControl.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHFunctionMenuControl.h"
#import "XHFunctionMenuCell.h"






@interface XHFunctionMenuControl () <UICollectionViewDelegate,UICollectionViewDataSource>




@end



@implementation XHFunctionMenuControl





-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self registerClass:[XHFunctionMenuCell class] forCellWithReuseIdentifier:CellIdentifier];
        [self setBackgroundColor:RGB(247, 247, 247)];
        [self setDelegate:self];
        [self setDataSource:self];
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




- (XHFunctionMenuCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHFunctionMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.deletage respondsToSelector:@selector(functionDidSelectItemAtindexObject:)])
    {
        [self.deletage functionDidSelectItemAtindexObject:[self.dataArray objectAtIndex:indexPath.row]];
    }
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHFunctionMenuFrame *frame = [self.dataArray objectAtIndex:indexPath.row];
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
