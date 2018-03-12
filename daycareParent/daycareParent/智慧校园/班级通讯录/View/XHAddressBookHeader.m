//
//  XHAddressBookHeader.m
//  daycareParent
//
//  Created by mac on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAddressBookHeader.h"
#import "BaseCollectionView.h"
#import "XHAddressBookHeaderItemCell.h"
#import "XHAddressBookHeaderSwitchKnob.h"







@interface XHAddressBookHeader () <UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,strong) XHAddressBookHeaderSwitchKnob *switchKnob; //!< 头部的切换孩子旋钮
@property (nonatomic,strong) BaseCollectionView *collectionView; //!< 孩子的滚动视图





@end


@implementation XHAddressBookHeader



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        [self addSubview:self.collectionView];
        [self addSubview:self.switchKnob];
        
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}



-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.collectionView resetFrame:CGRectMake(0.0, 0.0, (frame.size.width-frame.size.height), frame.size.height)];
    [self.switchKnob resetFrame:CGRectMake(self.collectionView.right, 0, frame.size.height, frame.size.height)];
}



#pragma mark - Public Method
-(void)setItemArray:(NSMutableArray *)array
{
    [self.dataArray setArray:array];
    [self.collectionView reloadData];
}


#pragma mark - Private Method
-(void)switchKnobAction:(XHAddressBookHeaderSwitchKnob*)sender
{
    switch (sender.tag)
    {
        case 1:
        {
            CATransition *anima = [CATransition animation];
            anima.type = @"cube";//设置动画的类型
            anima.subtype = kCATransitionFromTop; //设置动画的方向
            anima.duration = 0.35f;
            
            [self.layer addAnimation:anima forKey:@"revealAnimation"];
            [sender setTag:2];
        }
            break;
        case 2:
        {
            CATransition *anima = [CATransition animation];
            anima.type = @"cube";//设置动画的类型
            anima.subtype = kCATransitionFromBottom; //设置动画的方向
            anima.duration = 0.35f;
            
            [self.layer addAnimation:anima forKey:@"revealAnimation"];
            [sender setTag:1];
        }
            break;
    }
    
    
}



#pragma mark - Delertage Method
#pragma mark - Deletage Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}




- (XHAddressBookHeaderItemCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHAddressBookHeaderItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setModel:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark UICollectionViewDelegate
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XHChildListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return CGSizeMake(model.itemSize.width,model.itemSize.height);
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










#pragma mark - Getter /  Setter
-(BaseCollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[BaseCollectionView alloc]initWithType:UICollectionViewScrollDirectionHorizontal];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView registerClass:[XHAddressBookHeaderItemCell class] forCellWithReuseIdentifier:CellIdentifier];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
    }
    return _collectionView;
}


-(XHAddressBookHeaderSwitchKnob *)switchKnob
{
    if (!_switchKnob)
    {
        _switchKnob = [[XHAddressBookHeaderSwitchKnob alloc]init];
        [_switchKnob addTarget:self action:@selector(switchKnobAction:) forControlEvents:UIControlEventTouchUpInside];
        [_switchKnob setTag:1];
    }
    return _switchKnob;
}








@end
