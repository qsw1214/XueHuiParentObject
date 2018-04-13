//
//  XHPhotoMessageCell.m
//  TLMessageView
//
//  Created by 郭锐 on 16/8/18.
//  Copyright © 2016年 com.garry.message. All rights reserved.
//

#import "XHPhotoMessageCell.h"
#import "TLPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
static  CGFloat fitImgWidth  = 150;
static  CGFloat fitImgHeight = 150;


@interface XHPhotoMessageCell ()
@property(nonatomic,strong)UIImageView *photoImageView;
@property(nonatomic,strong)UIImageView *imageViewMask;
@end

@implementation XHPhotoMessageCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.bubbleImageView addSubview:self.photoImageView];
        [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.bubbleImageView);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImage)];
        [self.photoImageView addGestureRecognizer:tap];
        
    }
    return self;
}
-(void)didClickImage{
    RCImageMessage *imgMessage = (RCImageMessage *)self.message.content;
    kNSLog(imgMessage.imageUrl);
    if (imgMessage.originalImage)
    {
        [TLPhotoBrowser showOriginalImage:imgMessage.originalImage];
    }
    else if ([[XHChatManager shareManager] getRCImage:self.message])
    {
        [TLPhotoBrowser showOriginalImage:[[XHChatManager shareManager] getRCImage:self.message]];
    }
    else
    {
        [TLPhotoBrowser showOriginalImageUrl:imgMessage.imageUrl];
    }
}

-(void)updateMessage:(RCMessage *)message showDate:(BOOL)showDate{
    [super updateMessage:message showDate:showDate];
    RCImageMessage *imgMessage = (RCImageMessage *)message.content;
    self.photoImageView.image = imgMessage.thumbnailImage;
    
    CGSize imgSize = imgMessage.thumbnailImage.size;
    CGFloat scale = imgSize.width / imgSize.height;
    
    CGFloat newWidth  = MAX(MIN(imgSize.width, fitImgWidth), fitImgWidth);
    CGFloat newHeight = MAX(MIN(imgSize.height, fitImgHeight), fitImgHeight);
    
    CGSize newSize = scale > 1 ? CGSizeMake(newWidth, newWidth / scale) : CGSizeMake(newHeight * scale, newHeight);
    
    self.imageViewMask.image = self.bubbleImageView.image;
    self.imageViewMask.frame = CGRectMake(0, 0, newSize.width, newSize.height);
    self.photoImageView.layer.mask = self.imageViewMask.layer;
    
    [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(newSize);
    }];
}

-(UIImageView *)imageViewMask{
    if (!_imageViewMask) {
        _imageViewMask = [[UIImageView alloc] init];
    }
    return _imageViewMask;
}
-(UIImageView *)photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.layer.masksToBounds = YES;
        _photoImageView.userInteractionEnabled = YES;
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_photoImageView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _photoImageView;
}
@end
