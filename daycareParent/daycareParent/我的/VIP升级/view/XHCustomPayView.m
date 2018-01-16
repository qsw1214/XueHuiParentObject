//
//  XHCustomPayView.m
//  daycareParent
//
//  Created by 钧泰科技 on 2017/12/4.
//  Copyright © 2017年 XueHui. All rights reserved.
//

#import "XHCustomPayView.h"
#import "XHPayTableViewCell.h"
#import "XHTPayTitleableViewCell.h"

@implementation XHCustomPayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        _view=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-280, SCREEN_WIDTH, 280)];
        _view.backgroundColor=[UIColor whiteColor];
        [self addSubview:_view];
        _moneyImaV=@[@"icoweixin",@"icozhifubao"];
        _moneyTitle=@[@"微信支付",@"支付宝快捷支付"];
       _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
        _tableview.dataSource=self;
        _tableview.delegate=self;
        _tableview.bounces=NO;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_view addSubview:_tableview];
        [_tableview registerNib:[UINib nibWithNibName:@"XHTPayTitleableViewCell" bundle:nil] forCellReuseIdentifier:@"titleCell"];
         [_tableview registerNib:[UINib nibWithNibName:@"XHPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"payCell"];
        UIButton *sureBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, 220, SCREEN_WIDTH-20, 50)];
        sureBtn.layer.cornerRadius=CORNER_BTN;
        sureBtn.backgroundColor=[UIColor orangeColor];
        [sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_view addSubview:sureBtn];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moneyNoti:) name:@"money" object:nil];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0||indexPath.row==1) {
        XHTPayTitleableViewCell *titleCell=[tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
         titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==1) {
            titleCell.titleLa.text=@"选择支付方式";
            titleCell.moneyLab.hidden=YES;
        }
        else
        {
            titleCell.titleLa.text=[self getTitle];
            titleCell.titleLa.textColor=[UIColor orangeColor];
            titleCell.moneyLab.hidden=NO;
            titleCell.selectLab.text=@"需支付";
            titleCell.moneyLab.text=_model.price;
        }
        return titleCell;
    }
    else
    {
        XHPayTableViewCell *payCell=[tableView dequeueReusableCellWithIdentifier:@"payCell" forIndexPath:indexPath];
         payCell.selectionStyle = UITableViewCellSelectionStyleNone;
        payCell.moneyImageView.image=[UIImage imageNamed:_moneyImaV[indexPath.row-2]];
        payCell.moneyTitleLab.text=_moneyTitle[indexPath.row-2];
        _row=2;
        if (indexPath.row==3) {
            payCell.selectImageView.hidden=YES;
        }
        else
        {
            payCell.selectImageView.hidden=NO;
        }
        return payCell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0||indexPath.row==1) {
        return 45;
    }
    else
    {
        return 60;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0||indexPath.row==1) {
        return;
    }
    NSIndexPath *  _indexPath = [NSIndexPath indexPathForRow:_row inSection:0];
    //找到对应的cell
    XHPayTableViewCell *beforCell = [tableView cellForRowAtIndexPath:_indexPath];
    beforCell.selectImageView.hidden=YES;
     XHPayTableViewCell *nowCell = [tableView cellForRowAtIndexPath:indexPath];
      nowCell.selectImageView.hidden=NO;
    _row=indexPath.row;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeCustomView];
}
-(void)sureBtnClick
{
    [self removeCustomView];
    if ([_model.isBuy integerValue]==0) {
        [XHShowHUD showNOHud:@"低于会员等级，不可够买！"];
        return;
    }
    if ([_delegate respondsToSelector:@selector(getPayment:money:)]) {
        [_delegate getPayment:_row==2?@"wx":@"alipay" money:_model.ID];
    }
}
-(void)removeCustomView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _view.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5f];
}
-(void)delayMethod
{
    [self removeFromSuperview];
}
-(void)moneyNoti:(NSNotification *)notification{
    _model=notification.object;
    [_tableview reloadData];

}
-(NSString *)getTitle
{
    if ([_model.unitName containsString:@"月"]) {
        return [NSString stringWithFormat:@"%@一个月",_model.name];
    }
   
    else {
        return [NSString stringWithFormat:@"%@一年",_model.name];
    }

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
