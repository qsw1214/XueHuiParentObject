//
//  CameraManageViewController.m
//  TraBook
//
//  Created by Yaolizhi on 16/3/14.
//  Copyright © 2016年 zhs. All rights reserved.
//

#import "CameraManageViewController.h"
#import <AliyunOSSiOS/OSSService.h>

@interface CameraManageViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation CameraManageViewController

#pragma mark - LifeStyle Method

/**
 WithType:
 1.从照相机拍照
 2.从相册拾取图片
 */
-(instancetype)initWithCameraManageWithType:(CameraType)Type setDeletate:(id)imageDeletage
{
    self = [super init];
    if (self)
    {
        [self setCameraDelegate:imageDeletage];
        [self setDelegate:self];
        switch (Type)
        {
            case SourceTypeCamera:
            {
                if ([self isSourceTypeCamera])  //判断是否有相机
                {
                   
                    //相机类型
                    self.modalPresentationStyle= UIModalPresentationOverFullScreen;
                    [self setSourceType:UIImagePickerControllerSourceTypeCamera];
                    [self setMediaTypes:@[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie]];
                }
                else
                {
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"无法调取你的手机相机，请检查你的手机" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                    {
                        [self dismissViewControllerAnimated:YES completion:^{}];
                    }]];
                    [imageDeletage presentViewController:alertController animated:YES completion:^{}];
                                                    
                }
            }
                break;
            case SourceTypeHeadPortraitCamera:
            {
                if ([self isSourceTypeCamera])  //判断是否有相机
                {
                    
                    //相机类型
                    self.modalPresentationStyle= UIModalPresentationOverFullScreen;
                    [self setSourceType:UIImagePickerControllerSourceTypeCamera];
                    [self setMediaTypes:@[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie]];
                    [self setAllowsEditing:YES];
                }
                else
                {
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"无法调取你的手机相机，请检查你的手机" preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                                {
                                                    [self dismissViewControllerAnimated:YES completion:^{}];
                                                }]];
                    [imageDeletage presentViewController:alertController animated:YES completion:^{}];
                    
                }
            }
                break;
            case SourceTypeSavedPhotosAlbum:
            {
                //相机类型
                [self setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
                break;
            case SourceTypeHeadPortraitSavedPhotosAlbum:
            {
                //相机类型
                [self setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
                [self setAllowsEditing:YES];
            }
                break;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter/Setter Method
#pragma mark - Delegate Method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage] ? [info objectForKey:UIImagePickerControllerEditedImage] : [info objectForKey:UIImagePickerControllerOriginalImage];

    if ([self.cameraDelegate respondsToSelector:@selector(imagePickerControllerdidFinishPickingMediaWithImage:)])
    {
        [self.cameraDelegate imagePickerControllerdidFinishPickingMediaWithImage:image];
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}



#pragma mark - Response Method




#pragma mark - Private Method
#pragma mark 以下三个方法是判断用户手机中是否有摄像头、相册和使用浏览模式显示相册
#pragma mark --- 图片库
-(BOOL)isSourceTypePhotosAlbum
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}

#pragma mark --- 列表形式浏览目录
-(BOOL)isSourceTypePhotoLibrary
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

#pragma mark --- 相机
-(BOOL)isSourceTypeCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}


#pragma mark 保存图片信息
-(void)imageWriteToSavedPhotosAlbum:(nonnull UIImage*)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), @"保存照片，用于验证信息");
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(NSString *)contextInfo
{
    if ([contextInfo isEqualToString:@"保存照片，用于验证信息"])
    {
        if (error)
        {
            [XHShowHUD showNOHud:@"保存失败，请重试"];
        }
        else
        {
            [XHShowHUD showNOHud:@"保存成功"];
        }
    }
}


@end
