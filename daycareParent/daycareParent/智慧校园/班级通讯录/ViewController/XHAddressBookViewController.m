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


@interface XHAddressBookViewController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) XHAddressBookHeader *addressBookHeader;
@property (nonatomic,strong) BaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableArray;


@end




@implementation XHAddressBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
        
        for (int i = 0; i<10; i++)
        {
            XHChildListModel *model = [[XHChildListModel alloc]init];
            [model setStudentName:@"姚立志"];
            [model setClazzName:@"三年级二班"];
            [model setMarkType:ChildListNormalType];
            [self.dataArray addObject:model];
        }
        
        
        for (int i=0; i<10; i++)
        {
            XHAddressBookFrame *frame = [[XHAddressBookFrame alloc]init];
            XHAddressBookModel *model = [[XHAddressBookModel alloc]init];
            [model setTeacherName:@"姚立志"];
            [frame setModel:model];
            [self.tableArray addObject:frame];
        }
        
       
        [self.view addSubview:self.addressBookHeader];
        [self.addressBookHeader resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 60.0)];
        [self.tableView resetFrame:CGRectMake(0.0, (self.addressBookHeader.bottom+10.0), SCREEN_WIDTH, SCREEN_HEIGHT-(self.addressBookHeader.bottom+10.0))];
        [self.view addSubview:self.tableView];
        
        [self.addressBookHeader setItemArray:self.dataArray];
        
        
        [self.tableView reloadData];
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
        cell = [[XHAddressBookCell alloc]init];
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





#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
    
}



#pragma mark - Getter /  Setter
-(XHAddressBookHeader *)addressBookHeader
{
    if (!_addressBookHeader)
    {
        _addressBookHeader = [[XHAddressBookHeader alloc]init];
    }
    return _addressBookHeader;
}

-(BaseTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
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
