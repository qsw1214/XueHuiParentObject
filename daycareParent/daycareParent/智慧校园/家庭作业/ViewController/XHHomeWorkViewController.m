//
//  XHHomeWorkViewController.m
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkViewController.h"
#import "XHHomeWorkTableViewCell.h"




@interface XHHomeWorkViewController () <UITableViewDataSource,UITableViewDelegate>



@end

@implementation XHHomeWorkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"家庭作业"];
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
        [self.mainTableView setDelegate:self];
        [self.mainTableView setDataSource:self];
        [self.mainTableView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, CONTENT_HEIGHT)];
        [self.view addSubview:self.mainTableView];
        
        
        
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
        
        
        
        
        
    }
}




#pragma mark - Deletage Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
