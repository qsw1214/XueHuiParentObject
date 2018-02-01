//
//  XHLiveContentView.m
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLiveContentView.h"


@implementation XHLiveContentView





- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeaderAction)];
        [self.tableView beginRefreshing];
    }
    return self;
}



-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.dataArray removeAllObjects];
        [self getModel];
        for (int i = 0; i< 1; i++)
        {
            XHLiveFrame *frame = [[XHLiveFrame alloc] init];
            XHLiveModel *model = [[XHLiveModel alloc]init];
            [model setContentType:XHLiveAdvertType];
            [model setImageUrl:@"banner-live"];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
//
//
        
//        for (int i = 1; i<= 3; i++)
//        {
//            XHLiveFrame *frame = [[XHLiveFrame alloc] init];
//            XHLiveModel *model = [[XHLiveModel alloc]init];
//            [model setContentType:XHLiveItemType];
//            switch (i)
//            {
//                case 1:
//                {
//                    [model setImageUrl:@"one"];
//                }
//                    break;
//                case 2:
//                {
//                    [model setImageUrl:@"two"];
//                }
//                    break;
//                case 3:
//                {
//                    [model setImageUrl:@"three"];
//                }
//                    break;
//            }
//
//            [model setTitle:@"帮您解密互联网+共享教育的秘密"];
//            [model setDate:@"2018/1/25"];
//            [model setLiveMark:@"2"];
//            [model setLectureTeacher:@"田泽相"];
//            [frame setModel:model];
//            [self.dataArray addObject:frame];
//        }
    }
    
    //[self.tableView refreshReloadData];
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.tableView resetFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];

}



#pragma mark - Action Method
-(void)refreshHeaderAction
{
    [self addSubViews:YES];
}



#pragma mark - Deletage Method
-(NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return [self.dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}

-(XHLiveTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[XHLiveTableViewCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XHLiveFrame *liveFrame = [self.dataArray objectAtIndex:indexPath.row];
    switch (liveFrame.model.contentType)
    {
        case XHLiveAdvertType:
            break;
        case XHLiveItemType:
        {
            if ([self.deletage respondsToSelector:@selector(didSelectRowAtIndexPath:)])
            {
                [self.deletage didSelectRowAtIndexPath:[self.dataArray objectAtIndex:indexPath.row]];
            }
        }
            break;
    }
   
    
    
}
-(void)getModel
{
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_listLecture" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSArray *arr=[object objectItemKey:@"object"];
            for (NSDictionary *dic in arr)
            {
                XHLiveFrame *frame = [[XHLiveFrame alloc] init];
                XHLiveModel *model = [[XHLiveModel alloc]init];
                [model setContentType:XHLiveItemType];
               
                [model setImageUrl:[dic objectItemKey:@"head_image"]];
                [model setTitle:[dic objectItemKey:@"title"]];
                [model setDate:[self dateStr:[dic objectItemKey:@"start_time"]]];
                [model setLiveMark:[dic objectItemKey:@"live_state"]];
                [model setLectureTeacher:[dic objectItemKey:@"presenter"]];
                [model setPull_stream_add:[dic objectItemKey:@"pull_stream_add"]];
                [model setChatroom_id:[dic objectItemKey:@"chatroom_id"]];
                [frame setModel:model];
                [self.dataArray addObject:frame];
            }
              [self.tableView refreshReloadData];
        }
        {
              [self.tableView refreshReloadData];
        }
    } error:^(NSError *error) {
          [self.tableView refreshReloadData];
    }];
}
-(NSString *)dateStr:(NSString *)dateStr
{
    NSDateFormatter *setDateFormatter = [[NSDateFormatter alloc] init];
    [setDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date= [setDateFormatter dateFromString:dateStr];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    //设置日期格式
    [myDateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *String=[myDateFormatter stringFromDate:date];
    return String;
}
@end
