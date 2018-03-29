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
#import "XHAddressBookHeader.h"
#import "XHSyllabusHeaderBoardControl.h"





@interface XHSyllabusViewController () <UITableViewDelegate,UITableViewDataSource,XHAddressBookHeaderDelegate>

@property (nonatomic,strong) XHAddressBookHeader *addressBookHeader;
@property (nonatomic,strong) BaseButtonControl *weekMenuControl; //!< 菜单选择菜单
@property (nonatomic,strong) NSMutableArray *firstArry;
@property (nonatomic,strong) NSMutableArray *twoArry;
@property (nonatomic,strong) XHSyllabusHeaderBoardControl *headerBoardControl;


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
        
        [self.view addSubview:self.addressBookHeader];
        [self.addressBookHeader resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 60.0)];
        [self.headerBoardControl resetFrame:CGRectMake(10.0, (self.addressBookHeader.bottom+10.0), SCREEN_WIDTH-20.0, 50.0)];
        [self.view addSubview:self.headerBoardControl];
       
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:self.mainTableView];
        [self.mainTableView setDelegate:self];
        [self.mainTableView setDataSource:self];
        [self.mainTableView setBackgroundColor:[UIColor whiteColor]];
        [self.mainTableView setTipType:TipTitleAndTipImage withTipTitle:@"暂无课程" withTipImage: @"pic_nothing"];
        [self.mainTableView resetFrame:CGRectMake(0, (self.headerBoardControl.bottom), SCREEN_WIDTH, SCREEN_HEIGHT-(self.headerBoardControl.bottom))];
        
        
        
//
//        for (int i = 0; i <1; i++)
//        {
//            XHSyllabusFrame *frame = [[XHSyllabusFrame alloc]init];
//            XHSyllabusModel *model = [[XHSyllabusModel alloc]init];
//            [model setMonth:@"12\n月"];
//            [model setMonday:@"1\n周一"];
//            [model setTuesday:@"2\n周二"];
//            [model setWednesday:@"3\n周三"];
//            [model setThursday:@"4\n周四"];
//            [model setFriday:@"5\n周五"];
//            [model setModelType:SyllabusWeekType];
//            [frame setModel:model];
//            [self.dataArray addObject:frame];
//        }
//
//
//        for (int i = 0; i <20; i++)
//        {
//            XHSyllabusFrame *frame = [[XHSyllabusFrame alloc]init];
//            XHSyllabusModel *model = [[XHSyllabusModel alloc]init];
//            [model setMonth:[NSString stringWithFormat:@"%d",(i+1)]];
//            [model setMonday:@"语文"];
//            [model setTuesday:@"数学"];
//            [model setWednesday:@"英语"];
//            [model setThursday:@"物理"];
//            [model setFriday:@"化学"];
//            [model setModelType:SyllabusContentType];
//            [frame setModel:model];
//            [self.dataArray addObject:frame];
//        }
//
//
//        [self.mainTableView reloadData];
    
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


#pragma mark XHAddressBookHeaderDelegate
-(void)didSelectItem:(XHChildListModel*)model
{
    [self.netWorkConfig setObject:model.clazzId forKey:@"classId"];
    [self getNetWorkData:YES];
}


