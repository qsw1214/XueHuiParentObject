//
//  AFNetworkingHelper.m
//  TryCan
//
//  Created by yaolizhi on 15/5/1.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "AFNetworkingHelper.h"
#import <netinet/in_systm.h>
#import <netinet/in.h>

#define HostUrl @""



@implementation AFNetworkingHelper

static AFNetworkingHelper *networkingHelper = nil;

-(instancetype)init
{
    self = [super init];
    return self;
}


+ (instancetype)sharedNetworkingHelper
{
    
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        networkingHelper = [[self alloc]init];
        
    });
    
    return networkingHelper;
}

//get请求
- (NSURLSessionDataTask *)getWithUrl:(NSString *)url
                        theParmeters:(id )parmertes
                              sucess:(SucessBlock)sucessBlock
                               error:(ErrorBlock)errorBlock {
    
    if ([AFNetworkingHelper connectedToNetWork])
    {
        url = [NSString stringWithFormat:@"%@%@",HostUrl,url];
        
        return [self GET:url parameters:parmertes progress:^(NSProgress * _Nonnull downloadProgress)
                {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                {
                    //判断code 条件即可
                    sucessBlock(responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
                {
                    errorBlock(error);
                }];
    }
    else
    {
        [XHShowHUD showTextHud:@"当前网络不可用，请检查网络"];
        errorBlock(nil);
        return nil;
    }
}

//post请求
- (void)postWithUrl:(NSString *)url
       theParmeters:(id )parmertes
             sucess:(SucessBlock)sucessBlock
              error:(ErrorBlock)errorBlock
{
    if ([AFNetworkingHelper connectedToNetWork])
    {
        [self POST:[NSString stringWithFormat:@"%@%@",HostUrl,url] parameters:parmertes success:^(NSURLSessionDataTask *task, id responseObject)
         {
             sucessBlock(responseObject);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             errorBlock(error);
         }];
    }
    else
    {
        [XHShowHUD showTextHud:@"当前网络不可用，请检查网络"];
        errorBlock(nil);
    }
    
  
    
}


- (void)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if ([AFNetworkingHelper connectedToNetWork])
    {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  formData)
         {
             self.formDataBodyWithBlock(formData);
             
         } success:^(NSURLSessionDataTask *task,id  responseObject)
         {
             self.sucessBlock(responseObject);
             
         } failure:^(NSURLSessionDataTask *task, NSError *error)
         {
             self.errorBlock(error);
         }];
    }
    else
    {
        [XHShowHUD showTextHud:@"当前网络不可用，请检查网络"];
        self.errorBlock(nil);
    }
    
}




//post请求
- (NSURLSessionDataTask *)postFormDataObjectWithUrl:(NSString *)url
                     theParmeters:(id )parmertes
        constructingBodyWithBlock:(constructingBodyWithBlock)constructingBodyWithBlock
                           sucess:(SucessBlock)sucessBlock
                            error:(ErrorBlock)errorBlock
{   url = [NSString stringWithFormat:@"%@%@",HostUrl,[NSString safeString:url]];
    return [self POST:url parameters:parmertes constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         constructingBodyWithBlock(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        sucessBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        
        errorBlock(error);
        
    }];
}




//put 请求
- (NSURLSessionDataTask *)putWithUrl:(NSString *)url
      theParmeters:(NSDictionary *)parmertes
            sucess:(SucessBlock)sucessBlock
             error:(ErrorBlock)errorBlock
{
    url = [NSString stringWithFormat:@"%@%@",HostUrl,url];
    
    return [self PUT:url parameters:parmertes success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        sucessBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        errorBlock(error);
    }];
    
}

//PATCH 请求
- (NSURLSessionDataTask *)patchWithUrl:(NSString *)url
        theParmeters:(NSDictionary *)parmertes
              sucess:(SucessBlock)sucessBlock
               error:(ErrorBlock)errorBlock
{
    url = [NSString stringWithFormat:@"%@%@",HostUrl,url];
    
    
    
    return [self PATCH:url parameters:parmertes success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        
        sucessBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         errorBlock(error);
         
    }];
}

//DELETE 请求
- (NSURLSessionDataTask *)deleteWithUrl:(NSString *)url
         theParmeters:(NSDictionary *)parmertes
               sucess:(SucessBlock)sucessBlock
                error:(ErrorBlock)errorBlock
{
    url = [NSString stringWithFormat:@"%@%@",HostUrl,url];
    
    return [self DELETE:url parameters:parmertes success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        sucessBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        errorBlock(error);
    }];
}




//post上传图片
- (void)postFileWithUrl:(NSString *)url
       theParmeters:(NSData *)fileData
             sucess:(SucessBlock)sucessBlock
              error:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        [formData appendPartWithFormData:fileData name:@"profile"];
        
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:nil
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error)
                      {
                          errorBlock(error);
                          NSLog(@"Error: %@", error);
                      }
                      else
                      {
                          sucessBlock (responseObject);
                          NSLog(@"%@ %@", response, responseObject);
                      }
                  }];
    
    [uploadTask resume];
}




#pragma mark -  检查网络是否正常
+(BOOL)connectedToNetWork;
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"无法连接到网络");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && ! needsConnection) ? YES : NO;
}


+(BOOL)verifyCode:(NSDictionary*)object
{
    if([[object objectForKey:@"code"] integerValue] == 200)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+(BOOL)verifyCode:(NSDictionary*)object withCode:(NSInteger)code
{
    if([[object objectForKey:@"code"] integerValue] == code)
    {
        return YES;
    }
    else
    {
        NSString *message = [object objectForKey:@"message"];
        [XHShowHUD showTextHud:message];
        return NO;
    }
}


+(BOOL)verifyCode:(NSDictionary*)object withCode:(NSInteger)code withController:(UIViewController*)controller
{
    if([[object objectForKey:@"code"] integerValue] == code)
    {
        return YES;
    }
    else if ([[object objectForKey:@"code"] integerValue] == 403)
    {
#warning 这个地方需要修改
//        [MainRootControllerHelper rootHelperWith:RootHelperPresentLoginType withController:controller];
        return NO;
    }
    else
    {
        NSString *message = [object objectForKey:@"message"];
        [XHShowHUD showTextHud:message];
        return NO;
    }
}





@end
