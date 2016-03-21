//
//  RequestFailedView.m
//  miaozhuan
//
//  Created by 孙向前 on 15-1-23.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "RequestFailedView.h"

static RequestFailedView *shareInstance;

@implementation RequestFailedView

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!shareInstance)
        {
            shareInstance = [[RequestFailedView alloc] init];
        }
    });
    return shareInstance;
}

- (UIView *)createFailedHoverViewWithFrame:(CGRect)frame{
    self.frame = frame;
    
    //感叹图标
    UIImageView *warnIcon = WEAK_OBJECT(UIImageView, initWithFrame:CGRectMake((SCREENWIDTH - 88)/2 , 64, 88, 77));
    warnIcon.image = [UIImage imageNamed:@"warning.png"];
    
    //数据加载失败
    UILabel *lblFailed = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(50, 155, 220, 21));
    lblFailed.textAlignment = NSTextAlignmentCenter;
    lblFailed.text = @"数据加载失败";
    lblFailed.font = Font(19);
    lblFailed.textColor = AppColor(34);
    
    //失败原因
    UILabel *lblReason = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(20, 200, 300, 21));
    lblReason.text = @"失败原因可能是：";
    lblReason.font = Font(15);
    lblReason.textColor = AppColor(153);
    
    UILabel *lblReason1 = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(20, 230, 300, 21));
    lblReason1.text = @"1．本页面内容已不存在";
    lblReason1.font = Font(15);
    lblReason1.textColor = AppColor(153);
    
    UILabel *lblReason2 = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(20, 350, 300, 21));
    lblReason2.text = @"２．本页面加载失败";
    lblReason2.font = Font(15);
    lblReason2.textColor = AppColor(153);
    
    NSString *str = @"３．您的网络异常，请检查网络";
    CGSize size = [UICommon getSizeFromString:str withSize:CGSizeMake(MAXFLOAT, 21) withFont:15];
    UILabel *lblReason3 = WEAK_OBJECT(UILabel, initWithFrame:CGRectMake(20, 370, 300, 21));
    lblReason3.text = str;
    lblReason3.width = size.width;
    lblReason3.font = Font(15);
    lblReason3.textColor = AppColor(153);
    
    
    UIButton *btnRefresh = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRefresh.frame = CGRectMake(lblReason3.right + 5, 370, 80, 21);
    [btnRefresh setTitle:@"重新加载" forState:UIControlStateNormal];
    [btnRefresh setTitleColor:RGBCOLOR(40, 130, 220) forState:UIControlStateNormal];
    [btnRefresh setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    [btnRefresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubviews:warnIcon, lblFailed, lblReason, lblReason1, lblReason2, lblReason3, btnRefresh, nil];
    
    return self;
}

- (void)refresh:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickRefreshBUtton)]) {
        [_delegate didClickRefreshBUtton];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
