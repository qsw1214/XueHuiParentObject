//
//  XHSyllabusContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHSyllabusContentView.h"
#import "XHSyllabusCellContentView.h"
#import "XHSortedArrayComparator.h"
#import "XHSyllabusCell.h"



@interface XHSyllabusContentView () <UITableViewDelegate,UITableViewDataSource>

{
    NSArray *weekArray;
    NSInteger _selectIndex;
}
@property (nonatomic,strong) NSMutableArray *menuArray;
@property (nonatomic,strong) BaseMenuControl *menuControl; //!< 操作菜单
@property (nonatomic,strong) XHSyllabusCellContentView *headerView;
@property (nonatomic,strong) NSMutableArray *selectArry;
@end




@implementation XHSyllabusContentView




- (instancetype)init
{
    self = [super init];
    if (self)
    {
       
        [self addSubview:self.menuControl];
        [self.menuControl setMenuDeletage:self];
        [self addSubview:self.headerView];
        [self addSubview:self.tableView];
        _selectIndex=[self getWeekDay];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.tableView setBackgroundColor:[UIColor whiteColor]];
        [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHead)];
        [self.tableView beginRefreshing];
    }
    return self;
}
-(void)refreshHead
{
    [self getSyllabusWithMode:self.childModel];
}





-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.menuControl resetFrame:CGRectMake(0, 0, frame.size.width, 60.0)];
    [self.headerView resetFrame:CGRectMake(0,self.menuControl.bottom, frame.size.width, 60.0)];
    [self.tableView resetFrame:CGRectMake(0, self.headerView.bottom, self.headerView.width, frame.size.height-self.headerView.bottom)];
    
    //添加数据源
    weekArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    CGFloat itemWidth = (SCREEN_WIDTH/[weekArray count]);
    [weekArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
     {
         BaseMenuModel *model = [[BaseMenuModel alloc]init];
         [model setTitle:obj];
         [model setTage:idx];
         [model setItemSize:CGSizeMake(itemWidth, 60.0)];
         [model setFont:FontLevel4];
         [model setSelectColor:MainColor];
         [model setNormalColor:RGB(4, 4, 4)];
         [model setMarkColor:MainColor];
        [model setSelectType:BaseMenuNormalType];
         [self.menuArray addObject:model];
     }];
    
    [self.menuControl setItemSelectArray:self.menuArray];
}


-(void)getModel:(XHChildListModel *)model
{
    _selectIndex=[self getWeekDay];
    [self.menuControl setItemSelectArray:self.menuArray];
    self.childModel=model;
    [self getSyllabusWithMode:model];
}


#pragma mark - Deletage Method
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.tableView tableTipViewWithArray:self.selectArry];
    return [self.selectArry count];
}

- (XHSyllabusCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHSyllabusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==  nil)
    {
        cell = [[XHSyllabusCell alloc]init];
    }
    [cell setItemFrame:[self.selectArry objectAtIndex:indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.selectArry objectAtIndex:indexPath.row] cellHeight];
}



#pragma mark BaseMenuControlDeletage
-(void)didSelectItem:(BaseMenuModel*)object
{
    NSLog(@"%@===%d",object.title,object.tage);
    _selectIndex=object.tage;
    [self getSelectSub];
    [self.tableView refreshReloadData];
}
-(NSInteger)getWeekDay
{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components: NSWeekdayCalendarUnit fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    return weekDay-2;
}
-(void)getSelectSub
{
    [self.selectArry removeAllObjects];
    for (XHSyllabusFrame *frame in self.dataArray) {
        if ([frame.model.weekday isEqualToString:weekArray[_selectIndex]]) {
            [self.selectArry addObject:frame];
        }
    }
}




#pragma mark 获取成绩
-(void)getSyllabusWithMode:(XHChildListModel*)model
{
    if (model)
    {
        [self.netWorkConfig setObject:self.childModel.clazzId forKey:@"classId"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus006" sucess:^(id object, BOOL verifyObject)
        {
            if (verifyObject)
            {
                [self.dataArray removeAllObjects];
                NSArray *arr=[object objectItemKey:@"object"];
                for (NSDictionary *dic in arr)
                {
                    XHSyllabusFrame *frame = [[XHSyllabusFrame alloc]init];
                    XHSyllabusModel *model = [[XHSyllabusModel alloc]init];
                    [model setTime:[dic objectItemKey:@"coursetime"]];
                    [model setSubject:[dic objectItemKey:@"subjectName"]];
                    [model setWeekday:[dic objectItemKey:@"weekday"]];
                    [frame setModel:model];
                    [self.dataArray addObject:frame];
                }
                [self.dataArray setArray:[XHSortedArrayComparator sortedArrayUsingComparatorWithSyllabusKeyArray:self.dataArray]];
                
                [self getSelectSub];
                [self.tableView refreshReloadData];
                
            }
            
        } error:^(NSError *error) {
            [self getSelectSub];
            [self.tableView refreshReloadData];
        }];
    }
    else
    {
        [self getSelectSub];
        [self.tableView refreshReloadData];
    }
}





#pragma mark - Getter / Setter
-(BaseMenuControl *)menuControl
{
    if (_menuControl == nil)
    {
        _menuControl = [[BaseMenuControl alloc]init];
        [_menuControl setBackgroundColor:RGB(246, 246, 246)];
    }
    return _menuControl;
}

-(XHSyllabusCellContentView *)headerView
{
    if (_headerView == nil)
    {
        _headerView = [[XHSyllabusCellContentView alloc]init];
        [_headerView setFont:[UIFont boldSystemFontOfSize:14.0]];
        [_headerView setTextColor:RGB(41, 41, 41)];
        [_headerView setTime:@"时间"];
        [_headerView setSubject:@"科目"];
    }
    return _headerView;
}

-(NSMutableArray *)menuArray
{
    if (_menuArray == nil)
    {
        _menuArray = [NSMutableArray array];
    }
    return _menuArray;
}
-(NSMutableArray *)selectArry
{
    if (_selectArry == nil)
    {
        _selectArry = [NSMutableArray array];
    }
    return _selectArry;
}

@end
