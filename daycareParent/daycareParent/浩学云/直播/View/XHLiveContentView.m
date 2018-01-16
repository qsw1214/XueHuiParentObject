//
//  XHLiveContentView.m
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLiveContentView.h"
#import "XHLiveTableViewCell.h"

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
        
        for (int i = 0; i< 1; i++)
        {
            XHLiveFrame *frame = [[XHLiveFrame alloc] init];
            XHLiveModel *model = [[XHLiveModel alloc]init];
            [model setContentType:XHLiveAdvertType];
            [model setImageUrl:@"banner-live"];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
        
        
        
        for (int i = 1; i<= 3; i++)
        {
            XHLiveFrame *frame = [[XHLiveFrame alloc] init];
            XHLiveModel *model = [[XHLiveModel alloc]init];
            [model setContentType:XHLiveItemType];
            switch (i)
            {
                case 1:
                {
                    [model setImageUrl:@"one"];
                }
                    break;
                case 2:
                {
                    [model setImageUrl:@"two"];
                }
                    break;
                case 3:
                {
                    [model setImageUrl:@"three"];
                }
                    break;
            }
            
            [model setTitle:@"帮您解密互联网+共享教育的秘密"];
            [model setDate:@"2018/1/25"];
            [model setLiveMark:@"2"];
            [model setLectureTeacher:@"田泽相"];
            [frame setModel:model];
            [self.dataArray addObject:frame];
        }
    }
    
    [self.tableView refreshReloadData];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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



@end
