//
//  XHTeacherAddressBookContentView.h
//  daycareParent
//
//  Created by Git on 2017/12/13.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "BaseControl.h"
#import "XHTeacherAddressBookKey.h"
#import "XHTeacherAddressBookCell.h"



@protocol XHTeacherAddressBookContentViewDeletage <NSObject>

-(void)didSelectRowAtIndexItemObject:(XHTeacherAddressBookFrame*)object;
-(void)dissmissPopWithItemObjec:(XHTeacherAddressBookFrame*)object;

@end



@interface XHTeacherAddressBookContentView : BaseControl

@property (nonatomic,strong) XHChildListModel *model; //!< 孩子模型



@property (nonatomic,weak) id <XHTeacherAddressBookContentViewDeletage> deletage;



@end
