//
//  XHAskforLeaveContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeaveContentView.h"
#import "XHAskforLeaveArrowCell.h" //选择开始时间、结束时间、选择请假学生等视图
#import "XHAskforLeaveChargeTeacherControl.h" //!< 班主任按钮
#import "XHAskforLeaveSubmitControl.h" //!< 提交按钮
#import "XHDatePickerControl.h" //!< 日期选择器
#import "XHAskforLeavePreviewControl.h" //!< 添加的请假照片预览图
#import "CameraManageViewController.h"  //!< 相机管理类
#import "XHTeacherAddressBookViewController.h"
#import "BaseView.h"
#import "XHLeaveRecordViewController.h"//!< 请假列表
#import "XHLoseSubjectView.h"//!<  缺失课程显示
#import "XHSubjectModel.h"
#import "XHSubmitView.h"//!<  提交按钮视图
#import "XHRecipientModel.h"
#import "XHCustomPickerView.h"//!<请假类型
#import "XHDatePicker.h"//!< 日期选择器
@interface XHAskforLeaveContentView () <BaseTextViewDeletage,XHDatePickerDelegate,XHAskforLeavePreviewControlDeletage,CameraManageDeletage,XHCustomPickerViewDelegate,XHSubmitViewDelegate,XHDatePickerControlDeletage>

@property (nonatomic,strong) UIAlertController *alertController; //!< 弹出框视图控制器
@property (nonatomic,weak) BaseViewController *viewController;
@property (nonatomic,strong) UILabel *limitLabel; //!< 输入内容限制
@property (nonatomic,strong) BaseView *topAccessoryView;   //!< 顶部附件视图
@property (nonatomic,strong) BaseView *middleAccessoryView;   //!< 中部附件视图
@property (nonatomic,strong) BaseView *bottomAccessoryView;   //!< 底部附件视图

@property (nonatomic,strong) XHAskforLeaveArrowCell *childOptionsControl;   //!< 请假学生
@property (nonatomic,strong) XHAskforLeaveArrowCell *askforLeaveTypeControl;   //!<请假类型
@property (nonatomic,strong) UILabel *reasonTitleLabel;   //!<请假标题
@property (nonatomic,strong) BaseTextView *reasonTextView;  //!< 原因输入文本域
@property (nonatomic,strong) XHAskforLeaveArrowCell *startTimeControl;   //!< 开始时间选项
@property (nonatomic,strong) XHAskforLeaveArrowCell *endTimeControl;   //!< 开始时间选项
@property (nonatomic,strong) XHAskforLeaveArrowCell *timeControl;   //!< 输入时长选项
@property (nonatomic,strong) UILabel *timeLabel;   //!<时长说明
@property (nonatomic,strong) XHLoseSubjectView *loseSubjectView;   //!<缺失课程显示
@property (nonatomic,strong) XHAskforLeaveChargeTeacherControl *chargeTeacherControl;   //!< 班主任
@property (nonatomic,strong) XHAskforLeaveChargeTeacherControl *otherControl;   //!< 相关人员
@property (nonatomic,strong) XHAskforLeaveSubmitControl *submitControl;   //!< 提交
@property (nonatomic,strong) XHSubmitView *submitView;   //!< 提交视图
@property (nonatomic,assign) NSInteger selectTimeControl; //!< 记录选择的是哪个时间选择器
@property(nonatomic,strong)XHCustomPickerView *pickerView;//!<选择请假类型
@property(nonatomic,copy)NSString *bizType;//!<选择请假类型
@end


@implementation XHAskforLeaveContentView

