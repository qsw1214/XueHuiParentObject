//
//  AppDelegate.h
//  daycareParent
//
//  Created by Git on 2017/11/27.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
-(void)loginRongCloud:(NSString *)token;
- (void)setJpushAlias:(NSString *)loginName;
- (void)reloadIMBadge;
- (void)sendRCIMInfo;
@end

