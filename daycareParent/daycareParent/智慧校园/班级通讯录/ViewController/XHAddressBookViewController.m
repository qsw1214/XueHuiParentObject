//
//  XHAddressBookViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAddressBookViewController.h"
#import "XHAddressBookContentView.h"
#import "XHAddressBookKey.h"
#import "XHAddressBookHeader.h"


@interface XHAddressBookViewController () <UITableViewDelegate,UITableViewDataSource,XHAddressBookHeaderDelegate,XHAddressBookSwitchMenuViewDelegate>


@property (nonatomic,strong) XHAddressBookHeader *addressBookHeader;

@property (nonatomic,strong) NSMutableArray *tableArray;

@property (nonatomic,strong) XHChildListModel *childListModel;

@end




@implementation XHAddressBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"通讯录"];
    [self navtionItemHidden:NavigationItemLeftType];
    [self.mainTableView setTipType:TipTitleAndTipImage withTipTitle:@"暂无数据" withTipImage:@"pic_nothing"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Private Method
-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.addressBookHeader];
        [self.addressBookHeader resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 60.0)];
        [self.mainTableView resetFrame:CGRectMake(0.0, (self.addressBookHeader.bottom+10.0), SCREEN_WIDTH, SCREEN_HEIGHT-(self.addressBookHeader.bottom+10.0))];
        [self.mainTableView setDelegate:self];
        [self.mainTableView setDataSource:self];
        [self.mainTableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
        [self.mainTableView beginRefreshing];
        [self.view addSubview:self.mainTableView];
    }
}


-(void)refreshHead
{
    [self getAddressBookWithModel:self.childListModel];
}

#pragma mark - Delertage Method
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.tableArray];
    return [self.tableArray count];
}

- (XHAddressBookCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[XHAddressBookCell alloc]initWithDeletage:self];
    }
    [cell setItemFrame:[self.tableArray objectAtIndex:indexPath.row]];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.tableArray objectAtIndex:indexPath.row] cellHeight];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark XHAddressBookHeaderDelegate
-(void)didSelectItem:(XHChildListModel*)model
{
    [self setChildListModel:model];
    [self.mainTableView beginRefreshing];
}

#pragma mark XHddressBookSwitchMenuViewDelegate
-(void)switchDraggMenuIndexPath:(NSInteger)indexPath
{

    [self.dataArray enumerateObjectsUsingBlock:^(XHAddressBookFrame *obj, NSUInteger idx, BOOL *stop)
     {
         if (idx == indexPath)
         {
             [obj.model setModelType:XHAddressBookSelectType];
         }
         else
         {
             [obj.model setModelType:XHAddressBookModelNormalType];
         }
         
     }];
    
    [self.mainTableView refreshReloadData];
}




#pragma mark - NetWork Method
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
                 [self.tableArray removeAllObjects];
                 NSArray *itemArray = [object objectItemKey:@"object"];
                 [itemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                  {
                      XHAddressBookFrame *frame = [XHAddressBookFrame alloc];
                      XHAddressBookModel *model = [[XHAddressBookModel alloc]init];
                      [model setItemObject:obj];
                      [frame setModel:model];
                      [self.tableArray addObject:frame];
                  }];
                 [self.mainTableView refreshReloadData];
             }
             
         } error:^(NSError *error)
         {
             [self.mainTableView refreshReloadData];
         }];
    }
    else
    {
        [self.mainTableView refreshReloadData];
    }
}






#pragma mark - Getter /  Setter
-(XHAddressBookHeader *)addressBookHeader
{
    if (!_addressBookHeader)
    {
        _addressBookHeader = [[XHAddressBookHeader alloc]init];
        [_addressBookHeader setDelegate:self];
    }
    return _addressBookHeader;
}


-(NSMutableArray *)tableArray
{
    if (!_tableArray)
    {
        _tableArray = [NSMutableArray array];
    }
    return _tableArray;
}





@end
