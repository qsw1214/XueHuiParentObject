//
//  XHDynamicsPreviewControl.m
//  daycareParent
//
//  Created by Git on 2017/12/22.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsPreviewControl.h"




@interface XHDynamicsPreviewControl () <UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,strong) BaseCollectionView *collectionView;
@property (nonatomic,strong) UILabel *pageNumberLabel; //!< 分页页码标签



@end




@implementation XHDynamicsPreviewControl



- (instancetype)init
{
    self = [super initWithFrame:WindowScreen];
    if (self)
    {
        [self setBackgroundColor:RGBAlpha(0, 0, 0, 0.3)];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageNumberLabel];
        [self.pageNumberLabel setFrame:CGRectMake((SCREEN_WIDTH-80.0)/2.0, SCREEN_HEIGHT-80.0, 80, 30.0)];
        [self.pageNumberLabel setLayerCornerRadius:(self.pageNumberLabel.height/2.0)];
    }
    return self;
}




#pragma mark show 显示
/**
 显示
 */
-(void)show
{
    
    [kWindow addSubview:self];
    [self.collectionView setFrame:CGRectMake(((SCREEN_WIDTH)/2.0), ((SCREEN_HEIGHT)/2.0), 0, 0)];
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.collectionView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.pageNumberLabel setHidden:NO];
        
    }];
}



#pragma mark 消失
/**
 消失
 */
-(void)dismiss
{
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.collectionView setFrame:CGRectMake(((SCREEN_WIDTH)/2.0), ((SCREEN_HEIGHT)/2.0), 0, 0)];
        [self.pageNumberLabel setHidden:YES];
        
    } completion:^(BOOL finished)
    {
        [self setCollectionView:nil];
        [self removeFromSuperview];
        
    }];
    
}




-(void)setItemArray:(NSMutableArray *)array
{
    [self.dataArray setArray:array];
    [self.collectionView reloadData];
    
    if ([self.dataArray count])
    {
        [self.pageNumberLabel setText:[NSString stringWithFormat:@"1/%zd",[self.dataArray count]]];
        [self.pageNumberLabel setHidden:NO];
    }
    else
    {
        [self.pageNumberLabel setHidden:YES];
    }
}



#pragma mark - Action Method
-(void)action:(BaseControl*)sender
{
    [self dismiss];
}

#pragma mark - Deletage Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}




- (XHDynamicsPreviewCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHDynamicsPreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemObject:[self.dataArray objectAtIndex:indexPath.item]];
    return cell;
}



#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismiss];
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT);
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


#pragma mark UIScrollerView
-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = fabs((scrollView.contentOffset.x)/scrollView.frame.size.width);
    [self.pageNumberLabel setText:[NSString stringWithFormat:@"%d/%zd",(index+1),[self.dataArray count]]];
}
#pragma mark - Getter / Setter
-(BaseCollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[BaseCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView registerClass:[XHDynamicsPreviewCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        [_collectionView setPagingEnabled:YES];
        [_collectionView setShowsVerticalScrollIndicator:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setBounces:NO];
    }
    return _collectionView;
}

-(UILabel *)pageNumberLabel
{
    if (!_pageNumberLabel)
    {
        _pageNumberLabel = [[UILabel alloc]init];
        [_pageNumberLabel setTextAlignment:NSTextAlignmentCenter];
        [_pageNumberLabel setBackgroundColor:[UIColor whiteColor]];
        [_pageNumberLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
        [_pageNumberLabel setTextColor:[UIColor blackColor]];
        [_pageNumberLabel setHidden:YES];
    }
    return _pageNumberLabel;
}






@end
