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
    
   
    NSLog(@"===%.2f===%.2f",SCREEN_HEIGHT,SCREEN_WIDTH);
    NSString *iphoneType = [XHHelper iphoneType];
    CGFloat Height = 200.0;
    
    {
        if ([iphoneType isEqualToString:@"iPhone 4"] || [iphoneType isEqualToString:@"iPhone 4S"])
        {
            Height = 190.0;
           
        }
        
        
        if ([iphoneType isEqualToString:@"iPhone 6"] || [iphoneType isEqualToString:@"iPhone 6S"] || [iphoneType isEqualToString:@"iPhone 7"] || [iphoneType isEqualToString:@"iPhone 8"])
        {
            Height = 220;
        }
        
        if ([iphoneType isEqualToString:@"iPhone 5"] || [iphoneType isEqualToString:@"iPhone 5C"])
        {
            Height = 220.0;
        }
        
        if ([iphoneType isEqualToString:@"iPhone 6 Plus"] || [iphoneType isEqualToString:@"iPhone 6s Plus"] || [iphoneType isEqualToString:@"iPhone 7 Plus"])
        {
            Height = 250.0;
        }
        
        
        if ([iphoneType isEqualToString:@"iPhone X"])
        {
            Height = 260.0;
        }
    }
    
    
     [self.advertisementControl resetFrame:CGRectMake(0,0, frame.size.width, Height)];
    
    NSLog(@"%.2f",self.advertisementControl.height);
    
    
    [self.functionMenuControl resetFrame:CGRectMake(5, (self.advertisementControl.bottom+15.0), frame.size.width-10.0, 400.0)];
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
        NSArray *itemArray = @[
  @{@"title":@"考勤",@"describe":@"Attendance",@"icon":@"bg_kaoqin"},
  @{@"title":@"定位",@"describe":@"Location",@"icon":@"bg_dingwei"},
  @{@"title":@"成绩",@"describe":@"Performance",@"icon":@"bg_chengji"},
  @{@"title":@"课表",@"describe":@"Timetable",@"icon":@"bg_kechengbiao"},
  @{@"title":@"请假",@"describe":@"Leave",@"icon":@"bg_qingjia"},
  @{@"title":@"食谱",@"describe":@"Recipes",@"icon":@"bg_food"}];
        _itemArray = [NSMutableArray array];
        for (int i = 0; i < [itemArray count]; i++)
        {
            NSDictionary *dictobj = [itemArray objectAtIndex:i];
            NSString *title = [dictobj objectItemKey:@"title"];
            NSString *describe = [dictobj objectItemKey:@"describe"];
            NSString *icon = [dictobj objectItemKey:@"icon"];
            XHFunctionMenuFrame *frame = [[XHFunctionMenuFrame alloc]init];
            XHFunctionMenuModel *model = [[XHFunctionMenuModel alloc]init];
            [model setTitle:title];
            [model setTage:i];
            [model setDescribe:describe];
            [model setIconName:icon];
            [frame setModel:model];
            [_itemArray addObject:frame];
        }
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
