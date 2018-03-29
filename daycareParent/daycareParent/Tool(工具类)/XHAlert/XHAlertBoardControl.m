//
//  XHAlertBoardControl.m
//  daycareParent
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHAlertBoardControl.h"




@interface XHAlertBoardControl () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题标签
@property (nonatomic,strong) UIView *lineView; //!< 分割线
@property (nonatomic,strong) BaseCollectionView *collectionView; //!< 分布图





@end

@implementation XHAlertBoardControl




- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.collectionView];
        [self addSubview:self.cancelControl];
        [self addSubview:self.confirmControl];
        [self setLayerCornerRadius:5.0];
        
        
        [self setItemColor:NO];
    }
    return self;
}


#pragma mark - Public Method
-(void)setItemArray:(NSMutableArray *)array
{
    [self.dataArray setArray:array];
    [self.collectionView reloadData];
}

-(void)setTitle:(NSString*)title
{
    [self.titleLabel setText:title];
}


-(void)setBoardTyp:(XHAlertBoardType)boardTyp
{
    _boardTyp = boardTyp;
    
    switch (boardTyp)
    {
        case XHAlertBoardNormalType:
        {
            [self.collectionView setHidden:YES];
            
            [self.titleLabel setFrame:CGRectMake(0, 0, SCREEN_WIDTH-100.0, 56.0)];
            [self.lineView setFrame:CGRectMake(0, self.titleLabel.bottom, self.titleLabel.width, 0.5)];
            [self.cancelControl resetFrame:CGRectMake(0, self.lineView.bottom, self.lineView.width/2.0, 44.0)];
            [self.cancelControl setTitleEdgeFrame:CGRectMake(0, 0, self.cancelControl.width, self.cancelControl.height) withNumberType:0 withAllType:NO];
            [self.confirmControl resetFrame:CGRectMake(self.cancelControl.right, self.cancelControl.top, self.cancelControl.width, self.cancelControl.height)];
            [self.confirmControl setTitleEdgeFrame:CGRectMake(0, 0, self.cancelControl.width, self.cancelControl.height) withNumberType:0 withAllType:NO];
            [self setFrame:CGRectMake(0, 0, self.titleLabel.width, self.confirmControl.bottom)];
            
        }
            break;
        case XHAlertBoardOptionType:
        case XHAlertBoardKindType:
        {
            [self.collectionView setHidden:NO];
            [self.titleLabel setFrame:CGRectMake(0, 0, SCREEN_WIDTH-100.0, 40.0)];
            
            [self.collectionView resetFrame:CGRectMake(20.0, self.titleLabel.bottom, (self.titleLabel.width-40.0), 60.0)];
            
            [self.lineView setFrame:CGRectMake(0, (self.collectionView.bottom+5.0), self.titleLabel.width, 0.5)];
            [self.cancelControl resetFrame:CGRectMake(0, self.lineView.bottom, self.lineView.width/2.0, 44.0)];
            [self.cancelControl setTitleEdgeFrame:CGRectMake(0, 0, self.cancelControl.width, self.cancelControl.height) withNumberType:0 withAllType:NO];
            [self.confirmControl resetFrame:CGRectMake(self.cancelControl.right, self.cancelControl.top, self.cancelControl.width, self.cancelControl.height)];
            [self.confirmControl setTitleEdgeFrame:CGRectMake(0, 0, self.cancelControl.width, self.cancelControl.height) withNumberType:0 withAllType:NO];
            
            [self setFrame:CGRectMake(0, 0, self.titleLabel.width, self.confirmControl.bottom)];
        }
            break;
    }
}



#pragma mark - Private Method
-(void)alertBoardControlAction:(BaseButtonControl*)sender
{
    switch (sender.tag)
    {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
    }
    
}


#pragma mark - Delegate Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}




- (XHAlertItemCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHAlertItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setModel:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark UICollectionViewDelegate
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XHAlertModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return CGSizeMake(model.itemSize.width,model.itemSize.height);
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
    return UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHAlertModel *obj, NSUInteger idx, BOOL *stop)
    {
        [obj setName:obj.name];
        if (idx == indexPath.row)
        {
            [obj setModelType:XHAlertSelectType];
        }
        else
        {
            [obj setModelType:XHAlertNormalType];
        }
    }];
    
    
    
    
    
    if ([self.delegate respondsToSelector:@selector(didSelectItem:)])
    {
        [self.delegate didSelectItem:[self.dataArray objectAtIndex:indexPath.row]];
    }
    
    [collectionView reloadData];
}








#pragma mark - Getter /  Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:FontLevel2];
        [_titleLabel setTextColor:RGB(51,51,51)];
    }
    return _titleLabel;
}

-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:LineViewColor];
    }
    return _lineView;
}


-(BaseButtonControl *)cancelControl
{
    if (!_cancelControl)
    {
        _cancelControl = [[BaseButtonControl alloc]init];
        [_cancelControl setNumberLabel:1];
        [_cancelControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_cancelControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_cancelControl setText:@"取消" withNumberType:0 withAllType:NO];
    }
    return _cancelControl;
}


-(BaseButtonControl *)confirmControl
{
    if (!_confirmControl)
    {
        _confirmControl = [[BaseButtonControl alloc]init];
        [_confirmControl setNumberLabel:1];
        [_confirmControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_confirmControl setTextColor:RGB(81,200,162) withTpe:0 withAllType:NO];
        [_confirmControl setText:@"确定" withNumberType:0 withAllType:NO];
    }
    return _confirmControl;
}


-(BaseCollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[BaseCollectionView alloc]initWithType:UICollectionViewScrollDirectionHorizontal];
        [_collectionView registerClass:[XHAlertItemCell class] forCellWithReuseIdentifier:CellIdentifier];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
       
    }
    return _collectionView;
}


-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.titleLabel setBackgroundColor:[UIColor redColor]];
        [self.cancelControl setBackgroundColor:[UIColor orangeColor]];
        [self.confirmControl setBackgroundColor:[UIColor purpleColor]];
        [self.collectionView setBackgroundColor:[UIColor darkGrayColor]];
    }
}

@end
