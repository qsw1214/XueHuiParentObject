//
//  XHPhotoPickerViewController.h
//  TLMessageView
//
//  Created by 郭锐 on 16/8/25.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@protocol XHPhotoPickerDelegate <NSObject>
-(void)didSendPhotos:(NSArray *)photos;
@end

@interface XHPhotoPickerViewController : UIViewController
@property(nonatomic,assign)id <XHPhotoPickerDelegate> delegate;
-(instancetype)initWithDelegate:(id <XHPhotoPickerDelegate>)delegate;
-(void)sendPhotoAction;
@end
