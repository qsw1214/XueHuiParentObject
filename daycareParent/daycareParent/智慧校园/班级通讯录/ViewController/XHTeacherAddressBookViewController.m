//
//  XHTeacherAddressBookViewController.m
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHTeacherAddressBookViewController.h"



@interface XHTeacherAddressBookViewController () <XHTeacherAddressBookContentViewDeletage>

@property (nonatomic,strong) XHTeacherAddressBookContentView *contentView; //!< 内容视图


@end

@implementation XHTeacherAddressBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavtionTitle:@"选择审批人"];
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

-(void)setModel:(XHChildListModel *)model
{
    _model = model;
    [self.contentView setModel:model];
}


#pragma mark - Deletage Method
#pragma mark XHTeacherAddressBookContentViewDeletage
-(void)didSelectRowAtIndexItemObject:(XHTeacherAddressBookFrame *)object
{
    if (self.didselectBack)
    {
        self.didselectBack(object);
    }
}


-(void)dissmissPopWithItemObjec:(XHTeacherAddressBookFrame *)object
{
    if (self.didselectBack)
    {
        self.didselectBack(object);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Getter / Setter
-(XHTeacherAddressBookContentView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[XHTeacherAddressBookContentView alloc]init];
        [_contentView setDeletage:self];
    }
    return _contentView;
}






@end
