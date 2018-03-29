//
//  TabBarView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "TabBarView.h"
#define KTitle @[@"校园",@"消息", @"通讯录", @"我的"]
#define kImageTitle @[@"ico_shouye_xian",@"ico_xiaoxi_xian",@"ico_txli_xian",@"ico_wo_xiao"]
#define kImageSelectTitle @[@"ico_shouye_current",@"ico_xiaoxi_current",@"ico_txli_current",@"ico_wo_current"]
@interface TabBarView ()
@property(nonatomic,assign)NSInteger selectIndex;

@end

@implementation TabBarView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.selectIndex=0;
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 0.5)];
        lineImageView.backgroundColor =LineViewColor; //LINECOLOR;
        [self addSubview:lineImageView];
    
        for (int i = 0; i < 4; i ++)
        {
            
            ParentControl *control = [[ParentControl alloc] init];
            [control setFrame:CGRectMake((SCREEN_WIDTH/4)*i, 0, (SCREEN_WIDTH/4), 50)];
            [control setTag:i + 1];
            [control setNumberImageView:1];
            [control setNumberLabel:1];
            [control setImageViewCGRectMake:CGRectMake((control.width-22)/2.0, 7, 22, 22) withNumberIndex:0];
            [control setImageViewName:kImageTitle[i] withNumberIndex:0];
             [control setLabelCGRectMake:CGRectMake(0, 30, SCREEN_WIDTH/4, 20) withNumberIndex:0];
            [control setLabelFont:kFont(12.0) withNumberIndex:0];
            [control setLabelText:KTitle[i] withNumberIndex:0];
            [control setLabelTextColor:MainColor withNumberIndex:0];
            [control setLabelTextAlignment:NSTextAlignmentCenter withNumberIndex:0];
            if (i == 0)
            {
                [control setImageViewName:kImageSelectTitle[i] withNumberIndex:0];
                [control setImageViewCGRectMake:CGRectMake((control.width-30)/2.0, 10, 35, 35) withNumberIndex:0];
                [control setLabelText:@"" withNumberIndex:0];
                [control setSelected:YES];
            }
            [control addTarget:self action:@selector(tabBarcontrolClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:control];
            if (i==1) {
                UILabel *smallLab=[[UILabel alloc] init];
                smallLab.tag=1008611;
                smallLab.textAlignment=NSTextAlignmentCenter;
                smallLab.font=[UIFont systemFontOfSize:14.0f];
                smallLab.textColor=[UIColor whiteColor];
                smallLab.layer.masksToBounds=YES;
                smallLab.backgroundColor=[UIColor redColor];
                smallLab.layer.cornerRadius=9;
                [self addSubview:smallLab];
            }
            
        }
    }
    return self;
}

- (void)tabBarcontrolClick:(id)sender
{
    ParentControl *control = (ParentControl *)sender;
   
    if (control.tag == self.selectIndex + 1)
    {
        return;
    }
  
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[ParentControl class]])
        {
            ParentControl *control = (ParentControl *)view;
            [control setImageViewName:kImageTitle[control.tag-1] withNumberIndex:0];
           
            if (control.tag==1)
            {
                 [control setImageViewCGRectMake:CGRectMake((control.width-24)/2.0, 7, 24, 24) withNumberIndex:0];
            }
            else
            {
                 [control setImageViewCGRectMake:CGRectMake((control.width-22)/2.0, 7, 22, 22) withNumberIndex:0];
            }
            [control setLabelText:KTitle[control.tag-1] withNumberIndex:0];
            [control setSelected:NO];
        }
    }
    [control setSelected:YES];
    [control setImageViewName:kImageSelectTitle[control.tag-1] withNumberIndex:0];
    if (control.tag==1)
    {
        if (control.selected==YES)
        {
            [control setImageViewCGRectMake:CGRectMake((control.width-30)/2.0, 10, 30, 30) withNumberIndex:0];
            [control setLabelText:@"" withNumberIndex:0];
        }
        else
        {
            [control setImageViewCGRectMake:CGRectMake((control.width-24)/2.0, 7, 24, 24) withNumberIndex:0];
            [control setLabelText:KTitle[control.tag-1] withNumberIndex:0];
        }
        
    }
    else
    {
        [control setImageViewCGRectMake:CGRectMake((control.width-22)/2.0, 7, 22, 22) withNumberIndex:0];
        [control setLabelText:KTitle[control.tag-1] withNumberIndex:0];
    }
    self.selectIndex = control.tag - 1;
    if ([_delegate respondsToSelector:@selector(setItemSelectIndex:)]) {
        [self.delegate setItemSelectIndex:control.tag-1];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
