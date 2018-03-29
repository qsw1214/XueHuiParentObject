//
//  XHUserTableViewCell.h
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kTitle @[@"修改手机号",@"开启消息推送",@"清除缓存",@"关于我们",@"当前版本"]
#define kPersonTitle @[@"头像",@"姓名"]
typedef NS_ENUM(NSInteger,XHUserTableViewCellModelType)
{
    XHUserTableViewCellSetType=1,//!< 设置界面

    XHUserTableViewCellPersonType=2,//!< 个人信息界面

}
;
@interface XHUserTableViewCell : ParentTableViewCell

@property(nonatomic,strong)ParentLabel *frontLabel;
@property(nonatomic,strong)UIButton *headBtn;
@property(nonatomic,strong)ParentLabel *backLabel;
@property(nonatomic,assign)XHUserTableViewCellModelType modelType;

@end
