//
//  XHChildTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHChildTableViewCell.h"
#import "XHChildCollectionViewCell.h"
#import "XHChildListModel.h"
@implementation XHChildTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _childListArry=[NSMutableArray array];
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(USER_HEARD, USER_HEARD*2+20);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(15, 5, 15, 5);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,USER_HEARD*2+20) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces=NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XHChildCollectionViewCell class] forCellWithReuseIdentifier:@"childCellID"];
        [self.contentView addSubview:_collectionView];
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
        cell.childImageView.image=[UIImage imageNamed:@"ico_tied-student"];
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
    XHChildCollectionViewCell *cell=[_collectionView cellForItemAtIndexPath:indexPath];
    if (self.selectBlock) {
        self.selectBlock(indexPath.row,cell.childNameLabel.text);
    }
}
-(void)setItemArray:(NSMutableArray *)array
{
    _childListArry=array;
    [_collectionView reloadData];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
