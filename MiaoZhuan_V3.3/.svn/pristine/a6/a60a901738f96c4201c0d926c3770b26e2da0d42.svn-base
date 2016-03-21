//
//  BuyRecordsCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-20.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "BuyRecordsCell.h"

@implementation BuyRecordsCell

+ (instancetype)newInstance{
    BuyRecordsCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"BuyRecordsCell" owner:nil options:nil] firstObject];
    if (cell) {
        cell.line.top = 239.5;
    }
    return cell;
}

- (void)createNewInstanceWithRow:(NSInteger)row dataDic:(NSDictionary *)dataDic{
    DictionaryWrapper *dic = [dataDic wrapper];
    //公司名称
    NSString *company = [dic getString:@"EnterpriseName"];
    CGSize size = [UICommon getSizeFromString:company withSize:CGSizeMake(_lblCompany.width, MAXFLOAT) withFont:14];
    _lblCompany.height = size.height;
    if (size.height > 20) {
        _lblCompany.top = 8;
    } else {
        _lblCompany.top = 16;
    }
    _lblCompany.text = company;
    
    long state = [dic getLong:@"OrderStatus"];    
    switch (state) {
        case 101:
        {
            //未付款
            _lblSingleStatus.text = @"等待付款";
            _doubleView.hidden = YES;
            _btnFront.tag = 2000000 + row;
            [_btnFront setTitle:@"取消订单" forState:UIControlStateNormal];
            _btnFollow.tag = 3000000 + row;
            [_btnFollow setTitle:@"去付款" forState:UIControlStateNormal];
        }
            break;
        case 106:
        {
            //106: 等待银行转账
            _lblSingleStatus.text = @"等待银行转账";
            _doubleView.hidden = YES;
            _btnFront.tag = 2000000 + row;
            [_btnFront setTitle:@"取消订单" forState:UIControlStateNormal];
            _btnFollow.tag = 4000000 + row;
            [_btnFollow setTitle:@"去转账" forState:UIControlStateNormal];
        }
            break;
        case 107:
        {
            //107：等待POS转账
            _lblSingleStatus.text = @"等待快钱POS转账";
            _doubleView.hidden = YES;
            _btnFront.tag = 2000000 + row;
            [_btnFront setTitle:@"取消订单" forState:UIControlStateNormal];
            _btnFollow.tag = 5000000 + row;
            [_btnFollow setTitle:@"去转账" forState:UIControlStateNormal];
        }
            break;
        case 102:
        {
            //付款中
            _lblDoubleStatus.text = @"处理中";
            _lblDoubleDetail.text = @"请等待";
            _doubleView.hidden = NO;
            _btnFront.hidden = YES;
            _btnFollow.tag = 7000000 + row;
            [_btnFollow setTitle:@"刷新状态" forState:UIControlStateNormal];
        }
            break;
        case 103:
        {
            //联系客服 103：银行转账审核中
            _lblSingleStatus.text = @"审核中";
            _doubleView.hidden = YES;
            _btnFront.hidden = YES;
            _btnFollow.tag = 8000000 + row;
            [_btnFollow setTitle:@"联系客服" forState:UIControlStateNormal];
        }
            break;
        case 108:
        {
            //108：POS转账审核中
            _lblSingleStatus.text = @"审核中";
            _doubleView.hidden = YES;
            _btnFront.hidden = YES;
            _btnFollow.tag = 20000 + row;
            [_btnFollow setTitle:@"联系客服" forState:UIControlStateNormal];
        }
            break;
        case 901:
            //未付款
            _lblSingleStatus.text = @"交易成功";
            _doubleView.hidden = YES;
            _btnFront.hidden = YES;
            _btnFollow.tag = 1000000 + row;
            [_btnFollow setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        case 104:
            //104：银行转账审核失败
            _lblSingleStatus.text = @"审核失败";
            _doubleView.hidden = YES;
            _btnFront.hidden = YES;
            _btnFollow.tag = 1000000 + row;
            [_btnFollow setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        case 109:
            //109：POS转账审核失败
            _lblSingleStatus.text = @"审核失败";
            _doubleView.hidden = YES;
            _btnFront.hidden = YES;
            _btnFollow.tag = 1000000 + row;
            [_btnFollow setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        case 911:
            //未付款
            _lblSingleStatus.text = @"交易关闭";
            _doubleView.hidden = YES;
            _btnFront.hidden = YES;
            _btnFollow.tag = 1000000 + row;
            [_btnFollow setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    [self round:_btnFollow];
    [self round:_btnFront];
    
    _lblOrderNum.text = [NSString stringWithFormat:@"订单号：%@",[dic getString:@"OrderSerialNo"]];
    _lblDetail.text = [dic getString:@"Title"];
    _lblPrice.text = [NSString stringWithFormat:@"￥%.2f",[dic getFloat:@"OrderAmount"]];
}

- (void)round:(UIButton *)button{
    [button setRoundCorner];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
}

- (void)addAction:(id)obj withAction:(SEL)selector{
    [_btnFront addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [_btnFollow addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_lblSingleStatus release];
    [_lblDoubleStatus release];
    [_lblDoubleDetail release];
    [_doubleView release];
    [_lblCompany release];
    [_lblDetail release];
    [_lblOrderNum release];
    [_btnFront release];
    [_btnFollow release];
    [_lblPrice release];
    [_line release];
    [super dealloc];
}
@end
