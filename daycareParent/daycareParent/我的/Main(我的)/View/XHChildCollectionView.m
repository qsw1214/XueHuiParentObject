//
//  XHChildCollectionView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHChildCollectionView.h"
#import "XHChildCollectionViewCell.h"
#import "XHChildListModel.h"
@interface XHChildCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_childListArry;
}
@end


@implementation XHChildCollectionView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _childListArry=[NSMutableArray array];
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(USER_HEARD, USER_HEARD*2+20);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 8;
        layout.sectionInset = UIEdgeInsetsMake(15, 8, 15, 8);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,USER_HEARD*2+20) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces=NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XHChildCollectionViewCell class] forCellWithReuseIdentifier:@"childCellID"];
        [self addSubview:_collectionView];
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _childListArry.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHChildCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"childCellID" forIndexPath:indexPath];
    if (indexPath.item==_childListArry.count-1) {
        cell.childClassLabel.hidden=YES;
        cell.childNameLabel.text=@"绑定学生";
        cell.childImageView.image=[UIImage imageNamed:@"ico_bindstudents"];
    }
    else
    {
        cell.childClassLabel.hidden=NO;
        XHChildListModel *model=_childListArry[indexPath.item];
        [cell.childImageView sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(model.headPic)] placeholderImage:[UIImage imageNamed:@"addman"]];
        cell.childNameLabel.text=model.studentName;
        cell.childClassLabel.text=model.clazzName;
        
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHChildListModel *model = _childListArry[indexPath.item];
    XHChildCollectionViewCell *cell=[_collectionView cellForItemAtIndexPath:indexPath];
    if (self.selectBlock) {
        self.selectBlock(indexPath.row,cell.childNameLabel.text,model);
    }
}
-(void)setItemArray:(NSMutableArray *)array
{
    _childListArry=array;
    [_collectionView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
