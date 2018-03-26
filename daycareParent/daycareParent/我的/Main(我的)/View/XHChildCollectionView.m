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
@property(nonatomic,strong)NSMutableArray *childListArry;
@property(nonatomic,strong)ParentControl *addButton;

@end


@implementation XHChildCollectionView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.layer.cornerRadius=10;
        self.layer.masksToBounds=YES;
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.collectionView];
        [self addSubview:self.addButton];
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childListArry.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHChildCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"childCellID" forIndexPath:indexPath];
    XHChildListModel *model=self.childListArry[indexPath.item];
    [cell setItemObject:model];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHChildListModel *model = self.childListArry[indexPath.item];
    XHChildCollectionViewCell *cell=[collectionView cellForItemAtIndexPath:indexPath];
    if ([_delegate respondsToSelector:@selector(getChildModel:withChildName:index:)]) {
        [_delegate getChildModel:model withChildName:model.studentName index:indexPath.row];
    }
    
}
-(void)setItemArray:(NSMutableArray *)array
{
    self.childListArry=array;
    [self.collectionView reloadData];
}
-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(USER_HEARD, USER_HEARD*2+20);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 24;
        layout.sectionInset = UIEdgeInsetsMake(15, 24, 15, 24);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20-(USER_HEARD+24),USER_HEARD*2+20) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces=NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XHChildCollectionViewCell class] forCellWithReuseIdentifier:@"childCellID"];
    }
    return _collectionView;
}
-(ParentControl *)addButton
{
    if (_addButton==nil) {
        _addButton=[[ParentControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-USER_HEARD-24, 5, USER_HEARD, USER_HEARD*2+15)];
        [_addButton setNumberImageView:1];
        [_addButton setImageViewBackgroundColor:[UIColor redColor] withNumberIndex:0];
        [_addButton setImageViewCGRectMake:CGRectMake(0, 10, USER_HEARD, USER_HEARD) withNumberIndex:0];
        [_addButton setImageViewName:@"ico_bindstudents" withNumberIndex:0];
        [_addButton setImageViewCornerRadius:USER_HEARD/2.0 withNumberIndex:0];
        [_addButton setNumberLabel:1];
        [_addButton setLabelCGRectMake:CGRectMake(-10, USER_HEARD+20, USER_HEARD+20, 20) withNumberIndex:0];
        [_addButton setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:0];
        [_addButton setLabelFont:FontLevel3 withNumberIndex:0];
        [_addButton setLabelText:@"绑定学生" withNumberIndex:0];
        [_addButton addTarget:self action:@selector(addMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
-(void)addMethod
{
    if ([_delegate respondsToSelector:@selector(getChildModel:withChildName:index:)]) {
        [_delegate getChildModel:nil withChildName:@"绑定学生" index:self.childListArry.count];
    }
}
-(NSMutableArray *)childListArry
{
    if (_childListArry==nil) {
        _childListArry=[[NSMutableArray alloc] init];
    }
    return _childListArry;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
