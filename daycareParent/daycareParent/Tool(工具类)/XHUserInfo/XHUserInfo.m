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

-(void)isLogin:(isLogin)isLogin
{
    {
        XHLoginModel *model=[NSUserDefaults getLoginModel];
        XHNetWorkConfig *net=[XHNetWorkConfig new];
        [net setObject:model.loginName forKey:@"loginName"];
        [net setObject:model.pwd forKey:@"pwd"];
        [net setObject:@"3" forKey:@"type"];
        [XHShowHUD showTextHud];
        [net postWithUrl:@"zzjt-app-api_login" sucess:^(id object, BOOL verifyObject) {
            if (verifyObject)
            {
                [[XHUserInfo sharedUserInfo] setItemObject:[object objectItemKey:@"object"]];
                if ([[XHUserInfo sharedUserInfo].guardianModel.guardianId isEqualToString:@""]) {
                    isLogin(NO);
                    return ;
                }
                XHNetWorkConfig *netWork=[XHNetWorkConfig new];
                [netWork setObject:[XHUserInfo sharedUserInfo].guardianModel.guardianId forKey:@"guardianId"];
                [XHShowHUD showTextHud];
                [netWork postWithUrl:@"zzjt-app-api_studentBinding008" sucess:^(id object, BOOL verifyObject) {
                    if (verifyObject) {
                        NSMutableArray *tempChildArray = [NSMutableArray array];
                        NSArray *itemArry=[object objectItemKey:@"object"];
                        for (NSDictionary *dic in itemArry) {
                            XHChildListModel *model=[[XHChildListModel alloc] initWithDic:dic];
                            [tempChildArray addObject:model];
                        }
                        [[XHUserInfo sharedUserInfo].childListArry setArray:tempChildArray];
                         isLogin(YES);
                    }
                    else{
                         isLogin(NO);
                    }
                    
                } error:^(NSError *error) {
                     isLogin(NO);
                }];
                
            }
            else
            {
                 isLogin(NO);
            }
        } error:^(NSError *error) {
             isLogin(NO);

        }];
    }
}
                  


@end
