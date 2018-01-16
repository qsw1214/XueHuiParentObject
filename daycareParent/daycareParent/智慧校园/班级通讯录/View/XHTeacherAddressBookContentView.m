//
//  XHTeacherAddressBookContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHTeacherAddressBookContentView.h"
#import "XHSortedArrayComparator.h"




@interface XHTeacherAddressBookContentView () <UITableViewDelegate,UITableViewDataSource>



@property (nonatomic,strong) BaseButtonControl *confirmationControl;

@end

@implementation XHTeacherAddressBookContentView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubViews:YES];
    }
    return self;
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.tableView beginRefreshing];
        [self addSubview:self.confirmationControl];
    }
}

-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-50.0)];
    [self.confirmationControl resetFrame:CGRectMake(0, self.tableView.bottom, self.tableView.width, 50.0)];
    [self.confirmationControl setTitleEdgeFrame:CGRectMake(0, 0, self.confirmationControl.width, self.confirmationControl.height) withNumberType:0 withAllType:NO];
    
}



-(void)refreshHeaderAction
{
    [self getAddressBookWithModel:self.model];
}



#pragma mark - Deletage Method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}
-(NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XHTeacherAddressBookKey *bookKey = [self.dataArray objectAtIndex:section];
    [tableView tableTipViewWithArray:bookKey.itemArray];
    return [bookKey.itemArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    XHTeacherAddressBookKey *bookKey = [self.dataArray objectAtIndex:section];
    return bookKey.key;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexArray = [NSMutableArray array];
    for (XHTeacherAddressBookKey *bookKey in self.dataArray)
    {
        [indexArray addObject:bookKey.key];
    }
    return indexArray;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHTeacherAddressBookKey *bookKey = [self.dataArray objectAtIndex:indexPath.section];
    return [[bookKey.itemArray objectAtIndex:indexPath.row] cellHeight];
}


-(XHTeacherAddressBookCell*)tableView:(BaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHTeacherAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHTeacherAddressBookCell alloc]init];
    }
    XHTeacherAddressBookKey *bookKey = [self.dataArray objectAtIndex:indexPath.section];
    [cell setItemFrame:[bookKey.itemArray objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray enumerateObjectsUsingBlock:^(XHTeacherAddressBookKey *bookKey, NSUInteger bookKeyidx, BOOL * _Nonnull stop)
     {
         if (bookKeyidx == indexPath.section)
         {
#pragma mark 如果选中当前分组就开始遍历查询打开的是该分组下那个元素，把选中的元素打开，未选中的关闭
             [bookKey.itemArray enumerateObjectsUsingBlock:^(XHTeacherAddressBookFrame *obj, NSUInteger idx, BOOL *stop)
              {
                  if (idx == indexPath.row)
                  {
                      switch (obj.model.markType)
                      {
#pragma mark 如果当前行为选中状态的话就设置为未选中状态
                          case XHTeacherAddressBookMarkSelectedType:
                          {
                              [obj.model setMarkType:XHTeacherAddressBookMarkNormalType];
                              [obj setModel:obj.model];
                          }
                              break;
#pragma mark 如果是未选中状态的话，就设置为选中状态
                          case XHTeacherAddressBookMarkNormalType:
                          {
                              [obj.model setMarkType:XHTeacherAddressBookMarkSelectedType];
                              [obj setModel:obj.model];
                              
                              if ([self.deletage respondsToSelector:@selector(didSelectRowAtIndexItemObject:)])
                              {
                                  [self.deletage didSelectRowAtIndexItemObject:obj];
                              }
                          }
                              break;
                      }
                  }
                  else
                  {
#pragma mark 未选中的元素关闭
                      [obj.model setMarkType:XHTeacherAddressBookMarkNormalType];
                      [obj setModel:obj.model];
                  }
                  
              }];
         }
         else
         {
#pragma mark 如果为选中当前分组就把该分组下所有的元素设置为未选中状态（如果之前打开过该分组的某项，在点击另一分组的时候就关闭该分组中打开的元素）
             [bookKey.itemArray enumerateObjectsUsingBlock:^(XHTeacherAddressBookFrame *obj, NSUInteger idx, BOOL *stop)
              {
                  [obj.model setMarkType:XHTeacherAddressBookMarkNormalType];
                  [obj setModel:obj.model];
              }];
         }
     }];
    [tableView refreshReloadData];
}




/**
 
 @param model 孩子模型
 */
-(void)getAddressBookWithModel:(XHChildListModel *)model
{
    if (model)
    {
        [self.netWorkConfig setObject:model.clazzId forKey:@"classId"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus009" sucess:^(id object, BOOL verifyObject)
         {
             if (verifyObject)
             {
                 [self.dataArray removeAllObjects];
                 NSArray *itemArray = [object objectItemKey:@"object"];
                 [itemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                  {
                      XHTeacherAddressBookFrame *frame = [XHTeacherAddressBookFrame alloc];
                      XHTeacherAddressBookModel *model = [[XHTeacherAddressBookModel alloc]init];
                      [model setItemObject:obj];
                      [frame setModel:model];
                      [self.dataArray addObject:frame];
                  }];
                 
                 if ([self.dataArray count])
                 {
                     [self.dataArray setArray:[XHSortedArrayComparator sortedArrayUsingComparatorWithTeacherAddressBookKeyArray:self.dataArray]];
                 }
                 
                 [self.tableView refreshReloadData];
             }
             
         } error:^(NSError *error)
         {
             [self.tableView refreshReloadData];
         }];
    }
    else
    {
        [self.tableView refreshReloadData];
    }
}


#pragma mark - Action Method
-(void)confirmationControlAction:(BaseButtonControl*)sender
{
    [self.dataArray enumerateObjectsUsingBlock:^(XHTeacherAddressBookKey *obj, NSUInteger idx, BOOL *stop)
     {
         [obj.itemArray enumerateObjectsUsingBlock:^(XHTeacherAddressBookFrame *itemObj, NSUInteger idx, BOOL * _Nonnull stop)
          {
              switch (itemObj.model.markType)
              {
                  case XHTeacherAddressBookMarkSelectedType:
                  {
                      *stop = YES;
                      if ([self.deletage respondsToSelector:@selector(dissmissPopWithItemObjec:)])
                      {
                          [self.deletage dissmissPopWithItemObjec:itemObj];
                      }
                  }
                      break;
                  case XHTeacherAddressBookMarkNormalType:
                      break;
              }
              
          }];
     }];
}




#pragma mark - Getter / Setter
-(BaseButtonControl *)confirmationControl
{
    if (!_confirmationControl)
    {
        _confirmationControl = [[BaseButtonControl alloc]init];
        [_confirmationControl setBackgroundColor:MainColor];
        [_confirmationControl setNumberLabel:1];
        [_confirmationControl setText:@"确认选择" withNumberType:0 withAllType:NO];
        [_confirmationControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_confirmationControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_confirmationControl addTarget:self action:@selector(confirmationControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmationControl;
}




@end
