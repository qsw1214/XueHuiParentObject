//
//  CameraManageViewController.h
//  TraBook
//
//  Created by AnyObject（主要用于图片拾取、拍照管理） on 16/3/14.
//  Copyright © 2016年 zhs. All rights reserved.
//
//
//  图片拾取管理控制器
//
//
typedef NS_ENUM(NSInteger,CameraType)
{
    SourceTypeCamera = 1,
    SourceTypeHeadPortraitCamera = 2, //!< 前置摄像头
    SourceTypeSavedPhotosAlbum = 3, //保存相册
    SourceTypeHeadPortraitSavedPhotosAlbum = 4,
};



@protocol CameraManageDeletage <NSObject>

-(void)imagePickerControllerdidFinishPickingMediaWithImage:(nonnull UIImage*)image;

@end




#import <UIKit/UIKit.h>

@interface CameraManageViewController : UIImagePickerController


@property (nonnull,nonatomic,strong) id <CameraManageDeletage> cameraDelegate;

/**
 WithType:
 1.从照相机拍照
 2.从相册拾取图片
 */
-(nullable id)initWithCameraManageWithType:(CameraType)Type setDeletate:(nullable id)imageDeletage;



/**
 用于保存图片
 */
-(void)imageWriteToSavedPhotosAlbum:(nonnull UIImage*)image;

@end
