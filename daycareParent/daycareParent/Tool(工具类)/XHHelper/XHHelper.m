//
//  XHHelper.m
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHHelper.h"
#import <AliyunOSSiOS/OSSService.h>
#import "UIImage+DevKit.h"
#import "UIImage+Resizing.h"
#define xOriginImageSize CGSizeMake(1080, 1920)

@implementation XHHelper



static XHHelper *helper = nil;

/**
 单例初始化方法
 
 @return 单例初始化方法
 */
+ (instancetype)sharedHelper
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        helper = [[self alloc]init];
        
    });
    
    return helper;
}



#pragma mark 拨打电话
/**
 拨打电话

 @param phone 电话号码
 */
-(void)telephone:(NSString*)phone
{
    phone = [NSString stringWithFormat:@"telprompt://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}


#pragma mark 发送信息的手机号
/**
 发送信息

 @param phone 要发送信息的手机号
 */
-(void)sendMessage:(NSString *)phone
{
    phone = [NSString stringWithFormat:@"sms://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}



#pragma mark 获取当前视图所在的视图控制器
/**
 获取当前视图所在的视图控制器

 @return 当前视图控制器
 */
- (UIViewController *)currentlyViewController
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController)
    {
        result = result.presentedViewController;
    }
//    if ([result isKindOfClass:[MYTabBarViewController class]])
//    {
//        result = [(MYTabBarViewController *)result selectedViewController];
//    }
    if ([result isKindOfClass:[UINavigationController class]])
    {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

+ (void)uploadImage:(UIImage *)image name:(NSString *)name uploadCallback:(void (^)(BOOL success, NSError *error))uploadCallback withProgressCallback:(void (^)(float progress))progressCallback
{
    image = [image scaleToSize:xOriginImageSize usingMode:NYXResizeModeAspectFit];
    image = [image fixOrientation];
    
    NSString *endpoint = @"img.ixuehui.cn";
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:@"LTAIkxSxT02rGsIf" secretKey:@"Uh9QqhIbVNqs9Zk9TTdBdjEM74nvtC"];
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    
    // 必填字段
    put.bucketName = @"ixuehui";
   // put.objectKey = [NSString stringWithFormat:@"test/%@",name];   //测试环境
    put.objectKey = [NSString stringWithFormat:@"xh/%@",name];   //正式环境
    NSData *uploadData = UIImageJPEGRepresentation(image, 0.5);
    put.uploadingData = uploadData;
    
    //可选字段，可不设置
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 当前上传段长度、当前已经上传总长度、一共需要上传的总长度
        if (progressCallback)
        {
            progressCallback(totalByteSent/totalBytesExpectedToSend);
        }
    };
    OSSTask * putTask = [client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        BOOL isSuccess = YES;
        if (!task.error) {
            isSuccess = YES;
        } else {
            isSuccess = NO;
        }
        if (uploadCallback)
        {
            uploadCallback(isSuccess,task.error);
        }
        return nil;
    }];
    
}



+ (NSString *)ageFarment:(NSDate *)date
{
    if (date == nil)
    {
        return @"未知";
    }
    NSCalendar *gregorian = [NSCalendar  currentCalendar];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:date toDate:[NSDate date] options:0];
    NSInteger year = [components year];
    return [NSString stringWithFormat:@"%zd",year];
}

/**
 *创建UUID
 */
+ (NSString *)createGuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    return uuid;
}




/**
 根据当前日期，获取当前是星期几（周日、周一、周二、周三、周四、周五、周六）
 
 @param fromDate 当前日期
 @return 返回星期几
 */
+(NSString*)weekdayWithDate:(NSString*)fromDate
{
    // 创建 格式 对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置 日期 格式 可以根据自己的需求 随时调整， 否则计算的结果可能为 nil
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // 将字符串日期 转换为 NSDate 类型
    NSDate *date = [formatter dateFromString:fromDate];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSInteger weekday = [components weekday];
    NSString *week = @"周一";
    switch (weekday)
    {
        case 1:
        {
            week = @"周日";
        }
            break;
        case 2:
        {
            week = @"周一";
        }
            break;
        case 3:
        {
            week = @"周二";
        }
            break;
        case 4:
        {
            week = @"周三";
        }
            break;
        case 5:
        {
            week = @"周四";
        }
            break;
        case 6:
        {
            week = @"周五";
        }
            break;
        case 7:
        {
            week = @"周六";
        }
            break;
    }
    
    
    
    NSLog(@"weekday:%zd",weekday);
    return week;
}








@end
