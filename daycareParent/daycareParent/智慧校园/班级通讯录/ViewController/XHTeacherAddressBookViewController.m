//
//  XHTeacherAddressBookViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHTeacherAddressBookViewController.h"



@interface XHTeacherAddressBookViewController () <UITableViewDelegate,UITableViewDataSource>



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
        [self.view addSubview:self.mainTableView];
        [self.mainTableView setDelegate:self];
        [self.mainTableView setDataSource:self];
        [self.mainTableView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, CONTENT_HEIGHT)];
        
        
        
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
        
        
        [self.mainTableView reloadData];
    }
}

-(void)setModel:(XHChildListModel *)model
{
    _model = model;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.enterType)
    {
#pragma mark - case TeacherAddressBookIMType 联系老师进入
        case TeacherAddressBookIMType:
        {
            
        }
            break;
#pragma mark - case TeacherAddressBookAskLeaveType 请假进入
        case TeacherAddressBookAskLeaveType:
        {
            if (self.didselectBack)
            {
                self.didselectBack([self.dataArray objectAtIndex:indexPath.row]);
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
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











@end
