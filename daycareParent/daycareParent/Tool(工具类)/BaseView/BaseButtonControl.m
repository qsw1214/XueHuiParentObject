//
//  BaseButtonControl.m
//  ZhongBangShop
//
//  Created by XueHui on 2017/10/10.
//  Copyright © 2017年 YX. All rights reserved.
//

#import "BaseButtonControl.h"

@interface BaseButtonControl ()

#pragma mark 显示标签
@property (nonatomic,strong) NSMutableArray *labelArray; //!< 标签数组
#pragma mark 输入标签
@property (nonatomic,strong) NSMutableArray *textFieldArray; //!< 标签数组
#pragma mark 图片视图
@property (nonatomic,strong) NSMutableArray *imageViewArray; //!< 标签数组
#pragma mark 分割线
@property (nonatomic,strong) NSMutableArray *lineViewArray; //!< 标签数组

#pragma mark 文本域输入框
@property (nonatomic,strong) NSMutableArray *textViewArray; //!< 标签数组


@end


@implementation BaseButtonControl


#pragma mark - init初始化
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setItemColor:NO];
    }
    return self;
}




-(void)setNumberLabel:(NSInteger)numberLabel
{
    for (int i = 1; i <=  numberLabel; i++)
    {
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        [self.labelArray addObject:label];
    }
    
}

-(void)setNumberTextField:(NSInteger)numberTextField
{
    for (int i = 1; i <= numberTextField; i++)
    {
        UITextField *textField = [[UITextField alloc]init];
        [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:textField];
        [self.textFieldArray addObject:textField];
    }
}

-(void)setNumberTextView:(NSInteger)numberTextView
{
    for (int i = 1; i <= numberTextView; i++)
    {
        BaseTextView *textView = [[BaseTextView alloc]init];
        [self addSubview:textView];
        [self.textViewArray addObject:textView];
    }
}

-(void)setNumberLineView:(NSInteger)numberLineView
{
    for (int i = 1; i <= numberLineView; i++)
    {
        UIView *lineView = [[UIView alloc]init];
        [lineView setBackgroundColor:RGB(200.0, 200.0, 200.0)];
        [self addSubview:lineView];
        [self.lineViewArray addObject:lineView];
    }
}

-(void)setNumberImageView:(NSInteger)numberImageView
{
    for (int i = 1; i <= numberImageView; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        [self.imageViewArray addObject:imageView];
    }
}







#pragma mark - 获取标签内容
#pragma mark 获取输入内容
-(NSString*)textViewTitlewithNumberType:(NSInteger)type
{
    BaseTextView *object = [self.textViewArray objectAtIndex:type];
    return [NSString safeString:object.text];
}

-(NSString*)textFieldTitlewithNumberType:(NSInteger)type
{
    UITextField *object = [self.textFieldArray objectAtIndex:type];
    return [NSString safeString:object.text];
    
}

-(NSString*)labelTitlewithNumberType:(NSInteger)type
{
    UILabel *object = [self.labelArray objectAtIndex:type];
    return [NSString safeString:object.text];
}

#pragma mark - 设置输入模式
-(void)setKeyboardType:(UIKeyboardType)keyboardType withNumberType:(NSInteger)type withAllType:(BOOL)allType //!< 设置键盘模式
{
    [self.textFieldArray enumerateObjectsUsingBlock:^(UITextField *obj, NSUInteger idx, BOOL *stop)
     {
         if (allType)
         {
             [obj setKeyboardType:keyboardType];
         }
         else if (type)
         {
             [obj setKeyboardType:keyboardType];
         }
     }];
    
}

#pragma mark - Hidden
-(void)setImageHidden:(BOOL)hidden withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setHidden:hidden];
         }
         else if (type)
         {
             [obj setHidden:hidden];
             *stop = YES;
         }
     }];
}


-(void)setTitleHidden:(BOOL)hidden withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setHidden:hidden];
         }
         else if (type)
         {
             [obj setHidden:hidden];
             *stop = YES;
         }
     }];
}

-(void)setlineViewHidden:(BOOL)hidden withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.lineViewArray enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setHidden:hidden];
         }
         else if (type)
         {
             [obj setHidden:hidden];
             *stop = YES;
         }
     }];
}



-(void)setTextViewHidden:(BOOL)hidden withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.textViewArray enumerateObjectsUsingBlock:^(BaseTextView *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setHidden:hidden];
         }
         else if (type)
         {
             [obj setHidden:hidden];
             *stop = YES;
         }
     }];
}


-(void)setTextFieldHidden:(BOOL)hidden withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.textFieldArray enumerateObjectsUsingBlock:^(UITextField *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setHidden:hidden];
         }
         else if (type)
         {
             [obj setHidden:hidden];
             *stop = YES;
         }
     }];
}

#pragma mark - EdgeFrame
#pragma mark 设置图片的具体位置
/**
 设置图片的具体位置
 */
