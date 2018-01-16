//
//  XHDynamicsPreviewCollectionViewCell.m
//  daycareParent
//
//  Created by Git on 2017/12/22.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHDynamicsPreviewCollectionViewCell.h"

@interface XHDynamicsPreviewCollectionViewCell ()


@property (nonatomic,strong) UIImageView *previewImageView; //!< 预览视图
@property (nonatomic,strong) BaseButtonControl *saveImageControl; //!< 保存图片按钮



@end

@implementation XHDynamicsPreviewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setItemColor:NO];
        [self.contentView addSubview:self.previewImageView];
        [self.contentView addSubview:self.saveImageControl];
        [self.previewImageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.saveImageControl resetFrame:CGRectMake(frame.size.width-80.0, frame.size.height-90.0, 50.0, 50.0)];
        [self.saveImageControl setImageEdgeFrame:CGRectMake((self.saveImageControl.width-30.0)/2.0, (self.saveImageControl.height-30.0)/2.0, 30.0, 30.0) withNumberType:0 withAllType:NO];
    }
    return self;
}


#pragma mark - Action Method
-(void)saveImageControlAction:(BaseButtonControl*)sender
{
    [XHShowHUD showTextHud];
     UIImageWriteToSavedPhotosAlbum(self.previewImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [XHShowHUD hideHud];
    if (error)
    {
        [XHShowHUD showNOHud:@"保存失败"];
    }
    else
    {
        [XHShowHUD showOKHud:@"保存成功!"];
    }
}




#pragma mark - Getter / Setter
-(UIImageView *)previewImageView
{
    if (!_previewImageView)
    {
        _previewImageView = [[UIImageView alloc]init];
        [_previewImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _previewImageView;
}

-(BaseButtonControl *)saveImageControl
{
    if (!_saveImageControl)
    {
        _saveImageControl = [[BaseButtonControl alloc]init];
        [_saveImageControl setNumberImageView:1];
        [_saveImageControl setImage:@"ico_save" withNumberType:0 withAllType:NO];
        [_saveImageControl addTarget:self action:@selector(saveImageControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveImageControl;
}



-(void)setItemObject:(XHPreviewModel*)object
{
    [self.previewImageView sd_setImageWithURL:[NSURL URLWithString:ALGetFileImageOriginal(object.previewPic)]];
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.saveImageControl setBackgroundColor:[UIColor grayColor]];
    }
}



@end
