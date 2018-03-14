//
//  XHSyllabusViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSyllabusViewController.h"
#import "XHSyllabusCell.h"



@interface XHSyllabusViewController () <UITableViewDelegate,UITableViewDataSource>


@end



@implementation XHSyllabusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"课程表"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{

}

-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view setBackgroundColor:RGB(229,229,229)];
        [self.view addSubview:self.mainTableView];
        [self.mainTableView setDelegate:self];
        [self.mainTableView setDataSource:self];
        [self.mainTableView resetFrame:CGRectMake(0, (self.navigationView.bottom+10.0), SCREEN_WIDTH, CONTENT_HEIGHT)];
        
        
        
        
        for (int i = 0; i <1; i++)
        {
            XHSyllabusFrame *frame = [[XHSyllabusFrame alloc]init];
            XHSyllabusModel *model = [[XHSyllabusModel alloc]init];
            [model setMonth:@"12\n月"];
            [model setMonday:@"1\n周一"];
            [model setTuesday:@"2\n周二"];
            [model setWednesday:@"3\n周三"];
            [model setThursday:@"4\n周四"];
            [model setFriday:@"5\n周五"];
            [model setModelType:SyllabusWeekType];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }


        for (int i = 0; i <20; i++)
        {
            XHSyllabusFrame *frame = [[XHSyllabusFrame alloc]init];
            XHSyllabusModel *model = [[XHSyllabusModel alloc]init];
            [model setMonth:[NSString stringWithFormat:@"%d",(i+1)]];
            [model setMonday:@"语文"];
            [model setTuesday:@"数学"];
            [model setWednesday:@"英语"];
            [model setThursday:@"物理"];
            [model setFriday:@"化学"];
            [model setModelType:SyllabusContentType];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        
        [self.mainTableView reloadData];
    
    }
}





#pragma mark - Deletage Method
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}

- (XHSyllabusCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHSyllabusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==  nil)
    {
        cell = [[XHSyllabusCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}







#pragma mark 获取成绩
-(void)getSyllabusWithMode:(XHChildListModel*)model
{
//    if (model)
//    {
//        [self.netWorkConfig setObject:self.childModel.clazzId forKey:@"classId"];
//        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus006" sucess:^(id object, BOOL verifyObject)
//         {
//             if (verifyObject)
//             {
//                 [self.dataArray removeAllObjects];
//                 NSArray *arr=[object objectItemKey:@"object"];
//                 for (NSDictionary *dic in arr)
//                 {
//                     XHSyllabusFrame *frame = [[XHSyllabusFrame alloc]init];
//                     XHSyllabusModel *model = [[XHSyllabusModel alloc]init];
//                     [model setTime:[dic objectItemKey:@"coursetime"]];
//                     [model setSubject:[dic objectItemKey:@"subjectName"]];
//                     [model setWeekday:[dic objectItemKey:@"weekday"]];
//                     [frame setModel:model];
//                     [self.dataArray addObject:frame];
//                 }
//                 [self.dataArray setArray:[XHSortedArrayComparator sortedArrayUsingComparatorWithSyllabusKeyArray:self.dataArray]];
//
//                 [self getSelectSub];
//                 [self.tableView refreshReloadData];
//
//             }
//
//         } error:^(NSError *error) {
//             [self getSelectSub];
//             [self.tableView refreshReloadData];
//         }];
//    }
//    else
//    {
//        [self getSelectSub];
//        [self.tableView refreshReloadData];
//    }
}



#pragma mark - Getter / Setter

-(void)getChildModel:(XHChildListModel *)childModel
{
     [self setRightItemTitle:[childModel studentName]];
    
}









@end
