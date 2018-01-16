//
//  XHHomeWorkDetailsViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHomeWorkDetailsViewController.h"

#import "XHHomeWorkDetailView.h"

@interface XHHomeWorkDetailsViewController () 

@property (nonatomic,strong) XHHomeWorkDetailView *contentView;


@end

@implementation XHHomeWorkDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"作业详情"];
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


-(void)setItemObjet:(XHHomeWorkFrame*)object
{
    //先回执已读状态
    [self.netWorkConfig setObject:object.model.pushInfoId forKey:@"pushInfoId"];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus012" sucess:^(id object, BOOL verifyObject)
    {
        if (verifyObject)
        {
            [XHShowHUD hideHud];
            if (self.refeshBlock)
            {
                self.refeshBlock(verifyObject);
            }
            
        }
    } error:^(NSError *error){}];
    
    
    
    XHHomeWorkFrame *frame = [[XHHomeWorkFrame alloc]init];
    XHHomeWorkModel *model = [[XHHomeWorkModel alloc]init];
    [model setHeaderUrl:object.model.headerUrl];
    [model setSubject:object.model.subject];
    [model setUserName:object.model.userName];
    [model setReleaseDate:object.model.releaseDate];
    [model setGradeName:object.model.gradeName];
    [model setClazzName:object.model.clazzName];
    [model.imageUrlArray setArray:object.model.imageUrlArray];
    [model setWorkContent:object.model.workContent];
    [model setHomeWorkType:HomeWorkDetailsType];
    [model setContentType:object.model.contentType];
    [frame setModel:model];
    [self.dataArray addObject:frame];
    [self.contentView setItemArray:self.dataArray];
}





#pragma mark - Getter / Setter
-(XHHomeWorkDetailView *)contentView
{
    if (_contentView == nil)
    {
        _contentView = [[XHHomeWorkDetailView alloc]initWithDeletage:self];
    }
    return _contentView;
}



@end
