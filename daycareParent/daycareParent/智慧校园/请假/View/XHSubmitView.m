//
//  XHSubmitView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSubmitView.h"
#import "XHSubmitCollectionViewCell.h"
#import "XHRecipientModel.h"
#import "XHTeacherAddressBookViewController.h"
@interface XHSubmitView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,strong)NSMutableArray *teacherArry;
@end

@implementation XHSubmitView
-(instancetype)init
{
    if (self=[super init]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.collectionView];
        [self addSubview:self.submitButton];
    }
    return self;
}
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    self.titleLabel.frame=CGRectMake(10, 0, frame.size.width-20, 30);
    self.collectionView.frame=CGRectMake(0, self.titleLabel.bottom, frame.size.width,100);
    self.submitButton.frame=CGRectMake(10, self.collectionView.bottom+10, frame.size.width-20, frame.size.height-self.titleLabel.height-self.collectionView.height-10);
}

-(void)setItemArry:(NSMutableArray *)arry
{
    [self.dataArry setArray:arry];
    [self.collectionView reloadData];
}


 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
 {
     if (self.dataArry.count>3)
     {
         return 3;
     }
     else
     {
         return self.dataArry.count;
     }
     
 }
 - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
 {
     XHSubmitCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"childCellID" forIndexPath:indexPath];
     [cell setItemObject:self.dataArry[indexPath.row]];
 
     return cell;
 }
 -(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
 {
     XHRecipientModel *model=self.dataArry[indexPath.item];
     switch (model.modelType) {
         case XHRecipientNomalModelType:
         {
             [self.dataArry removeObject:model];
             [self.collectionView reloadData];
             [self.teacherArry removeObject:model.ID];
             if ([_delegate respondsToSelector:@selector(getItemObject:)]) {
                 NSString * teacherId = [self.teacherArry componentsJoinedByString:@","];
                 [self.delegate getItemObject:teacherId];
             }
         }
             break;
             
         case XHRecipientAddModelType:
         {
             XHTeacherAddressBookViewController *teacherAddressBook = [[XHTeacherAddressBookViewController alloc]init];
              teacherAddressBook.enterType=TeacherAddressBookAskLeaveType;
                [[XHHelper sharedHelper].currentlyViewController.navigationController pushViewController:teacherAddressBook animated:YES];
                         teacherAddressBook.didselectBack = ^(XHTeacherAddressBookFrame *itemObject)
                         {
                             XHRecipientModel *model=[[XHRecipientModel alloc] init];
                             model.name=itemObject.model.teacherName;
                             model.headPic=itemObject.model.headerUrl;
                             model.ID=itemObject.model.ID;
                             model.modelType=XHRecipientNomalModelType;
                             [self.dataArry insertObject:model atIndex:self.dataArry.count-1];
                             
                             [self.collectionView reloadData];
                             [self.teacherArry addObject:[NSString safeString:itemObject.model.ID]];
                             if ([_delegate respondsToSelector:@selector(getItemObject:)]) {
                                 NSString * teacherId = [self.teacherArry componentsJoinedByString:@","];
                                 [self.delegate getItemObject:teacherId];
                             }
                         };
         }
             break;
     }
// XHChildCollectionViewCell *cell=[_collectionView cellForItemAtIndexPath:indexPath];
// if (self.selectBlock) {
// self.selectBlock(indexPath.row,cell.childNameLabel.text);
// }
 }
-(UILabel *)titleLabel
{
    if (_titleLabel==nil) {
        _titleLabel=[[UILabel alloc] init];
        [_titleLabel setTextColor:RGB(14, 14, 14)];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        _titleLabel.text=@"接收人";
    }
    return _titleLabel;
}
-(UIButton *)submitButton
{
    if (_submitButton==nil) {
        _submitButton=[[UIButton alloc] init];
        _submitButton.titleLabel.font=[UIFont boldSystemFontOfSize:14.0];
        _submitButton.backgroundColor=MainColor;
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius=8;
        _submitButton.layer.masksToBounds=YES;
    }
    return _submitButton;
}
-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(70, 100);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0,5);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces=NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XHSubmitCollectionViewCell class] forCellWithReuseIdentifier:@"childCellID"];
    }
    return _collectionView;
}
-(NSMutableArray *)dataArry
{
    if (_dataArry==nil) {
        _dataArry=[[NSMutableArray alloc] init];
        XHRecipientModel *model=[[XHRecipientModel alloc] init];
        model.modelType=XHRecipientAddModelType;
        [_dataArry addObject:model];
    }
    return _dataArry;
}
-(NSMutableArray *)teacherArry
{
    if (_teacherArry==nil) {
        _teacherArry=[[NSMutableArray alloc] init];
    }
    return _teacherArry;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
