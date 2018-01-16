//
//  XHNetWorkConfig.h
//  daycareParent
//
//  Created by Git on 2017/11/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//



typedef NS_ENUM(NSInteger,XHNetWorkOption)
{
    XHNetWorkOptionService = 0, //!< service Url  默认选项
    XHNetWorkOptionH5ixueHui = 1, //!< 浩学云专用Url
    XHNetWorkOptionLocation = 2, //!< 绑定卡
};






#define NetWorkType 1  //!< 0 为线下 1为线上

#if  NetWorkType

#define ServiceBaseUrl @"http://app.ixuehui.cn:7777/service?ky="
#define H5iXueHuiBaseUrl @"http://h5.ixuehui.cn"
#define LocationBaseUrl @"http://device.ixuehui.cn"

#define VideoBaseUrl @"http://h5.ixuehui.cn/zx/h5/index.html"
#define OrderBaseUrl @"http://h5.mall.ixuehui.cn"

#define RONGCLOUD_IM_APPKEY @"82hegw5u820xx" //8w7jv4qb8wt3y


#else

#define ServiceBaseUrl @"http://192.168.1.155:7777/service?ky="
#define H5iXueHuiBaseUrl @"http://h5.ixuehui.cn"
#define LocationBaseUrl @"http://device.ixuehui.cn"

#define VideoBaseUrl @"http://192.168.1.155:8888/video/index.html"
#define OrderBaseUrl @"http://192.168.1.155:8888/haoxuemall-h5-app/index.html"

#define RONGCLOUD_IM_APPKEY @"8w7jv4qb8wt3y" //8w7jv4qb8wt3y


#endif


#import <Foundation/Foundation.h>
#import "AFNetworking.h"






typedef  void (^NetWorkSucessBlock) (id object,BOOL verifyObject);

typedef  void (^NetWorkErrorBlock) (NSError *error);

typedef void (^NetWorkConstructingBodyWithBlock) (id <AFMultipartFormData> formData);

typedef void (^NetWorkProgressWithBlock) (NSProgress *uploadProgress);




@interface XHNetWorkConfig : AFHTTPSessionManager

@property (nonatomic,assign) XHNetWorkOption option; //!< 选项








/**
 单例初始化方法
 
 @return 单例对象
 */
+ (instancetype)sharedNetWork;

-(void)setObject:(NSString*)object forKey:(NSString*)key;


#pragma mark GET方法网络请求
/**
 @param url 接口后缀url地址
 @param sucessBlock 成功回掉
 @param errorBlock  失败回调
 */
- (void)getWithUrl:(NSString *)url
            sucess:(NetWorkSucessBlock)sucessBlock
             error:(NetWorkErrorBlock)errorBlock;


#pragma mark POST方法网络请求
/**
 @param url 接口后缀url地址
 @param sucessBlock 成功回调
 @param errorBlock  失败回调
 */
- (void)postWithUrl:(NSString *)url
             sucess:(NetWorkSucessBlock)sucessBlock
              error:(NetWorkErrorBlock)errorBlock;

#pragma mark POST方法表单网络请求
/**
 @param url 接口后缀url地址
 @param constructingBodyWithBlock 表单回调
 @param sucessBlock 成功回调
 @param errorBlock  失败回调
 */
- (void)postFormDataObjectWithUrl:(NSString *)url
                          constructingBodyWithBlock:(NetWorkConstructingBodyWithBlock)constructingBodyWithBlock
                                             sucess:(NetWorkSucessBlock)sucessBlock
                                              error:(NetWorkErrorBlock)errorBlock;



#pragma mark POST方法进度网络请求
/**
 @param url 接口后缀url地址
 @param constructingBodyWithBlock 表单回调
 @param progressWithBlock 进度回调
 @param sucessBlock 成功回调
 @param errorBlock  失败回调
 */
- (void)postProgressWithUrl:(NSString *)url
        constructingBodyWithBlock:(NetWorkConstructingBodyWithBlock)constructingBodyWithBlock
                   progress:(NetWorkProgressWithBlock)progressWithBlock
                           sucess:(NetWorkSucessBlock)sucessBlock
                            error:(NetWorkErrorBlock)errorBlock;






@end
