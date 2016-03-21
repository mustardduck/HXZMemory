//
//  MyMarketMyOrderCell.m
//  miaozhuan
//
//  Created by momo on 14/12/27.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "MyMarketMyOrderCell.h"
#import "UIView+expanded.h"

@implementation MyMarketMyOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) initWithDic:(NSDictionary *)dic
{
    NSString * enterName = [dic.wrapper getString:@"EnterpriseName"];
    
    if(_compLbl.text.length)
    {
        self.compLbl.text = enterName;
    }
    
    NSString * picUrl = [dic.wrapper getString:@"PictureUrl"];
    
    [_prodImgView borderLayer];
    
    [_prodImgView requestPic:picUrl placeHolder:NO];
    
    NSString *orderName = [dic.wrapper getString:@"ProductName"];
    
    self.prodLbl.text = [orderName length] > 0 ? orderName : @"未填写";
    
    self.numLbl.text = [NSString stringWithFormat:@"x %d", [dic.wrapper getInt:@"Count"] ];
    
    double totalPrice = [dic.wrapper getDouble:@"TotalPrice"];
    
    int orderType = [dic.wrapper getInt:@"OrderType"];
    
    NSString * payMoneyText = @"";
    
    if(orderType == 0)//订单类型 0-银元（邮寄），1-易货码
    {
        payMoneyText = [NSString stringWithFormat:@"%d银元", [dic.wrapper getInt:@"TotalPrice"]];
    }
    else if (orderType == 1)
    {
        payMoneyText = [NSString stringWithFormat:@"%0.2f易货码", totalPrice];
    }
    self.payMoneyLbl.text = payMoneyText;

    NSString *orderNum = [dic.wrapper getString:@"OrderNo"];
    
    self.orderNumLbl.text = [NSString stringWithFormat:@"订单号：%@", [orderNum length] > 0 ? orderNum : @"暂无"];
    
    [_BtnOne setRoundCorner:5.0f];
    [_BtnTwo setRoundCorner:5.0f];

}

- (void)dealloc {
    [_orderNumLbl release];
    [_payMoneyLbl release];
    [_payBtn release];
    [_paySuccessLbl release];
    [_nameLbl release];
    [_compLbl release];
    [_statusView release];
    [_statusOneLbl release];
    [_statusTwoLbl release];
    [_numLbl release];
    [_BtnOne release];
    [_BtnTwo release];
    [_imgView release];
    [_prodLbl release];
    [_prodImgView release];
    [_compBtn release];
    [_bottomBtnView release];
    [_bottomLbl release];
    [super dealloc];
}


- (void) setCellHandler:(id)obj withAction:(SEL)selector
{
    [_BtnOne addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [_BtnTwo addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [_compBtn addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    
}

@end
