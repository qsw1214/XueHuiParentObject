//
//  XHRCModel.h
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//



@interface XHRCModel : ParentModel
@property(nonatomic,copy)NSString *RCtitle;//!<标题

@property(nonatomic,copy)NSString *RCtitlePic;//!< 头像

@property(nonatomic,copy)NSString *RCContent;//!< 内容

@property(nonatomic,copy)NSString *createTime;//!< 时间

@property(nonatomic,copy)NSString *sum;//!< 未读数字

@property(nonatomic,assign)NSInteger CellHeight;//!< 行高

-(id)initWithDic:(NSDictionary *)dic;
@end
