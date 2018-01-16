//
//  XHHelper.h
//  daycareParent
//
//  Created by Git on 2017/12/8.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHHelper : NSObject
@property(nonatomic,strong) BaseViewController *currentVC;//!< 获取当前视图控制器

/**
 单例初始化方法
 
 @return 单例初始化方法
 */
+ (instancetype)sharedHelper;


#pragma mark 拨打电话
/**
 拨打电话
 
 @param phone 电话号码
 */
-(void)telephone:(NSString*)phone;



#pragma mark 发送信息
/**
 发送信息

 @param phone 手机号
 */
-(void)sendMessage:(NSString*)phone;


#pragma mark 获取当前视图所在的视图控制器
/**
 获取当前视图所在的视图控制器
 
 @return 当前视图控制器
 */
- (UIViewController *)currentlyViewController;

+ (void)uploadImage:(UIImage *)image name:(NSString *)name uploadCallback:(void (^)(BOOL success, NSError *error))uploadCallback withProgressCallback:(void (^)(float progress))progressCallback;
+ (NSString *)ageFarment:(NSDate *)date;
/**
 *创建UUID
 */
+ (NSString *)createGuid;


/**
 根据当前日期，获取当前是星期几（周日、周一、周二、周三、周四、周五、周六）
 
 @param fromDate 当前日期
 @return 返回星期几
 */
+(NSString*)weekdayWithDate:(NSString*)fromDate;



@end