-(instancetype)initWithObject:(BaseViewController*)object
{
    self = [super init];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        [self setViewController:object];
        [self addSubview:self.topAccessoryView];
        [self addSubview:self.childOptionsControl];
        [self addSubview:self.askforLeaveTypeControl];
        [self addSubview:self.reasonTitleLabel];
        [self addSubview:self.reasonTextView];
        [self addSubview:self.addPhotoControl];
        [self addSubview:self.limitLabel];
        [self addSubview:self.startTimeControl];
        [self addSubview:self.endTimeControl];
        [self addSubview:self.timeControl];
        [self addSubview:self.timeLabel];
        [self addSubview:self.middleAccessoryView];
        [self addSubview:self.loseSubjectView];
        [self addSubview:self.bottomAccessoryView];
        [self addSubview:self.submitView];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self addSubViews:YES];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.childOptionsControl resetFrame:CGRectMake(0, 0, frame.size.width, 60.0)];
    [self.askforLeaveTypeControl resetFrame:CGRectMake(self.childOptionsControl.left, self.childOptionsControl.bottom, frame.size.width, 60.0)];
    [self.topAccessoryView resetFrame:CGRectMake(0, self.askforLeaveTypeControl.bottom, frame.size.width, 10.0)];
    [self.reasonTitleLabel setFrame:CGRectMake(15.0, self.topAccessoryView.bottom, frame.size.width-20.0, 30.0)];
    [self.reasonTextView resetFrame:CGRectMake(10.0, self.reasonTitleLabel.bottom, frame.size.width-20.0, 60.0)];
    [self.addPhotoControl resetFrame:CGRectMake(self.reasonTextView.left+5, self.reasonTextView.bottom+10.0, 70.0, 70.0)];
    [self.limitLabel setFrame:CGRectMake(self.addPhotoControl.right, self.addPhotoControl.bottom-20.0, frame.size.width-self.addPhotoControl.right-20.0, 20.0)];
    [self.startTimeControl resetFrame:CGRectMake(self.topAccessoryView.left, self.addPhotoControl.bottom+10.0, frame.size.width, self.childOptionsControl.height)];
    [self.endTimeControl resetFrame:CGRectMake(self.startTimeControl.left, self.startTimeControl.bottom, self.startTimeControl.width, self.startTimeControl.height)];
     [self.timeControl resetFrame:CGRectMake(self.endTimeControl.left, self.endTimeControl.bottom, self.endTimeControl.width, self.endTimeControl.height)];
    [self.timeLabel setFrame:CGRectMake(15,self.timeControl.bottom,self.topAccessoryView.width-20, 40)];
    [self.middleAccessoryView resetFrame:CGRectMake(self.topAccessoryView.left,self.timeLabel.bottom,self.topAccessoryView.width, self.topAccessoryView.height)];
    [self.loseSubjectView resetFrame:CGRectMake(0, self.middleAccessoryView.bottom, self.middleAccessoryView.width, 90)];
    
    [self.bottomAccessoryView resetFrame:CGRectMake(self.topAccessoryView.left,self.loseSubjectView.bottom,self.topAccessoryView.width, self.topAccessoryView.height)];
     [self.submitView resetFrame:CGRectMake(0, self.bottomAccessoryView.bottom, frame.size.width, 190.0)];
    [self.submitView.submitButton setTag:7];
    [self.submitView.submitButton addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setContentSize:CGSizeMake(frame.size.width, self.submitView.bottom+20.0)];
    
    
  
}


