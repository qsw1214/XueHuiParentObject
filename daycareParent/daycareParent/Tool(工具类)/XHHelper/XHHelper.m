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
#import <sys/utsname.h>
#define xOriginImageSize CGSizeMake(1080, 1920)

@implementation XHHelper

@synthesize kvoTag;

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


/**
 根据当前日期，获取当前是星期几（周日、周一、周二、周三、周四、周五、周六）
 
 @param fromDate 当前日期
 @return 返回星期几
 */
+(NSInteger)weekdayWithNowDate:(NSDate*)fromDate
{

    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:fromDate];
    
    NSInteger weekday = [components weekday];
    NSString *week = @"周一";
    switch (weekday)
    {
        case 1:
        {
            weekday = 7;
        }
            break;
        case 2:
        {
            weekday = 1;
        }
            break;
        case 3:
        {
            weekday = 2;
        }
            break;
        case 4:
        {
            weekday = 3;
        }
            break;
        case 5:
        {
            weekday = 4;
        }
            break;
        case 6:
        {
            weekday = 5;
        }
            break;
        case 7:
        {
            weekday = 6;
        }
            break;
    }
    
    
    
    NSLog(@"weekday:%zd",weekday);
    return weekday;
}

- (NSString*)iphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])
    {
        return@"iPhone 2G";
    }
    
    if([platform isEqualToString:@"iPhone1,2"])
    {
        return@"iPhone 3G";
    }
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;
    
}





@end
