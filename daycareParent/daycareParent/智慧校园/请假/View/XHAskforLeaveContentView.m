//
//  XHAskforLeaveContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeaveContentView.h"
#import "XHAskforLeaveArrowCell.h" //选择开始时间、结束时间、选择请假孩子等视图
#import "XHAskforLeaveAddPhotoControl.h" //!< 添加图片
#import "XHAskforLeaveChargeTeacherControl.h" //!< 班主任按钮
#import "XHAskforLeaveSubmitControl.h" //!< 提交按钮
#import "XHDatePickerControl.h" //!< 日期选择器
#import "XHAskforLeavePreviewControl.h" //!< 添加的请假照片预览图
#import "CameraManageViewController.h"  //!< 相机管理类
#import "XHTeacherAddressBookViewController.h"
#import "BaseView.h"
#import "XHLeaveRecordViewController.h"//!< 请假列表


@interface XHAskforLeaveContentView () <BaseTextViewDeletage,XHDatePickerControlDeletage,XHAskforLeavePreviewControlDeletage,CameraManageDeletage>

@property (nonatomic,strong) UIAlertController *alertController; //!< 弹出框视图控制器
@property (nonatomic,strong) BaseViewController *viewController;
@property (nonatomic,strong) UILabel *limitLabel; //!< 输入内容限制
@property (nonatomic,strong) BaseView *topAccessoryView;   //!< 顶部附件视图
@property (nonatomic,strong) BaseView *bottomAccessoryView;   //!< 底部附件视图
@property (nonatomic,strong) XHAskforLeaveArrowCell *childOptionsControl;   //!< 孩子选项
@property (nonatomic,strong) BaseTextView *reasonTextView;  //!< 原因输入文本域
@property (nonatomic,strong) XHAskforLeaveAddPhotoControl *addPhotoControl;   //!< 添加照片选项
@property (nonatomic,strong) XHAskforLeaveArrowCell *startTimeControl;   //!< 开始时间选项
@property (nonatomic,strong) XHAskforLeaveArrowCell *endTimeControl;   //!< 开始时间选项
@property (nonatomic,strong) XHAskforLeaveChargeTeacherControl *chargeTeacherControl;   //!< 班主任
@property (nonatomic,strong) XHAskforLeaveChargeTeacherControl *otherControl;   //!< 相关人员
@property (nonatomic,strong) XHAskforLeaveSubmitControl *submitControl;   //!< 提交

@property (nonatomic,assign) NSInteger selectTimeControl; //!< 记录选择的是哪个时间选择器


@end


@implementation XHAskforLeaveContentView

-(instancetype)initWithObject:(BaseViewController*)object
{
    self = [super init];
    if (self)
    {
        [self setViewController:object];
        [self addSubview:self.topAccessoryView];
        [self addSubview:self.childOptionsControl];
        [self addSubview:self.reasonTextView];
        [self addSubview:self.addPhotoControl];
        [self addSubview:self.limitLabel];
        [self addSubview:self.startTimeControl];
        [self addSubview:self.endTimeControl];
        [self addSubview:self.bottomAccessoryView];
        [self addSubview:self.chargeTeacherControl];
        [self addSubview:self.otherControl];
        [self addSubview:self.submitControl];
        
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self addSubViews:YES];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.topAccessoryView resetFrame:CGRectMake(0, 0, frame.size.width, 10.0)];
    [self.childOptionsControl resetFrame:CGRectMake(self.topAccessoryView.left, self.topAccessoryView.bottom, frame.size.width, 60.0)];
    [self.reasonTextView resetFrame:CGRectMake(10.0, self.childOptionsControl.bottom+10.0, frame.size.width-20.0, 60.0)];
    [self.addPhotoControl resetFrame:CGRectMake(self.reasonTextView.left, self.reasonTextView.bottom+10.0, 70.0, 70.0)];
    [self.limitLabel setFrame:CGRectMake(self.addPhotoControl.right, self.addPhotoControl.bottom-20.0, frame.size.width-self.addPhotoControl.right-20.0, 20.0)];
    [self.startTimeControl resetFrame:CGRectMake(self.topAccessoryView.left, self.addPhotoControl.bottom+10.0, frame.size.width, self.childOptionsControl.height)];
    [self.endTimeControl resetFrame:CGRectMake(self.startTimeControl.left, self.startTimeControl.bottom, self.startTimeControl.width, self.startTimeControl.height)];
    [self.bottomAccessoryView resetFrame:CGRectMake(self.topAccessoryView.left,self.endTimeControl.bottom,self.topAccessoryView.width, self.topAccessoryView.height)];
    [self.chargeTeacherControl resetFrame:CGRectMake(self.bottomAccessoryView.left, self.bottomAccessoryView.bottom, 80.0, 105)];
    [self.otherControl resetFrame:CGRectMake(self.chargeTeacherControl.right, self.chargeTeacherControl.top, self.chargeTeacherControl.width, self.chargeTeacherControl.height)];
    [self.submitControl resetFrame:CGRectMake(10, self.chargeTeacherControl.bottom+20.0, (frame.size.width-20.0), 40.0)];
    [self setContentSize:CGSizeMake(frame.size.width, self.submitControl.bottom+20.0)];
    
    
  
}


