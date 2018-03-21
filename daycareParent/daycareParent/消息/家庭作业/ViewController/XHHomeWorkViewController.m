//
//  XHHomeWorkViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkViewController.h"
#import "XHHomeWorkTableViewCell.h"
#import "XHDatePicker.h"




@interface XHHomeWorkViewController () <UITableViewDataSource,UITableViewDelegate,XHDatePickerDelegate>

@property(nonatomic,copy)NSString *dateStr;
@property(nonatomic,strong)XHNetWorkConfig *netWork;

@end

@implementation XHHomeWorkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"家庭作业"];
     [self setItemContentType:NavigationIconype withItemType:NavigationItemRightype withIconName:@"ico_date" withTitle:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
          [self.mainTableView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, CONTENT_HEIGHT)];
        [self.mainTableView setDelegate:self];
        [self.mainTableView setDataSource:self];
        [self.mainTableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
         [self.mainTableView setTipType:TipTitleAndTipImage withTipTitle:@"暂无数据" withTipImage:@"pic_nothing"];
        [self.mainTableView beginRefreshing];
        [self.view addSubview:self.mainTableView];
        /*
        for (int i=0; i<10; i++)
        {
            XHHomeWorkFrame *frame = [[XHHomeWorkFrame alloc]init];
            XHHomeWorkModel *model = [[XHHomeWorkModel alloc]init];
            [model setUserName:@"姚立志"];
            [model setWorkContent:@"中华人民共和国商务部（以下简称商务部）收到联 发科技股份有限公司（以下简称联发科技）和晨星 半导体股份有限公司（以下简称晨星台湾）关于解 除2013年第61号公告（以下简称《公告》）附加 的限制性条件的申请。商务部对该申请进行了审 查，有关事项公告如下。"];
            [model setSubject:@"数学"];
            [model setHeaderUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520921938088&di=a0c7f3aee3ebf72a5281b5de3bac9b70&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fwh%253D450%252C600%2Fsign%3D574841b80a24ab18e043e93300cacafb%2F3b292df5e0fe9925b91fcdce37a85edf8db17118.jpg"];
            
            for (int i= 0 ; i < 4; i++)
            {
                XHPreviewModel *Pmodel = [[XHPreviewModel alloc]init];
                [Pmodel setPreviewUrl:@"http://imgsrc.baidu.com/imgad/pic/item/18d8bc3eb13533fa39934cfaa2d3fd1f41345b39.jpg"];
                [model.imageUrlArray addObject:Pmodel];
            }
            
            for (int i= 0 ; i < 2; i++)
            {
                XHPreviewModel *Pmodel = [[XHPreviewModel alloc]init];
                [Pmodel setPreviewUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520935805242&di=19342aa1d82c3300da4f2c78476b2dab&imgtype=0&src=http%3A%2F%2Fpic2.16pic.com%2F00%2F11%2F78%2F16pic_1178392_b.jpg"];
                [model.imageUrlArray addObject:Pmodel];
            }
            
            [model setReleaseDate:@"02-13 11:20"];
            [model setHomeWorkType:NotifyType];
            [model setHomeWorkUnreadType:HomeWorkUnreadType];
            [model setContentType:XHHomeWorkTextAndImageType];
            [frame setModel:model];
            [self.dataArray addObject:frame];
            
        }
        
        for (int i=0; i<10; i++)
        {
            XHHomeWorkFrame *frame = [[XHHomeWorkFrame alloc]init];
            XHHomeWorkModel *model = [[XHHomeWorkModel alloc]init];
            [model setUserName:@"姚立志"];
            [model setWorkContent:@"中华人民共和国商务部（以下简称商务部）收到联 发科技股份有限公司（以下简称联发科技）和晨星 半导体股份有限公司（以下简称晨星台湾）关于解 除2013年第61号公告（以下简称《公告》）附加 的限制性条件的申请。商务部对该申请进行了审 查，有关事项公告如下。"];
            [model setSubject:@"数学"];
            [model setHeaderUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520921938088&di=a0c7f3aee3ebf72a5281b5de3bac9b70&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fwh%253D450%252C600%2Fsign%3D574841b80a24ab18e043e93300cacafb%2F3b292df5e0fe9925b91fcdce37a85edf8db17118.jpg"];
            [model setReleaseDate:@"02-13 11:20"];
            [model setHomeWorkType:HomeWorkType];
            [model setHomeWorkUnreadType:HomeWorkUnreadType];
            [model setContentType:XHHomeWorkTextType];
            [frame setModel:model];
            [self.dataArray addObject:frame];
            
        }
        
        for (int i=0; i<10; i++)
        {
            XHHomeWorkFrame *frame = [[XHHomeWorkFrame alloc]init];
            XHHomeWorkModel *model = [[XHHomeWorkModel alloc]init];
            [model setUserName:@"姚立志"];
            [model setWorkContent:@"中华人民共和国商务部（以下简称商务部）收到联 发科技股份有限公司（以下简称联发科技）和晨星 半导体股份有限公司（以下简称晨星台湾）关于解 除2013年第61号公告（以下简称《公告》）附加 的限制性条件的申请。商务部对该申请进行了审 查，有关事项公告如下。"];
            [model setSubject:@"数学"];
            [model setHeaderUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520921938088&di=a0c7f3aee3ebf72a5281b5de3bac9b70&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fwh%253D450%252C600%2Fsign%3D574841b80a24ab18e043e93300cacafb%2F3b292df5e0fe9925b91fcdce37a85edf8db17118.jpg"];
            [model setReleaseDate:@"02-13 11:20"];
            [model setHomeWorkType:HomeWorkType];
            [model setHomeWorkUnreadType:HomeWorkAlreadyReadType];
            [model setContentType:XHHomeWorkTextType];
            [frame setModel:model];
            [self.dataArray addObject:frame];
            
        }
        
        
     
        
        [self.mainTableView reloadData];
        
        
        
        */
        
    }
}