#pragma mark - Action Method
-(void)controlAction:(UIControl*)sender
{
    [self.reasonTextView resignFirstResponder];
    switch (sender.tag)
    {
#pragma mark case 1 请假学生
        case 1:
        {
            
            [self.viewController presentViewController:self.alertController animated:YES completion:^{}];
        }
            break;
   #pragma mark case 2 请假类型
            case 2:
        {
            [self.pickerView show];
        }
            break;
#pragma mark case 3 添加图片
        case 3:
        {
            [self addphototAction:sender];
        }
            break;
#pragma mark case 4 开始时间
        case 4:
#pragma mark case 5 结束时间
        case 5:
        {
            [self setSelectTimeControl:sender.tag];
            [[XHDatePickerControl sharedObject] showWithDeletage:self];
        }
            break;
#pragma mark case 6  请假时长
            case 6:
        {
           UIAlertController *alertController= [UIAlertController addtextFeildWithmessage:@"请输入请假时长" controller:self.viewController indexBlock:^(NSInteger index, id object) {
               if (![NSString times:@"0.5" withMultiple:object])
               {
                   [XHShowHUD showNOHud:@"天数最小单位为0.5"];
                   return ;
               }
                [self.timeControl setDescribe:[NSString stringWithFormat:@"%@天",object]];
                [self.netWorkConfig setObject:object forKey:@"bizDays"];
               self.timeControl.describeLabel.textColor=RGB(51, 51, 51);
            }];
alertController.textFields.firstObject.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        }
            break;
#pragma mark case 7 提交
        case 7:
        {
            [self uploadImageWithImage:self.addPhotoControl.image withImageName:[XHHelper createGuid] WithContent:self.reasonTextView.text withBeginTime:self.startTimeControl.describe withEndTime:self.endTimeControl.describe withBizDays:self.timeControl.describe withActorId:[XHUserInfo sharedUserInfo].guardianModel.guardianId withStudentBaseId:self.childOptionsControl.model.studentBaseId withBizType:self.bizType withCsr:self.submitView.teacherId];
            
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
            CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeCamera setDeletate:self.viewController];
            [self.viewController presentViewController:manager animated:YES completion:^{}];
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"选择相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
        {
            CameraManageViewController *manager=[[CameraManageViewController alloc] initWithCameraManageWithType:SourceTypeSavedPhotosAlbum setDeletate:self.viewController];
            [self.viewController presentViewController:manager animated:YES completion:^{}];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}]];
        [self.viewController presentViewController:alertController animated:YES completion:^{}];
    }
}



