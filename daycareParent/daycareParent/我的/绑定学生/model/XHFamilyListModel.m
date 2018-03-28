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
    [self setGuardianId:[object objectItemKey:@"guardianId"]];
    [self setGuardianName:[object objectItemKey:@"guardianName"]];
    [self setGuardianType:[object objectItemKey:@"guardianType"]];
    [self setHeadUrl:ALGetFileHeadThumbnail(self.headPic)];
    
    
    
    if ([[XHUserInfo sharedUserInfo].selfId isEqualToString:self.guardianId])
    {
        [[XHUserInfo sharedUserInfo] setIsMajor:[self.isMajor integerValue]];
        [[XHUserInfo sharedUserInfo] setGuardianType:self.guardianType];
    }
    
    
    
}


@end
