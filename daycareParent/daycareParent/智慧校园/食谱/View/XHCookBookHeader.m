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

@property (nonatomic,weak)id <XHCookBookHeaderDeletage> cookDeletage;


@end



@implementation XHCookBookHeader

-(instancetype)initWithDelegate:(id <XHCookBookHeaderDeletage>)delegate
{
    self = [super initWithType:UICollectionViewScrollDirectionHorizontal];
    if (self)
    {
        [self setCookDeletage:delegate];
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
    
    
    
    NSInteger weekDay = [XHHelper weekdayWithNowDate:[NSDate date]];
    
    switch (weekDay)
    {
        case 6:
        case 7:
        {
            [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHCookBookFrame *obj, NSUInteger idx, BOOL *stop)
             {
                 [obj.model setSelectType:CookBookNormalType];
             }];
            
            if ([self.cookDeletage respondsToSelector:@selector(didSelectItemObject:)])
            {
                [self.cookDeletage didSelectItemObject:[self.dataArray lastObject]];
            }
        }
            break;
            
        default:
        {
            [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHCookBookFrame *obj, NSUInteger idx, BOOL *stop)
             {
                 if ((weekDay-1) == idx)
                 {
                    [obj.model setSelectType:CookBookSelectType];
                 }
                 else
                 {
                     [obj.model setSelectType:CookBookNormalType];
                 }
                 
             }];
            
            
            if ([self.cookDeletage respondsToSelector:@selector(didSelectItemObject:)])
            {
                [self.cookDeletage didSelectItemObject:[self.dataArray objectAtIndex:(weekDay-1)]];
            }
           
        }
            break;
    }
    
    
    
   
    
   
    
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



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHCookBookFrame *obj, NSUInteger idx, BOOL *stop)
    {
        if (idx == indexPath.row)
        {
            [obj.model setSelectType:CookBookSelectType];
        }
        else
        {
            [obj.model setSelectType:CookBookNormalType];
        }
        
    }];
    
    [self reloadData];
    if ([self.cookDeletage respondsToSelector:@selector(didSelectItemObject:)])
    {
        [self.cookDeletage didSelectItemObject:[self.dataArray objectAtIndex:indexPath.row]];
    }
}


@end
