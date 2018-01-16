//
//  XHSyllabusCellContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/6.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHSyllabusFrame.h"


@interface XHSyllabusCellContentView : BaseControl

@property (nonatomic,strong) XHSyllabusFrame *itemFrame;


-(void)setTextColor:(UIColor*)color;
-(void)setFont:(UIFont*)font;
-(void)setTime:(NSString*)time;
-(void)setSubject:(NSString*)subject;





@end
