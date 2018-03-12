//
//  XHSubmitView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSubmitView.h"
#import "XHChildCollectionViewCell.h"
@interface XHSubmitView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation XHSubmitView
-(instancetype)init
{
    if (self=[super init]) {
        [self addSubview:self.collectionView];
        [self addSubview:self.submitButton];
    }
    return self;
}
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    self.submitButton.frame=CGRectMake(10, self.collectionView.bottom+10, frame.size.width-20, frame.size.height-self.collectionView.height);
    
}

-(void)setItemArry:(NSMutableArray *)arry
{
    [self.collectionView reloadData];
}
-(UIButton *)submitButton
{
    if (_submitButton==nil) {
        _submitButton=[[UIButton alloc] init];
        _submitButton.titleLabel.font=[UIFont boldSystemFontOfSize:14.0];
        _submitButton.backgroundColor=MainColor;
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    }
    return _submitButton;
}
-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(50, 110);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,110) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor redColor];
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

 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
 {
     return 3;
 }
 - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
 {
     XHChildCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"childCellID" forIndexPath:indexPath];
// if (indexPath.item==_childListArry.count-1) {
// cell.childClassLabel.hidden=YES;
// cell.childNameLabel.text=@"绑定学生";
// cell.childImageView.image=[UIImage imageNamed:@"ico_bindstudents"];
// }
// else
// {
// cell.childClassLabel.hidden=NO;
// XHChildListModel *model=_childListArry[indexPath.item];
// [cell.childImageView sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(model.headPic)] placeholderImage:[UIImage imageNamed:@"addman"]];
// cell.childNameLabel.text=model.studentName;
// cell.childClassLabel.text=model.clazzName;
//
// }
 
 return cell;
 }
 -(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
 {
// XHChildCollectionViewCell *cell=[_collectionView cellForItemAtIndexPath:indexPath];
// if (self.selectBlock) {
// self.selectBlock(indexPath.row,cell.childNameLabel.text);
// }
 }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
