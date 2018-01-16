//
//  XHRegisterModel.h
//  daycareParent
//
//  Created by Git on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHRegisterModel : NSObject

/*因为每个学校的时间段不一致，就暂切定义为四个时间段
 *
 */
@property (nonatomic,copy) NSString *oneTimeSolt; //!< 第一个时间段
@property (nonatomic,copy) NSString *twoTimeSolt; //!< 第一个时间段
@property (nonatomic,copy) NSString *threeTimeSolt; //!< 第一个时间段
@property (nonatomic,copy) NSString *fourTimeSolt; //!< 第一个时间段
@property (nonatomic,assign) NSInteger oneTimeSoltTyp; //!< 第一个时间段
@property (nonatomic,assign) NSInteger twoTimeSoltType; //!< 第一个时间段
@property (nonatomic,assign) NSInteger threeTimeSoltType; //!< 第一个时间段
@property (nonatomic,assign) NSInteger fourTimeSoltType; //!< 第一个时间段


@property (nonatomic,copy) NSString *userName; //!< 学生名字
@property (nonatomic,copy) NSString *registerDate; //!< 签到时间









@end
