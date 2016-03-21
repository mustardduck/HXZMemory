//
//  ConsultAndAnswerCell.m
//  miaozhuan
//
//  Created by Santiago on 14-12-6.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "ConsultAndAnswerCell.h"

@implementation ConsultAndAnswerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [_delBtn addTarget:self action:@selector(delRequest) forControlEvents:UIControlEventTouchUpInside];
}

- (void)delRequest {

    ADAPI_adv3_MessageDelete([GLOBAL_DELEGATOR_MANAGER addDelegator:self selector:@selector(requestArguments:)],_messageID,_cellType);
}

- (void)requestArguments:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    if (wrapper.operationSucceed) {
        
        if (_delegate) {
            
            [_delegate deleteMessage:self atIndexPath:_thisIndexPath];
        }
    }else {
    
    }
}

- (void)dealloc {
    [_delBtn release];
    [_consultText release];
    [_answerText release];
    [_earlierReplyText release];
    [_messageDate release];
    [_littleGrayLine release];
    [_answerImage release];
    [_fromCompanyName release];
    [_UIButtomLineView release];
    [_delMessageImage release];
    [_fromMerchantTitle release];
    [_topGrayView release];
    [_consultMessage release];
    [super dealloc];
}
@end
