//
//  XHListTableViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHListTableViewCell.h"
#import "XHListCollectionViewCell.h"
#define ICON_LIST @[@"ico_study",@"ico_collection",@"ico_down",@"ico_course"]
#define TITLE_LIST @[@"学习记录",@"收藏资源",@"下载记录",@"我的课程"]
@implementation XHListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         _listArry=TITLE_LIST;
        _arry=ICON_LIST;
        for (int i=0; i<4; i++)
        {
            
            UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
            layout.itemSize = CGSizeMake((SCREEN_WIDTH-25)/4, SCREEN_WIDTH/4);
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumLineSpacing = 5;
            layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
            _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_WIDTH/4) collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor whiteColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            _collectionView.scrollsToTop = NO;
            _collectionView.bounces=NO;
            _collectionView.showsVerticalScrollIndicator = NO;
            _collectionView.showsHorizontalScrollIndicator = NO;
            [_collectionView registerClass:[XHListCollectionViewCell class] forCellWithReuseIdentifier:@"childCellID"];
            [self.contentView addSubview:_collectionView];
        }
        
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHListCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"childCellID" forIndexPath:indexPath];
    cell.listImageView.image=[UIImage imageNamed:_arry[indexPath.item]];
    cell.listLabel.text=_listArry[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectListBlock) {
        self.selectListBlock(indexPath.row);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
