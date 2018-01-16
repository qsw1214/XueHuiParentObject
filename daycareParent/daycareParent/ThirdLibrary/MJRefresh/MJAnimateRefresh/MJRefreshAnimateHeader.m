//
//  MJChiBaoZiHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJRefreshAnimateHeader.h"

@implementation MJRefreshAnimateHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages duration:1.5f forState:MJRefreshStateIdle];
    [self setImages:idleImages duration:1.5f forState:MJRefreshStatePulling];
    [self setImages:idleImages duration:1.5f forState:MJRefreshStateRefreshing];
    
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开加载" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    self.stateLabel.font = [UIFont systemFontOfSize:13.f];
    self.stateLabel.textColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1.f];
    self.lastUpdatedTimeLabel.hidden = YES;
}
@end
