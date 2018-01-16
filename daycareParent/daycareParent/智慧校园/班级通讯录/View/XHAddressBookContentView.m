//
//  XHAddressBookContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookContentView.h"
#import "XHSortedArrayComparator.h"



@interface XHAddressBookContentView () <UITableViewDelegate,UITableViewDataSource>


@end

@implementation XHAddressBookContentView



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
    }
    return self;
}

-(void)refreshHead
{
    [self getAddressBookWithModel:self.childModel];
}


-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}


#pragma mark - Deletage Method
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    XHAddressBookKey *bookKey = [self.dataArray objectAtIndex:section];
    [tableView tableTipViewWithArray:bookKey.itemArray];
    return [bookKey.itemArray count];
}

// 设置组头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    XHAddressBookKey *bookKey = [self.dataArray objectAtIndex:section];
    return bookKey.key;
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectio
{
    return 30.0;
}

- (XHAddressBookCell *)tableView:(BaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[XHAddressBookCell alloc]init];
    }
    
    XHAddressBookKey *bookKey = [self.dataArray objectAtIndex:indexPath.section];
    [cell setItemFrame:[bookKey.itemArray objectAtIndex:indexPath.row]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHAddressBookKey *bookKey = [self.dataArray objectAtIndex:indexPath.section];
    return [[bookKey.itemArray objectAtIndex:indexPath.row] cellHeight];
}


- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexArray = [NSMutableArray array];
    for (XHAddressBookKey *bookKey in self.dataArray)
    {
         [indexArray addObject:bookKey.key];
    }
    return indexArray;
    
}


#pragma mark UITableViewDelegate
-(void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray enumerateObjectsUsingBlock:^(XHAddressBookKey *bookKey, NSUInteger bookKeyidx, BOOL * _Nonnull stop)
     {
         
         if (bookKeyidx == indexPath.section)
         {
             #pragma mark 如果选中当前分组就开始遍历查询打开的是该分组下那个元素，把选中的元素打开，未选中的关闭
             [bookKey.itemArray enumerateObjectsUsingBlock:^(XHAddressBookFrame *obj, NSUInteger idx, BOOL *stop)
              {
                  if (idx == indexPath.row)
                  {
                      switch (obj.model.modelType)
                      {
                        #pragma mark 如果当前行为选中状态的话就设置为未选中状态
                          case XHAddressBookSelectType:
                          {
                              [obj.model setModelType:XHAddressBookModelNormalType];
                              [obj setModel:obj.model];
                          }
                              break;
                         #pragma mark 如果是未选中状态的话，就设置为选中状态
                          case XHAddressBookModelNormalType:
                          {
                              [obj.model setModelType:XHAddressBookSelectType];
                              [obj setModel:obj.model];
                          }
                              break;
                      }
                  }
                  else
                  {
                      #pragma mark 未选中的元素关闭
                      [obj.model setModelType:XHAddressBookModelNormalType];
                      [obj setModel:obj.model];
                  }
              }];
         }
         else
         {
             #pragma mark 如果为选中当前分组就把该分组下所有的元素设置为未选中状态（如果之前打开过该分组的某项，在点击另一分组的时候就关闭该分组中打开的元素）
             [bookKey.itemArray enumerateObjectsUsingBlock:^(XHAddressBookFrame *obj, NSUInteger idx, BOOL *stop)
              {
                  [obj.model setModelType:XHAddressBookModelNormalType];
                  [obj setModel:obj.model];
              }];
         }
     }];
    

    
    [tableView reloadData];
}
-(void)getModel:(XHChildListModel *)model
{
    self.childModel = model;
    [self getAddressBookWithModel:model];
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
                     XHAddressBookFrame *frame = [XHAddressBookFrame alloc];
                     XHAddressBookModel *model = [[XHAddressBookModel alloc]init];
                     [model setItemObject:obj];
                     [frame setModel:model];
                     [self.dataArray addObject:frame];
                 }];
                
                if ([self.dataArray count])
                {
                    [self.dataArray setArray:[XHSortedArrayComparator sortedArrayUsingComparatorWithKeyArray:self.dataArray]];
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



@end
