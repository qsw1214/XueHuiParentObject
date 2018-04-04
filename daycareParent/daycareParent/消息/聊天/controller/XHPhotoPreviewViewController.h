//
//  XHPhotoPreviewViewController.h
//  TLMessageView
//
//  Created by 郭锐 on 16/8/25.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "TLPhotoBrowser.h"

@protocol XHPhotoPreviewDelegate <NSObject>
-(void)selectedPhoto:(PHAsset *)photo;
-(void)removePhoto:(PHAsset *)photo;
-(void)sendPhotos;
@end

@interface XHPhotoPreviewViewController : UIViewController
@property(nonatomic,assign)id <XHPhotoPreviewDelegate> delegate;
-(instancetype)initWithSelectedAsset:(PHAsset *)selectedAsset assets:(NSArray *)asstes;
@end


@interface TLCountLabel : UILabel

@end


@interface TLPhotoPreviewCell : UICollectionViewCell
@property(nonatomic,strong)TLImageScrollView *imgScrollView;
@property(nonatomic,strong)PHAsset *asset;
@end
