//
//  XHSmartCampusContentView.m
//  daycareParent
//
//  Created by Git on 2017/11/28.
//  Copyright © 2017年 XueHui. All rights reserved.
//




#import "XHSmartCampusContentView.h"



@interface XHSmartCampusContentView ()


@property (nonatomic,strong) XHAdvertisementControl *advertisementControl; //!< 广告轮播图
@property (nonatomic,strong) XHFunctionMenuControl *functionMenuControl;  //!< 九宫格功能视图
@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,strong) XHNetWorkConfig *netWorkConfig; //!< 网络请求工具类




@end



@implementation XHSmartCampusContentView


-(instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:RGB(244.0, 244.0, 244.0)];
        [self setItemColor:NO];
        [self.layer setMasksToBounds:YES];
        [self showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self addSubview:self.functionMenuControl];
        [self addSubview:self.advertisementControl];
        
        [self.functionMenuControl setItemArray:self.itemArray];
        [self.functionMenuControl setDeletage:deletage];
        
        [self getAdvertisement];
    }
    return self;
}


-(void)refreshHeaderAction
{
    [self getAdvertisement];
}

-(void)getAdvertisement
{
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_advertisement001" sucess:^(id object, BOOL verifyObject)
    {
        if (verifyObject)
        {
            NSArray *itemArray = [object objectItemKey:@"object"];
            if (itemArray)
            {
                [self.dataArray removeAllObjects];
                [itemArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * stop)
                 {
                     [self.dataArray addObject:ALGetFileImageOriginal([obj objectItemKey:@"picUrl"])];
                 }];
            }
            [self.advertisementControl setItemArray:self.dataArray];
            [self refreshReloadData];
        }
    } error:^(NSError *error)
    {
        [self refreshReloadData];
    }];
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.advertisementControl resetFrame:CGRectMake(0,0, frame.size.width, 190.0)];
    [self.functionMenuControl resetFrame:CGRectMake(0, (self.advertisementControl.bottom+10.0), frame.size.width, 360.0)];
    [self setContentSize:CGSizeMake(frame.size.width, self.functionMenuControl.bottom)];
}




#pragma mark - Getter / Setter
#pragma mark 九宫格功能视图
-(XHFunctionMenuControl *)functionMenuControl
{
    if (_functionMenuControl == nil)
    {
        _functionMenuControl = [[XHFunctionMenuControl alloc]init];
    }
    return _functionMenuControl;
}




#pragma mark 广告轮播图
-(XHAdvertisementControl*)advertisementControl
{
    if (_advertisementControl == nil)
    {
        _advertisementControl = [[XHAdvertisementControl alloc]init];
    }
    return _advertisementControl;
}


-(NSMutableArray *)itemArray
{
    if (_itemArray == nil)
    {
        NSArray *itemArray = @[@{@"title":@"考勤记录",@"describe":@"Attendance Record",@"icon":@"bg_kaoqin"},
  @{@"title":@"安全定位",@"describe":@"Safety Positioning",@"icon":@"bg_dingwei"},
  @{@"title":@"成绩",@"describe":@"Ache",@"icon":@"bg_kaoqin",@"icon":@"bg_chengji"},
  @{@"title":@"课程表",@"describe":@"Class Schedule Card",@"icon":@"bg_kechengbiao"},
  @{@"title":@"请假",@"describe":@"Leave",@"icon":@"bg_qingjia"},
  @{@"title":@"食谱",@"describe":@"Recipes",@"icon":@"bg_food"}];
        _itemArray = [NSMutableArray array];
        [itemArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop)
         {
             NSString *title = [obj objectItemKey:@"title"];
             NSString *describe = [obj objectItemKey:@"describe"];
             NSString *icon = [obj objectItemKey:@"icon"];
             XHFunctionMenuFrame *frame = [[XHFunctionMenuFrame alloc]init];
             XHFunctionMenuModel *model = [[XHFunctionMenuModel alloc]init];
             [model setTitle:title];
             [model setDescribe:describe];
             [model setTage:idx];
             [model setIconName:icon];
             [frame setModel:model];
             [_itemArray addObject:frame];
         }];
    }
    return _itemArray;
}



-(XHNetWorkConfig *)netWorkConfig
{
    if (!_netWorkConfig)
    {
        _netWorkConfig = [[XHNetWorkConfig alloc]init];
    }
    return _netWorkConfig;
}

-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.advertisementControl setBackgroundColor:[UIColor orangeColor]];
        [self.functionMenuControl setBackgroundColor:[UIColor darkGrayColor]];
    }
}


@end