#pragma mark - 点击日历方法
-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    XHDatePicker *datePicker = [[XHDatePicker alloc]init];
    [datePicker setDelegate:self];
    [datePicker show];
}

-(void)getNetWorkData:(BOOL)work
{
    if (work)
    {
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"guardianId"];
        if (![[NSString safeString:self.dateStr] isEqualToString:@""])
        {
            [self.netWorkConfig setObject:self.dateStr forKey:@"date"];
        }
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus004" sucess:^(id object, BOOL verifyObject)
        {
            if (verifyObject) {
                [self.dataArray removeAllObjects];
                NSArray *itemArry=[object objectItemKey:@"object"];
                if (itemArry) {
                    for ( NSDictionary *dic in itemArry) {
                        XHHomeWorkFrame *frame = [[XHHomeWorkFrame alloc]init];
                        XHHomeWorkModel *model = [[XHHomeWorkModel alloc]init];
                        [model setItemObject:dic];
                        [frame setModel:model];
                        [self.dataArray addObject:frame];
                        if (self.isRefresh) {
                            self.isRefresh(YES);
                        }
                    }
                }
            }
             [self.mainTableView refreshReloadData];
        } error:^(NSError *error)
         {
              [self.mainTableView refreshReloadData];
         }];
    }
}

-(void)refreshHeaderAction
{
    [self getNetWorkData:YES];
}


#pragma mark - Deletage Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.mainTableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}



- (XHHomeWorkTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHHomeWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[XHHomeWorkTableViewCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}

#pragma mark XHDatePickerDelegate
-(void)datePickerAction:(NSString *)date
{
    self.dateStr=date;
    [self.mainTableView beginRefreshing];
}
-(XHNetWorkConfig *)netWork
{
    if (_netWork==nil) {
        _netWork=[XHNetWorkConfig new];
    }
    return _netWork;
}
-(NSString *)dateStr
{
    if (_dateStr==nil) {
        _dateStr=[[NSString alloc]init];
    }
    return _dateStr;
}

@end
