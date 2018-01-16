//
//  XHAddressBookLecturesContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "BaseCollectionView.h"
#import "XHAddressBookFrame.h"

@interface XHAddressBookLecturesContentView : BaseControl <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题
@property (nonatomic,strong) BaseCollectionView *contentView; //!< 内容
@property (nonatomic,strong) BaseButtonControl *confirmControl; //!< 确定





@end
