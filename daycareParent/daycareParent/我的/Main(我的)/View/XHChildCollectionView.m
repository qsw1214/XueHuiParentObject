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
@property(nonatomic,strong)ParentButton *addButton;

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
    if (self.selectBlock) {
        self.selectBlock(indexPath.row,model.studentName,model);
    }
}
-(void)setItemArray:(NSMutableArray *)array
{
    self.childListArry=array;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:array.count - 1 inSection:0]  atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(USER_HEARD, USER_HEARD*2+20);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 8;
        layout.sectionInset = UIEdgeInsetsMake(15, 8, 15, 8);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20-(USER_HEARD+8),USER_HEARD*2+20) collectionViewLayout:layout];
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
-(ParentButton *)addButton
{
    if (_addButton==nil) {
        _addButton=[[ParentButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-USER_HEARD-8, 0, USER_HEARD, USER_HEARD*2+20)];
        [_addButton setNumberImageView:1];
        [_addButton setImageViewBackgroundColor:[UIColor redColor] withNumberIndex:0];
        [_addButton setImageViewCGRectMake:CGRectMake(0, 10, USER_HEARD, USER_HEARD) withNumberIndex:0];
        [_addButton setImageViewName:@"ico_bindstudents" withNumberIndex:0];
        [_addButton setImageViewCornerRadius:USER_HEARD/2.0 withNumberIndex:0];
        [_addButton setNumberLabel:1];
        [_addButton setLabelCGRectMake:CGRectMake(0, USER_HEARD+20, USER_HEARD, 20) withNumberIndex:0];
        [_addButton setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:0];
        [_addButton setLabelFont:FontLevel3 withNumberIndex:0];
        [_addButton setLabelText:@"绑定学生" withNumberIndex:0];
        [_addButton addTarget:self action:@selector(addMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
-(void)addMethod
{
    if (self.selectBlock) {
        self.selectBlock(self.childListArry.count,@"绑定学生",nil);
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
