//
//  XHHomeWorkDetailsViewController.h
//  daycareParent
//
//  Created by Git on 2017/12/1.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#pragma mark 智慧校园->家庭作业->作业详情


#import "BaseViewController.h"
#import "XHHomeWorkContentView.h"

typedef void (^BackRefeshBlock) (BOOL isRefesh);


@interface XHHomeWorkDetailsViewController : BaseViewController
@property (nonatomic,copy) BackRefeshBlock refeshBlock;


-(void)setItemObjet:(XHHomeWorkFrame*)objet;


@end
