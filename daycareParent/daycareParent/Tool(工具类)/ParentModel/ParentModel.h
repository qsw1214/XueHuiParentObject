//
//  ParentModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParentModel : NSObject

@property(nonatomic,assign)CGRect itemFrame;

@property(nonatomic,assign)CGFloat itemCellHeight;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