#pragma mark - NetWorkData
-(void)getNetWorkData:(BOOL)work
{
    if (work)
    {
        [XHShowHUD showTextHud];
        
        NSInteger werrk = [XHHelper weekdayWithNowDate:[NSDate date]];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus020" sucess:^(id object, BOOL verifyObject)
        {
            [self.dataArray removeAllObjects];
            object = [object objectItemKey:@"object"];
            NSArray *dateArray = [object objectForKey:@"date"];
            NSArray *syllabusArray = [object objectForKey:@"syllabus"];
            
            /**
             
             syllabusArray = @[@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"生物",@"想想品德",@"社会科学",@"历史",@"政治",@"语文",@"数学",@"英语",@"化学",@"地理",@"化学",@"地理"];
             
             
             */
            
            
            
            XHSyllabusFrame *frame = [[XHSyllabusFrame alloc]init];
            XHSyllabusModel *model = [[XHSyllabusModel alloc]init];
            [model setMarkType:werrk];
            [NSArray enumerateObjectsWithArray:dateArray usingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
            {
                NSArray *firstArray = [obj componentsSeparatedByString:@"-"];
                NSString *month = [firstArray objectAtIndex:1];
                NSString *day = [firstArray lastObject];
                switch (idx)
                {
                    case 0:
                    {
                        [model setMonth:[NSString stringWithFormat:@"%@",month]];
                        [model setMonthDescribe:[NSString stringWithFormat:@"月"]];
                        [model setMonday:[NSString stringWithFormat:@"%@",day]];
                        [model setMondayDescribe:[NSString stringWithFormat:@"周一"]];
                    }
                        break;
                    case 1:
                    {
                        [model setTuesday:[NSString stringWithFormat:@"%@",day]];
                        [model setTuesdayDescribe:[NSString stringWithFormat:@"周二"]];
                    }
                        break;
                    case 2:
                    {
                        [model setWednesday:[NSString stringWithFormat:@"%@",day]];
                        [model setWednesdayDescribe:[NSString stringWithFormat:@"周三"]];
                    }
                        break;
                    case 3:
                    {
                        [model setThursday:[NSString stringWithFormat:@"%@",day]];
                        [model setThursdayDescribe:[NSString stringWithFormat:@"周四"]];
                    }
                        break;
                    case 4:
                    {
                        [model setFriday:[NSString stringWithFormat:@"%@",day]];
                        [model setFridayDescribe:[NSString stringWithFormat:@"周五"]];
                    }
                        break;
                }
            }];
            
            [frame setModel:model];
            [self.headerBoardControl setItemFrame:frame];
            
            NSArray *itemArray = [self getSubjectWithdataArry:syllabusArray];
    
            
            [NSArray enumerateObjectsWithArray:itemArray usingforceBlock:^(id obj, NSUInteger idx, BOOL *stop,BOOL forceStop)
            {
                if (forceStop)
                {
                    XHSyllabusFrame *frame = [[XHSyllabusFrame alloc]init];
                    XHSyllabusModel *model = [[XHSyllabusModel alloc]init];
                    [model setMarkType:werrk];
                    [model setMonth:[NSString stringWithFormat:@"%zd",(idx+1)]];
                    
                    [NSArray enumerateObjectsWithArray:obj usingforceBlock:^(id obj, NSUInteger idx, BOOL *stop, BOOL forceStop)
                    {
                        switch (idx)
                        {
                            case 0:
                            {
                                [model setMonday:obj];
                            }
                                break;
                            case 1:
                            {
                                [model setTuesday:obj];
                            }
                                break;
                            case 2:
                            {
                                [model setWednesday:obj];
                            }
                                break;
                            case 3:
                            {
                                [model setThursday:obj];
                            }
                                break;
                            case 4:
                            {
                                 [model setFriday:obj];
                            }
                                break;
                        }
                    }];
                    
                    [frame setModel:model];
                    [self.dataArray addObject:frame];
                }
            }];
            
            [self.mainTableView refreshReloadData];

            
            
            
            
        } error:^(NSError *error)
        {
            [self.mainTableView refreshReloadData];
        }];
    }
}


#pragma mark - Getter / Setter

-(void)getChildModel:(XHChildListModel *)childModel
{
     [self setRightItemTitle:[childModel studentName]];
    
}

-(XHAddressBookHeader *)addressBookHeader
{
    if (!_addressBookHeader)
    {
        _addressBookHeader = [[XHAddressBookHeader alloc]init];
        [_addressBookHeader setDelegate:self];
    }
    return _addressBookHeader;
}

-(XHSyllabusHeaderBoardControl *)headerBoardControl
{
    if (!_headerBoardControl)
    {
        _headerBoardControl = [[XHSyllabusHeaderBoardControl alloc]init];
    }
    return _headerBoardControl;
}

-(NSMutableArray *)firstArry
{
    if (_firstArry==nil) {
        _firstArry=[[NSMutableArray alloc] init];
    }
    return _firstArry;
}

-(NSMutableArray *)twoArry
{
    if (_twoArry==nil) {
        _twoArry=[[NSMutableArray alloc] init];
    }
    return _twoArry;
}

-(NSArray *)getSubjectWithdataArry:(NSArray *)dataArry
{

    if (dataArry && [dataArry count])
    {
        NSMutableString *string=[[NSMutableString alloc] init];
        NSMutableArray *mutableArry = [[NSMutableArray alloc] init];
        [NSArray enumerateObjectsWithArray:dataArry usingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
         {
             if (idx%5==0&&idx!=0)
             {
                 [string appendFormat:@"%@",@"(*)"];
                 [string appendFormat:@"%@ ",obj];
             }
             else
             {
                 [string appendFormat:@"%@ ",obj];
             }
             
         }];
        
        NSArray *arr = [string componentsSeparatedByString:@"(*)"];
        
        for (NSString *str in arr)
        {
            NSArray *arr=[str componentsSeparatedByString:@" "];
            
            NSMutableArray *temmpArray = [[NSMutableArray alloc]initWithArray:arr];
            [temmpArray  removeLastObject];
            [mutableArry addObject:temmpArray];
            
        }
        
        return mutableArry;
    }
    else
    {
        return nil;
    }
 
    
    
}






@end
