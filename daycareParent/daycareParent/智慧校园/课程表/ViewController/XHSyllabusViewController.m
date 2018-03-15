//
//  XHSyllabusViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSyllabusViewController.h"
#import "XHSyllabusCell.h"
#import "XHDropDownMenuControl.h"




@interface XHSyllabusViewController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) BaseButtonControl *weekMenuControl; //!< 菜单选择菜单



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
        [self.view addSubview:self.weekMenuControl];
        [self.weekMenuControl resetFrame:CGRectMake(((SCREEN_WIDTH-100.0)/2.0), (self.navigationView.height-44.0), 100.0, 44.0)];
        [self.weekMenuControl setTitleEdgeFrame:CGRectMake(0, 0, 0, self.weekMenuControl.height) withNumberType:0 withAllType:NO];
        [self.weekMenuControl setImageEdgeFrame:CGRectMake((self.weekMenuControl.width-10.0), ((self.weekMenuControl.height-10.0)/2.0), 10.0, 10.0) withNumberType:0 withAllType:NO];
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



#pragma mark - Private Method
-(void)weekMenuControlAction:(BaseButtonControl*)sender
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0; i<10; i++)
    {
        XHDropDownMenuModel *model = [[XHDropDownMenuModel alloc]init];
        [model setTitle:@"一年级三班"];
        [model setObjectID:@"ADSFOP1903LSW"];
        [tempArray addObject:model];
    }
    
    
    XHDropDownMenuControl *downMenu = [[XHDropDownMenuControl alloc]initWithDeletage:self];
    [downMenu setDataArray:tempArray];
    [downMenu show];
}


#pragma mark - Getter / Setter

-(void)getChildModel:(XHChildListModel *)childModel
{
     [self setRightItemTitle:[childModel studentName]];
    
}



-(BaseButtonControl *)weekMenuControl
{
    if (!_weekMenuControl)
    {
        _weekMenuControl = [[BaseButtonControl alloc]init];
        [_weekMenuControl setNumberLabel:1];
        [_weekMenuControl setNumberImageView:1];
        [_weekMenuControl setFont:FontLevel1 withNumberType:0 withAllType:NO];
        [_weekMenuControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_weekMenuControl setImage:@"ico_arr_week" withNumberType:0 withAllType:NO];
        [_weekMenuControl addTarget:self action:@selector(weekMenuControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_weekMenuControl setItemColor:NO];
    }
    return _weekMenuControl;
}








@end
