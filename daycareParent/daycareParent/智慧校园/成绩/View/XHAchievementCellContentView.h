//
//  XHAchievementCellContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHAchievementFrame.h"


@interface XHAchievementCellContentView : BaseControl


-(void)setTextColor:(UIColor*)color;
-(void)setFont:(UIFont*)font;
-(void)setSubject:(NSString*)subject;
-(void)setBatch:(NSString*)batch;
-(void)setScore:(NSString*)score;



@end
