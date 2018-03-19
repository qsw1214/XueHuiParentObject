//
//  XHFamilyListModel.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/16.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHFamilyListModel.h"
@implementation XHFamilyListModel


-(void)setItemObject:(NSDictionary *)object
{
    [self setHeadPic:[object objectItemKey:@"headPic"]];
    [self setIsMajor:[object objectItemKey:@"isMajor"]];
    [self setTelphoneNumber:[object objectItemKey:@"telphoneNumber"]];
    [self setHeadPic:[object objectItemKey:@"guardianId"]];
    [self setIsMajor:[object objectItemKey:@"guardianName"]];
    [self setTelphoneNumber:[object objectItemKey:@"guardianType"]];
    
}


@end
