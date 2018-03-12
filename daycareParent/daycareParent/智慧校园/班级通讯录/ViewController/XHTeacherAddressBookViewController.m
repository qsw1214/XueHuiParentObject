//
//  XHTeacherAddressBookViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHTeacherAddressBookViewController.h"



@interface XHTeacherAddressBookViewController () <XHTeacherAddressBookContentViewDeletage>

@property (nonatomic,strong) XHTeacherAddressBookContentView *contentView; //!< 内容视图

@property (nonatomic,strong) BaseTableView *tableView;



@end

@implementation XHTeacherAddressBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"选择审批人"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.tableView];
        [self.tableView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
        
        
        
        for (int i = 0; i< 10;i++)
        {
            XHTeacherAddressBookFrame *frame = [[XHTeacherAddressBookFrame alloc]init];
            XHTeacherAddressBookModel *model = [[XHTeacherAddressBookModel alloc]init];
            [model setTeacherName:@"姚立志"];
            [model setPhone:@"15515667760"];
            [model setHeaderUrl:@""];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        
        [self.tableView reloadData];
    }
}

-(void)setModel:(XHChildListModel *)model
{
    _model = model;
    [self.contentView setModel:model];
}


#pragma mark - Deletage Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}


- (XHTeacherAddressBookCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHTeacherAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHTeacherAddressBookCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}

#pragma mark XHTeacherAddressBookContentViewDeletage
-(void)didSelectRowAtIndexItemObject:(XHTeacherAddressBookFrame *)object
{
    if (self.didselectBack)
    {
        self.didselectBack(object);
    }
}


-(void)dissmissPopWithItemObjec:(XHTeacherAddressBookFrame *)object
{
    if (self.didselectBack)
    {
        self.didselectBack(object);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter / Setter
-(BaseTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[BaseTableView alloc]init];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
}







@end
