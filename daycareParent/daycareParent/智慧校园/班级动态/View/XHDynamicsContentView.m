//
//  XHDynamicsContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/14.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsContentView.h"


@interface XHDynamicsContentView () <UITableViewDelegate,UITableViewDataSource,XHDynamicsCellContentViewDeletage,XHDynamicsCollectionViewDeletage>

@property (nonatomic,assign) NSInteger pageNumber; //!< 分页数




@end


@implementation XHDynamicsContentView

-(instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setTipType:TipImage withTipTitle:nil withTipImage:@"ico-no-data"];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.tableView showRefresFooterWithTarget:self withSelector:@selector(refreshFooterAction)];
        [self.tableView beginRefreshing];
        [self addSubViews:YES];
    }
    return self;
}


-(void)dealloc
{
    [[XHVideoControl sharedVideo] dismiss];
}



-(void)addSubViews:(BOOL)subview
{
    if (!subview)
    {
        for (int i = 0; i < 10; i++)
        {
            XHDynamicsFrame *frame = [[XHDynamicsFrame alloc]init];
            XHDynamicsModel *model = [[XHDynamicsModel alloc]init];
            [model setTeacherName:@"姚立志"];
            [model setHeaderUrl:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3944680232,2054173354&fm=27&gp=0.jpg"];
            [model setWorkUnit:@"学汇教育"];
            [model setDate:@"2017-10-20"];
            [model setContent:@"这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住"];
            [model setVideoUrl:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3944680232,2054173354&fm=27&gp=0.jpg"];
            [model setVideoPreviewUrl:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3944680232,2054173354&fm=27&gp=0.jpg"];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        for (int i = 0; i < 10; i++)
        {
            NSArray *arr = @[@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3944680232,2054173354&fm=27&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3944680232,2054173354&fm=27&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3944680232,2054173354&fm=27&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3944680232,2054173354&fm=27&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3944680232,2054173354&fm=27&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3944680232,2054173354&fm=27&gp=0.jpg",];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSString *url in arr)
            {
                XHPreviewModel *model = [[XHPreviewModel alloc]init];
                [model setPreviewUrl:url];
                [tempArray addObject:model];
            }
            
            XHDynamicsFrame *frame = [[XHDynamicsFrame alloc]init];
            XHDynamicsModel *model = [[XHDynamicsModel alloc]init];
            [model setTeacherName:@"姚立志"];
            [model setHeaderUrl:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3944680232,2054173354&fm=27&gp=0.jpg"];
            [model setWorkUnit:@"学汇教育"];
            [model setDate:@"2017-10-20"];
            [model setContent:@"这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住"];
            [model setItemArray:tempArray];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        for (int i = 0; i < 10; i++)
        {
            XHDynamicsFrame *frame = [[XHDynamicsFrame alloc]init];
            XHDynamicsModel *model = [[XHDynamicsModel alloc]init];
            [model setTeacherName:@"姚立志"];
            [model setHeaderUrl:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3944680232,2054173354&fm=27&gp=0.jpg"];
            [model setWorkUnit:@"学汇教育"];
            [model setDate:@"2017-10-20"];
            [model setContent:@"这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住，这是一段新的内容，请大家记住"];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        [self.tableView reloadData];
    }
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}




#pragma mark - Action Method
-(void)refreshHeaderAction
{
    [self setPageNumber:1];
    [self getDynamicsWithGuardianId:[XHUserInfo sharedUserInfo].guardianModel.guardianId withRefreshType:HeaderRefresh];
}

-(void)refreshFooterAction
{
    [self getDynamicsWithGuardianId:[XHUserInfo sharedUserInfo].guardianModel.guardianId withRefreshType:FooterRefresh];
}



#pragma mark 获取班级动态的网络请求
-(void)getDynamicsWithGuardianId:(NSString*)guardianId withRefreshType:(BaseRefreshType)type
{
    [self.netWorkConfig setObject:guardianId forKey:@"guardianId"];
    [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",self.pageNumber] forKey:@"pageNumber"];
    [self.netWorkConfig setObject:@"10" forKey:@"pageSize"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus010" sucess:^(id object, BOOL verifyObject)
     {
         if (verifyObject)
         {
             NSDictionary *itemObject = [object objectItemKey:@"object"];
             NSArray *pageResultArray = [itemObject objectItemKey:@"pageResult"];
             if (pageResultArray)
             {
                 switch (type)
                 {
                     case HeaderRefresh:
                     {
                         [self.dataArray removeAllObjects];
                     }
                         break;
                     case FooterRefresh:
                         break;
                 }
                 [pageResultArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
                  {
                      NSInteger inddexTage = [self.dataArray count];
                      NSDictionary *item = [obj objectItemKey:@"propValue"];
                      XHDynamicsFrame *frame = [[XHDynamicsFrame alloc]init];
                      XHDynamicsModel *model = [[XHDynamicsModel alloc]init];
                      [model setTage:inddexTage];
                      [model setItemObject:item];
                      [model.playModel setScrollView:self.tableView];
                      [frame setModel:model];
                      [self.dataArray addObject:frame];
                  }];
                 
                 
                 if ([pageResultArray count] >= 10)
                 {
                     [self.tableView refreshReloadData];
                     [self setPageNumber:(self.pageNumber+1)];
                 }
                 else
                 {
                     [self.tableView refreshReloadData];
                     [self.tableView noMoreData];
                 }
             }
             else
             {
                 [self.tableView refreshReloadData];
                 [self.tableView noMoreData];
             }
         }
     } error:^(NSError *error)
     {
         [self.tableView refreshReloadData];
     }];
}


#pragma mark - 回执已读状态
-(void)isreadWithNoticeActorId:(NSString *)noticeActorId withIndexPath:(NSIndexPath*)indexPath
{
    XHDynamicsFrame *frame = [self.dataArray objectAtIndex:indexPath.row];
    //先回执已读状态
    [self.netWorkConfig setObject:noticeActorId forKey:@"noticeActorId"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus016" sucess:^(id object, BOOL verifyObject)
     {
         if (verifyObject)
         {
             [frame.model setUnreadType:@"1"];
         }
     } error:^(NSError *error){}];
}








#pragma mark - Deletage Method
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}

- (XHDynamicsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHDynamicsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[XHDynamicsCell alloc]initWithDeletage:self];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row] withIndexPath:indexPath];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHDynamicsFrame *frame = self.dataArray[indexPath.row];
    [self isreadWithNoticeActorId:frame.model.noticeActorId withIndexPath:indexPath];
}

#pragma mark XHDynamicsCellContentViewDeletage Method
-(void)videoPlayerAction:(XHDynamicsFrame *)frame
{
    [[XHVideoControl sharedVideo] playerWithModel:frame.model.playModel];
    //先回执已读状态
    [frame.model setPlayType:XHDynamicsPlayerType];
    [self.netWorkConfig setObject:frame.model.noticeActorId forKey:@"noticeActorId"];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:frame.model.tage inSection:0];
    [self isreadWithNoticeActorId:frame.model.noticeActorId withIndexPath:indexPath];
}

#pragma mark XHDynamicsCollectionViewDeletage
-(void)didselectItemModel:(XHPreviewModel*)model
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:model.indexTage inSection:0];
    [self isreadWithNoticeActorId:model.noticeActorId withIndexPath:indexPath];
}
















@end
