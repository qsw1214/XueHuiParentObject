//
//  XHNoticeDetailViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHNoticeDetailViewController.h"

#import "XHNoticeDetailView.h"

@interface XHNoticeDetailViewController ()

@property (nonatomic,strong) XHNoticeDetailView *contentView;


@end

@implementation XHNoticeDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"通知详情"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.height)];
    }
}


-(void)setItemObjet:(XHNoticeFrame*)object
{
    
    /**
     无论发送已读状态成功与否都要进入通知的详请
     */
    [self.netWorkConfig setObject:object.model.noticeActorId forKey:@"noticeActorId"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus016" sucess:^(id object, BOOL verifyObject)
    {
        if (verifyObject)
        {
            if (self.refeshBlock)
            {
                self.refeshBlock(verifyObject);
            }   
        }
    } error:^(NSError *error){}];
    
    
    XHNoticeFrame *frame = [[XHNoticeFrame alloc]init];
    XHNoticeModel *model = [[XHNoticeModel alloc]init];
    [model setHeaderUrl:object.model.headerUrl];
    [model setVedioAllUrl:object.model.vedioAllUrl];
    [model setVedioFirstPicUrl:object.model.vedioFirstPicUrl];
    [model setUserName:object.model.userName];
    [model setReleaseDate:object.model.releaseDate];
    [model.imageUrlArray setArray:object.model.imageUrlArray];
    [model setContent:object.model.content];
    [model setContentType:object.model.contentType];
    [model setNoticeType:NoticeDetailsType];
    [frame setModel:model];
    [self.dataArray addObject:frame];
    [self.contentView setItemArray:self.dataArray];
}






#pragma mark - Getter / Setter
-(XHNoticeDetailView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHNoticeDetailView alloc]initWithDeletage:self];
    }
    return _contentView;
}



@end
