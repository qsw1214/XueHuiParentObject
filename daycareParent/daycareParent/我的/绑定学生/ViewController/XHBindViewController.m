//
//  XHBindViewController.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHBindViewController.h"
#import "XHChildListModel.h"
#import "XHStudentInfoViewController.h"
#import "XHBindViewContentView.h"
#import "XHAddBindPasswordViewController.h"
#import "MainRootControllerHelper.h"

@interface XHBindViewController () <XHBindViewContentViewDelegate>

@property (nonatomic,strong) XHBindViewContentView *contentView;  //!< 内容视图



@end

@implementation XHBindViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"绑定学生"];
    if (self.enterType==XHRegisterEnterType)
    {
      [self setItemContentType:NavigationTitleType withItemType:NavigationItemRightype withIconName:nil withTitle:@"跳过"];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Public Method
-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self.view addSubview:self.contentView];
        [self.contentView resetFrame:CGRectMake(0, self.navigationView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigationView.bottom)];
    }
}


#pragma mark - Delertage Method
#pragma mark XHBindViewContentViewDelegate （根据当前还是确定是否被绑定过）
-(void)submitControlAction:(XHNetWorkConfig*)sender
{
    [XHShowHUD showTextHud];
//    [sender setObject:@"张晓" forKey:@"studentName"];
//    [sender setObject:@"101" forKey:@"archiveId"];
    [sender postWithUrl:@"zzjt-app-api_studentBinding001" sucess:^(id object, BOOL verifyObject)
    {
        if (verifyObject)
        {
            object = [object objectItemKey:@"object"];
            NSDictionary *propValue = [object objectItemKey:@"propValue"];
            NSString *studentBaseId = [object objectItemKey:@"studentBaseId"]; //!< 根据查询出来学生信息填充绑定信息
            [sender setObject:studentBaseId forKey:@"studentBaseId"];
            /**
             （1.已经有第一监护人 0.没有被绑定过）
             */
            
            NSInteger isBinding = [[propValue objectForKey:@"isBinding"] integerValue]; //!< （1.已经有第一监护人 0.没有被绑定过）
            XHAddBindPasswordViewController *addPassword = [[XHAddBindPasswordViewController alloc]init];
            [addPassword setNetWorkConfig:sender];
            
            switch (self.enterType)
            {
                case XHRegisterEnterType:
                {
                    addPassword.enterType=XHRegisterAddEnterType;
                }
                    break;
                    
                case XHBindEnterType:
                {
                     addPassword.enterType=XHBindAddEnterType;
                }
                    break;
            }
            if (isBinding)
            {
                [addPassword setType:XHAddBindEnterPasswordType];
            }
            else
            {
                [addPassword setType:XHAddBindSettingPasswordType];
            }
            addPassword.isRefresh = ^(BOOL ok) {
                if (ok) {
                    if (self.isRefresh) {
                        self.isRefresh(YES);
                    }
                }
            };
            [self.navigationController pushViewController:addPassword animated:YES];


        }



    } error:^(NSError *error)
     {




     }];
}
-(void)rightItemAction:(BaseNavigationControlItem *)sender
{
    //自动登录
    [[MainRootControllerHelper sharedRootHelperHelper] autoLoginWithWindow:kWindow];
}
-(XHBindViewContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHBindViewContentView alloc]init];
        [_contentView setActionDeletgate:self];
    }
    return _contentView;
}


@end
