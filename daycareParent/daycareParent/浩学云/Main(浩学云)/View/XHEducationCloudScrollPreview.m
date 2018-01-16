//
//  XHEducationCloudScrollPreview.m
//  daycareParent
//
//  Created by Git on 2017/12/11.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHEducationCloudScrollPreview.h"
#import "SDCycleScrollView.h"

@interface XHEducationCloudScrollPreview () <SDCycleScrollViewDelegate>


@property (nonatomic,strong) SDCycleScrollView *cycleScrollView; //!< 轮播轮动视图




@end



@implementation XHEducationCloudScrollPreview


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSArray *imagesURLStrings = @[@"placeholderImage",@"placeholderImage",@"placeholderImage"];
         self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200.0) shouldInfiniteLoop:YES imageNamesGroup:imagesURLStrings withCurrentPageDotImage:@"pageControlCurrentDot" withPageControlDot:@"pageControlDot"];
        [self.cycleScrollView setDelegate:self];
        [self.cycleScrollView setPageControlStyle:SDCycleScrollViewPageContolStyleAnimated];
        [self.cycleScrollView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [self addSubview:self.cycleScrollView];
    }
    return self;
}



-(void)resetFrame:(CGRect)frame
{
    [super resetFrame:frame];
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height)];
}




-(void)setItemArray:(NSMutableArray *)array
{
    [self.cycleScrollView setImageURLStringsGroup:array];
}




@end
