//
//  XHDropDownMenuControl.m
//  daycareParent
//
//  Created by Git on 2018/2/27.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHDropDownMenuControl.h"


@interface XHDropDownMenuControl () <UICollectionViewDelegate,UICollectionViewDataSource>



@property (nonatomic,weak) id <XHDropDownMenuControlDeletage> deletage;





@property (nonatomic,strong) UICollectionView *dropDownMenuCollectionView;




@end

@implementation XHDropDownMenuControl


-(instancetype)initWithDeletage:(id<XHDropDownMenuControlDeletage>)deletage
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self)
    {
        [self setDeletage:deletage];
        [self addSubview:self.dropDownMenuCollectionView];
        [self.dropDownMenuCollectionView setFrame:CGRectMake(SCREEN_WIDTH-140.0, 64, 120, 0)];
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.2)];
        [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


-(void)setItemArray:(NSArray *)array
{
    [self.dataArray setArray:array];
    [self.dropDownMenuCollectionView reloadData];
}


#pragma mark - Deletage Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}




- (XHDropDownMenuCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHDropDownMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemObject:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismiss];
    if ([self.deletage respondsToSelector:@selector(didSelectItemObjectAtIndexPath:)])
    {
        [self.deletage didSelectItemObjectAtIndexPath:[self.dataArray objectAtIndex:indexPath.row]];
    }
    
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120,40.0);
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







#pragma mark - Getter / Setter
-(UICollectionView *)dropDownMenuCollectionView
{
    if (!_dropDownMenuCollectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _dropDownMenuCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_dropDownMenuCollectionView setShowsVerticalScrollIndicator:NO];
        [_dropDownMenuCollectionView setShowsHorizontalScrollIndicator:NO];
        [_dropDownMenuCollectionView registerClass:[XHDropDownMenuCell class] forCellWithReuseIdentifier:CellIdentifier];
        [_dropDownMenuCollectionView setBounces:NO];
        [_dropDownMenuCollectionView setDataSource:self];
        [_dropDownMenuCollectionView setDelegate:self];
        [_dropDownMenuCollectionView setBackgroundColor:[UIColor whiteColor]];
    }
    return _dropDownMenuCollectionView;
}








-(void)show
{
    [kWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.dropDownMenuCollectionView setFrame:CGRectMake(SCREEN_WIDTH-140.0, 64, 120, 200)];
        
    } completion:^(BOOL finished){}];
}




-(void)dismiss
{
    [UIView animateWithDuration:0.20 animations:^{
        
        
        [self.dropDownMenuCollectionView setFrame:CGRectMake(SCREEN_WIDTH-140.0, 64, 120, 0)];
        
    } completion:^(BOOL finished)
     {
         [self removeFromSuperview];
         [self setDropDownMenuCollectionView:nil];
     }];
}







@end
