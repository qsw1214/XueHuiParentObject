//
//  XHStudyRecordViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHStudyRecordViewController.h"
#import "BaseTableView.h"
#import "XHDelegateView.h"
#import "XHSelectTableViewCell.h"
#import "XHSelectFileTableViewCell.h"
#import "XHStudyModel.h"
#import "XHEducationCloudWebViewController.h"
#define TITLE_LIST @[@"学习记录",@"收藏资源",@"下载记录",@"我的课程"]
#define IMAGE_LIST @[@"morentu_study",@"morentu_collection",@"morentu_nodownlaod",@"morentu_study"]
@interface XHStudyRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BaseTableView *_tableView;
    NSMutableArray *_deleteArry;
    NSMutableString *_deleteStr;
}
@property(nonatomic,strong)XHDelegateView *deleteView;
@property(nonatomic,assign)NSInteger selectNumber;
@end

@implementation XHStudyRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavtionTitle:TITLE_LIST[self.index]];
    [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"编辑"];
    _deleteArry=[NSMutableArray array];
    _deleteStr=[NSMutableString string];
    _tableView=[[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.rowHeight=100;
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"XHSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"XHSelectFileTableViewCell" bundle:nil] forCellReuseIdentifier:@"fileCell"];
    [_tableView showRefresHeaderWithTarget:self withSelector:@selector(refreshHeader)];
    [_tableView beginRefreshing];
    [_tableView setTipType:TipTitleAndTipImage withTipTitle:[NSString stringWithFormat:@"暂时还没有%@哦",TITLE_LIST[self.index]] withTipImage:IMAGE_LIST[self.index]];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.selectNumber=0;
    [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].ID forKey:@"userId"];
    [self.netWorkConfig setObject:[NSString stringWithFormat:@"%zd",self.index+1] forKey:@"recordType"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_learnRecord003" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            [self.dataArray removeAllObjects];
            NSDictionary *DIC=[object objectItemKey:@"object"];
            for (NSDictionary *Dic in DIC) {
                NSDictionary *dic=[Dic objectItemKey:@"propValue"];
                XHStudyModel *model=[[XHStudyModel alloc]initWithDic:dic];
                [self.dataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView refreshReloadData];
            });
        }
    } error:^(NSError *error) {
        [_tableView refreshReloadData];
    }];
}
-(void)refreshHeader
{
    [_deleteArry removeAllObjects];
    self.selectNumber=0;
    _tableView.editing=NO;
    [self setRightItemTitle:@"编辑"];
    [self deleteSelectArry];
    [_tableView refreshReloadData];
}
- (NSInteger)tableView:(BaseTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView tableTipViewWithArray:self.dataArray];
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(BaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHStudyModel *model = self.dataArray[indexPath.row];
    if ([model.resource_type integerValue]==1) {
        XHSelectTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.titleImagV.image=[UIImage imageNamed:@"img_video"];
        cell.contentLab.text=model.resource_name;
        cell.detailLab.text=model.create_time;
        return cell;
    }
    else
    {
        XHSelectFileTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"fileCell" forIndexPath:indexPath];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.titleImagV.image=[UIImage imageNamed:@"ico_word"];
        cell.contentLab.text=model.resource_name;
        cell.detailLab.text=model.create_time;
        return cell;
    }
   
}

//选择你要对表进行处理的方式  默认是删除方式

-(UITableViewCellEditingStyle)tableView:(BaseTableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

//选中时将选中行的在self.dataArray 中的数据添加到删除数组self.deleteArr中

- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.editing==YES) {
        [_deleteArry addObject:[self.dataArray objectAtIndex:indexPath.row]];
        NSLog(@"选中那一行");
        self.selectNumber++;
        [self selectNotifi];
    }
    else
    {
       XHStudyModel *model=self.dataArray[indexPath.row];
        XHEducationCloudWebViewController *webView = [[XHEducationCloudWebViewController alloc]initHiddenWhenPushHidden];
        if ([model.resource_type integerValue]==2) {

            [webView setWebViewUrl:[model.resource_path encoding]];
        }
        else
        {
            NSString *webUrl = [NSString stringWithFormat:@"%@%@&user_id=%@",VideoBaseUrl,model.resource_path,[XHUserInfo sharedUserInfo].loginName];
            [webView setWebViewUrl:webUrl];
        }
        [webView setNavtionTitle:[NSString stringWithFormat:@"%@详情",TITLE_LIST[self.index]]];
        [self.navigationController pushViewController:webView animated:YES];
        
    }

    
}

