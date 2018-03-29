//
//  XHStudentInfoContentView.m
//  daycareParent
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHStudentInfoContentView.h"
#import "XHStudentInfofamilyItemCell.h"


@interface XHStudentInfoContentView () <XHAlertControlDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) XHNetWorkConfig *netWorkConfig;
@property (nonatomic,strong) UILabel *baseLabel; //!< 基本信息标签
@property (nonatomic,strong) UILabel *parentInformationLabel; //!< 家长信息标签
@property (nonatomic,strong) UILabel *tipLabel; //!< 提醒信息标签
@property (nonatomic,strong) XHHeaderControl *header; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *headerControl; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *nameControl; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *schoolControl; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *classControl; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *sexControl; //!< 提醒信息标签
@property (nonatomic,strong) BaseButtonControl *birthdayControl; //!< 生日标签
@property (nonatomic,strong) BaseButtonControl *identityControl;  //!< 身份
@property (nonatomic,strong) BaseButtonControl *passwordControl; //!< 密码重置按钮
@property (nonatomic,strong) BaseButtonControl *unBindControl; //!< 解除绑定按钮
@property (nonatomic,strong) BaseCollectionView *familyCollectionView; //!< 家庭数组

@end




@implementation XHStudentInfoContentView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.baseLabel];
        [self addSubview:self.headerControl];
        [self.headerControl addSubview:self.header];
        [self addSubview:self.nameControl];
        [self addSubview:self.schoolControl];
        [self addSubview:self.classControl];
        [self addSubview:self.sexControl];
        [self addSubview:self.birthdayControl];
        [self addSubview:self.identityControl];
        [self addSubview:self.parentInformationLabel];
        [self addSubview:self.familyCollectionView];
        [self addSubview:self.tipLabel];
        [self addSubview:self.passwordControl];
        [self addSubview:self.unBindControl];
        
        
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


#pragma mark - Private Method

-(void)studentInfoControlAction:(BaseButtonControl*)sender
{
    if ([self.infoDelegate respondsToSelector:@selector(studentInfoControlAction:)])
    {
        [self.infoDelegate studentInfoControlAction:sender.tag];
    }
}


#pragma mark - 解除绑定
-(void)unBindControlAction:(BaseButtonControl*)sender
{
    switch ([XHUserInfo sharedUserInfo].isMajor)
    {
#pragma mark case 0 不是主监护人
        case 0:
        {
            
            
            XHAlertControl *alert = [[XHAlertControl alloc]initWithDelegate:self];
            [alert setTitle:@"解绑学生"];
            [alert setBoardType:XHAlertBoardNormalType];
            [alert show];
        }
            break;
#pragma mark  cas 1 是主要监护人
        case 1:
        {
            if ([self.dataArray count]>1)
            {
                
                NSMutableArray *alertArray = [NSMutableArray array];
                
                [NSArray enumerateObjectsWithArray:self.dataArray usingBlock:^(XHFamilyListModel *obj, NSUInteger idx, BOOL *stop)
                 {
                     if (![obj.guardianId isEqualToString:[XHUserInfo sharedUserInfo].guardianModel.guardianId])
                     {
                         XHAlertModel *model = [[XHAlertModel alloc]init];
                         [model setAlertTag:2];
                         [model setName:obj.guardianName];
                         [model setObjectID:obj.guardianId];
                         [alertArray addObject:model];
                     }
                    
                 }];
                
                
                XHAlertControl *alert = [[XHAlertControl alloc]initWithDelegate:self];
                [alert setTitle:@"设定主监护人"];
                [alert setItemArray:alertArray];
                [alert setBoardType:XHAlertBoardOptionType];
                [alert show];
            }
            else
            {
                [XHShowHUD showOKHud:@"主监护人不能解绑"];
            }
        }
            break;
    }
    
    
   
}



#pragma mark 修改孩子之间的关系
-(void)identityControlAction:(BaseButtonControl*)sender
{
    
    NSMutableArray *alertArray = [NSMutableArray array];
    for (int i= 0; i< 3; i++)
    {
        XHAlertModel *model = [[XHAlertModel alloc]init];
        [model setAlertTag:1];
        [model setIdentityType:[NSString stringWithFormat:@"%d",i]];
        switch (i)
        {
            case 0:
            {
                [model setName:@"爸爸"];
            }
                break;
            case 1:
            {
                [model setName:@"妈妈"];
            }
                break;
            case 2:
            {
                [model setName:@"其他"];
            }
                break;
        }
        
        [alertArray addObject:model];
    }
    
    XHAlertControl *alert = [[XHAlertControl alloc]initWithDelegate:self];
    [alert setTitle:@"请选择您的身份"];
    [alert setItemArray:alertArray];
    [alert setBoardType:XHAlertBoardKindType];
    [alert show];
}




