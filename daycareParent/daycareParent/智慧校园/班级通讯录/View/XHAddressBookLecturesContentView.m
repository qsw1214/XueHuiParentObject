//
//  XHAddressBookLecturesContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookLecturesContentView.h"
#import "XHAddressBookLecturesCell.h"




@interface XHAddressBookLecturesContentView ()

@property (nonatomic,assign) CGFloat contentHeight;

@end


@implementation XHAddressBookLecturesContentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentView];
        [self addSubview:self.confirmControl];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}



-(void)setItemFrame:(XHAddressBookFrame*)frame
{
    
    [self.titleLabel setText:[NSString stringWithFormat:@"%@所授课程",frame.model.teacherName]];
    
    
    if (frame.model.courseArray)
    {
        [self.dataArray setArray:frame.model.courseArray];
        CGFloat tempHeight = ([self.dataArray count]  ? [self.dataArray count]*40.0+5.0 : 40+5.0);
        [self setContentHeight:((tempHeight + 90.0) >= (SCREEN_HEIGHT/2.0) ? ((SCREEN_HEIGHT/2.0)-90.0) : tempHeight)];
    }
    else
    {
        [self.dataArray addObject:@"暂无"];
        [self setContentHeight:([self.dataArray count]*40.0+5.0)];
    }
    
    
    [self resetFrame:CGRectMake(20,(SCREEN_HEIGHT-(self.contentHeight+90.0))/2.0, (SCREEN_WIDTH-40.0), (self.contentHeight+90.0))];
    
    [self.contentView reloadData];
    
    
}

-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, 40.0)];
    [self.contentView resetFrame:CGRectMake(0, self.titleLabel.bottom, frame.size.width, self.contentHeight)];
    [self.confirmControl resetFrame:CGRectMake(0,self.contentView.bottom, self.titleLabel.width, 50.0)];
    [self.confirmControl setTitleEdgeFrame:CGRectMake(0, 0, self.confirmControl.width, self.confirmControl.height) withNumberType:0 withAllType:NO];
    [self.confirmControl resetLineViewFrame:CGRectMake(0, 0, self.confirmControl.width, 0.5) withNumberType:0 withAllType:NO];
    
    [self setLayerCornerRadius:5.0];
}








#pragma mark - Deletage Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}




- (XHAddressBookLecturesCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHAddressBookLecturesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setTitle:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark UICollectionViewDelegate
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.width,40);
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
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    }
    return _titleLabel;
}


-(BaseCollectionView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[BaseCollectionView alloc]init];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_contentView setDelegate:self];
        [_contentView setDataSource:self];
        [_contentView registerClass:[XHAddressBookLecturesCell class] forCellWithReuseIdentifier:CellIdentifier];
    }
    return _contentView;
}


-(BaseButtonControl *)confirmControl
{
    if (!_confirmControl)
    {
        _confirmControl = [[BaseButtonControl alloc]init];
        [_confirmControl setNumberLabel:1];
        [_confirmControl setNumberLineView:1];
        [_confirmControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_confirmControl setTextColor:MainColor withTpe:0 withAllType:NO];
        [_confirmControl setText:@"确定" withNumberType:0 withAllType:NO];
    }
    return _confirmControl;
}





@end
