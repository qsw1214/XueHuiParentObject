//
//  XHCookBookViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCookBookViewController.h"
#import "XHCookBookHeader.h"
#import "XHCookBookCell.h"
#import "XHAddressBookHeader.h"




@interface XHCookBookViewController () <UITableViewDelegate,UITableViewDataSource,XHAddressBookHeaderDelegate,XHCookBookHeaderDeletage>



@property (nonatomic,strong) XHCookBookHeader *cookBookHeader;  //!< 头部星期选择视图
@property (nonatomic,strong) NSMutableArray *cookBookItemArray; //!< 食谱内容数组
@property (nonatomic,strong) BaseTableView *tableView; //!< 表视图
@property (nonatomic,strong) XHAddressBookHeader *addressBookHeader;


@end

@implementation XHCookBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"食谱"];
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
        [self.view addSubview:self.cookBookHeader];
        [self.cookBookHeader resetFrame:CGRectMake(0.0, self.addressBookHeader.bottom, self.addressBookHeader.width, 80.0)];
        [self.view addSubview:self.tableView];
        [self.tableView resetFrame:CGRectMake(0, self.cookBookHeader.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.cookBookHeader.bottom)];
        [self.tableView setTipType:TipTitleAndTipImage withTipTitle:@"暂无数据" withTipImage:@"pic_nothing"];
        
        
        

//        for (int i = 0; i< 1; i++)
//        {
//            XHCookBookFrame *frame = [[XHCookBookFrame alloc]init];
//            XHCookBookModel *model = [[XHCookBookModel alloc]init];
//            [model setTitle:[NSString stringWithFormat:@"周%d",i]];
//            [model setModeType:CookBookWeekType];
//            [model setSelectType:CookBookSelectType];
//            [frame setModel:model];
//            [self.dataArray addObject:frame];
//        }
//
//        for (int i = 0; i< 4; i++)
//        {
//            XHCookBookFrame *frame = [[XHCookBookFrame alloc]init];
//            XHCookBookModel *model = [[XHCookBookModel alloc]init];
//            [model setTitle:[NSString stringWithFormat:@"周%d",i]];
//            [model setModeType:CookBookWeekType];
//            [model setSelectType:CookBookNormalType];
//            [frame setModel:model];
//            [self.dataArray addObject:frame];
//        }
//
//        [self.cookBookHeader setItemArray:self.dataArray];
        
        
//        {
//
//            for (int i = 0; i< 5; i++)
//            {
//                XHCookBookFrame *frame = [[XHCookBookFrame alloc]init];
//                XHCookBookModel *model = [[XHCookBookModel alloc]init];
//                [model setTitle:@"早餐"];
//                [model setContent:@"肉末菜粥、豆沙包、芹菜豆干,肉末菜粥、豆沙包、芹菜豆干,肉末菜粥、豆沙包、芹菜豆干,肉末菜粥、豆沙包、芹菜豆干,肉末菜粥、豆沙包、芹菜豆干"];
//                [model setPreviewUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520858413773&di=73ddf5c3cc4b1ea6af56b308aa2a7c56&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fbf096b63f6246b60553a62a0e1f81a4c510fa22a.jpg"];
//                [model setModeType:CookBookDetailsType];
//                [model setSelectType:CookBookNormalType];
//
//
//
//                for (int i = 0; i< 1; i++)
//                {
//                    XHInfiniteRotationModel *rotaionModel = [[XHInfiniteRotationModel alloc]init];
//                    [rotaionModel setImageUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520858413773&di=73ddf5c3cc4b1ea6af56b308aa2a7c56&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fbf096b63f6246b60553a62a0e1f81a4c510fa22a.jpg"];
//                    XHPageModel *pageModel = [[XHPageModel alloc]init];
//                    [pageModel setImageName:nil];
//                    [pageModel setType:XHPageModelSelectType];
//                    [model.pageArray addObject:pageModel];
//                    [model.infiniteRotationArray addObject:rotaionModel];
//                }
//
//
//                for (int i = 0; i< 2; i++)
//                {
//                    XHInfiniteRotationModel *rotaionModel = [[XHInfiniteRotationModel alloc]init];
//                    [rotaionModel setImageUrl:@"http://img3.3lian.com/2013/c2/78/d/38.jpg"];
//                    XHPageModel *pageModel = [[XHPageModel alloc]init];
//                    [pageModel setImageName:nil];
//                    [pageModel setType:XHPageModelNormalType];
//                    [model.pageArray addObject:pageModel];
//                    [model.infiniteRotationArray addObject:rotaionModel];
//                }
//
//                for (int i = 0; i< 2; i++)
//                {
//                    XHInfiniteRotationModel *rotaionModel = [[XHInfiniteRotationModel alloc]init];
//                    [rotaionModel setImageUrl:@"http://pic37.nipic.com/20140115/9448607_120900609000_2.jpg"];
//                    XHPageModel *pageModel = [[XHPageModel alloc]init];
//                    [pageModel setImageName:nil];
//                    [pageModel setType:XHPageModelNormalType];
//                    [model.pageArray addObject:pageModel];
//                    [model.infiniteRotationArray addObject:rotaionModel];
//                }
//
//
//
//                [frame setModel:model];
//                [self.cookBookItemArray addObject:frame];
//            }
//        }
        
    }
    
}