#pragma mark - Action Method
-(void)controlAction:(UIControl*)sender
{
    [self.reasonTextView resignFirstResponder];
    switch (sender.tag)
    {
#pragma mark case 1 选择孩子
        case 1:
        {
            
            [self.viewController presentViewController:self.alertController animated:YES completion:^{}];
        }
            break;
#pragma mark case 2 添加图片
        case 2:
        {
            [self addphototAction:sender];
        }
            break;
#pragma mark case 3 开始时间
        case 3:
#pragma mark case 4 结束时间
        case 4:
        {
            [self setSelectTimeControl:sender.tag];
            [[XHDatePickerControl sharedObject] showWithDeletage:self];
        }
            break;
#pragma mark case 5  班主任
        case 5:
        {
            XHTeacherAddressBookViewController *teacherAddressBook = [[XHTeacherAddressBookViewController alloc]init];
            [teacherAddressBook setModel:self.childOptionsControl.model];
            [self.viewController.navigationController pushViewController:teacherAddressBook animated:YES];
            teacherAddressBook.didselectBack = ^(XHTeacherAddressBookFrame *itemObject)
            {
                [self.chargeTeacherControl setTeacherAddressBook:itemObject];
            };
        }
            break;
#pragma mark case 6 相关人
        case 6:
        {
            XHTeacherAddressBookViewController *teacherAddressBook = [[XHTeacherAddressBookViewController alloc]init];
            [teacherAddressBook setModel:self.childOptionsControl.model];
            [self.viewController.navigationController pushViewController:teacherAddressBook animated:YES];
            teacherAddressBook.didselectBack = ^(XHTeacherAddressBookFrame *itemObject)
            {
                [self.otherControl setTeacherAddressBook:itemObject];
            };
        }
            break;
#pragma mark case 7 提交
        case 7:
        {
            [self uploadImageWithImage:self.addPhotoControl.image withImageName:[XHHelper createGuid] WithContent:self.reasonTextView.text withBeginTime:self.startTimeControl.describe withEndTime:self.endTimeControl.describe withActorId:[XHUserInfo sharedUserInfo].guardianModel.guardianId withStudentBaseId:self.childOptionsControl.model.studentBaseId withShr:self.chargeTeacherControl.teacherAddressBook.model.ID withCsr:self.otherControl.teacherAddressBook.model.ID];
            
        }
            break;
    }
}


-(void)addphototAction:(UIControl*)sender
{
    if (self.addPhotoControl.isAddImage)
    {
        [[XHAskforLeavePreviewControl sharedObject] showWithImage:self.addPhotoControl.image withDeletage:self];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"选择相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)
        {
            CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeCamera setDeletate:self];
            [self.viewController.navigationController presentViewController:manager animated:YES completion:^{}];
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"选择相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
        {
            CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeSavedPhotosAlbum setDeletate:self];
            [self.viewController.navigationController presentViewController:manager animated:YES completion:^{}];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}]];
        [self.viewController presentViewController:alertController animated:YES completion:^{}];
    }
}



