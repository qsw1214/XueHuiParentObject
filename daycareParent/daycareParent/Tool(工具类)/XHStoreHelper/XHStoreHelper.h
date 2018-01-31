//
//  XHStoreHelper.h
//  daycareParent
//
//  Created by Git on 2018/1/30.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>


typedef void (^StorePaySucceedBlock) (BOOL succeed);

@interface XHStoreHelper : NSObject


/**
 单例初始化方法
 
 @return 单例初始化方法
 */
+ (instancetype)sharedHelper;

#pragma mark 根据商品ID查找商品信息
- (void)requestProductID:(NSString *)productID withSucceedBlock:(StorePaySucceedBlock)succeedBlock;


@end
