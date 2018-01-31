//
//  XHUserInfo.m
//  daycareParent
//
//  Created by Git on 2017/12/12.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHUserInfo.h"

@implementation XHUserInfo

static XHUserInfo *userInfo = nil;

/**
 单例初始化方法
 
 @return 单例对象
 */
+ (instancetype)sharedUserInfo
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    userInfo = [[self alloc]init];
    });
    
   return userInfo;
    
}

-(void)setItemObject:(NSDictionary*)object
{
     _age=[object  objectItemKey:@"age"];
    _birthdate=[object  objectItemKey:@"birthdate"];
    _headPic=[object objectItemKey:@"headPic"];
    _ID=[object objectItemKey:@"id"];
    _loginName=[object objectItemKey:@"loginName"];
    _nickName=[object objectItemKey:@"nickName"];
    _selfId=[object objectItemKey:@"selfId"];
    _sessionId=[object objectItemKey:@"sessionId"];
    _signature=[object objectItemKey:@"signature"];
    _telphoneNumber=[object objectItemKey:@"telphoneNumber"];
    _token=[object objectItemKey:@"token"];
    _sex=[object objectItemKey:@"sex"];
    _primaryFamilyId=[[object objectItemKey:@"propValue"] objectItemKey:@"primaryFamilyId"];
    _guardianModel=[[XHGuardianInfo alloc] initWithDic:[[object objectItemKey:@"propValue"] objectItemKey:@"guardian"]];
    switch ([self.sex integerValue])
    {
        case 0:
        {
            _sexName=@"女";
        }
            break;
        case 1:
        {
            _sexName=@"男";
            
        }
            break;
    }
}

-(NSMutableArray *)childListArry
{
    if (!_childListArry)
    {
        _childListArry = [NSMutableArray array];
    }
    return _childListArry;
}


                  


@end
