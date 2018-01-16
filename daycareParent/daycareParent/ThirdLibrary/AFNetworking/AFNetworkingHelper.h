//
//  AFNetworkingHelper.h
//  TryCan
//
//  Created by yaolizhi on 15/5/1.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


//#define BaseUrl @"http://www.duchebaodian.com/"



typedef  void (^SucessBlock)(id object);

typedef  void (^ErrorBlock)(NSError *error);

typedef void (^constructingBodyWithBlock)(id <AFMultipartFormData> formData);


@interface AFNetworkingHelper : AFHTTPSessionManager

@property (nonatomic,copy) SucessBlock sucessBlock;
@property (nonatomic,copy) ErrorBlock errorBlock;
@property (nonatomic,copy) constructingBodyWithBlock formDataBodyWithBlock;



-(instancetype)init;

+ (instancetype)sharedNetworkingHelper;

- (NSURLSessionDataTask *)getWithUrl:(NSString *)url
                        theParmeters:(id )parmertes
                              sucess:(SucessBlock)sucessBlock
                               error:(ErrorBlock)errorBlock;


- (void)postWithUrl:(NSString *)url
       theParmeters:(id )parmertes
             sucess:(SucessBlock)sucessBlock
              error:(ErrorBlock)errorBlock;

- (void)POST:(NSString *)URLString
                             parameters:(id)parameters
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



- (NSURLSessionDataTask *)postFormDataObjectWithUrl:(NSString *)url
                     theParmeters:(id )parmertes
        constructingBodyWithBlock:(constructingBodyWithBlock)constructingBodyWithBlock
                           sucess:(SucessBlock)sucessBlock
                            error:(ErrorBlock)errorBlock;



- (NSURLSessionDataTask *)putWithUrl:(NSString *)url
      theParmeters:(NSDictionary *)parmertes
            sucess:(SucessBlock)sucessBlock
             error:(ErrorBlock)errorBlock;

- (NSURLSessionDataTask *)patchWithUrl:(NSString *)url
        theParmeters:(NSDictionary *)parmertes
              sucess:(SucessBlock)sucessBlock
               error:(ErrorBlock)errorBlock;




+(BOOL)verifyCode:(NSDictionary*)object;

+(BOOL)verifyCode:(NSDictionary*)object withCode:(NSInteger)code;

+(BOOL)verifyCode:(NSDictionary*)object withCode:(NSInteger)code withController:(UIViewController*)controller;


#pragma mark -  检查网络是否正常
/**
 检查网络是否正常
 */
+(BOOL)connectedToNetWork;






@end