#pragma mark - Deletage Method
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.cookBookItemArray];
    return [self.cookBookItemArray count];
}

- (XHCookBookCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHCookBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHCookBookCell alloc]init];
    }
    [cell setItemFrame:[self.cookBookItemArray objectAtIndex:indexPath.row]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.cookBookItemArray objectAtIndex:indexPath.row] cellHeight];
}


#pragma mark XHAddressBookHeaderDelegate
-(void)didSelectItem:(XHChildListModel *)model
{
    [self getCookBookWithSchoolId:model.schoolId];
}

#pragma mark XHCookBookHeaderDeletage
-(void)didSelectItemObject:(XHCookBookFrame *)model
{
    [self.cookBookItemArray setArray:model.model.contentArray];
    [self.tableView refreshReloadData];
}






#pragma mark - NetWork Method (请求网络内容)
-(void)getCookBookWithSchoolId:(NSString*)schoolId
{
    [XHShowHUD showTextHud];
    [self.netWorkConfig setObject:schoolId forKey:@"schoolId"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus005" sucess:^(id object, BOOL verifyObject)
     {
         if (verifyObject)
         {
             [self.dataArray removeAllObjects];
             NSArray <NSDictionary*> *objectArray = [object objectItemKey:@"object"];
             [objectArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
              {
                  XHCookBookFrame *frame = [[XHCookBookFrame alloc]init];
                  XHCookBookModel *model = [[XHCookBookModel alloc]init];
                  [model setDate:[obj objectItemKey:@"date"]];
                  [model setModeType:CookBookWeekType];
                  NSArray <NSDictionary*> *itemArray = [obj objectItemKey:@"recipe"];
                  [itemArray enumerateObjectsUsingBlock:^(NSDictionary *itemObj, NSUInteger idx, BOOL *stop)
                   {
                       XHCookBookFrame *itemFrame = [[XHCookBookFrame alloc]init];
                       XHCookBookModel *itemModel = [[XHCookBookModel alloc]init];
                       [itemModel setItemObject:itemObj];
                       [itemModel setModeType:CookBookDetailsType];
                       [itemFrame setModel:itemModel];
                       [model.contentArray addObject:itemFrame];
                   }];
                  
                  [frame setModel:model];
                  [self.dataArray addObject:frame];
              }];
             
              [self.cookBookHeader setItemArray:self.dataArray];
         }
     } error:^(NSError *error)
     {
         [self.mainTableView refreshReloadData];
     }];
}



#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
    
}



#pragma mark - Getter /  Setter
-(XHCookBookHeader *)cookBookHeader
{
    if (!_cookBookHeader)
    {
        _cookBookHeader = [[XHCookBookHeader alloc]initWithDelegate:self];
    }
    return _cookBookHeader;
}


-(NSMutableArray *)cookBookItemArray
{
    if (!_cookBookItemArray)
    {
        _cookBookItemArray = [NSMutableArray array];
    }
    return _cookBookItemArray;
}


-(BaseTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[BaseTableView alloc]init];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    return _tableView;
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