-(void)setImageEdgeFrame:(CGRect)edgeInset withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setHidden:NO];
             [obj setFrame:edgeInset];
             [obj
              setContentMode:UIViewContentModeScaleAspectFit];
             [obj.layer setMasksToBounds:YES];
         }
         else if (type == idx)
         {
             [obj setHidden:NO];
             [obj setFrame:edgeInset];
             [obj
              setContentMode:UIViewContentModeScaleAspectFit];
             [obj.layer setMasksToBounds:YES];
             *stop = YES;
         }
     }];
}





#pragma mark 设置文本标签的具体位置
/**
 设置文本标签的具体位置
 */
-(void)setTitleEdgeFrame:(CGRect)edgeInset withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setFrame:edgeInset];
             [obj setHidden:NO];
         }
         else if (type == idx)
         {
             [obj setFrame:edgeInset];
             [obj setHidden:NO];
             *stop = YES;
         }
     }];
}



/**
 设置描述文本标签的具体位置
 */
-(void)setInputEdgeFrame:(CGRect)edgeInset withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.textFieldArray enumerateObjectsUsingBlock:^(UITextField *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setFrame:edgeInset];
             [obj setHidden:NO];
         }
         else if (type == idx)
         {
             [obj setFrame:edgeInset];
             [obj setHidden:NO];
             *stop = YES;
         }
     }];
}



/**
 设置描述文本标签的具体位置
 */
-(void)setInputTextViewEdgeFrame:(CGRect)edgeInset withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.textViewArray enumerateObjectsUsingBlock:^(BaseTextView *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj resetFrame:edgeInset];
             [obj setHidden:NO];
         }
         else if (type == idx)
         {
             [obj resetFrame:edgeInset];
             [obj setHidden:NO];
             *stop = YES;
         }
     }];
}




#pragma mark - resetFrame

#pragma mark 重置当前视图的Frame
/**
 @param frame 重置frane
 */
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self setHidden:NO];
}



#pragma mark 重置当前是分割线的的Frame
/**
 重置Frame
 */
-(void)resetLineViewFrame:(CGRect)frame withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.lineViewArray enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setFrame:frame];
             [obj setHidden:NO];
         }
         else if (type == idx)
         {
             [obj setFrame:frame];
             [obj setHidden:NO];
             *stop = YES;
         }
     }];
}









#pragma mark - 文本输入框颜色
/**
 设置描述文字的颜色
 */
-(void)setInputTextColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.textFieldArray enumerateObjectsUsingBlock:^(UITextField  *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setTextColor:color];
         }
         else if (type == idx)
         {
              [obj setTextColor:color];
             *stop = YES;
         }
     }];
}



#pragma mark 文本输入框TintColor颜色
/**
 设置描述文字的颜色
 */
-(void)setInputTintColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.textFieldArray enumerateObjectsUsingBlock:^(UITextField  *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
              [obj setTintColor:color];
         }
         else if (type == idx)
         {
             [obj setTintColor:color];
             *stop = YES;
         }
     }];
}


#pragma mark 设置文本输入框的字体大小
/**
 设置描述标题
 */
-(void)setinputTextFont:(UIFont*)font withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.textFieldArray enumerateObjectsUsingBlock:^(UITextField   *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setFont:font];
         }
         else if (type == idx)
         {
             [obj setFont:font];
             *stop = YES;
         }
     }];
}



#pragma mark - 文本输入域内容颜色
/**
 文本输入域内容颜色
 */
-(void)setInputTextViewColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.textViewArray enumerateObjectsUsingBlock:^(BaseTextView  *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setTextColor:color];
         }
         else if (type == idx)
         {
             [obj setTextColor:color];
             *stop = YES;
         }
     }];
}




#pragma mark 文本输入域占位字符
-(void)setTextViewPlaceholderColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.textViewArray enumerateObjectsUsingBlock:^(BaseTextView   *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setBackgroundColor:color];
         }
         else if (type == idx)
         {
             [obj setBackgroundColor:color];
             *stop = YES;
         }
     }];
}
/**
 设置描述文字的颜色
 */
-(void)setInputTextViewBackGroundColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.textFieldArray enumerateObjectsUsingBlock:^(UITextField   *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setBackgroundColor:color];
         }
         else if (type == idx)
         {
             [obj setBackgroundColor:color];
             *stop = YES;
         }
     }];
}


#pragma mark - 设置标签的文字

/**
 设置标签的文字
 @param text 文本内容
 @param type 要设置的文本标号
 */
-(void)setText:(NSString*)text withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel   *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setText:text];
         }
         else if (type == idx)
         {
             [obj setText:text];
             *stop = YES;
         }
     }];
}


#pragma mark 设置标签的圆角模式
/**
 设置图片的layer的圆角弧度
 */
-(void)setLabelLayerCornerRadius:(CGFloat)radius withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel   *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj.layer setCornerRadius:radius];
             [obj.layer setMasksToBounds:YES];
         }
         else if (idx == type)
         {
             [obj.layer setCornerRadius:radius];
             [obj.layer setMasksToBounds:YES];
             *stop = YES;
         }
     }];
}

#pragma mark  设置文字的位置
/**
 设置文字的位置
 */
