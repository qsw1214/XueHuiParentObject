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
@property (nonatomic,strong) NSMutableArray  <XHChildListModel*> *bridgeArray; //!< 孩子的滚动视图




@end


@implementation XHAddressBookHeader



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        [self addSubview:self.collectionView];
        [self addSubview:self.switchKnob];
        [self setBackgroundColor:MainColor];
    }
    return self;
}



/**
 默认高度：60px

 @param frame 头部切换视图
 */
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.collectionView resetFrame:CGRectMake(0.0, 0.0, (frame.size.width-60.0), 60.0)];
    [self.switchKnob resetFrame:CGRectMake(self.collectionView.right, 0, 60.0, 60.0)];
    
    
    for (int i = 0; i<10; i++)
    {
        XHChildListModel *model = [[XHChildListModel alloc]init];
        [model setStudentName:@"姚立志"];
        [model setClazzName:[NSString stringWithFormat:@"三年级%zd班",i]];
        [model setMarkType:ChildListNormalType];
        [self.bridgeArray addObject:model];
    }
    
    
    
    [self.bridgeArray setArray:[XHUserInfo sharedUserInfo].childListArry];
    [NSArray enumerateObjectsWithArray:self.bridgeArray usingBlock:^(XHChildListModel *obj, NSUInteger idx, BOOL *stop)
     {
         if (idx)
         {
             [obj setMarkType:ChildListNormalType];
         }
         else
         {
             [obj setMarkType:ChildListSelectType];
         }
     }];

    [self setItemArray:self.bridgeArray];

    
    if ([self.bridgeArray count])
    {
        if ([self.delegate respondsToSelector:@selector(didSelectItem:)])
        {
            [self.delegate didSelectItem:[self.dataArray firstObject]];
        }
    }
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
#pragma mark - case 1 选中状态
        case 1:
        {
            [self animationTransitionType:1];
            [self tidyArrayWithType:1];
            [sender setTag:2];
        }
            break;
#pragma mark - case 2 未选中状态
        case 2:
        {
            [self animationTransitionType:2];
            [self tidyArrayWithType:2];
            [sender setTag:1];
        }
            break;
    }
    
    [self.switchKnob setTransformType:sender.tag];
}


-(void)animationTransitionType:(NSInteger)type
{
    CATransition *anima = [CATransition animation];
    [anima setType:@"cube"]; //设置动画的类型
    [anima setDuration:0.35];
    
    switch (type)
    {
        case 1:
        {
            [anima setSubtype:kCATransitionFromTop]; //设置动画的方向
        }
            break;
        case 2:
        {
            [anima setSubtype:kCATransitionFromBottom]; //设置动画的方向
        }
            
        default:
            break;
    }
    
    [self.layer addAnimation:anima forKey:@"revealAnimation"];
}


-(void)tidyArrayWithType:(NSInteger)type
{
    switch (type)
    {
#pragma mark - case 1:选中状态
        case 1:
        {
            [self didSelectEntirelyItemAtIndexPath:YES];
            
        }
            break;
#pragma mark - case 2:未选中状态
        case 2:
        {
            [NSArray enumerateObjectsWithArray:self.bridgeArray usingBlock:^(XHChildListModel *obj, NSUInteger idx, BOOL *stop)
            {
                [obj setShowType:ChildListEntirelyType];
            }];
            [self.dataArray setArray:self.bridgeArray];
        }
            break;
    }
    
    [self.collectionView reloadData];
    
}


-(void)didSelectEntirelyItemAtIndexPath:(BOOL)entirely
{
    NSMutableArray *tempArray = [NSMutableArray array];
    [NSArray enumerateObjectsWithArray:self.bridgeArray usingBlock:^(XHChildListModel *obj, NSUInteger idx, BOOL *stop)
     {
         switch (obj.markType)
         {
             case ChildListSelectType:
             {
                 [obj setShowType:ChildListAloneType];
                 [tempArray addObject:obj];
             }
                 break;
             case ChildListNormalType:
                 break;
         }
     }];
    
    [self.dataArray setArray:tempArray];
}



#pragma mark - Delegate Method
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


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XHChildListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    switch (model.showType)
    {
        case ChildListAloneType:
            break;
        case ChildListEntirelyType:
        {
            [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHChildListModel *obj, NSUInteger idx, BOOL *stop)
             {
                 if (idx == indexPath.row)
                 {
                     [obj setMarkType:ChildListSelectType];
                     
                 }
                 else
                 {
                     [obj setMarkType:ChildListNormalType];
                 }
                 
                 [obj setShowType:ChildListAloneType];
             }];
            
            
            
            [self didSelectEntirelyItemAtIndexPath:YES];
            [self.switchKnob setTag:2];
            [self animationTransitionType:1];
            [self.switchKnob setTransformType:self.switchKnob.tag];
            
            
            if ([self.delegate respondsToSelector:@selector(didSelectItem:)])
            {
                [self.delegate didSelectItem:model];
            }
        }
            break;
    }
    
    
    
    [collectionView reloadData];
  
    
    
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
        [_collectionView setBackgroundColor:MainColor];
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


-(NSMutableArray <XHChildListModel*> *)bridgeArray
{
    if (!_bridgeArray)
    {
        _bridgeArray = [NSMutableArray array];
    }
    return _bridgeArray;
}






@end
