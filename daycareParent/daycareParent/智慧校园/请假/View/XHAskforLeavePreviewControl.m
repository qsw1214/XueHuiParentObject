//
//  XHAskforLeavePreviewControl.m
//  daycareParent
//
//  Created by Git on 2017/12/7.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHAskforLeavePreviewControl.h"
#import "XHAskforLeavePreviewToolBar.h"




@interface XHAskforLeavePreviewControl ()

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,weak) id <XHAskforLeavePreviewControlDeletage> deletage;
@property (nonatomic,strong) XHAskforLeavePreviewToolBar *toolBar; //!< 工具条



@end


@implementation XHAskforLeavePreviewControl





static XHAskforLeavePreviewControl *askforLeave = nil;



+ (instancetype)sharedObject
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        askforLeave = [[self alloc]initWithFrame:WindowScreen];
        [askforLeave setBackgroundColor:[UIColor blackColor]];
        
    });
    
    return askforLeave;
}


-(void)showWithImage:(UIImage*)image withDeletage:(id<XHAskforLeavePreviewControlDeletage>)deletage
{
    [self setDeletage:deletage];
    [askforLeave addSubview:askforLeave.imageView];
    [askforLeave addSubview:askforLeave.toolBar];
    [askforLeave.imageView setImage:image];
    [askforLeave.imageView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [askforLeave.toolBar resetFrame:CGRectMake(0, askforLeave.height-50.0, askforLeave.width, 50.0)];
    
    
    [kWindow addSubview:askforLeave];
}


-(void)dismiss
{
    [askforLeave.imageView setImage:nil];
    [askforLeave setImageView:nil];
    [askforLeave setToolBar:nil];
    [askforLeave removeFromSuperview];
}



#pragma mark - Action Method
-(void)controlAction:(BaseButtonControl*)sender
{
  
    
    
    switch (sender.tag)
    {
#pragma mark case 1 删除按钮
        case 1:
        {
            
            if ([self.deletage respondsToSelector:@selector(askforLeavePreviewControlAction:)])
            {
                [self.imageView setImage:nil];
                [self.deletage askforLeavePreviewControlAction:nil];
            }
        }
            break;
#pragma mark case 2 确定按钮
        case 2:
        {
            if ([self.deletage respondsToSelector:@selector(askforLeavePreviewControlAction:)])
            {
                 [self.deletage askforLeavePreviewControlAction:self.imageView.image];
            }
        }
            break;
    }
      [self dismiss];
}







#pragma mark - Getter / Setter
-(XHAskforLeavePreviewToolBar *)toolBar
{
    if (!_toolBar)
    {
        _toolBar = [[XHAskforLeavePreviewToolBar alloc]init];
        [_toolBar.deleteControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar.confirmControl addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toolBar;
}


-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_imageView.layer setMasksToBounds:YES];
    }
    return _imageView;
}



@end
