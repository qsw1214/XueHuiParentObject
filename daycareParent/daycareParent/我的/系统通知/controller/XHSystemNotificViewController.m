//
//  XHSystemNotificViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHSystemNotificViewController.h"
#import "XHSystemModel.h"
#import "XHSystemNoticeTableViewCell.h"
@interface XHSystemNotificViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)BaseTableView *tableView;
@end

@implementation XHSystemNotificViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:@"系统通知"];
    [self.view addSubview:self.tableView];
    for (int i=0; i<7; i++) {
        if (i<3) {
            XHSystemModel *model=[[XHSystemModel alloc] initWithDic:nil];
            model.modelType=XHSystemNoticeType;
            model.title=@"通知";
            model.date=@"03-06 17:21";
            model.content=@"抱歉抱歉，由于头像不符合规定，更新失败。抱歉抱歉，由于头像不符合规定，更新失败。抱歉抱歉，由于头像不符合规定，更新失败。抱歉抱歉，由于头像不符合规定，更新失败。抱歉抱歉，由于头像不符合规定，更新失败。抱歉抱歉，由于头像不符合规定，更新失败。抱歉抱歉，由于头像不符合规定，更新失败。抱歉抱歉，由于头像不符合规定，更新失败";
            model.itemCellHeight=40+[self contentSizeWithTitle:model.content withFontOfSize:kFont(16.0) withWidth:SCREEN_WIDTH-20].height;
            [self.dataArray addObject:model];
           
        }
        else
        {
            XHSystemModel *model=[[XHSystemModel alloc] initWithDic:nil];
            model.modelType=XHSystemOtherType;
            model.title=@"活动";
            model.date=@"03-07 21:03";
            model.content=@"你好，欢迎加入欢迎加入欢迎加入欢迎加入。你好，欢迎加入欢迎加入欢迎加入欢迎加入。你好，欢迎加入欢迎加入欢迎加入欢迎加入。你好，欢迎加入欢迎加入欢迎加入欢迎加入。";
            model.itemCellHeight=40+[self contentSizeWithTitle:model.content withFontOfSize:kFont(16.0) withWidth:SCREEN_WIDTH-20].height;
            [self.dataArray addObject:model];
        }
        
    }
    
   
    [self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray[indexPath.section] itemCellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHSystemNoticeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setItemObject:self.dataArray[indexPath.section]];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 15;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else
        if(scrollView.contentOffset.y >= sectionHeaderHeight){

            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
}
-(BaseTableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[XHSystemNoticeTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