-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [[XHUserInfo sharedUserInfo].childListArry enumerateObjectsUsingBlock:^(XHChildListModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             if (idx == 0)
             {
                 [obj setMarkType:ChildListSelectType];
                 [self.childOptionsControl setModel:obj];
             }
             else
             {
                 [obj setMarkType:ChildListNormalType];
             }
             
             UIAlertAction *action = [UIAlertAction actionWithTitle:obj.studentName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
             {
                 [[XHUserInfo sharedUserInfo].childListArry enumerateObjectsUsingBlock:^(XHChildListModel *obj, NSUInteger itemidx, BOOL * _Nonnull stop)
                  {
                      [self.chargeTeacherControl reset];
                      [self.otherControl reset];
                      [self.reasonTextView reset];
                      
                      
                      if (idx == itemidx)
                      {
                          [obj setMarkType:ChildListSelectType];
                          [self.childOptionsControl setModel:obj];
                      }
                      else
                      {
                          [obj setMarkType:ChildListNormalType];
                      }
                      
                  }];
                 
             }];
             
             [self.alertController addAction:action];
         }];
    }
}




#pragma mark - Deletage Method
#pragma mark BaseTextViewDeletage
- (void)textViewDidChange:(UITextView *)textView
{
    //实时显示字数
    [self.limitLabel setText:[NSString stringWithFormat:@"%lu/200", (unsigned long)textView.text.length]];
    
    //字数限制操作
    if (textView.text.length >= 200)
    {
        
        textView.text = [textView.text substringToIndex:200];
        [self.limitLabel setText:@"200/200"];
        
    }
}


#pragma mark XHDatePickerControlDeletage
-(void)datePickerClickObject:(NSString *)date
{
    switch (self.selectTimeControl)
    {
        case 3:
        {
            [self.startTimeControl setDescribe:date];
        }
            break;
        case 4:
        {
            [self.endTimeControl setDescribe:date];
            
        }
            break;
    }
}

#pragma mark XHAskforLeavePreviewControlDeletage
-(void)askforLeavePreviewControlAction:(UIImage*)image
{
    [self.addPhotoControl setImage:image];
}


#pragma mark CameraManageDeletage
-(void)imagePickerControllerdidFinishPickingMediaWithImage:(nonnull UIImage*)image
{
    [self.addPhotoControl setImage:image];
}











#pragma mark - NetWoth Method
-(void)uploadImageWithImage:(UIImage*)image  //!< 图片
              withImageName:(NSString*)imageName  //!< 图片名称
                WithContent:(NSString*)content  //!< 请假内容
              withBeginTime:(NSString*)beginTime  //!< 开始时间
                withEndTime:(NSString*)endTime  //!< 结束时间
                withActorId:(NSString*)actorId   //!< 申请人ID（家长Id）
          withStudentBaseId:(NSString*)studentBaseId //!< 学生ID
                    withShr:(NSString*)shr //!< 班主任ID
                    withCsr:(NSString*)csr //!< 相关人ID（多位以逗号拼接）
{
    if (image)
    {
        [XHHelper uploadImage:image name:imageName uploadCallback:^(BOOL success, NSError *error)
         {
             if (success)
             {
                 [self submitAskforLeaveWithContent:content withBeginTime:beginTime withEndTime:endTime withPicUrl:imageName withActorId:actorId withStudentBaseId:studentBaseId withShr:shr withCsr:csr];
             }
        
             
         } withProgressCallback:^(float progress)
         {
         }];
    }
    else
    {
         [self submitAskforLeaveWithContent:content withBeginTime:beginTime withEndTime:endTime withPicUrl:@"" withActorId:actorId withStudentBaseId:studentBaseId withShr:shr withCsr:csr];
    }
}



