//
//  XHLoseSubjectView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2018/3/12.
//  Copyright © 2018年 XueHui. All rights reserved.
//

#import "XHLoseSubjectView.h"
#import "XHSubjectModel.h"
@interface XHLoseSubjectView ()
{
    NSInteger Width;
}
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *buttonArry;
@end


@implementation XHLoseSubjectView
-(instancetype)init
{
    if (self=[super init]) {
        [self addSubview:self.scrollView];
        [self addSubview:self.titleLabel];
    }
    return self;
}
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.titleLabel setFrame:CGRectMake(15, 0, SCREEN_WIDTH-20, 30)];
    [self.scrollView setFrame:CGRectMake(0, self.titleLabel.bottom, frame.size.width, frame.size.height-self.titleLabel.bottom)];
    
}
-(void)setTitle:(NSString *)title
{
    [self.titleLabel setText:title];
}
-(void)setItemArry:(NSMutableArray *)arry
{
    if ([self.buttonArry count])
    {
        Width=0;
        for (int i=0; i<self.buttonArry.count; i++)
        {
            UIButton *btn=self.buttonArry[i];
            [btn removeFromSuperview];
        }
    }
    for (int i=0; i<arry.count; i++) {
        XHSubjectModel *model=arry[i];
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(10*(i+1)+Width, 10, [self getCustomWidth:model.sub], 40)];
        [self setLine:btn];
        [btn setTitle:model.sub forState:UIControlStateNormal];
        [btn setTitleColor:MainColor forState:UIControlStateNormal];
       btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        Width=Width+btn.width;
        [self.scrollView addSubview:btn];
        [self.buttonArry addObject:btn];
    }
  self.scrollView.contentSize=CGSizeMake(Width+10*(arry.count+1), 40);
}
-(UILabel *)titleLabel
{
    if (_titleLabel==nil) {
        _titleLabel=[[UILabel alloc] init];
        _titleLabel.textAlignment=NSTextAlignmentLeft;
        _titleLabel.textColor=RGB(51, 51, 51);
        [_titleLabel setFont:kFont(15.0)];
    }
    return _titleLabel;
}
-(UIScrollView *)scrollView
{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
    }
    return _scrollView;
}
-(CGFloat)getCustomWidth:(NSString *)str
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 40) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;;
    if (str.length==0) {
        return 0;
    }
    else
    {
        return textSize.width+8;
    }
    
}
-(NSMutableArray *)buttonArry
{
    if (_buttonArry==nil) {
        _buttonArry=[[NSMutableArray alloc] init];
    }
    return _buttonArry;
}
-(void)setLine:(UIButton *)lineButton
{
    CAShapeLayer *border = [CAShapeLayer layer];
    
    //虚线的颜色
    border.strokeColor = MainColor.CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:lineButton.bounds cornerRadius:5];
    
    //设置路径
    border.path = path.CGPath;
    
    border.frame = lineButton.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    
    lineButton.layer.cornerRadius = 5.f;
    lineButton.layer.masksToBounds = YES;
    
    [lineButton.layer addSublayer:border];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
