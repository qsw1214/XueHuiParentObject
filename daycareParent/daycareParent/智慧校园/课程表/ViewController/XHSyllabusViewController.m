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





@interface XHSyllabusViewController () <UITableViewDelegate,UITableViewDataSource,XHAddressBookHeaderDelegate>

@property (nonatomic,strong) XHAddressBookHeader *addressBookHeader;
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
        [self.view addSubview:self.addressBookHeader];
        [self.addressBookHeader resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, 60.0)];
        [self.view setBackgroundColor:RGB(229,229,229)];
        [self.view addSubview:self.mainTableView];
        [self.mainTableView setDelegate:self];
        [self.mainTableView setDataSource:self];
        [self.mainTableView resetFrame:CGRectMake(0, (self.addressBookHeader.bottom+10.0), SCREEN_WIDTH, CONTENT_HEIGHT)];
        
        
        
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
    [self.netWorkConfig setObject:@"900600746423382016" forKey:@"classId"];
    [self getNetWorkData:YES];
}


#pragma mark - NetWorkData
-(void)getNetWorkData:(BOOL)work
{
    if (work)
    {
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus020" sucess:^(id object, BOOL verifyObject)
        {
            object = [object objectItemKey:@"object"];
            NSArray *dateArray = [object objectForKey:@"date"];
            NSArray *syllabusArray = [object objectForKey:@"syllabus"];
            
            XHSyllabusFrame *frame = [[XHSyllabusFrame alloc]init];
            XHSyllabusModel *model = [[XHSyllabusModel alloc]init];
            
            [NSArray enumerateObjectsWithArray:dateArray usingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
            {
                NSArray *firstArray = [obj componentsSeparatedByString:@"-"];
                NSString *year = [firstArray firstObject];
                NSString *month = [firstArray objectAtIndex:1];
                NSString *day = [firstArray lastObject];
                switch (idx)
                {
                    case 0:
                    {
                       
                        [model setMonth:[NSString stringWithFormat:@"%@\n月",month]];
                        [model setMonday:[NSString stringWithFormat:@"%@\n周一",day]];
                    }
                        break;
                    case 1:
                    {
                        [model setTuesday:[NSString stringWithFormat:@"%@\n周二",day]];
                    }
                        break;
                    case 2:
                    {
                        [model setWednesday:[NSString stringWithFormat:@"%@\n周三",day]];
                    }
                        break;
                    case 3:
                    {
                        
                        [model setThursday:[NSString stringWithFormat:@"%@\n周四",day]];
                    }
                        break;
                    case 4:
                    {
                        [model setFriday:[NSString stringWithFormat:@"%@\n周五",day]];
                    }
                        break;
                }
            }];
            
            [model setModelType:SyllabusWeekType];
            [frame setModel:model];
            [self.dataArray addObject:frame];
            
            
    
            
            [NSArray enumerateObjectsWithArray:syllabusArray usingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
             {
                 NSMutableArray *tempArray = [NSMutableArray array];
                 for (int i = 0; i < 5; i++)
                 {
                     [tempArray addObject:object];
                 }
                 
                 if ([tempArray count]>=5)
                 {
                     
                 }
                 
             }];
            
            [self.mainTableView reloadData];
            
            
            
            
        } error:^(NSError *error){}];
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







@end
