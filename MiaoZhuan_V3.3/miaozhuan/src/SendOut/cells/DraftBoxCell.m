//
//  DraftBoxCell.m
//  miaozhuan
//
//  Created by 孙向前 on 14-11-19.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "DraftBoxCell.h"

@implementation DraftBoxCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataDic:(NSDictionary *)dataDic{
    DictionaryWrapper *dic = [dataDic wrapper];
    //标题
    NSString *title = [[dic getString:@"Name"] length] ? [dic getString:@"Name"] : @"未填写广告名称";
    CGSize size = [UICommon getSizeFromString:title withSize:CGSizeMake(_lblTitle.width, MAXFLOAT) withFont:15];
    
    if (_state != 2 && _state != 6) {
        if (size.height < 21) {
            self.lblTitle.top = 28;
            self.lblTime.top = 53;
            self.lblTitle.height = 21;
        } else {
            self.lblTitle.top = 23;
            self.lblTime.top = 65
            ;
            self.lblTitle.height = 38;
        }
    } else {
        
        _lblWatchedNum.hidden = _lblPlayedNum.hidden = NO;
        
        _lblTitle.top = 20;
        _lblTitle.height = size.height > 35 ? 38 : size.height;
        _lblTitle.text = title;
        
        //已播放次数
        _lblPlayedNum.top =_lblTitle.bottom + 2;
        _lblPlayedNum.text = [NSString stringWithFormat:@"已投放人数 %d", [dic getInt:@"PutCount"]];
        
        //已收看人数
        _lblWatchedNum.top =_lblPlayedNum.bottom + 2;
        _lblWatchedNum.text = [NSString stringWithFormat:@"已收看人数 %d", [dic getInt:@"ReadCount"]];
        
    }
    
    _lblTitle.text = title;
    //图片
    [_imageview requestWithRecommandSize:[dic getString:@"PictureUrl"]];
    _imageview.layer.masksToBounds = YES;
    self.layer.cornerRadius = 0.f;
    _imageview.layer.borderColor = RGBCOLOR(197, 197, 197).CGColor;
    _imageview.layer.borderWidth = 0.5;
    //时间
    switch (_state) {
        case 0:
        {
            //草稿箱
            NSString *time = [UICommon formatTime:[dic getString:@"LastUpdateTime"]];
            _lblTime.text = [NSString stringWithFormat:@"保存于%@", [UICommon formatTime:time]];
        }
            break;
        case 1:
            
            break;
        case 2:
        {
            //播放中
            _lblTime.top = _lblWatchedNum.bottom + 2;
            
            NSString *startTime = [dic getString:@"StartTime"];
            NSString *endTime = [dic getString:@"EndTime"];
            NSString *str = [UICommon countWithFromDate:startTime toDate:endTime];
            _lblTime.text = [NSString stringWithFormat:@"剩余有效期%@", str];
            
            self.height = _lblTime.bottom + 12;
        }
            break;
        case 3:
        {
            //即将播放
            NSString *startTime = [UICommon formatDate:[dic getString:@"StartTime"]];
            _lblTime.text = [NSString stringWithFormat:@"播放时间：%@", startTime];
        }
            break;
        case 4:
        {
            //审核中
            NSString *auditTime = [UICommon formatTime:[dic getString:@"AuditTime"]];
            _lblTime.text = [NSString stringWithFormat:@"于%@提交审核", auditTime];
        }
            break;
        case 5:
        {
            //审核失败
            NSString *auditFalse = [UICommon formatTime:[dic getString:@"AuditFalse"]];
            _lblTime.text = [NSString stringWithFormat:@"于%@审核失败", auditFalse];
        }
            break;
        case 6:
        {
            //播放完毕
            _lblTime.top = _lblWatchedNum.bottom + 2;
            
            NSString *endTime = [UICommon formatTime:[dic getString:@"FinishTime"]];
            _lblTime.text = [NSString stringWithFormat:@"于%@广告下架", endTime];
            self.height = _lblTime.bottom + 12;
        }
            break;
            
        default:
            break;
    }
    
}

- (void)dealloc {
    [_lblWatchedNum release];
    [_lblPlayedNum release];
    [_dataDic release];
    [_lblTitle release];
    [_lblTime release];
    [_imageview release];
    [super dealloc];
}
@end
