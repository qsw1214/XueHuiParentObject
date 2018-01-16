//
//  XHCookBookImageControl.h
//  daycareParent
//
//  Created by Git on 2018/1/10.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHPreviewModel.h"

@interface XHCookBookImageControl : BaseControl

@property (nonatomic,strong) XHPreviewModel *model;



-(void)sd_setImageWithURL:(NSString*)url placeholderImage:(NSString*)imageName;
-(void)sd_setImageWithURL:(NSString*)url;

@end
