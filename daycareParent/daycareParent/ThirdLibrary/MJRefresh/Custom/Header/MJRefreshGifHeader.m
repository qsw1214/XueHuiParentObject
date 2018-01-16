//
//  MJRefreshGifHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshGifHeader.h"

@interface MJRefreshGifHeader()
@property (weak, nonatomic) UIImageView *gifView;
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
@end

@implementation MJRefreshGifHeader
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) { 
        UIImageView *gifView = [[UIImageView alloc] init]; 
        [self addSubview:_gifView = gifView]; 
    } 
    return _gifView; 
}

- (NSMutableDictionary *)stateImages 
{ 
    if (!_stateImages) { 
        self.stateImages = [NSMutableDictionary dictionary]; 
    } 
    return _stateImages; 
}

- (NSMutableDictionary *)stateDurations 
{ 
    if (!_stateDurations) { 
        self.stateDurations = [NSMutableDictionary dictionary]; 
    } 
    return _stateDurations; 
}

#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state 
{ 
    if (images == nil) return; 
    
    self.stateImages[@(state)] = images; 
    self.stateDurations[@(state)] = @(duration); 
    
    /* 根据图片设置控件的高度 */ 
    UIImage *image = [images firstObject]; 
    if (image.size.height > self.mj_h) { 
        self.mj_h = image.size.height; 
    } 
}

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state 
{ 
    [self setImages:images duration:images.count * 0.1 forState:state]; 
}

#pragma mark - 实现父类的方法
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
    if (self.state != MJRefreshStateIdle || images.count == 0) return;
    // 停止动画
    [self.gifView stopAnimating];
    // 设置当前需要显示的图片
    NSUInteger index =  images.count * pullingPercent;
    if (index >= images.count) index = images.count - 1;
    self.gifView.image = images[index];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.gifView.frame = self.bounds;
    
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    }
    else
    {
        CGSize stateLabelSize = [self contentSizeWithTitle:[self.stateTitles objectForKey:@(self.state)] withFontOfSize:self.stateLabel.font withWidth:200.f];
        
        CGFloat gifWidth = 19;
        CGFloat space = 20;
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        CGFloat startX = (screenW - stateLabelSize.width - gifWidth - space)/2 - 5;
        
        self.stateLabel.frame =  CGRectMake(startX, 0, stateLabelSize.width, stateLabelSize.height);
        self.stateLabel.center = CGPointMake(self.stateLabel.center.x, self.mj_h * 0.5f);
        
        self.gifView.contentMode = UIViewContentModeRight;
        self.gifView.frame = CGRectMake(startX + stateLabelSize.width + space, 0, gifWidth, 26);
        self.gifView.center = CGPointMake(self.gifView.center.x, self.mj_h * 0.5f);
        
//        self.gifView.contentMode = UIViewContentModeRight;
//        self.gifView.frame = CGRectMake(200, self.mj_h - 33.0f, 19, 26);
//        self.gifView.center = CGPointMake(self.gifView.center.x, self.mj_h * 0.5);
//        self.stateLabel.frame = CGRectMake(80.0f, self.mj_h - 28.0f, self.mj_w - 200, 20.0f);
//        self.stateLabel.center = CGPointMake(self.stateLabel.center.x, self.gifView.center.y);

    }
}


- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    [self setNeedsLayout];
    
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    }
}
@end