#pragma mark - Delegate Method
#pragma mark XHAlertControlDelegate (弹框回调)
-(void)alertBoardControlAction:(XHAlertModel *)sender
{
    [XHShowHUD showTextHud];
    if (sender)
    {
        switch (sender.AlertTag)
        {
#pragma mark - case 1 修改关系
            case 1:
            {
                [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"guardianId"];
                [self.netWorkConfig setObject:sender.identityType forKey:@"type"];
                [self.netWorkConfig postWithUrl:@"zzjt-app-api_studentBinding009" sucess:^(id object, BOOL verifyObject)
                 {
                     if (verifyObject)
                     {
                         [self.identityControl setText:sender.name withNumberType:1 withAllType:NO];
                         
                         [self getFamilyInfo:YES];
                         
                     }
                 } error:^(NSError *error)
                 {
                     [XHShowHUD showOKHud:@"修改关系失败!"];
                 }];
            }
                break;
#pragma mark - case 2 解除绑定
            case 2:
            {
                
                
                [self.netWorkConfig setObject:sender.objectID forKey:@"newGuardianId"];
                [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"oldGuardianId"];
                [self.netWorkConfig postWithUrl:@"zzjt-app-api_studentBinding005" sucess:^(id object, BOOL verifyObject)
                 {
                     if (verifyObject)
                     {
                         
                         [XHShowHUD showOKHud:@"解绑成功!"];
                         [self getFamilyInfo:YES];
                         
                         
                         if ([self.infoDelegate respondsToSelector:@selector(studentInfoControlAction:)])
                         {
                             [self.infoDelegate studentInfoControlAction:3];
                         }
                         
                     }
                 } error:^(NSError *error)
                 {
                     
                 }];
                
            }
                break;
        }
    }
    else
    {
        
        [self.netWorkConfig setObject:[XHUserInfo sharedUserInfo].selfId forKey:@"guardianId"];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_studentBinding006" sucess:^(id object, BOOL verifyObject)
         {
             if (verifyObject)
             {
                 
                 [XHShowHUD showOKHud:@"解绑成功!"];
                 [self getFamilyInfo:YES];
                 
                 if ([self.infoDelegate respondsToSelector:@selector(studentInfoControlAction:)])
                 {
                     [self.infoDelegate studentInfoControlAction:3];
                 }
             }
         } error:^(NSError *error)
         {
             
         }];
        
        
    }
    
    

    
    
}


#pragma mark - Delegate Method
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}




- (XHStudentInfofamilyItemCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XHStudentInfofamilyItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setModel:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


#pragma mark UICollectionViewDelegate
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(SCREEN_WIDTH,60.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark - Getter /  Setter
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    
    //!< 设置基本信息标签Frame
    [self.baseLabel setFrame:CGRectMake(10.0, 0, (frame.size.width-20.0), 40.0)];
    //!< 头像的Frame
    [self.headerControl resetFrame:CGRectMake(0, self.baseLabel.bottom, frame.size.width, 60.0)];
    [self.headerControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.headerControl.height) withNumberType:0 withAllType:NO];
    [self.headerControl resetLineViewFrame:CGRectMake(0, self.headerControl.height-0.5, self.headerControl.width, 0.5) withNumberType:0 withAllType:NO];
    [self.headerControl setImageLayerCornerRadius:(50.0/2.0) withNumberType:0 withAllType:NO];
    //!< 头像
    [self.header resetFrame:CGRectMake(frame.size.width-60.0, (self.headerControl.height-50.0)/2.0, 50.0, 50.0)];
    [self.header setLayerCornerRadius:(self.header.height/2.0)];
    //!< 设置姓名
    [self.nameControl resetFrame:CGRectMake(0, self.headerControl.bottom, frame.size.width, 50.0)];
    [self.nameControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.nameControl.height) withNumberType:0 withAllType:NO];
    [self.nameControl setTitleEdgeFrame:CGRectMake((frame.size.width)/2.0, 0, (frame.size.width-20.0)/2.0, self.nameControl.height) withNumberType:1 withAllType:NO];
    [self.nameControl resetLineViewFrame:CGRectMake(0, self.nameControl.height-0.5, self.nameControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 设置学校
    [self.schoolControl resetFrame:CGRectMake(0, self.nameControl.bottom, frame.size.width, self.nameControl.height)];
    [self.schoolControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.schoolControl.height) withNumberType:0 withAllType:NO];
    [self.schoolControl setTitleEdgeFrame:CGRectMake((frame.size.width)/2.0, 0, (frame.size.width-20.0)/2.0, self.schoolControl.height) withNumberType:1 withAllType:NO];
    [self.schoolControl resetLineViewFrame:CGRectMake(0, self.nameControl.height-0.5, self.nameControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 设置班级
    [self.classControl resetFrame:CGRectMake(0, self.schoolControl.bottom, frame.size.width, self.schoolControl.height)];
    [self.classControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.classControl.height) withNumberType:0 withAllType:NO];
    [self.classControl setTitleEdgeFrame:CGRectMake((frame.size.width)/2.0, 0, (frame.size.width-20.0)/2.0, self.classControl.height) withNumberType:1 withAllType:NO];
    [self.classControl resetLineViewFrame:CGRectMake(0, self.classControl.height-0.5, self.classControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 设置性别
    [self.sexControl resetFrame:CGRectMake(0, self.classControl.bottom, frame.size.width, self.classControl.height)];
    [self.sexControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.sexControl.height) withNumberType:0 withAllType:NO];
    [self.sexControl setTitleEdgeFrame:CGRectMake((frame.size.width)/2.0, 0, (frame.size.width-20.0)/2.0, self.sexControl.height) withNumberType:1 withAllType:NO];
    [self.sexControl resetLineViewFrame:CGRectMake(0, self.sexControl.height-0.5, self.sexControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 设置生日
    [self.birthdayControl resetFrame:CGRectMake(0, self.sexControl.bottom, frame.size.width, self.sexControl.height)];
    [self.birthdayControl setTitleEdgeFrame:CGRectMake(10.0, 0, (frame.size.width-20.0)/2.0, self.birthdayControl.height) withNumberType:0 withAllType:NO];
    [self.birthdayControl setTitleEdgeFrame:CGRectMake((frame.size.width)/2.0, 0, (frame.size.width-20.0)/2.0, self.birthdayControl.height) withNumberType:1 withAllType:NO];
    [self.birthdayControl resetLineViewFrame:CGRectMake(0, self.birthdayControl.height-0.5, self.birthdayControl.width, 0.5) withNumberType:0 withAllType:NO];
    //!< 身份Frame
    [self.identityControl resetFrame:CGRectMake(0, self.birthdayControl.bottom, self.birthdayControl.width, self.birthdayControl.height+20.0)];
    [self.identityControl setTitleEdgeFrame:CGRectMake(10.0, 5, ((frame.size.width-20.0)/2.0), (self.identityControl.height-10.0)) withNumberType:0 withAllType:NO];
    [self.identityControl setTitleEdgeFrame:CGRectMake((frame.size.width/2.0), 5, (((frame.size.width-20.0)/2.0)-40.0), (self.identityControl.height-10.0)) withNumberType:1 withAllType:NO];
    [self.identityControl setImageEdgeFrame:CGRectMake((frame.size.width-30.0), (self.identityControl.height-15.0)/2.0, 15.0, 15.0) withNumberType:0 withAllType:NO];
    [self.identityControl resetLineViewFrame:CGRectMake(0, 0.0, self.identityControl.width, 10.0) withNumberType:0 withAllType:NO];
    [self.identityControl resetLineViewFrame:CGRectMake(0, self.identityControl.height-2.0, self.identityControl.width, 10.0) withNumberType:1 withAllType:NO];
    //!< 设置家长信息
    [self.parentInformationLabel setFrame:CGRectMake(10.0, self.identityControl.bottom, self.baseLabel.width,self.baseLabel.height)];
    
   
    
    
    [self setContentSize:CGSizeMake(frame.size.width, self.parentInformationLabel.bottom)];
    
}



-(UILabel *)baseLabel
{
    if (!_baseLabel)
    {
        _baseLabel = [[UILabel alloc]init];
        [_baseLabel setTextColor:MainColor];
        [_baseLabel setFont:FontLevel2];
        [_baseLabel setText:@"学生信息"];
    }
    return _baseLabel;
}

-(UILabel *)parentInformationLabel
{
    if (!_parentInformationLabel)
    {
        _parentInformationLabel = [[UILabel alloc]init];
        [_parentInformationLabel setTextColor:MainColor];
        [_parentInformationLabel setFont:FontLevel2];
        [_parentInformationLabel setText:@"家长信息"];
    }
    return _parentInformationLabel;
}

-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc]init];
        [_tipLabel setTextColor:RGB(244,128,5)];
        [_tipLabel setFont:FontLevel3A];
        [_tipLabel setText:@"提示：此密码为绑定学生密码"];
    }
    return _tipLabel;
}

