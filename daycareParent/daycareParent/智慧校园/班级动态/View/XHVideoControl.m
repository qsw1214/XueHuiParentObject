//
//  XHVideoControl.m
//  daycareParent
//
//  Created by Git on 2018/1/5.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHVideoControl.h"

@interface XHVideoControl ()


@property (nonatomic,strong) UIImageView *previewImageView;  //!< 预览视图
@property (nonatomic,strong) UIImageView *playerImageView;  //!< 播放视图
@property (nonatomic,strong) ZFPlayerView *playerView; //!< 播放器



@end

@implementation XHVideoControl




- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.previewImageView];
        [self addSubview:self.playerImageView];
    }
    return self;
}




-(void)setObject:(XHDynamicsFrame *)object
{
    _object = object;
    [self setImageWithURL:object.model.videoPreviewUrl placeholderImage:@"img_video"];
}


-(void)setNotoceObject:(XHNoticeFrame *)notoceObject
{
    _notoceObject = notoceObject;
    [self setImageWithURL:notoceObject.model.vedioFirstPicUrl placeholderImage:@"img_video"];
}

-(void)setImageWithURL:(NSString *)imageUrl placeholderImage:(NSString *)imageName
{
    [self.previewImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:imageName]];
}





-(void)resetFrame:(CGRect)frame
{
    [self setHidden:NO];
    [self setFrame:frame];
    
    
    [self.previewImageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.playerImageView setFrame:CGRectMake((frame.size.width-40)/2.0, (frame.size.height-40)/2.0, 40, 40)];
}



-(UIImageView *)previewImageView
{
    if (!_previewImageView)
    {
        _previewImageView = [[UIImageView alloc]init];
        [_previewImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_previewImageView.layer setMasksToBounds:YES];
    }
    return _previewImageView;
}


-(UIImageView *)playerImageView
{
    if (!_playerImageView)
    {
        _playerImageView = [[UIImageView alloc]init];
        [_playerImageView setImage:[UIImage imageNamed:@"ico_bofang"]];
    }
    return _playerImageView;
}




#pragma mark - 单例方法

static XHVideoControl *videoControl = nil;

/**
 单例初始化方法
 
 @return 单例初始化方法
 */
+ (instancetype)sharedVideo
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        videoControl = [[self alloc]init];
        
    });
    
    return videoControl;
}


-(void)dismiss
{
    [videoControl.playerView dismiss];
    
}
-(void)playerWithModel:(ZFPlayerModel*)model
{
    [videoControl.playerView resetPlayer];
    [videoControl.playerView playerModel:model];
    [videoControl.playerView autoPlayTheVideo];
}


#pragma mark - Getter / Setter
-(ZFPlayerView *)playerView
{
    if (!_playerView)
    {
        _playerView = [ZFPlayerView sharedPlayerView];
        // 设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
        [_playerView setPlayerLayerGravity:ZFPlayerLayerGravityResizeAspect];
        [_playerView setHasBack:NO];
    }
    
    return _playerView;
}


@end
