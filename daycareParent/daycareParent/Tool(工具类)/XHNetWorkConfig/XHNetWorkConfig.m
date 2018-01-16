//
//  XHNetWorkConfig.m
//  daycareParent
//
//  Created by Git on 2017/11/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//










#import "XHNetWorkConfig.h"



@interface XHNetWorkConfig ()

@property (nonatomic,strong) NSMutableDictionary *paramDictionary; //!< 参数字典





@end


@implementation XHNetWorkConfig

static XHNetWorkConfig *net = nil;

/**
 单例初始化方法
 
 @return 单例对象
 */
+ (instancetype)sharedNetWork
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        net = [[self alloc]init];
        
    });
    return net;
    
}


#pragma mark - 设置字典的参数

/**
 设置参数

 @param object 参数内容
 @param key 参数的key
 */
-(void)setObject:(NSString*)object forKey:(NSString*)key
{
    [self.paramDictionary setObject:[NSString safeString:object] forKey:[NSString safeString:key]];
}


/**
 验证数据请求的数据

 @param object 要解析的数据请求数据
 @return 成功与否
 */
-(BOOL)verifyResPonseObject:(NSDictionary*)object
{
    NSDictionary *response = [object objectForKey:@"response"];
    NSInteger responseCode = [[response objectForKey:@"code"] integerValue];
    NSString *responseMessage = [NSString safeString:[response objectForKey:@"message"]];
    
    if (responseCode)
    {
        [XHShowHUD showNOHud:responseMessage];
        return NO;
    }
    else
    {
        NSDictionary *responseContent = [[object objectForKey:@"responseContent"] objectForKey:@"status"];

        NSInteger responseContentCode = [[responseContent objectForKey:@"code"] integerValue];
        NSString *responseContentMessage = [NSString safeString:[responseContent objectForKey:@"message"]];
        NSLog(@"--------message-------%@",responseContentMessage);
        if (responseContentCode)
        {
            [XHShowHUD showNOHud:responseContentMessage];
            return NO;
        }
        else
        {
            if (![responseContentMessage isEqualToString:@""]) {
                [XHShowHUD showOKHud:responseContentMessage];
            }
            else
            {
                [XHShowHUD hideHud];
            }
            
            return YES;
        }
    }
}



/**
 解析网络请求数据

 @param object 返回的数据问题
 @return 解析之后的数据
 */
-(NSDictionary*)analyzingObject:(id)object
{
    return [object objectItemKey:@"responseContent"];
}


#pragma mark - NetWork Method
- (void)getWithUrl:(NSString *)url
            sucess:(NetWorkSucessBlock)sucessBlock
             error:(NetWorkErrorBlock)errorBlock
{
    
    if ([AFNetworkingHelper connectedToNetWork])
    {
        //[XHShowHUD showTextHud];
        
        switch (self.option)
        {
            case XHNetWorkOptionService:
            {
                url = [NSString stringWithFormat:@"%@%@",ServiceBaseUrl,url];
            }
                break;
            case XHNetWorkOptionH5ixueHui:
            {
                url = [NSString stringWithFormat:@"%@%@",H5iXueHuiBaseUrl,url];
            }
                break;
            case XHNetWorkOptionLocation:
            {
                url = [NSString stringWithFormat:@"%@%@",LocationBaseUrl,url];
            }
                break;
        }
        
        [self GET:url parameters:self.paramDictionary success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             if (responseObject)
             {
                 BOOL verifyObject = [self verifyResPonseObject:responseObject];
                 responseObject = [self analyzingObject:responseObject];
                 sucessBlock(responseObject,verifyObject);
             }
             else
             {
                 NSDictionary *object = @{@"XUHEOBJECTKEY":@"XUHEOBJECTKEY"};
                 sucessBlock(object,NO);
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
            [XHShowHUD showNOHud:@"请求失败，请尝试重试！"];
             errorBlock(error);
         }];
    }
    else
    {
        [self alertFailed];
    }
}


