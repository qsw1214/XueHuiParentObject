//
//  XHCustomView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/20.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCustomView.h"

@implementation XHCustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)init
{
    if (self=[super init]) {
        NSArray *arry=[XHUserInfo sharedUserInfo].childListArry;
        UIScrollView *scrollView=[[UIScrollView alloc] init];
        [self addSubview:scrollView];
        if (arry.count<5) {
            scrollView.frame=CGRectMake(0, 0, 80, 30*arry.count);
        }
        else
        {
            scrollView.frame=CGRectMake(0, 0, 80, 30*5);
        }
        scrollView.contentSize=CGSizeMake(80, 30*arry.count);
        for (int i=0; i<arry.count; i++) {
            XHChildListModel *model = arry[i];
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 30*i, 80, 30)];
            self.backgroundColor=[UIColor whiteColor];
            btn.titleLabel.font=FontLevel2;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.tag=i+100;
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:model.studentName forState:UIControlStateNormal];
            [scrollView addSubview:btn];
        }
    }
    return self;
}

-(void)BtnClick:(UIButton *)btn
{
    XHChildListModel *model=[XHUserInfo sharedUserInfo].childListArry[btn.tag-100];
    if ([_delegate respondsToSelector:@selector(getChildModel:)]) {
        [_delegate getChildModel:model];
        self.isExist=NO;
        [self removeFromSuperview];
    }
}

@end
