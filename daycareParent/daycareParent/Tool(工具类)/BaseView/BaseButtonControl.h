//
//  BaseButtonControl.h
//  ZhongBangShop
//
//  Created by XueHui on 2017/10/10.
//  Copyright © 2017年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextView.h"





typedef struct UIEdgeFrame {
    CGFloat x, y, width, height;
} UIEdgeFrame;

typedef NS_ENUM(NSInteger,BaseButtonControlSelectType)
{
    BaseButtonControlSelectNormalType = 0,
    BaseButtonControlSelectMarkType = 1,
};


typedef NS_ENUM(NSInteger,BaseControlItemType)
{
    BaseOneItemType = 0, //!< 图片类型
    BaseTwoItemType = 1, //!< 图片类型
    BaseThreeItemType = 2, //!< 图片类型
    BaseFourItemType = 3, //!< 图片类型
    BaseFiveItemType = 4, //!< 图片类型
};

typedef NS_ENUM(NSInteger,BaseControlModelType)
{
    CenterType = 0, //!< 居中类型
    VerticalType = 1, //!< 垂直类型
    HorizontalType = 2, //!< 水平类型
};



@interface BaseButtonControl : UIControl

@property (nonatomic,assign) BaseButtonControlSelectType selectType; //!<是否已经选择
@property (nonatomic,assign) BaseControlModelType contentModelType;


-(instancetype)init;

-(void)setNumberLabel:(NSInteger)numberLabel;
-(void)setNumberTextField:(NSInteger)numberTextField;
-(void)setNumberTextView:(NSInteger)numberTextView;
-(void)setNumberLineView:(NSInteger)numberLineView;
-(void)setNumberImageView:(NSInteger)numberImageView;



#pragma mark - 获取标签内容
#pragma mark 获取输入内容
-(NSString*)textViewTitlewithNumberType:(NSInteger)type;

-(NSString*)textFieldTitlewithNumberType:(NSInteger)type;

-(NSString*)labelTitlewithNumberType:(NSInteger)type;

#pragma mark - 设置输入模式
-(void)setKeyboardType:(UIKeyboardType)keyboardType withNumberType:(NSInteger)type withAllType:(BOOL)allType; //!< 设置键盘模式


#pragma mark - Hidden
-(void)setImageHidden:(BOOL)hidden withNumberType:(NSInteger)type withAllType:(BOOL)allType;

-(void)setTitleHidden:(BOOL)hidden withNumberType:(NSInteger)type withAllType:(BOOL)allType;

-(void)setlineViewHidden:(BOOL)hidden withNumberType:(NSInteger)type withAllType:(BOOL)allType;


-(void)setTextViewHidden:(BOOL)hidden withNumberType:(NSInteger)type withAllType:(BOOL)allType;


-(void)setTextFieldHidden:(BOOL)hidden withNumberType:(NSInteger)type withAllType:(BOOL)allType;

#pragma mark - EdgeFrame
#pragma mark 设置图片的具体位置
/**
 设置图片的具体位置
 */
-(void)setImageEdgeFrame:(CGRect)edgeInset withNumberType:(NSInteger)type withAllType:(BOOL)allType;




#pragma mark 设置文本标签的具体位置
/**
 设置文本标签的具体位置
 */
-(void)setTitleEdgeFrame:(CGRect)edgeInset withNumberType:(NSInteger)type withAllType:(BOOL)allType;


/**
 设置描述文本标签的具体位置
 */
-(void)setInputEdgeFrame:(CGRect)edgeInset withNumberType:(NSInteger)type withAllType:(BOOL)allType;


/**
 设置描述文本标签的具体位置
 */
-(void)setInputTextViewEdgeFrame:(CGRect)edgeInset withNumberType:(NSInteger)type withAllType:(BOOL)allType;




#pragma mark - resetFrame

#pragma mark 重置当前视图的Frame
/**
 @param frame 重置frane
 */
-(void)resetFrame:(CGRect)frame;

#pragma mark 重置当前是分割线的的Frame
/**
 重置Frame
 */
