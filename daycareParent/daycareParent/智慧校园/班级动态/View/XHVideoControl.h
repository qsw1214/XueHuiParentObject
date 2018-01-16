//
//  XHVideoControl.h
//  daycareParent
//
//  Created by Git on 2018/1/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHDynamicsFrame.h"
#import "XHNoticeFrame.h"
#import "ZFPlayerView.h"


@interface XHVideoControl : UIControl

@property (nonatomic,strong) XHDynamicsFrame *object;
@property (nonatomic,strong) XHNoticeFrame *notoceObject;




-(void)setImageWithURL:(NSString *)imageUrl placeholderImage:(NSString *)imageName;

-(void)resetFrame:(CGRect)frame;


/**
 单例初始化方法
 
 @return 单例初始化方法
 */
+ (instancetype)sharedVideo;
-(void)dismiss;
-(void)playerWithModel:(ZFPlayerModel*)model;



@end