-(void)submitAskforLeaveWithContent:(NSString*)content  //!< 请假内容
                      withBeginTime:(NSString*)beginTime  //!< 开始时间
                        withEndTime:(NSString*)endTime  //!< 结束时间
                         withPicUrl:(NSString*)picUrl  //!< 图片url地址
                        withActorId:(NSString*)actorId   //!< 申请人ID（家长Id）
                  withStudentBaseId:(NSString*)studentBaseId //!< 学生ID
                            withShr:(NSString*)shr //!< 班主任ID
                            withCsr:(NSString*)csr //!< 相关人ID（多位以逗号拼接）
{
    if ([[NSString safeString:content] isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"内容不能为空"];
    }
    else if ([[NSString safeString:studentBaseId] isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"请选择孩子"];
    }
    else if ([[NSString safeString:beginTime] isEqualToString:@"请选择"])
    {
        [XHShowHUD showNOHud:@"请选择开始时间"];
    }
    else if ([[NSString safeString:endTime] isEqualToString:@"请选择"])
    {
        [XHShowHUD showNOHud:@"请选择结束时间"];
    }
    else if ([[NSString safeString:beginTime] isEqualToString:endTime])
    {
        [XHShowHUD showNOHud:@"开始结束时间不能相同"];
    }
    else if ([beginTime compare:endTime] == NSOrderedDescending)
    {
        [XHShowHUD showNOHud:@"开始时间不能晚于结束时间"];
    }
    else if ([[NSString safeString:shr] isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"请选择审批人"];
    }
    else
    {
        if (![[NSString safeString:picUrl] isEqualToString:@""])
        {
            [self.netWorkConfig setObject:picUrl forKey:@"picUrl"];
        }
        if (![[NSString safeString:csr] isEqualToString:@""])
        {
            [self.netWorkConfig setObject:csr forKey:@"csr"];
        }
        [self.netWorkConfig setObject:content forKey:@"content"];
        [self.netWorkConfig setObject:beginTime forKey:@"beginTime"];
        [self.netWorkConfig setObject:endTime forKey:@"endTime"];
        [self.netWorkConfig setObject:actorId forKey:@"actorId"];
        [self.netWorkConfig setObject:studentBaseId forKey:@"studentBaseId"];
        [self.netWorkConfig setObject:shr forKey:@"shr"];
        [XHShowHUD showTextHud];
        [self.netWorkConfig postWithUrl:@"zzjt-app-api_smartCampus008" sucess:^(id object, BOOL verifyObject)
         {
             if (verifyObject)
             {
                 XHLeaveRecordViewController *leaveRecord=[[XHLeaveRecordViewController alloc] init];
                 [leaveRecord setModel:self.childOptionsControl.model];
                 [self.viewController.navigationController popViewControllerAnimated:YES];
             }
         } error:^(NSError *error){}];
    }
}




#pragma mark - Getter / Setter
#pragma mark 请假孩子
-(XHAskforLeaveArrowCell *)childOptionsControl
{
    if (_childOptionsControl == nil)
    {
        _childOptionsControl = [[XHAskforLeaveArrowCell alloc]init];
        [_childOptionsControl setTitle:@"请假孩子"];
        [_childOptionsControl setImageName:@"ico_arrow"];
        [_childOptionsControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_childOptionsControl setTag:1];
    }
    return _childOptionsControl;
}


#pragma mark 请输入请假理由
-(BaseTextView *)reasonTextView
{
    if (_reasonTextView == nil)
    {
        _reasonTextView = [[BaseTextView alloc]init];
        [_reasonTextView setPlaceholder:@"请输入请假理由"];
        [_reasonTextView setTintColor:MainColor];
        [_reasonTextView setTextDeletage:self];
    }
    return _reasonTextView;
}




#pragma mark 添加图片
-(XHAskforLeaveAddPhotoControl *)addPhotoControl
{
    if (_addPhotoControl == nil)
    {
        _addPhotoControl = [[XHAskforLeaveAddPhotoControl alloc]init];
        [_addPhotoControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addPhotoControl setTag:2];
    }
    return _addPhotoControl;
}



