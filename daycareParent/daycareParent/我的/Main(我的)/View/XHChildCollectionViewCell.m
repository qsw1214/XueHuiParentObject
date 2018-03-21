//
//  XHChildCollectionViewCell.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/11/29.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHChildCollectionViewCell.h"
#define NAME_WIDTH
@implementation XHChildCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _childImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 15, USER_HEARD, USER_HEARD)];
        _childImageView.layer.cornerRadius=USER_HEARD/2.0;
        _childImageView.layer.masksToBounds=YES;
        [self.contentView addSubview:_childImageView];
        _childNameLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(0, USER_HEARD+20, USER_HEARD, 20)];
       // _childNameLabel.backgroundColor=[UIColor orangeColor];
        _childNameLabel.textAlignment=NSTextAlignmentCenter;
        _childNameLabel.font=FontLevel3;
        [self.contentView addSubview:_childNameLabel];
        _childClassLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(4, _childNameLabel.bottom+5, USER_HEARD-8, 15)];
        _childClassLabel.textAlignment=NSTextAlignmentCenter;
        _childClassLabel.font=FontLevel4;
        _childClassLabel.textColor=DEFAULTCOLOR;
        //_childClassLabel.backgroundColor=[UIColor redColor];
//        _childClassLabel.layer.cornerRadius=(USER_HEARD-20)/4;
//        _childClassLabel.layer.borderWidth=1;
//        _childClassLabel.layer.borderColor=[[UIColor greenColor] CGColor];
        [self.contentView addSubview:_childClassLabel];
    }
    return self;
}
-(ParentLabel *)headLabel
{
    if (_headLabel==nil) {
        _headLabel=[[ParentLabel alloc] initWithFrame:CGRectMake(0, 15, USER_HEARD, USER_HEARD)];
        _headLabel.layer.cornerRadius=USER_HEARD/2.0;
        _headLabel.layer.masksToBounds=YES;
        [_headLabel setBackgroundColor:MainColor];
        [_headLabel setTextAlignment:NSTextAlignmentCenter];
        [_headLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        [_headLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:_headLabel];
    }
    
    return _headLabel;
}
-(void)setHeadrPic:(NSString*)pic withName:(NSString*)name withType:(XHHeaderType)type
{
    pic = [NSString safeString:pic];
    if ([pic isEqualToString:@""])
    {
        self.headLabel.hidden=NO;
        NSInteger length = name.length;
        NSString *makeName = name;
        if ([name isEqualToString:@""])
        {
            [self.headLabel setText:name];
        }
        else
        {
            //        2.截取我们想要的字符串内容
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
            
            [self.headLabel setText:makeName];
        }
        
    }
    else
    {
        self.headLabel.hidden=YES;
        [self.childImageView sd_setImageWithURL:[NSURL URLWithString:ALGetFileHeadThumbnail(pic)]];
    }
}

@end
