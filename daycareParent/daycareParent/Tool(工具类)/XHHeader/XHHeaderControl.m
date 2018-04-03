//
//  XHHeaderControl.m
//  daycareParent
//
//  Created by mac on 2018/3/21.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHHeaderControl.h"


@interface XHHeaderControl ()

@property (nonatomic,strong) UIImageView *imageView; //!< 头像视图
@property (nonatomic,strong) UILabel *titleLabel; //!< 名字标签

@end

@implementation XHHeaderControl


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setBackgroundColor:kHeaderColor];
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        
        [self setItemColor:NO];
    }
    return self;
}

-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.imageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}


/**
 头像为空时需要设置用户的名字作为头像

 @param url 头像的url地址
 @param name 用户名
 @param type 类型 1 老师  2 非老师
 */
-(void)setHeadrUrl:(NSString*)url withName:(NSString*)name withType:(XHHeaderType)type
{
    [self.imageView setHidden:NO];
    [self.titleLabel setHidden:NO];
    
    
    
    url = [NSString safeString:url];
    {
        NSInteger length = name.length;
        NSString *makeName = name;
        if ([name isEqualToString:@""])
        {
            [self.titleLabel setText:name];
        }
        else
        {
            //2.截取我们想要的字符串内容
            switch (type)
            {
                case XHHeaderTeacherType:
                {
                    makeName = [name substringWithRange:NSMakeRange(0,1)];
                }
                    break;
                case XHHeaderOtherType:
                {
                    makeName = [name substringWithRange:NSMakeRange((length-1),1)];
                }
                    break;
            }
            
            [self.titleLabel setText:makeName];
        }
        
    }
    
   
    @WeakObj(self);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
     {
         @StrongObj(self);
         if (image)
         {
             [self.titleLabel setHidden:YES];
         }
     }];
    
}



-(void)setImageName:(NSString*)imageName
{
    [self.imageView setImage:[UIImage imageNamed:imageName]];
}



#pragma mark - Getter /  Setter
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
    }
    return _titleLabel;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.imageView setBackgroundColor:[UIColor orangeColor]];
        [self.titleLabel setBackgroundColor:[UIColor purpleColor]];
    }
}
@end
