//
//  XHSafeRegisterViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSafeRegisterViewController.h"
#import "XHRegisterTableViewCell.h"
#import "XHDateSwitchControl.h"
#import "XHAddressBookHeader.h"





@interface XHSafeRegisterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) XHAddressBookHeader *switchHeaderControl;
@property (nonatomic,strong) XHDateSwitchControl *dateSwitchControl;
@property (nonatomic,strong) BaseTableView *tableView;

@end

@implementation XHSafeRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"平安记录"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.switchHeaderControl];
        [self.switchHeaderControl resetFrame:CGRectMake(0, self.navigationView.height, SCREEN_WIDTH, 60.0)];
        [self.view addSubview:self.dateSwitchControl];
        [self.dateSwitchControl resetFrame:CGRectMake(0, self.switchHeaderControl.bottom, SCREEN_WIDTH, self.switchHeaderControl.height)];
        [self.view addSubview:self.tableView];
        [self.tableView resetFrame:CGRectMake(0, self.dateSwitchControl.bottom, SCREEN_WIDTH, CONTENT_HEIGHT-120.0)];
        
        
        
        for (int i = 0; i<10; i++)
        {
            XHRegisterFrame *frame = [[XHRegisterFrame alloc]init];
            XHRegisterModel *model = [[XHRegisterModel alloc]init];
            [model setTitle:@"周一"];
            [model setDate:@"11月10日"];
            [model setTime:@"00:00:00"];
            [frame setModel:model];
            
            [self.dataArray addObject:frame];
        }
        
        [self.tableView refreshReloadData];
    }
}




#pragma mark - Delertage Method
-(NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}


-(XHRegisterTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHRegisterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHRegisterTableViewCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
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


-(XHDateSwitchControl *)dateSwitchControl
{
    if (!_dateSwitchControl)
    {
        _dateSwitchControl = [[XHDateSwitchControl alloc]init];
        [_dateSwitchControl setBackgroundColor:RGB(244.0, 244.0, 244.0)];
    }
    return _dateSwitchControl;
}


-(XHAddressBookHeader *)switchHeaderControl
{
    if (!_switchHeaderControl)
    {
        _switchHeaderControl = [[XHAddressBookHeader alloc]init];
    }
    return _switchHeaderControl;
}








@end
