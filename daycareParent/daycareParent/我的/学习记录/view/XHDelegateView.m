//
//  XHDelegateView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDelegateView.h"

@implementation XHDelegateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=RGB(239, 239, 239);
        _allSelectBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0, 60)];
        [_allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_allSelectBtn];
        _deleteBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0, 60)];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.alpha=0.6;
         [_deleteBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self addSubview:_deleteBtn];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        view.backgroundColor=RGB(224, 224, 224);
        [self addSubview:view];
        UIView *backview=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-0.5, 5, 1, 50)];
        backview.backgroundColor=RGB(224, 224, 224);
        [self addSubview:backview];
    }
    return self;
}

@end
