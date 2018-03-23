//
//  XHTeacherAddressBookViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHTeacherAddressBookViewController.h"
#import "XHAddressBookHeader.h"
#import "AppDelegate.h"
#import "XHRCConversationViewController.h"
#import "XHMessageUserInfo.h"


@interface XHTeacherAddressBookViewController () <UITableViewDelegate,UITableViewDataSource,XHAddressBookHeaderDelegate>


@property (nonatomic,strong) XHAddressBookHeader *addressBookHeader;
@property (nonatomic,strong) XHChildListModel *childListModel;
@end

@implementation XHTeacherAddressBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        
        
        if ([[XHUserInfo sharedUserInfo].childListArry count])
        {
            [self.view addSubview:self.addressBookHeader];
            [self.addressBookHeader resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 60.0)];
            [self.mainTableView resetFrame:CGRectMake(0, self.addressBookHeader.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-(self.addressBookHeader.bottom))];
            [self.view addSubview:self.mainTableView];
            [self.mainTableView setDelegate:self];
            [self.mainTableView setDataSource:self];
            [self.mainTableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
            [self.mainTableView beginRefreshing];
        }
        else
        {
            [self.mainTableView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom)];
            [self.view addSubview:self.mainTableView];
            [self.mainTableView setDelegate:self];
            [self.mainTableView setDataSource:self];
            [self.mainTableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
            [self.mainTableView beginRefreshing];
        }
    }
}
-(void)refreshHead
{
    [self getAddressBookWithModel:self.childListModel];
}

#pragma mark - Deletage Method

- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
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
            XHTeacherAddressBookFrame *frame=[self.dataArray objectAtIndex:indexPath.row];
            XHTeacherAddressBookModel *model=frame.model;
             XHMessageUserInfo *messageInfo = [[XHMessageUserInfo alloc] init];
             messageInfo.name = model.teacherName;
             messageInfo.headPic =model.headerUrl;
             messageInfo.userId = model.ID;
             [messageInfo saveOrUpdateByColumnName:@"userId" AndColumnValue:model.ID];
            
             AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
             [app sendRCIMInfo];
             
             XHRCConversationViewController *conversationVC = [[XHRCConversationViewController alloc] init];
             conversationVC.titleLabel.text=model.teacherName;
             conversationVC.conversationType = ConversationType_PRIVATE;
             conversationVC.targetId = [NSString stringWithFormat:@"%@",model.ID];
            conversationVC.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:conversationVC animated:YES];
            
            
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

#pragma mark XHAddressBookHeaderDelegate
-(void)didSelectItem:(XHChildListModel*)model
{
    [self setChildListModel:model];
    [self.mainTableView beginRefreshing];
}






#pragma mark - NetWork Method
/**
 @param model 孩子模型
 */
-(void)getAddressBookWithModel:(XHChildListModel *)model
{
    if (model)
    {
        @WeakObj(self);
        [self.netWorkConfig setObject:model.clazzId forKey:@"classId"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus009" sucess:^(id object, BOOL verifyObject)
         {
             @StrongObj(self);
             if (verifyObject)
             {
                 [self.dataArray removeAllObjects];
                 NSArray *itemArray = [object objectItemKey:@"object"];
                 [itemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                  {
                      XHTeacherAddressBookFrame *frame = [XHTeacherAddressBookFrame alloc];
                      XHTeacherAddressBookModel *model = [[XHTeacherAddressBookModel alloc]init];
                      [model setItemObject:obj];
                      [frame setModel:model];
                      [self.dataArray addObject:frame];
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







@end
