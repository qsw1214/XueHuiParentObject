//
//  XHCookBookViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCookBookViewController.h"
#import "XHCookDateContentView.h"
#import "XHCookDetailsContentView.h"

@interface XHCookBookViewController () <XHCookDateContentViewDeletage,XHCustomViewDelegate>

@property (nonatomic,strong) XHCookDateContentView *dateContentView; //!< 日期内容视图
@property (nonatomic,strong) XHCookDetailsContentView *detailsContentView; //!< 详情内容视图

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
    if ([[XHUserInfo sharedUserInfo].childListArry count])
    {
        XHChildListModel *childModel = [[XHUserInfo sharedUserInfo].childListArry firstObject];
        [self getCookBookWithSchoolId:childModel.schoolId];
    }
    
}



-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.dateContentView];
        [self.view addSubview:self.detailsContentView];
        [self.dateContentView resetFrame:CGRectMake(0, self.navigationView.bottom, 90.0, SCREEN_HEIGHT-self.navigationView.height)];
        [self.detailsContentView resetFrame:CGRectMake(self.dateContentView.right, self.dateContentView.top, SCREEN_WIDTH-self.dateContentView.width, self.dateContentView.height)];
        [self setChildListArry:[XHUserInfo sharedUserInfo].childListArry];
    }
}

#pragma mark - Deletage Method
#pragma mark XHCookDateContentViewDeletage
-(void)didSelectItemObject:(XHCookBookFrame *)frame
{
    [self.detailsContentView setItemObject:frame];
}



#pragma mark XHCustomViewDelegate (选择孩子列表)
-(void)getChildModel:(XHChildListModel *)childModel
{
    [self setRightItemTitle:[childModel studentName]];
    [self getCookBookWithSchoolId:childModel.schoolId];
}



#pragma mark - NetWork Method (请求网络内容)
-(void)getCookBookWithSchoolId:(NSString*)schoolId
{
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
                  [model setModeType:CookBookDateType];
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
             
             [self.dateContentView setItemArray:self.dataArray];
         }
     } error:^(NSError *error)
     {
         [self.dateContentView setItemArray:self.dataArray];
     }];
}

#pragma mark - Getter / Setter
-(XHCookDateContentView *)dateContentView
{
    if (_dateContentView == nil)
    {
        _dateContentView = [[XHCookDateContentView alloc]initWithDeletage:self];
    }
    return _dateContentView;
}

-(XHCookDetailsContentView *)detailsContentView
{
    if (_detailsContentView == nil)
    {
        _detailsContentView = [[XHCookDetailsContentView alloc]initWithDeletage:self];
    }
    return _detailsContentView;
}


#pragma mark 右侧按钮相应的方法
-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
    if (self.childListView.isExist==NO) {
        self.childListView.delegate=self;
        [self.view addSubview:self.childListView];
        self.childListView.isExist=YES;
    }
    else
    {
        [self.childListView removeFromSuperview];
        self.childListView.isExist=NO;
    }
}



@end