-(void)addSubViews:(BOOL)subview
{
    if (subview)
    {
        [self setBizType:@"0"];
        [[XHUserInfo sharedUserInfo].childListArry enumerateObjectsUsingBlock:^(XHChildListModel *obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             if (idx == 0)
             {
                 [obj setMarkType:ChildListSelectType];
                 [self.childOptionsControl setModel:obj];
                 [self.submitView setClassid:obj.clazzId];
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
                          [self.submitView setClassid:obj.clazzId];
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
        case 4:
        {
            [self.startTimeControl setDescribe:date];
            self.startTimeControl.describeLabel.textColor=RGB(51, 51, 51);
        }
            break;
        case 5:
        {
            [self.endTimeControl setDescribe:date];
            self.endTimeControl.describeLabel.textColor=RGB(51, 51, 51);
        }
            break;
    }
    
    if (![self.startTimeControl.describe isEqualToString:@"请选择"]&&![self.endTimeControl.describe isEqualToString:@"请选择"]) {
        [self getLoseSubject];
    }
}

#pragma mark  请假类型Delegate
-(void)getItemObject:(NSString *)itemObject atItemIndex:(NSInteger)index
{
    [self.askforLeaveTypeControl setDescribe:itemObject];
    if ([itemObject isEqualToString:@"事假"]) {
        self.bizType=@"0";
    }
    if ([itemObject isEqualToString:@"病假"]) {
        self.bizType=@"3";
    }
}
#pragma mark  submitDelegate
-(void)getItemObject:(NSString *)ItemObject
{
    NSLog(@"=====%@",ItemObject);
    self.submitView.teacherId=ItemObject;
}
#pragma mark XHAskforLeavePreviewControlDeletage
-(void)askforLeavePreviewControlAction:(UIImage*)image
{
    [self.addPhotoControl setImage:image];
}


#pragma mark - NetWoth Method
-(void)uploadImageWithImage:(UIImage*)image  //!< 图片
              withImageName:(NSString*)imageName  //!< 图片名称
                WithContent:(NSString*)content  //!< 请假内容
              withBeginTime:(NSString*)beginTime  //!< 开始时间
                withEndTime:(NSString*)endTime  //!< 结束时间
               withBizDays:(NSString *)bizDays //!< 请假时长
                withActorId:(NSString*)actorId   //!< 申请人ID（家长Id）
          withStudentBaseId:(NSString*)studentBaseId //!< 学生ID
                    withBizType:(NSString*)bizType //!< 请假类型
                    withCsr:(NSString*)csr //!< 相关人ID（多位以逗号拼接）
{
    if (image)
    {
        [XHHelper uploadImage:image name:imageName uploadCallback:^(BOOL success, NSError *error)
         {
             if (success)
             {
                 [self submitAskforLeaveWithContent:content withBeginTime:beginTime withEndTime:endTime withBizDays:bizDays withPicUrl:imageName withActorId:actorId withStudentBaseId:studentBaseId withBizType:bizType withCsr:csr];
             }
        
             
         } withProgressCallback:^(float progress)
         {
         }];
    }
    else
    {
        [self submitAskforLeaveWithContent:content withBeginTime:beginTime withEndTime:endTime withBizDays:self.timeControl.describe withPicUrl:@"" withActorId:actorId withStudentBaseId:studentBaseId withBizType:bizType withCsr:csr];
    }
}



-(void)submitAskforLeaveWithContent:(NSString*)content  //!< 请假内容
                      withBeginTime:(NSString*)beginTime  //!< 开始时间
                        withEndTime:(NSString*)endTime  //!< 结束时间
                       withBizDays:(NSString *)bizDays//!< 请假时长
                         withPicUrl:(NSString*)picUrl  //!< 图片url地址
                        withActorId:(NSString*)actorId   //!< 申请人ID（家长Id）
                  withStudentBaseId:(NSString*)studentBaseId //!< 学生ID
                            withBizType:(NSString*)bizType //!< 请假类型
                            withCsr:(NSString*)csr //!< 相关人ID（多位以逗号拼接）
{
    if ([[NSString safeString:content] isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"内容不能为空"];
    }
    else if ([[NSString safeString:bizType] isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"请选择请假类型"];
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
//    else if ([[NSString safeString:beginTime] isEqualToString:endTime])
//    {
//        [XHShowHUD showNOHud:@"开始结束时间不能相同"];
//    }
    else if ([beginTime compare:endTime] == NSOrderedDescending)
    {
        [XHShowHUD showNOHud:@"开始时间不能晚于结束时间"];
    }
    else if ([[NSString safeString:bizDays] isEqualToString:@"请输入时长"])
    {
        [XHShowHUD showNOHud:@"请选择请假时长"];
    }
    else if ([[NSString safeString:csr] isEqualToString:@""])
    {
        [XHShowHUD showNOHud:@"请选择接收人"];
    }
    else
    {
        if (![[NSString safeString:picUrl] isEqualToString:@""])
        {
            [self.netWorkConfig setObject:picUrl forKey:@"picUrl"];
        }
        [self.netWorkConfig setObject:studentBaseId forKey:@"studentBaseId"];
        [self.netWorkConfig setObject:bizType forKey:@"bizType"];
        [self.netWorkConfig setObject:content forKey:@"content"];
        [self.netWorkConfig setObject:beginTime forKey:@"beginTime"];
        [self.netWorkConfig setObject:endTime forKey:@"endTime"];
        [self.netWorkConfig setObject:csr forKey:@"csr"];
        [self.netWorkConfig setObject:actorId forKey:@"actorId"];
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
-(void)getLoseSubject
{
    XHNetWorkConfig *netWork=[XHNetWorkConfig new];
    [netWork setObject:self.childOptionsControl.model.clazzId forKey:@"clazzId"];
    kNSLog(self.startTimeControl.describe);
    kNSLog(self.endTimeControl.describe);
    [netWork setObject:[NSString safeString:self.startTimeControl.describe] forKey:@"beginTime"];
      [netWork setObject:[NSString safeString:self.endTimeControl.describe] forKey:@"endTime"];
    [netWork postWithUrl:@"zzjt-app-api_bizInfo007" sucess:^(id object, BOOL verifyObject) {
        if (verifyObject) {
            NSMutableArray *loseSubJect=[[NSMutableArray alloc] init];
            NSArray *arry=[object objectItemKey:@"object"];
            for (NSDictionary *dic in arry) {
                NSDictionary *Dic=[dic objectItemKey:@"propValue"];
                XHSubjectModel *model=[[XHSubjectModel alloc] initWithDic:Dic];
                [loseSubJect addObject:model];
            }
            [self.loseSubjectView setItemArry:loseSubJect];
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - Getter / Setter
#pragma mark 请假学生
-(XHAskforLeaveArrowCell *)childOptionsControl
{
    if (_childOptionsControl == nil)
    {
        _childOptionsControl = [[XHAskforLeaveArrowCell alloc]init];
        [_childOptionsControl setTitle:@"请假学生"];
        [_childOptionsControl setImageName:@"ico_arrow"];
        [_childOptionsControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_childOptionsControl setTag:1];
    }
    return _childOptionsControl;
}

#pragma mark 请假类型
-(XHAskforLeaveArrowCell *)askforLeaveTypeControl
{
    if (_askforLeaveTypeControl == nil)
    {
        _askforLeaveTypeControl = [[XHAskforLeaveArrowCell alloc]init];
        [_askforLeaveTypeControl setTitle:@"请假类型"];
        [_askforLeaveTypeControl setDescribe:@"事假"];
        _askforLeaveTypeControl.topLineView.hidden=YES;
        [_askforLeaveTypeControl setImageName:@"ico_arrow"];
        [_askforLeaveTypeControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_askforLeaveTypeControl setTag:2];
    }
    return _askforLeaveTypeControl;
}
#pragma mark 请假理由
-(UILabel *)reasonTitleLabel
{
    if (_reasonTitleLabel==nil) {
        _reasonTitleLabel=[[UILabel alloc] init];
        _reasonTitleLabel.textAlignment=NSTextAlignmentLeft;
        _reasonTitleLabel.textColor=RGB(51, 51, 51);
        [_reasonTitleLabel setFont:kFont(15.0)];
        _reasonTitleLabel.text=@"请假理由";
    }
    return _reasonTitleLabel;
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
        [_addPhotoControl setTag:3];
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
        _startTimeControl.describeLabel.textColor=RGB(174, 174, 174);
        [_startTimeControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_startTimeControl setTag:4];
        
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
        _endTimeControl.topLineView.hidden=YES;
        [_endTimeControl setTitle:@"结束时间"];
        [_endTimeControl setDescribe:@"请选择"];
        _endTimeControl.describeLabel.textColor=RGB(174, 174, 174);
        [_endTimeControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_endTimeControl setTag:5];
    }
    return _endTimeControl;
}

#pragma mark 请假时长选项
-(XHAskforLeaveArrowCell *) timeControl
{
    if (_timeControl == nil)
    {
        _timeControl = [[XHAskforLeaveArrowCell alloc]init];
       _timeControl.topLineView.hidden=YES;
        [_timeControl setTitle:@"请假时长（天）"];
        [_timeControl setDescribe:@"请输入时长"];
        _timeControl.describeLabel.textColor=RGB(174, 174, 174);
        [_timeControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_timeControl setTag:6];
    }
    return _timeControl;
}
#pragma mark 时长说明
-(UILabel *)timeLabel
{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc] init];
        _timeLabel.font=FontLevel4;
        _timeLabel.textAlignment=NSTextAlignmentLeft;
        _timeLabel.textColor=RGB(174, 174, 174);
        _timeLabel.text=@"请假时长以天为单位，最小为0.5";
    }
    return _timeLabel;
}
#pragma mark 时长说明
-(XHLoseSubjectView *)loseSubjectView
{
    if (_loseSubjectView==nil) {
        _loseSubjectView=[[XHLoseSubjectView alloc] init];
        [_loseSubjectView setTitle:@"或缺课科目"];
    }
    return _loseSubjectView;
}

#pragma mark 提交视图
-(XHSubmitView *)submitView
{
    if (_submitView == nil)
    {
        _submitView = [[XHSubmitView alloc]init];
        _submitView.delegate=self;
    }
    return _submitView;
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
-(BaseView *)middleAccessoryView
{
    if (_middleAccessoryView == nil)
    {
        _middleAccessoryView = [[BaseView alloc]init];
        [_middleAccessoryView setBackgroundColor:RGB(243, 243, 243)];
      
    }
    return _middleAccessoryView;
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
-(XHCustomPickerView *)pickerView
{
    if (_pickerView==nil) {
        _pickerView=[[XHCustomPickerView alloc] initWithDelegate:self itemArry:kAskforLeaveList];
    }
    return _pickerView;
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
-(NSString *)bizType
{
    if (_bizType==nil) {
        _bizType=[[NSString alloc] init];
    }
    return _bizType;
}

@end
