//
//  TabBarView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/9.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "TabBarView.h"

@interface TabBarView ()
@property(nonatomic,assign)NSInteger selectIndex;

@end

@implementation TabBarView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.selectIndex=2;
        NSMutableArray  *imageArray = [NSMutableArray arrayWithCapacity:0];
        [imageArray addObjectsFromArray:@[[UIImage imageNamed:@"ico_xiaoxi_xian"],
                                          [UIImage imageNamed:@"ico_txli_xian"],
                                          [UIImage imageNamed:@"ico_shouye_current"],
                                          [UIImage imageNamed:@"ico_xuehui_xian"],
                                          [UIImage imageNamed:@"ico_wo_xiao"]
                                          ]];
        
        NSArray *selectedImageArray = @[[UIImage imageNamed:@"ico_xiaoxi_current"],
                                        [UIImage imageNamed:@"ico_txli_current"],
                                        [UIImage imageNamed:@"ico_shouye_current"],
                                        [UIImage imageNamed:@"ico_xuehui_current"],
                                        [UIImage imageNamed:@"ico_wo_current"]
                                        ];
        
        NSMutableArray  *titleArray = [NSMutableArray arrayWithCapacity:0];
        [titleArray addObjectsFromArray:@[@"消息", @"通讯录", @"", @"学汇", @"我的"]];
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 40, - 17,80, 80)];
        lineImageView.backgroundColor = [UIColor whiteColor];
        lineImageView.layer.masksToBounds = YES;
        lineImageView.layer.cornerRadius = 40;
        lineImageView.layer.borderColor = LineViewColor.CGColor;//边框颜色
        lineImageView.layer.borderWidth = 1;//边框宽度
        [self addSubview:lineImageView];
        [self sendSubviewToBack:lineImageView];
        
        
        UIImageView *backImageView = [[UIImageView alloc] init];
        [backImageView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 54)];
        backImageView.backgroundColor=[UIColor whiteColor];
        [self addSubview:backImageView];
        
        UIImageView *leftLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width/2 - 32, 1)];
        leftLine.backgroundColor =LineViewColor; //LINECOLOR;
        [self addSubview:leftLine];
        
        UIImageView *rightLine = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 + 32, 0,[UIScreen mainScreen].bounds.size.width/2 - 30, 1)];
        rightLine.backgroundColor = LineViewColor;//LINECOLOR;
        [self addSubview:rightLine];
        
        for (int i = 0; i < 5; i ++)
        {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width/5)*i, 0, ([[UIScreen mainScreen] bounds].size.width/5), 54)];
            [button setTag:i + 1];
            [button setImage:[imageArray objectAtIndex:i] forState:UIControlStateNormal];
            [button setImage:[selectedImageArray objectAtIndex:i] forState:UIControlStateSelected];
            [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1] forState:UIControlStateNormal];//WHOLE_TONE
            [button setTitleColor:[UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1] forState:UIControlStateSelected];
            [button.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [self initButton:button];
            if (i == 2) {
                button.adjustsImageWhenHighlighted = NO;
                [button setFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width/5)*i, -8, ([[UIScreen mainScreen] bounds].size.width/5), 60)];
                 [button setSelected:YES];
            }
            [button addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            if (i==0) {
                UILabel *smallLab=[[UILabel alloc] init];
                smallLab.tag=1008611;
                smallLab.textAlignment=NSTextAlignmentCenter;
                smallLab.font=[UIFont systemFontOfSize:14.0f];
                smallLab.textColor=[UIColor whiteColor];
                smallLab.layer.masksToBounds=YES;
                smallLab.backgroundColor=[UIColor redColor];
                smallLab.backgroundColor=[UIColor redColor];
                smallLab.layer.cornerRadius=7.5;
                [self addSubview:smallLab];
            }
            
        }
    }
    return self;
}

- (void)tabBarButtonClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == self.selectIndex + 1)
    {
        return;
    }
  
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setSelected:NO];
        }
    }
    [button setSelected:YES];
    self.selectIndex = button.tag - 1;
    if ([_delegate respondsToSelector:@selector(setItemSelectIndex:)]) {
        [self.delegate setItemSelectIndex:button.tag-1];
    }
}

-(void)initButton:(UIButton*)btn{
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height+10 ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
