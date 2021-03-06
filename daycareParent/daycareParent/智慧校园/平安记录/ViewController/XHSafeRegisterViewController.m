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






@interface XHSafeRegisterViewController ()<UITableViewDelegate,UITableViewDataSource,XHAddressBookHeaderDelegate,XHDateSwitchControlDelegate>

@property (nonatomic,strong) XHAddressBookHeader *switchHeaderControl;
@property (nonatomic,strong) XHDateSwitchControl *dateSwitchControl;
@property (nonatomic,strong) BaseTableView *tableView;

@end

@implementation XHSafeRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"考勤记录"];
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
        [self.tableView setTipType:TipTitleAndTipImage withTipTitle:@"暂无考勤记录" withTipImage:@"pic_nothing"];
        [self.tableView resetFrame:CGRectMake(0, self.dateSwitchControl.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.dateSwitchControl.bottom)];
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




#pragma mark XHAddressBookHeaderDelegate
-(void)didSelectItem:(XHChildListModel *)model
{
    [self.dateSwitchControl resetDate:YES];
    [self.netWorkConfig setObject:model.studentBaseId forKey:@"studentBaseId"];
    [self.netWorkConfig setObject:[self.dateSwitchControl getNonceDate:NO] forKey:@"date"];
    [self getNetWorkDataWithType:YES];
}

#pragma mark XHDateSwitchControlDelegate
-(void)dateSwitchAction:(NSString *)date
{
    [self.netWorkConfig setObject:date forKey:@"date"];
    [self getNetWorkDataWithType:YES];
}




#pragma mark - Public Method
-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
}



#pragma mark - NetWork Method
-(void)getNetWorkDataWithType:(BOOL)type
{
    @WeakObj(self);
    [XHShowHUD showTextHud];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus002" sucess:^(id object, BOOL verifyObject)
    {
        @StrongObj(self);
        if (verifyObject)
        {
            NSArray *itemArray = [object objectForKey:@"object"];
            NSMutableArray *tempArray = [NSMutableArray array];
            [NSArray enumerateObjectsWithArray:itemArray usingforceBlock:^(id obj, NSUInteger idx, BOOL *stop, BOOL forceStop)
            {
                if (forceStop)
                {
                    XHRegisterFrame *frame = [[XHRegisterFrame alloc]init];
                    XHRegisterModel *model = [[XHRegisterModel alloc]init];
                    [model setItemObject:obj];
                    [frame setModel:model];
                    [tempArray addObject:frame];
                }
             }];
            
            [self.dataArray setArray:tempArray];
            [self.tableView refreshReloadData];
        }
        
        
    } error:^(NSError *error)
     {
         [self.tableView refreshReloadData];
     }];
    
}

#pragma mark - Getter / Setter
-(BaseTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[BaseTableView alloc]init];
        [_tableView setTipType:TipTitleAndTipImage withTipTitle:@"暂无数据" withTipImage:@"pic_nothing"];
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
        [_dateSwitchControl setDelegate:self];
    }
    return _dateSwitchControl;
}


-(XHAddressBookHeader *)switchHeaderControl
{
    if (!_switchHeaderControl)
    {
        _switchHeaderControl = [[XHAddressBookHeader alloc]init];
        [_switchHeaderControl setDelegate:self];
    }
    return _switchHeaderControl;
}








@end