//取消选中时 将存放在self.deleteArr中的数据移除

- (void)tableView:(BaseTableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    [_deleteArry removeObject:[self.dataArray objectAtIndex:indexPath.row]];
     NSLog(@"取消那一行");
    self.selectNumber--;
    [self selectNotifi];
}

-(void)rightItemAction:(BaseNavigationControlItem*)sender
{
   
    if (self.dataArray.count==0) {
        return;
    }
    
    _tableView.editing = !_tableView.editing;
     [sender setTitle:_tableView.editing==YES?@"取消":@"编辑"];
    [self deleteSelectArry];
    [_tableView reloadData];
    
}
-(XHDelegateView *)deleteView
{
    if (_deleteView==nil) {
        _deleteView=[[XHDelegateView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 60)];
    }
    [_deleteView.allSelectBtn addTarget:self action:@selector(selectAllBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_deleteView.deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _deleteView.frame=CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60);
    [UIView commitAnimations];
    return _deleteView;
}
- (void)selectAllBtnClick {
    
    _deleteView.allSelectBtn.selected=!_deleteView.allSelectBtn.selected;
    [_deleteView.allSelectBtn setTitle:_deleteView.allSelectBtn.selected==YES?@"取消全选":@"全选" forState:UIControlStateNormal];
    if (_deleteView.allSelectBtn.selected) {
        [_deleteArry removeAllObjects];
        for (int i = 0; i < self.dataArray.count; i ++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
             [_deleteArry addObjectsFromArray:self.dataArray];
      }
        self.selectNumber=self.dataArray.count;
  }
    else
    {
        for (int i = 0; i < self.dataArray.count; i ++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [_tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        self.selectNumber=0;
        [_deleteArry removeAllObjects];
        [_tableView refreshReloadData];
    }
     [self selectNotifi];

}

- (void)deleteClick:(XHBaseBtn *) button {
    
    if (_selectNumber==0) {
        return;
    }
    if (_tableView.editing) {
        [_deleteStr appendString:@""];
        for (XHStudyModel *_model in _deleteArry) {
            [_deleteStr appendFormat:@"%@,",_model.record_id];
        }
        [self.netWorkConfig setObject:_deleteStr forKey:@"recordId"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_learnRecord002" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //删除
                    [self.dataArray removeObjectsInArray:_deleteArry];
                    [_tableView refreshReloadData];
                    _tableView.editing=NO;
                    [self setRightItemTitle:@"编辑"];
                    [self deleteSelectArry];
                });
            }
            
        } error:^(NSError *error) {
            [_tableView refreshReloadData];
        }];
        
    }
    
    else return;
    
}

-(void)selectNotifi
{
    if (_selectNumber==0) {
        [_deleteView.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteView.deleteBtn.alpha=0.6;
    }
    else
    {
        [_deleteView.deleteBtn setTitle:[NSString stringWithFormat:@"删除（%zd)",_selectNumber] forState:UIControlStateNormal];
        _deleteView.deleteBtn.alpha=1.0;
    }
    [self chageSelect];
}
#pragma mark-------改变全选状态
-(void)chageSelect
{
    if (_selectNumber==self.dataArray.count) {
        _deleteView.allSelectBtn.selected=YES;
    }
    else
    {
        _deleteView.allSelectBtn.selected=NO;
    }
    [_deleteView.allSelectBtn setTitle:_deleteView.allSelectBtn.selected==YES?@"取消全选":@"全选" forState:UIControlStateNormal];
}
-(void)deleteSelectArry
{
    if (_tableView.editing==YES) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.deleteView.frame=CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 60);
        [UIView commitAnimations];
    }
    else
    {
        _selectNumber=0;
        _deleteView.allSelectBtn.selected=NO;
        _deleteView.deleteBtn.selected=NO;
        [self selectNotifi];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.deleteView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 60);
        [UIView commitAnimations];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