-(BaseButtonControl *)headerControl
{
    if (!_headerControl)
    {
        _headerControl = [[BaseButtonControl alloc]init];
        [_headerControl setNumberLabel:1];
        [_headerControl setNumberLineView:1];
        [_headerControl setText:@"头像" withNumberType:0 withAllType:NO];
        [_headerControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_headerControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_headerControl addTarget:self action:@selector(studentInfoControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headerControl setTag:1];
    }
    return _headerControl;
}



-(XHHeaderControl *)header
{
    if (!_header)
    {
        _header = [[XHHeaderControl alloc]init];
    }
    return _header;
}
-(BaseButtonControl *)nameControl
{
    if (!_nameControl)
    {
        _nameControl = [[BaseButtonControl alloc]init];
        [_nameControl setNumberLabel:2];
        [_nameControl setNumberLineView:1];
        [_nameControl setText:@"名字" withNumberType:0 withAllType:NO];
        [_nameControl setText:@"姚立志" withNumberType:1 withAllType:NO];
        [_nameControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_nameControl setFont:FontLevel2A withNumberType:1 withAllType:NO];
        [_nameControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_nameControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_nameControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_nameControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
       
    }
    return _nameControl;
}



-(BaseButtonControl *)schoolControl
{
    if (!_schoolControl)
    {
        _schoolControl = [[BaseButtonControl alloc]init];
        [_schoolControl setNumberLabel:2];
        [_schoolControl setNumberLineView:1];
        [_schoolControl setText:@"学校" withNumberType:0 withAllType:NO];
        [_schoolControl setText:@"北京大学" withNumberType:1 withAllType:NO];
        [_schoolControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_schoolControl setFont:FontLevel2A withNumberType:1 withAllType:NO];
        [_schoolControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_schoolControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_schoolControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_schoolControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
    }
    return _schoolControl;
}

-(BaseButtonControl *)classControl
{
    if (!_classControl)
    {
        _classControl = [[BaseButtonControl alloc]init];
        [_classControl setNumberLabel:2];
        [_classControl setNumberLineView:1];
        [_classControl setText:@"班级" withNumberType:0 withAllType:NO];
        [_classControl setText:@"三年级二班" withNumberType:1 withAllType:NO];
        [_classControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_classControl setFont:FontLevel2A withNumberType:1 withAllType:NO];
        [_classControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_classControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_classControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_classControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
    }
    return _classControl;
}

-(BaseButtonControl *)sexControl
{
    if (!_sexControl)
    {
        _sexControl = [[BaseButtonControl alloc]init];
        [_sexControl setNumberLabel:2];
        [_sexControl setNumberLineView:1];
        [_sexControl setText:@"性别" withNumberType:0 withAllType:NO];
        [_sexControl setText:@"男" withNumberType:1 withAllType:NO];
        [_sexControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_sexControl setFont:FontLevel2A withNumberType:1 withAllType:NO];
        [_sexControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_sexControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_sexControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_sexControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
    }
    return _sexControl;
}

-(BaseButtonControl *)birthdayControl
{
    if (!_birthdayControl)
    {
        _birthdayControl = [[BaseButtonControl alloc]init];
        [_birthdayControl setNumberLabel:2];
        [_birthdayControl setNumberLineView:1];
        [_birthdayControl setText:@"生日" withNumberType:0 withAllType:NO];
        [_birthdayControl setText:@"11/12" withNumberType:1 withAllType:NO];
        [_birthdayControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_birthdayControl setFont:FontLevel2A withNumberType:1 withAllType:NO];
        [_birthdayControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_birthdayControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_birthdayControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_birthdayControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
    }
    return _birthdayControl;
}


-(BaseButtonControl *)identityControl
{
    if (!_identityControl)
    {
        _identityControl = [[BaseButtonControl alloc]init];
        [_identityControl setNumberLabel:2];
        [_identityControl setNumberImageView:1];
        [_identityControl setNumberLineView:2];
        [_identityControl setText:@"您的身份" withNumberType:0 withAllType:NO];
        [_identityControl setText:@"爸爸" withNumberType:1 withAllType:NO];
        [_identityControl setImage:@"ico_identity" withNumberType:0 withAllType:NO];
        [_identityControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_identityControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_identityControl setFont:FontLevel2A withNumberType:1 withAllType:NO];
        [_identityControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_identityControl setTextColor:RGB(51,51,51) withTpe:1 withAllType:NO];
        [_identityControl addTarget:self action:@selector(identityControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _identityControl;
}



-(BaseButtonControl *)passwordControl
{
    if (!_passwordControl)
    {
        _passwordControl = [[BaseButtonControl alloc]init];
        [_passwordControl setNumberLabel:2];
        [_passwordControl setNumberLineView:1];
        [_passwordControl setNumberImageView:1];
        [_passwordControl setText:@"主家长密码" withNumberType:0 withAllType:NO];
        [_passwordControl setText:@"重置密码" withNumberType:1 withAllType:NO];
        [_passwordControl setFont:FontLevel2 withNumberType:0 withAllType:NO];
        [_passwordControl setFont:FontLevel2A withNumberType:1 withAllType:NO];
        [_passwordControl setTextColor:RGB(51,51,51) withTpe:0 withAllType:NO];
        [_passwordControl setTextColor:RGB(102,102,102) withTpe:1 withAllType:NO];
        [_passwordControl setTextAlignment:NSTextAlignmentLeft withNumberType:0 withAllType:NO];
        [_passwordControl setTextAlignment:NSTextAlignmentRight withNumberType:1 withAllType:NO];
        [_passwordControl setImage:@"arr_accessory" withNumberType:0 withAllType:NO];
        [_passwordControl addTarget:self action:@selector(studentInfoControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_passwordControl setTag:2];
        
    }
    return _passwordControl;
}

-(BaseButtonControl *)unBindControl
{
    if (!_unBindControl)
    {
        _unBindControl = [[BaseButtonControl alloc]init];
        [_unBindControl setNumberLabel:1];
        [_unBindControl setTextColor:[UIColor whiteColor] withTpe:0 withAllType:NO];
        [_unBindControl setText:@"解除绑定" withNumberType:0 withAllType:NO];
        [_unBindControl setTextAlignment:NSTextAlignmentCenter withNumberType:0 withAllType:NO];
        [_unBindControl setBackgroundColor:RGB(255,87,87)];
        [_unBindControl addTarget:self action:@selector(unBindControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_unBindControl setTag:3];
    }
    return _unBindControl;
}


-(BaseCollectionView *)familyCollectionView
{
    if (!_familyCollectionView)
    {
        _familyCollectionView = [[BaseCollectionView alloc]init];
        [_familyCollectionView setDelegate:self];
        [_familyCollectionView setDataSource:self];
        [_familyCollectionView registerClass:[XHStudentInfofamilyItemCell class] forCellWithReuseIdentifier:CellIdentifier];
        [_familyCollectionView setBackgroundColor:[UIColor whiteColor]];
        
    }
    return _familyCollectionView;
}

-(XHNetWorkConfig *)netWorkConfig
{
    if (!_netWorkConfig)
    {
        _netWorkConfig = [[XHNetWorkConfig alloc]init];
    }
    return _netWorkConfig;
}


#pragma mark - NetWorkData
-(void)getChildInfo:(XHChildListModel*)model
{
    
    [self.nameControl setText:model.studentName withNumberType:1 withAllType:NO];
    [self.header setHeadrUrl:model.headerUrl withName:model.studentName withType:XHHeaderOtherType];
    [self.schoolControl setText:model.schoolName withNumberType:1 withAllType:NO];
    [self.classControl setText:model.clazzName withNumberType:1 withAllType:NO];
    [self.sexControl setText:model.sexString withNumberType:1 withAllType:NO];
    [self.birthdayControl setText:model.birthdate withNumberType:1 withAllType:NO];
    
    [self.netWorkConfig setObject:model.studentBaseId forKey:@"studentBaseId"];
    
    [self getFamilyInfo:YES];

}

-(void)getFamilyInfo:(BOOL)info
{
    [XHShowHUD showTextHud];
    [self.netWorkConfig postWithUrl:@"zzjt-app-api_studentBinding004" sucess:^(id object, BOOL verifyObject)
     {
         if (verifyObject)
         {
             
             NSArray *familyArray = [object objectItemKey:@"object"];
             if (familyArray)
             {
                 [self.dataArray removeAllObjects];
             }
             @WeakObj(self);
             [NSArray enumerateObjectsWithArray:familyArray usingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop)
              {
                  @StrongObj(self);
                  obj = [obj objectItemKey:@"propValue"];
                  XHFamilyListModel *model = [[XHFamilyListModel alloc]init];
                  [model setItemObject:obj];
                  [self.dataArray addObject:model];
              }];
             
             
             if ([self.dataArray count])
             {
                 [self stretchingWithArray:self.dataArray];
             }
             
             
         }
     } error:^(NSError *error){}];
}



-(void)stretchingWithArray:(NSArray*)array
{
    //!< 设置与孩子关系
    if ([[XHUserInfo sharedUserInfo].guardianType isEqualToString:@"0"])
    {
        [self.identityControl setText:@"爸爸" withNumberType:1 withAllType:NO];
    }
    else if ([[XHUserInfo sharedUserInfo].guardianType isEqualToString:@"1"])
    {
        [self.identityControl setText:@"妈妈" withNumberType:1 withAllType:NO];
    }
    else if ([[XHUserInfo sharedUserInfo].guardianType isEqualToString:@"2"])
    {
        [self.identityControl setText:@"其他" withNumberType:1 withAllType:NO];
    }
    
    [self.familyCollectionView resetFrame:CGRectMake(0, self.parentInformationLabel.bottom, SCREEN_WIDTH, 60.0*[array count])];
    [self.familyCollectionView setItemArray:self.dataArray];
    [self.familyCollectionView reloadData];
    
    
    if ([XHUserInfo sharedUserInfo].isMajor)
    {
        //!< 设置密码
        [self.passwordControl resetFrame:CGRectMake(0, self.familyCollectionView.bottom, self.birthdayControl.width, self.birthdayControl.height)];
        [self.passwordControl setTitleEdgeFrame:CGRectMake(10.0, 0, (self.familyCollectionView.width-20.0)/2.0, self.passwordControl.height) withNumberType:0 withAllType:NO];
        [self.passwordControl setTitleEdgeFrame:CGRectMake((self.familyCollectionView.width)/2.0, 0, ((self.familyCollectionView.width-20.0)/2.0)-30.0, self.passwordControl.height) withNumberType:1 withAllType:NO];
        [self.passwordControl setImageEdgeFrame:CGRectMake((self.passwordControl.width-30.0), (self.passwordControl.height-15.0)/2.0, 15.0, 15.0) withNumberType:0 withAllType:NO];
        [self.passwordControl resetLineViewFrame:CGRectMake(0, self.passwordControl.height-0.5, self.passwordControl.width, 0.5) withNumberType:0 withAllType:NO];
        //!< 设置提醒信息
        [self.tipLabel setFrame:CGRectMake(10.0, self.passwordControl.bottom, self.baseLabel.width,self.baseLabel.height)];
        //!< 设置解绑
        [self.unBindControl resetFrame:CGRectMake(0, self.tipLabel.bottom, self.familyCollectionView.width, 50.0)];
        [self.unBindControl setTitleEdgeFrame:CGRectMake(0, 0, self.unBindControl.width, self.unBindControl.height) withNumberType:0 withAllType:NO];
        
        [self setContentSize:CGSizeMake(self.familyCollectionView.width, self.unBindControl.bottom)];
    }
    else
    {
        [self.unBindControl resetFrame:CGRectMake(0, (self.familyCollectionView.bottom+10.0), self.familyCollectionView.width, 50.0)];
        [self.unBindControl setTitleEdgeFrame:CGRectMake(0, 0, self.unBindControl.width, self.unBindControl.height) withNumberType:0 withAllType:NO];
        
       
    }
    
    
    
     [self setContentSize:CGSizeMake(self.familyCollectionView.width, self.unBindControl.bottom)];
    
    
    
    
    
}




@end
