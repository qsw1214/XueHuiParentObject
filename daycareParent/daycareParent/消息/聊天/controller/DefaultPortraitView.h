//
//  DefaultPortraitView.h
//  RCloudMessage
//
//  Created by Jue on 16/3/31.
//  Copyright © 2016年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,XHDefaultPortraitViewType)
{
    XHRCDDefaultPortraitViewHeaderTeacherType = 1,
    XHRCDDefaultPortraitViewHeaderOtherType = 2,
};


@interface DefaultPortraitView : UIView

@property(nonatomic, strong) NSString *firstCharacter;

- (void)setColorAndLabel:(NSString *)userId Nickname:(NSString *)nickname with:(XHDefaultPortraitViewType)type;

- (UIImage *)imageFromView;

@end
