//
//  XHDynamicsHeaderControl.h
//  daycareParent
//
//  Created by Git on 2018/1/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHDynamicsHeaderControl : UIControl

-(void)resetFrame:(CGRect)frame;

-(void)dotHidden:(BOOL)hidden;

-(void)sd_setImageWithURL:(NSString*)url placeholderImage:(NSString*)imageName;


@end
