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


@end




@implementation XHAddressBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"通讯录"];
    [[XHHelper sharedHelper] addObserver:self forKeyPath:@"KVO" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"接收用户点击的行"];
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
        [self.view addSubview:self.mainTableView];
    }
}




#pragma mark - Delertage Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    [self getAddressBookWithModel:model];
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
    
    [self.mainTableView reloadData];
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
                 [self.dataArray removeAllObjects];
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



/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"KVO"])
    {
        NSInteger kvoTag = [[change valueForKey:@"new"] integerValue];
        NSLog(@"%zd",kvoTag);
        // 响应变化处理：UI更新（label文本改变）
        
        //上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
        NSLog(@"\noldnum:%@ newnum:%@",[change valueForKey:@"old"],[change valueForKey:@"new"]);
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
