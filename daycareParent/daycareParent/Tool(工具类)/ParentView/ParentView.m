//
//  ParentView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/13.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "ParentView.h"

@implementation ParentView

-(void)setItemObject:(id)object
{
    
}
-(void)setItemObjectArry:(NSMutableArray *)arry
{
    
}
-(UIView *)baseView
{
    if (_baseView==nil) {
        _baseView=[[UIView alloc]init];
        _baseView.backgroundColor=[UIColor whiteColor];
    }
    return _baseView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
