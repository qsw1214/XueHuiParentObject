//
//  BaseModel.h
//  daycareParent
//
//  Created by Git on 2017/11/30.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseModel : NSObject

@property (nonatomic,copy) NSString *objectID; //!< 当前对象的id
@property (nonatomic,assign) NSInteger tage; //!< 当前对象的tage



/**
 设置内容

 @param object 数据对象
 */
-(void)setItemObject:(NSDictionary*)object;


@end
