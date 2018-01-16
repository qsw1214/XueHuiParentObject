//
//  XHCookDetailsContentView.m
//  daycareParent
//
//  Created by Git on 2017/12/5.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCookDetailsContentView.h"


@interface XHCookDetailsContentView () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) BaseButtonControl *titleControl; //!< 标题标签

@end

@implementation XHCookDetailsContentView

- (instancetype)initWithDeletage:(id)deletage
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.titleControl];
        [self addSubview:self.tableView];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setBackgroundColor:[UIColor whiteColor]];
        [self.tableView setShowsVerticalScrollIndicator:NO];
        [self.tableView setShowsHorizontalScrollIndicator:NO];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.titleControl resetFrame:CGRectMake(0, 0, frame.size.width, 40.0)];
    [self.titleControl setTitleEdgeFrame:CGRectMake(10.0, 0, self.titleControl.width-20.0, self.titleControl.height) withNumberType:0 withAllType:NO];
    [self.tableView resetFrame:CGRectMake(0, self.titleControl.bottom, frame.size.width, frame.size.height-self.titleControl.height)];
}


-(void)setItemObject:(XHCookBookFrame*)object
{
    [self.titleControl setText:object.model.weekAndDate withNumberType:0 withAllType:NO];
    [self.dataArray setArray:object.model.contentArray];
    [self.tableView reloadData];
    
    
}




#pragma mark - Deletage Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (XHCookBookCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHCookBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[XHCookBookCell alloc]init];
    }
    [cell setItemFrame:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray objectAtIndex:indexPath.row] cellHeight];
}




#pragma mark - Getter / Setter
-(BaseButtonControl *)titleControl
{
    if (_titleControl == nil)
    {
        _titleControl = [[BaseButtonControl alloc]init];
        [_titleControl setNumberLabel:1];
        [_titleControl setBackgroundColor:RGB(245, 245, 245)];
        [_titleControl setFont:FontLevel3 withNumberType:0 withAllType:NO];
        [_titleControl setTextColor:RGB(51, 51, 51) withTpe:0 withAllType:NO];
        
    }
    return _titleControl;
}
@end
