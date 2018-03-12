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
@property (nonatomic,copy) NSString *title; //!< 周几
@property (nonatomic,copy) NSString *date; //!< 日期
@property (nonatomic,copy) NSString *time; //!< 具体时间
@property (nonatomic,copy) NSString *markIcon; //!< 显示的图片









@end