-(void)resetLineViewFrame:(CGRect)frame withNumberType:(NSInteger)type withAllType:(BOOL)allType;








#pragma mark - 文本输入框颜色
/**
 设置描述文字的颜色
 */
-(void)setInputTextColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType;



#pragma mark 文本输入框TintColor颜色
/**
 设置描述文字的颜色
 */
-(void)setInputTintColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType;
#pragma mark 设置文本输入框的字体大小
/**
 设置描述标题
 */
-(void)setinputTextFont:(UIFont*)font withNumberType:(NSInteger)type withAllType:(BOOL)allType;


#pragma mark - 文本输入域内容颜色
/**
 文本输入域内容颜色
 */
-(void)setInputTextViewColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType;




#pragma mark 文本输入域占位字符
-(void)setTextViewPlaceholderColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType;
/**
 设置描述文字的颜色
 */
-(void)setInputTextViewBackGroundColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType;

#pragma mark - 设置标签的文字

/**
 设置标签的文字
 @param text 文本内容
 @param type 要设置的文本标号
 */
-(void)setText:(NSString*)text withNumberType:(NSInteger)type withAllType:(BOOL)allType;


#pragma mark 设置标签的圆角模式
/**
 设置图片的layer的圆角弧度
 */
-(void)setLabelLayerCornerRadius:(CGFloat)radius withNumberType:(NSInteger)type withAllType:(BOOL)allType;


#pragma mark  设置文字显示位置
/**
 设置文字的位置
 */
-(void)setTextAlignment:(NSTextAlignment)alignment withNumberType:(NSInteger)type withAllType:(BOOL)allType;
#pragma mark 设置字体大小 UIFont
/**
 设置字体大小
 */
-(void)setFont:(UIFont*)font withNumberType:(NSInteger)type withAllType:(BOOL)allType;

#pragma mark 设置文本标签的颜色
/**
 设置字体大小
 */
-(void)setTextColor:(UIColor*)color withTpe:(NSInteger)type withAllType:(BOOL)allType;

#pragma mark 设置文本标签的背景颜色
/**
 设置文本标签的背景颜色
 @paran color 文本标签的背景颜色
 @paran type 第几个文本标签的背景颜色
 @paran allType 当前控件上是否设置全部文本标签的背景颜色
 */
-(void)setTextBackGroundColor:(UIColor*)color withTpe:(NSInteger)type withAllType:(BOOL)allType;

#pragma mark 设置标签的行数
/**
 设置标签的行数
 */
-(void)setNumberOfLines:(NSInteger)lines withTpe:(NSInteger)type withAllType:(BOOL)allType;



#pragma mark - 设置图片内容的填充模式
-(void)setImageContentMode:(UIViewContentMode)mode withNumberType:(NSInteger)type withAllType:(BOOL)allType;




#pragma mark 设置图片的圆角模式
/**
 设置图片的layer的圆角弧度
 */
-(void)setImageLayerCornerRadius:(CGFloat)radius withNumberType:(NSInteger)type withAllType:(BOOL)allType;

#pragma mark 设置图片的背景颜色
/**
 设置背景图片的颜色
 */
-(void)setIconImageViewBackGroundColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType;
#pragma mark 设置图片的图标名称
/**
 设置图标名称
 */
-(void)setImage:(NSString*)imageName withNumberType:(NSInteger)type withAllType:(BOOL)allType;


#pragma mark 设置按钮图片名称
/**
 @param imageName 图片名称
 */
#pragma mark 设置图片的URL地址
-(void)sd_setImageWithURL:(NSString*)url withNumberType:(NSInteger)type withAllType:(BOOL)allType;

#pragma mark 设置图片的URL地址
-(void)sd_setImageWithURL:(NSString*)url withPlaceholder:(NSString*)placeholder withNumberType:(NSInteger)type withAllType:(BOOL)allType;
#pragma mark - 取消第一响应者
-(void)resignInputFirstResponder;


@end
