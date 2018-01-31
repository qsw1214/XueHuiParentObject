//
//  XHStoreHelper.m
//  daycareParent
//
//  Created by Git on 2018/1/30.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHStoreHelper.h"
#import "XHShowHUD.h"


static XHStoreHelper *helper = nil;


@interface XHStoreHelper () <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic,copy) StorePaySucceedBlock paySuceedBlock;


@property (nonatomic,copy) NSString *productID; //!< 商品id



@end


@implementation XHStoreHelper

/**
 单例初始化方法
 
 @return 单例初始化方法
 */
+ (instancetype)sharedHelper
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        helper = [[self alloc]init];
        //添加一个交易队列观察者
        [[SKPaymentQueue defaultQueue] addTransactionObserver:helper];
    });
    
    return helper;
}



#pragma mark 根据商品ID查找商品信息
- (void)requestProductID:(NSString *)productID withSucceedBlock:(StorePaySucceedBlock)succeedBlock
{
    [XHShowHUD showTextHud];
    [helper setPaySuceedBlock:succeedBlock];
    [helper setProductID:productID];
    //判断是否可进行支付
    if ([SKPaymentQueue canMakePayments])
    {
        //根据商品ID查找商品信息
        NSArray *product = [[NSArray alloc] initWithObjects:productID, nil];
        NSSet *nsset = [NSSet setWithArray:product];
        //创建SKProductsRequest对象，用想要出售的商品的标识来初始化， 然后附加上对应的委托对象。
        //该请求的响应包含了可用商品的本地化信息。
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
        [request setDelegate:self];
        [request start];
    }
    else
    {
        [XHShowHUD showNOHud:@"不允许程序内付费"];
    }
}



#pragma mark - Deletage Method (接收消息的代理方法)
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    //接收商品信息
    NSArray *product = response.products;
    if ([product count])
    {
        // SKProduct对象包含了在App Store上注册的商品的本地化信息。
        SKProduct *storeProduct = nil;
        for (SKProduct *pro in product)
        {
            if ([pro.productIdentifier isEqualToString:helper.productID])
            {
                storeProduct = pro;
            }
        }
        //创建一个支付对象，并放到队列中
        SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:storeProduct];
        //设置购买的数量 默认是购买一个
        [payment setQuantity:1];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else
    {
        [XHShowHUD showNOHud:@"购买失败，请重试!"];
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    [XHShowHUD showNOHud:@"购买失败，请重试!"];
}

- (void)requestDidFinish:(SKRequest *)request
{
    NSLog(@"反馈信息结束调用");
}
//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction
{
    for (SKPaymentTransaction *tran in transaction)
    {
        switch (tran.transactionState)
        {
#pragma mark case SKPaymentTransactionStatePurchased 购买成功
            case SKPaymentTransactionStatePurchased:
            {
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                // 更新界面或者数据，把用户购买得商品交给用户
                //返回购买的商品信息
                [self verifyPruchase];
                //商品购买成功可调用本地接口
            }
                break;
#pragma mark case SKPaymentTransactionStateRestored 恢复购买
            case SKPaymentTransactionStateRestored:
#pragma mark case SKPaymentTransactionStateFailed 购买失败
            case SKPaymentTransactionStateFailed:
            {
                // 将交易从交易队列中删除
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
#pragma mark case SKPaymentTransactionStatePurchasing 购买成功
            case SKPaymentTransactionStatePurchasing:
            {
                NSLog(@"已经添加到请求队列里了");
            }
                break;
#pragma mark case SKPaymentTransactionStateDeferred 等待确认，儿童模式需要询问家长同意
            case SKPaymentTransactionStateDeferred:
            {
                
            }
                break;
        }
        // 如果小票状态是购买完成
        if (SKPaymentTransactionStatePurchased == tran.transactionState)
        {
            
        } else if (SKPaymentTransactionStateRestored == tran.transactionState)
        {
            // 将交易从交易队列中删除
            [[SKPaymentQueue defaultQueue] finishTransaction:tran];
        }
        else if (SKPaymentTransactionStateFailed == tran.transactionState)
        {
            
        }
        else if (SKPaymentTransactionStateDeferred == tran.transactionState)
        {
            NSLog(@"等待确认，儿童模式需要询问家长同意");
        }
        else if (SKPaymentTransactionStatePurchasing == tran.transactionState)
        {
            
        }
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"交易结束");
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}
#pragma mark 验证购买凭据

- (void)verifyPruchase
{
    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    // 发送网络POST请求，对购买凭据进行验证
    //测试验证地址:https://sandbox.itunes.apple.com/verifyReceipt
    //正式验证地址:https://buy.itunes.apple.com/verifyReceipt
    NSURL *url = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
    NSMutableURLRequest *urlRequest =
    [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    urlRequest.HTTPMethod = @"POST";
    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", encodeStr];
    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    urlRequest.HTTPBody = payloadData;
    // 提交验证请求，并获得官方的验证JSON结果 iOS9后更改了另外的一个方法
    NSData *result = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    // 官方验证结果为空
    if (result == nil) 
    {
        NSLog(@"验证失败");
        helper.paySuceedBlock(NO);
    }
    else
    {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:nil];
        if (dict == nil)
        {
            
            helper.paySuceedBlock(NO);
        }
        else if ([[dict objectForKey:@"status"] integerValue] == 0)
        {
            
            NSDictionary *receipt  = [dict objectForKey:@"receipt"];
            NSString *bundle_id = [receipt objectForKey:@"bundle_id"];
            if ([@"12" isEqualToString:@"12"])
            {
                // 比对字典中以下信息基本上可以保证数据安全
                // bundle_id , application_version , product_id , transaction_id
                [XHShowHUD showOKHud:@"购买成功!"];
                helper.paySuceedBlock(NO);
            }
            else
            {
                [XHShowHUD showOKHud:@"验证失败!"];
                helper.paySuceedBlock(NO);
            }
        }
    }
    
}

@end
