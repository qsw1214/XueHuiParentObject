//
//  XHGuideViewContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHGuideViewContentView.h"
#import "BaseCollectionView.h"
#import "BaseButtonControl.h"
#import "KYAnimatedPageControl.h"
#import "MainRootControllerHelper.h"



@interface XHGuideViewContentView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,assign) NSInteger itemCount;  //!< 当前的个数
@property (nonatomic,strong) BaseButtonControl *experienceControl;
@property (nonatomic,strong) BaseCollectionView *collectionView;  //!< 滚动视图
@property (nonatomic,strong) KYAnimatedPageControl *pageControl;

@end



@implementation XHGuideViewContentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:RGB(255, 254, 254)];
        [self addSubview:self.collectionView];
        [self addSubview:self.experienceControl];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.collectionView resetFrame:frame];
    /**
     隐藏分页功能
     [self addSubview:self.pageControl];
     */
    
    
    self.pageControl.didSelectIndexBlock = ^(NSInteger index)
    {
            NSLog(@"Did Selected index : %ld", (long)index);
        
    };
    
    [self.experienceControl resetFrame:CGRectMake(((frame.size.width-120.0)/2.0), (frame.size.height-80.0), 120.0, 40.0)];
    [self.experienceControl setImageEdgeFrame:CGRectMake(0, 0, 120, 40.0) withNumberType:0 withAllType:NO];
    [self.experienceControl setHidden:YES];
}




-(void)setItemArray:(NSMutableArray*)array
{
    [self.dataArray setArray:array];
    [self setItemCount:[self.dataArray count]];
    [self.collectionView reloadData];
}


#pragma mark - Action Method
-(void)experienceControlAction:(BaseButtonControl*)sender
{
    [MainRootControllerHelper setAppVersion];
}



#pragma mark - Deletage Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemCount;
}




- (XHGuideCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHGuideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemObject:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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



#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //Indicator动画
    [self.pageControl.indicator animateIndicatorWithScrollView:scrollView andIndicator:self.pageControl];
    
    if (scrollView.dragging || scrollView.isDecelerating || scrollView.tracking) {
        //背景线条动画
        [self.pageControl.pageControlLine animateSelectedLineWithScrollView:scrollView];
    }
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat currently_X = scrollView.contentOffset.x;
    if (currently_X >= (((self.itemCount-1) > 0 ? (self.itemCount-1) : 0)*SCREEN_WIDTH))
    {
        [UIView animateWithDuration:0.15 animations:^{

            [self.experienceControl setHidden:NO];

        }];
    }
    else
    {
        [UIView animateWithDuration:0.1 animations:^{

            [self.experienceControl setHidden:YES];

        }];
    }
    
    self.pageControl.indicator.lastContentOffset = scrollView.contentOffset.x;
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    
    [self.pageControl.indicator restoreAnimation:@(1.0/self.pageControl.pageCount)];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.pageControl.indicator.lastContentOffset = scrollView.contentOffset.x;
}


#pragma mark - Getter / Setter
-(KYAnimatedPageControl *)pageControl
{
    if (_pageControl == nil)
    {
        _pageControl = [[KYAnimatedPageControl alloc]initWithFrame:CGRectMake(60.0, SCREEN_HEIGHT-60.0, SCREEN_WIDTH-120.0, 40.0)];
        [_pageControl setPageCount:4];
        [_pageControl setUnSelectedColor:[UIColor colorWithWhite:0.9 alpha:1]];
        [_pageControl setSelectedColor:[UIColor redColor]];
        [_pageControl setBindScrollView:self.collectionView];
        [_pageControl setShouldShowProgressLine:YES];
        [_pageControl setIndicatorStyle:IndicatorStyleGooeyCircle];
        [_pageControl setIndicatorSize:20.0];
        [_pageControl setSwipeEnable:YES];
    }
    return _pageControl;
}


-(BaseCollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[BaseCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setShowsVerticalScrollIndicator:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView registerClass:[XHGuideCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        [_collectionView setPagingEnabled:YES];
        [_collectionView setBounces:NO];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
    }
    return _collectionView;
}


-(BaseButtonControl *)experienceControl
{
    if (_experienceControl == nil)
    {
        _experienceControl = [[BaseButtonControl alloc]init];
        [_experienceControl setImageContentMode:UIViewContentModeScaleAspectFit withNumberType:0 withAllType:NO];
        [_experienceControl setNumberImageView:1];
        [_experienceControl setImage:@"experiencel" withNumberType:0 withAllType:NO];
        [_experienceControl addTarget:self action:@selector(experienceControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _experienceControl;
}



@end