#pragma mark 字数限制
-(UILabel *)limitLabel
{
    if (_limitLabel == nil)
    {
        _limitLabel = [[UILabel alloc]init];
        [_limitLabel setTextAlignment:NSTextAlignmentRight];
        [_limitLabel setFont:FontLevel4];
        [_limitLabel setTextColor:RGB(64, 64, 64)];
        [_limitLabel setText:@"0/200"];
    }
    return _limitLabel;
}


#pragma mark 开始时间
-(XHAskforLeaveArrowCell *)startTimeControl
{
    if (_startTimeControl == nil)
    {
        _startTimeControl = [[XHAskforLeaveArrowCell alloc]init];
        [_startTimeControl setImageName:@"ico_arrow"];
        [_startTimeControl setTitle:@"开始时间"];
        [_startTimeControl setDescribe:@"请选择"];
        [_startTimeControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_startTimeControl setTag:3];
        
    }
    return _startTimeControl;
}


#pragma mark 结束时间
-(XHAskforLeaveArrowCell *)endTimeControl
{
    if (_endTimeControl == nil)
    {
        _endTimeControl = [[XHAskforLeaveArrowCell alloc]init];
        [_endTimeControl setImageName:@"ico_arrow"];
        [_endTimeControl setTitle:@"结束时间"];
        [_endTimeControl setDescribe:@"请选择"];
        [_endTimeControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_endTimeControl setTag:4];
    }
    return _endTimeControl;
}


#pragma mark 班主任
-(XHAskforLeaveChargeTeacherControl *)chargeTeacherControl
{
    if (_chargeTeacherControl == nil)
    {
        _chargeTeacherControl = [[XHAskforLeaveChargeTeacherControl alloc]init];
        [_chargeTeacherControl setTitle:@"班主任"];
        [_chargeTeacherControl setImaeg:[UIImage imageNamed:@"addman"]];
        [_chargeTeacherControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_chargeTeacherControl setTag:5];
    }
    return _chargeTeacherControl;
}




#pragma mark 相关人
-(XHAskforLeaveChargeTeacherControl *)otherControl
{
    if (_otherControl == nil)
    {
        _otherControl = [[XHAskforLeaveChargeTeacherControl alloc]init];
        [_otherControl setTitle:@"相关人"];
        [_otherControl setImaeg:[UIImage imageNamed:@"addman"]];
        [_otherControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_otherControl setTag:6];
    }
    return _otherControl;
}


#pragma mark 提交
-(XHAskforLeaveSubmitControl *)submitControl
{
    if (_submitControl == nil)
    {
        _submitControl = [[XHAskforLeaveSubmitControl alloc]init];
        [_submitControl setBackgroundColor:MainColor];
        [_submitControl setTitle:@"提交"];
        [_submitControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_submitControl setTag:7];
    }
    return _submitControl;
}


-(BaseView *)topAccessoryView
{
    if (_topAccessoryView == nil)
    {
        _topAccessoryView = [[BaseView alloc]init];
        [_topAccessoryView setBackgroundColor:RGB(243, 243, 243)];
    }
    return _topAccessoryView;
}

-(BaseView *)bottomAccessoryView
{
    if (_bottomAccessoryView == nil)
    {
        _bottomAccessoryView = [[BaseView alloc]init];
        [_bottomAccessoryView setBackgroundColor:RGB(243, 243, 243)];
    }
    return _bottomAccessoryView;
}


#pragma mark 孩子列表
-(UIAlertController *)alertController
{
    if (!_alertController)
    {
        _alertController = [UIAlertController alertControllerWithTitle:@"孩子列表" message:@"选择孩子" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){}];
        
        [_alertController addAction:action];
    }
    return _alertController;
}


-(XHNetWorkConfig *)netWorkConfig
{
    if (!_netWorkConfig)
    {
        _netWorkConfig = [[XHNetWorkConfig alloc]init];
    }
    return _netWorkConfig;
}


@end