-(void)setTextAlignment:(NSTextAlignment)alignment withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel   *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setTextAlignment:alignment];
         }
         else if (type == idx)
         {
             [obj setTextAlignment:alignment];
             *stop = YES;
         }
     }];
}

#pragma mark 设置字体大小 UIFont
/**
 设置字体大小
 */
-(void)setFont:(UIFont*)font withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel   *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setFont:font];
         }
         else if (type == idx)
         {
             [obj setFont:font];
             *stop = YES;
         }
     }];
}

#pragma mark 设置文本标签的颜色
/**
 设置字体大小
 */
-(void)setTextColor:(UIColor*)color withTpe:(NSInteger)type withAllType:(BOOL)allType
{
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL *stop)
     {
         if (allType)
         {
             [obj setTextColor:color];
         }
         else if (type == idx)
         {
             [obj setTextColor:color];
             *stop = YES;
         }
     }];
}

#pragma mark 设置文本标签的背景颜色
/**
 设置文本标签的背景颜色
 @paran color 文本标签的背景颜色
 @paran type 第几个文本标签的背景颜色
 @paran allType 当前控件上是否设置全部文本标签的背景颜色
 */
-(void)setTextBackGroundColor:(UIColor*)color withTpe:(NSInteger)type withAllType:(BOOL)allType
{
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL *stop)
     {
         if (allType)
         {
             [obj setBackgroundColor:color];
         }
         else if (type == idx)
         {
             [obj setBackgroundColor:color];
             *stop = YES;
         }
     }];
}



#pragma mark 设置标签的行数
/**
 设置标签的行数
 */
-(void)setNumberOfLines:(NSInteger)lines withTpe:(NSInteger)type withAllType:(BOOL)allType
{
    [self.labelArray enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL *stop)
     {
         if (allType)
         {
         }
         else if (type == idx)
         {
             [obj setNumberOfLines:lines];
             *stop = YES;
         }
     }];
}



#pragma mark - 设置图片内容的填充模式
-(void)setImageContentMode:(UIViewContentMode)mode withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * stop)
     {
         if (allType)
         {
             [obj setContentMode:mode];
         }
         else if (idx == type)
         {
             [obj setContentMode:mode];
             *stop = YES;
         }
         
     }];
}




#pragma mark 设置图片的圆角模式
/**
 设置图片的layer的圆角弧度
 */
-(void)setImageLayerCornerRadius:(CGFloat)radius withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * stop)
     {
         if (allType)
         {
             [obj.layer setCornerRadius:radius];
             [obj.layer setMasksToBounds:YES];
         }
         else if (idx == type)
         {
             [obj.layer setCornerRadius:radius];
             [obj.layer setMasksToBounds:YES];
             *stop = YES;
         }
         
     }];
}



#pragma mark 设置图片的背景颜色
/**
 设置背景图片的颜色
 */
-(void)setIconImageViewBackGroundColor:(UIColor*)color withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView   *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setBackgroundColor:color];
         }
         else if (type == idx)
         {
             [obj setBackgroundColor:color];
             *stop = YES;
         }
     }];
}




#pragma mark 设置图片的图标名称
/**
 设置图标名称
 */
-(void)setImage:(NSString*)imageName withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView   *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj setImage:[UIImage imageNamed:imageName]];
         }
         else if (type == idx)
         {
             [obj setImage:[UIImage imageNamed:imageName]];
             *stop = YES;
         }
     }];
}

#pragma mark 设置图片的URL地址
-(void)sd_setImageWithURL:(NSString*)url withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView   *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
         }
         else if (type == idx)
         {
             [obj sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
             *stop = YES;
         }
     }];
}



#pragma mark 设置图片的URL地址
-(void)sd_setImageWithURL:(NSString*)url withPlaceholder:(NSString*)placeholder withNumberType:(NSInteger)type withAllType:(BOOL)allType
{
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView   *obj, NSUInteger idx, BOOL *  stop)
     {
         if (allType)
         {
             [obj sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholder]];
         }
         else if (type == idx)
         {
             [obj sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholder]];
             *stop = YES;
         }
     }];
}


#pragma mark - 取消第一响应者
-(void)resignInputFirstResponder
{
    for (UITextField *textField in self.textFieldArray)
    {
        [textField resignFirstResponder];
    }
    
    for (BaseTextView *textView in self.textViewArray)
    {
        [textView resignFirstResponder];
    }
    
}



#pragma mark - Getter / Setter
-(NSMutableArray *)imageViewArray
{
    if (_imageViewArray == nil)
    {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

-(NSMutableArray *)labelArray
{
    if (_labelArray == nil)
    {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

-(NSMutableArray *)textFieldArray
{
    if (_textFieldArray == nil)
    {
        _textFieldArray = [NSMutableArray array];
    }
    return _textFieldArray;
}

-(NSMutableArray *)textViewArray
{
    if (_textViewArray == nil)
    {
        _textViewArray = [NSMutableArray array];
    }
    return _textViewArray;
}


-(NSMutableArray *)lineViewArray
{
    if (_lineViewArray == nil)
    {
        _lineViewArray = [NSMutableArray array];
    }
    return _lineViewArray;
}

-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        
    }
}











@end