- (void)postWithUrl:(NSString *)url
             sucess:(NetWorkSucessBlock)sucessBlock
              error:(NetWorkErrorBlock)errorBlock
{

    if ([AFNetworkingHelper connectedToNetWork])
    {
       // [XHShowHUD showTextHud];
        
        switch (self.option)
        {
            case XHNetWorkOptionService:
            {
                url = [NSString stringWithFormat:@"%@%@",ServiceBaseUrl,url];
            }
                break;
            case XHNetWorkOptionH5ixueHui:
            {
                url = [NSString stringWithFormat:@"%@/server%@",H5iXueHuiBaseUrl,url];
            }
                break;
            case XHNetWorkOptionLocation:
            {
                url = [NSString stringWithFormat:@"%@%@",LocationBaseUrl,url];
                self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
            }
                break;
        }
        
         NSLog(@"url****************%@",url);
        
        [self POST:url parameters:self.paramDictionary  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             if (responseObject)
             {
                 NSLog(@"sussess===============%@",responseObject);
                 BOOL verifyObject = [self verifyResPonseObject:responseObject];
                 responseObject = [self analyzingObject:responseObject];
                 sucessBlock(responseObject,verifyObject);
             }
             else
             {
                 NSDictionary *object = @{@"XUHEOBJECTKEY":@"XUHEOBJECTKEY"};
                 sucessBlock(object,NO);
             }
             
        
             NSLog(@"object===============%@",responseObject);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [XHShowHUD showNOHud:@"请求失败，请尝试重试！"];
             errorBlock(error);
         }];
    }
    else
    {
        [self alertFailed];
    }
    
}

- (void)postFormDataObjectWithUrl:(NSString *)url
                          constructingBodyWithBlock:(NetWorkConstructingBodyWithBlock)constructingBodyWithBlock
                                             sucess:(NetWorkSucessBlock)sucessBlock
                                              error:(NetWorkErrorBlock)errorBlock;
{
    
    if ([AFNetworkingHelper connectedToNetWork])
    {
         //[XHShowHUD showTextHud];
        switch (self.option)
        {
            case XHNetWorkOptionService:
            {
                url = [NSString stringWithFormat:@"%@%@",ServiceBaseUrl,url];
            }
                break;
            case XHNetWorkOptionH5ixueHui:
            {
                url = [NSString stringWithFormat:@"%@%@",H5iXueHuiBaseUrl,url];
            }
                break;
            case XHNetWorkOptionLocation:
            {
                url = [NSString stringWithFormat:@"%@%@",LocationBaseUrl,url];
            }
                break;
        }
        
        
        [self POST:url parameters:self.paramDictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
         {
             constructingBodyWithBlock(formData);
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             if (responseObject)
             {
                 BOOL verifyObject = [self verifyResPonseObject:responseObject];
                 responseObject = [self analyzingObject:responseObject];
                 sucessBlock(responseObject,verifyObject);
             }
             else
             {
                 NSDictionary *object = @{@"XUHEOBJECTKEY":@"XUHEOBJECTKEY"};
                 sucessBlock(object,NO);
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
              [XHShowHUD showNOHud:@"请求失败，请尝试重试！"];
             errorBlock(error);
         }];
    }
    else
    {
        [self alertFailed];
    }
   
}


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
                      error:(NetWorkErrorBlock)errorBlock
{
    if ([AFNetworkingHelper connectedToNetWork])
    {
         //[XHShowHUD showTextHud];
        switch (self.option)
        {
            case XHNetWorkOptionService:
            {
                url = [NSString stringWithFormat:@"%@%@",ServiceBaseUrl,url];
            }
                break;
            case XHNetWorkOptionH5ixueHui:
            {
                url = [NSString stringWithFormat:@"%@%@",H5iXueHuiBaseUrl,url];
            }
                break;
            case XHNetWorkOptionLocation:
            {
                url = [NSString stringWithFormat:@"%@%@",LocationBaseUrl,url];
            }
                break;
        }
        [self POST:url parameters:self.paramDictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
         {
             constructingBodyWithBlock(formData);
             
         } progress:^(NSProgress * _Nonnull uploadProgress)
         {
             progressWithBlock(uploadProgress);
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             if (responseObject)
             {
                 BOOL verifyObject = [self verifyResPonseObject:responseObject];
                 responseObject = [self analyzingObject:responseObject];
                 sucessBlock(responseObject,verifyObject);
             }
             else
             {
                 NSDictionary *object = @{@"XUHEOBJECTKEY":@"XUHEOBJECTKEY"};
                 sucessBlock(object,NO);
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
            [XHShowHUD showNOHud:@"请求失败，请尝试重试！"];
             errorBlock(error);
         }];
    }
    else
    {
        [self alertFailed];
    }
  
}

-(void)alertFailed
{
    [XHShowHUD showNOHud:@"当前网络不可用，请检查网络"];
}



#pragma mark - Getter / Setter
-(NSMutableDictionary *)paramDictionary
{
    if (_paramDictionary == nil)
    {
        _paramDictionary = [NSMutableDictionary dictionary];
    }
    return _paramDictionary;
}



@end

