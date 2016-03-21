//
//  SalesReturnViewController.m
//  miaozhuan
//
//  Created by Santiago on 14-12-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import "SalesReturnDetailViewController.h"
#import "BaseSalesReturnCell.h"
#import "SalesReturnCell1.h"
#import "SalesReturnCell2.h"
#import "SalesReturnCell3.h"
#import "SalesReturnCell4.h"
#import "SalesReturnCell5.h"
#import "AgreeReturnCell.h"
#import "DisagreeCell.h"
#import "WaitMerchantEnsureCell.h"
#import "PreviewViewController.h"
@interface SalesReturnDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *mainTable;

//看广告详情数据
@property (strong, nonatomic) DictionaryWrapper *user_CustomerReturnApplyDic;
@property (strong, nonatomic) DictionaryWrapper *user_MerchantDisagreeDic;
@property (strong, nonatomic) DictionaryWrapper *user_CustomerReturnLogisticsDic;
@property (strong, nonatomic) DictionaryWrapper *user_AgreeDic;


//发广告详情数据
@property (strong, nonatomic) DictionaryWrapper *merchant_ReturnDetail;
@property (strong, nonatomic) DictionaryWrapper *merchant_MerchantDisagreeDic;
@property (strong, nonatomic) DictionaryWrapper *merchant_MerchantAgreeDic;
@property (strong, nonatomic) DictionaryWrapper *merchant_CustomerReturnLogisticsDic;

@end

@implementation SalesReturnDetailViewController
@synthesize mainTable = _mainTable;
@synthesize orderId = _orderId;
@synthesize status = _status;
@synthesize creatTime = _creatTime;
@synthesize user_CustomerReturnApplyDic = _user_CustomerReturnApplyDic;
@synthesize user_CustomerReturnLogisticsDic = _user_CustomerReturnLogisticsDic;
@synthesize user_MerchantDisagreeDic = _user_MerchantDisagreeDic;

@synthesize merchant_ReturnDetail = _merchant_ReturnDetail;
@synthesize merchant_CustomerReturnLogisticsDic = _merchant_CustomerReturnLogisticsDic;
@synthesize merchant_MerchantAgreeDic = _merchant_MerchantAgreeDic;
@synthesize merchant_MerchantDisagreeDic = _merchant_MerchantDisagreeDic;

MTA_viewDidAppear()
MTA_viewDidDisappear()
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupMoveBackButton];
    [self setTitle:@"协商退货"];
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (_type == 1) {
        
        ADAPI_NegotiateReturnDetail([self genDelegatorID:@selector(requestDataList:)],_orderId);
    }
    
    if (_type == 2) {

        ADAPI_MerchantNegotiateReturnDetail([self genDelegatorID:@selector(requestDataList2:)], _orderId);
    }
}


//看广告回调数据
- (void)requestDataList:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    DictionaryWrapper *item = wrapper.data;
    if (wrapper.operationSucceed) {
        
        self.user_CustomerReturnApplyDic = [item getDictionaryWrapper:@"ReturnApplyFor"];
        self.user_CustomerReturnLogisticsDic = [item getDictionaryWrapper:@"Delivery"];
        self.user_MerchantDisagreeDic = [item getDictionaryWrapper:@"Disagree"];
        self.user_AgreeDic = [item getDictionaryWrapper:@"Agree"];
    }else {
    
        [HUDUtil showErrorWithStatus:@"请求数据失败！"];
    }
    [_mainTable reloadData];
}



//发广告回调数据
-(void)requestDataList2:(DelegatorArguments*)arguments {

    DictionaryWrapper *wrapper = arguments.ret;
    
    if (wrapper.operationSucceed) {
        
        self.merchant_ReturnDetail = wrapper.data;
        self.merchant_MerchantDisagreeDic = [_merchant_ReturnDetail getDictionaryWrapper:@"NotAgreeReturnDetails"];
        self.merchant_MerchantAgreeDic = [_merchant_ReturnDetail getDictionaryWrapper:@"WaitReturnDetails"];
        self.merchant_CustomerReturnLogisticsDic = [_merchant_ReturnDetail getDictionaryWrapper:@"WaitConfirmReturnDetails"];
    }else {
    
        [HUDUtil showErrorWithStatus:@"请求数据失败！"];
    }
    [_mainTable reloadData];
}

- (void)previewPic:(UIButton*)btn {
    
    NSArray *picArray = nil;
    NSArray *disAgreePic = nil;
    
    NSDictionary *url1;
    NSArray *array;
    
    if (_type == 1) {
        
        picArray = [[_user_CustomerReturnApplyDic getArray:@"PictureUrls"] copy];
        disAgreePic = [[_user_MerchantDisagreeDic getArray:@"PictureUrls"] copy];
        
        
        switch (btn.tag) {
            case 1:{
                
                if ([picArray count] > 0) {
                    
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:[[picArray[0] wrapper] getString:@"Url"],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 2:{
                
                if ([picArray count] > 1) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:[[picArray[1] wrapper] getString:@"Url"],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                
                break;}
            case 3:{
                
                if ([picArray count] > 2) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:[[picArray[2] wrapper] getString:@"Url"],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 4:{
                
                if ([picArray count] > 3) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:[[picArray[3] wrapper] getString:@"Url"],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 5:{
                
                if ([picArray count] > 4) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:[[picArray[4] wrapper] getString:@"Url"],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 6:{
                
                if ([disAgreePic count] > 0) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:[[disAgreePic[0] wrapper] getString:@"Url"],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                
                break;}
            case 7:{
                
                if ([disAgreePic count] > 1) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:[[disAgreePic[1] wrapper] getString:@"Url"],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 8:{
                
                if ([disAgreePic count] > 2) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:[[disAgreePic[2] wrapper] getString:@"Url"],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 9:{
                
                if ([disAgreePic count] > 3) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:[[disAgreePic[3] wrapper] getString:@"Url"],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 10:{
                
                if ([disAgreePic count] > 4) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:[[disAgreePic[4] wrapper] getString:@"Url"],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
                
            default:
                break;
        }
    }
    
    if (_type == 2) {
        
        picArray = [[_merchant_ReturnDetail getArray:@"Pictures"] copy];
        disAgreePic = [[_merchant_MerchantDisagreeDic getArray:@"Pictures"] copy];
        
        
        switch (btn.tag) {
            case 1:{
                
                if ([picArray count] > 0) {
                    
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:picArray[0],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 2:{
                
                if ([picArray count] > 1) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:picArray[1],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                
                break;}
            case 3:{
                
                if ([picArray count] > 2) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:picArray[2],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 4:{
                
                if ([picArray count] > 3) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:picArray[3],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 5:{
                
                if ([picArray count] > 4) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:picArray[4],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 6:{
                
                if ([disAgreePic count] > 0) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:disAgreePic[0],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                
                break;}
            case 7:{
                
                if ([disAgreePic count] > 1) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:disAgreePic[1],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 8:{
                
                if ([disAgreePic count] > 2) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:disAgreePic[2],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 9:{
                
                if ([disAgreePic count] > 3) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:disAgreePic[3],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
            case 10:{
                
                if ([disAgreePic count] > 4) {
                    url1 = [[NSDictionary alloc]initWithObjectsAndKeys:disAgreePic[4],@"PictureUrl",nil];
                    array = [[NSArray alloc] initWithObjects:url1,nil];
                }else {
                    
                    return;
                }
                break;}
                
            default:
                break;
        }
    }
    
    PreviewViewController *temp = WEAK_OBJECT(PreviewViewController, init);
    temp.dataArray = array;
    
    
    
    [self presentViewController:temp animated:YES completion:^{
    }];
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_type == 1) {
        switch (_status) {
            case 401:
                
                return 2;
            case 402:
                
                return 3;
            case 403:
                
                return 3;
            case 404:
                
                return 5;
            default:
                return 0;
        }
    }
    
    if (_type == 2) {
        
        switch (_status) {
            case 401:
                
                return 2;
            case 402:
                
                return 3;
            case 403:
                
                return 3;
            case 404:
                
                return 5;
                
            default:
                break;
        }
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //看广告协商退货
    if (_type == 1) {
        
        //申请退货信息
        CGSize user_ReturnReasonSize = [[_user_CustomerReturnApplyDic getString:@"Comment"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        //申请退货更多说明
        CGSize user_MoreStatementSize = [[_user_CustomerReturnApplyDic getString:@"AddComment"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        //拒绝退货信息
        CGSize user_RejectReturnSize = [[_user_MerchantDisagreeDic getString:@"Comment"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        int extraPicHeight = 0;
        int disAgreePicHeight = 0;
        
        if ([[_user_CustomerReturnApplyDic getArray:@"PictureUrls"] count] > 3) {
            
            extraPicHeight = 60;
        }else {
        
            extraPicHeight = 0;
        }
        
        if ([[_user_MerchantDisagreeDic getArray:@"PictureUrls"] count] > 3) {
            
            disAgreePicHeight = 60;
        }else {
        
            disAgreePicHeight = 0;
        }
        
        if (user_MoreStatementSize.height < 17) {
            
            user_MoreStatementSize.height = 14;
        }
    
        if (user_ReturnReasonSize.height < 17) {
            
            user_ReturnReasonSize.height = 14;
        }
        
        if (user_RejectReturnSize.height < 17) {
            
            user_RejectReturnSize.height = 14;
        }
        
        switch (_status) {
            case 401:{
                
                switch (indexPath.row) {
                    case 0:{
                        return 245 + user_ReturnReasonSize.height + user_MoreStatementSize.height - 28 + extraPicHeight;
                    }
                    case 1:{
                        return 217;}
                    default:
                        break;
                }
                break;
            }
                
            case 402:{
                
                switch (indexPath.row) {
                    case 0:{
                        return 245 + user_ReturnReasonSize.height + user_MoreStatementSize.height - 28 + extraPicHeight;}
                    case 1:{
                        return 217;}
                    case 2:{
                        return 153;}
                    default:
                        break;
                }
                break;
            }
                
            case 403:{
                switch (indexPath.row) {
                    case 0:{
                        return 245 + user_ReturnReasonSize.height + user_MoreStatementSize.height - 28 + extraPicHeight;}
                    case 1:{
                        return 217;}
                    case 2:{
                        return 183 + user_RejectReturnSize.height - 14 + disAgreePicHeight;}
                    default:
                        break;
                }
                break;
            }
                
            case 404:{
                
                switch (indexPath.row) {
                    case 0:{
                        return 245 + user_ReturnReasonSize.height + user_MoreStatementSize.height - 28 + extraPicHeight;}
                    case 1:{
                        return 217;
                        break;}
                    case 2:{
                        return 153;
                        break;}
                    case 3:{
                        return 162;
                        break;}
                    case 4:{
                        return 234;
                        break;}
                    default:
                        break;
                }
                break;
            }
            default:
                break;
        }
    }
    
    //发广告协商退货
    if (_type == 2) {
        
        //申请退货信息
        CGSize merchant_ReturnReasonSize = [[_merchant_ReturnDetail getString:@"ReturnReason"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        //申请退货更多说明
        CGSize merchant_MoreStatementSize = [[_merchant_ReturnDetail getString:@"ReturnComment"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        //拒绝退货信息
        CGSize merchant_RejectReturnSize = [[_merchant_MerchantDisagreeDic getString:@"Reason"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        int extraPicHeight = 0;
        int disagreeReturnPicHeight = 0;
        
        if ([[_merchant_ReturnDetail getArray:@"Pictures"] count] > 3) {
            
            extraPicHeight = 60;
        }else {
        
            extraPicHeight = 0;
        }
        
        if ([[_merchant_ReturnDetail getArray:@"Pictures"] count] > 3) {
            
            disagreeReturnPicHeight = 60;
        }else {
        
            disagreeReturnPicHeight = 0;
        }
        
        if (merchant_ReturnReasonSize.height < 17) {
            
            merchant_ReturnReasonSize.height = 14;
        }
        
        if (merchant_MoreStatementSize.height < 17) {
            
            merchant_MoreStatementSize.height = 14;
        }
        
        if (merchant_RejectReturnSize.height < 17) {
            
            merchant_RejectReturnSize.height = 14;
        }
        
        switch (_status) {
            case 401:{
                
                switch (indexPath.row) {
                    case 0:{
                        return 245 + merchant_ReturnReasonSize.height + merchant_MoreStatementSize.height - 28 + extraPicHeight;}
                    case 1:{
                        return 217;}
                    default:
                        break;
                }
                break;
            }
            case 402:{
                
                switch (indexPath.row) {
                    case 0:{
                        return 245 + merchant_ReturnReasonSize.height + merchant_MoreStatementSize.height - 28 + extraPicHeight;
                        break;}
                    case 1:{
                        return 217;}
                    case 2:{
                        return 201;}
                    default:
                        break;
                }
                break;
            }
            case 403:{
                switch (indexPath.row) {
                    case 0:{
                        return 245 + merchant_ReturnReasonSize.height + merchant_MoreStatementSize.height - 28 + extraPicHeight;
                        break;}
                    case 1:{
                        return 217;}
                    case 2:{
                        return 178 + merchant_RejectReturnSize.height - 14 + disagreeReturnPicHeight;}
                    default:
                        break;
                }
                break;
            }
            case 404:{
                
                switch (indexPath.row) {
                    case 0:{
                        return 245 + merchant_ReturnReasonSize.height + merchant_MoreStatementSize.height - 28 + extraPicHeight;}
                    case 1:{
                        return 217;}
                    case 2:{
                        return 201;}
                    case 3:{
                        return 154;}
                    case 4:{
                        return 234;}
                    default:
                        break;
                }
                break;
            }
            default:
                break;
        }
    }
    return 0;
}

- (NSString*)configTime:(NSString*)string {
    
    if (string && ![string isEqualToString:@""]) {
    
        NSArray* array = [string componentsSeparatedByString:@"."];
    
        if ([array count] > 0) {
        
            string = array[0];
        }
    
        NSMutableString *temp2 = WEAK_OBJECT(NSMutableString, init);
    
        array = [string componentsSeparatedByString:@"T"];
    
        if ([array count] > 1) {
            [temp2 appendString:array[0]];
            [temp2 appendString:@" "];
            [temp2 appendString:array[1]];
        }
        string = [NSString stringWithString:temp2];
        
        }
    self.creatTime = [string copy];
    return string;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    BaseSalesReturnCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //看广告协商退货
    if (_type == 1) {
        switch (_status) {
            case 401:{
                
                switch (indexPath.row) {
                    case 0:{
                        
                        cell = [BaseSalesReturnCell createCell:1];
                        ((SalesReturnCell1*)cell).userLabel.text = @"您";
                        ((SalesReturnCell1*)cell).creatTimeLabel.text = [self configTime:[_user_CustomerReturnApplyDic getString:@"CreateTime"]];
                        ((SalesReturnCell1*)cell).cellTitle.text = @"您创建了退货申请";
                        ((SalesReturnCell1*)cell).returnReasonDetail.text = [_user_CustomerReturnApplyDic getString:@"Comment"];
                        ((SalesReturnCell1*)cell).returnAmountDetail.text = [NSString stringWithFormat:@"%.2f",[_user_CustomerReturnApplyDic getFloat:@"ReturnPrice"]];
                        ((SalesReturnCell1*)cell).moreStatementDetail.text = [_user_CustomerReturnApplyDic getString:@"AddComment"];
                        
                        if (![_user_CustomerReturnApplyDic getString:@"AddComment"]||[[_user_CustomerReturnApplyDic getString:@"AddComment"] isEqualToString:@""]) {
                            
                            ((SalesReturnCell1*)cell).moreStatement.text = @"补充说明：(暂无)";
                        }
                        
                        CGSize returnReasonSize = [((SalesReturnCell1*)cell).returnReasonDetail.text sizeWithFont:((SalesReturnCell1*)cell).returnReasonDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (returnReasonSize.height < 17) {
                            
                            returnReasonSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).returnReasonDetail setSize:CGSizeMake(140, returnReasonSize.height)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmount setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmount.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmountDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmountDetail.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatement setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatement.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatementDetail.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        CGSize moreStatementDetailSize = [((SalesReturnCell1*)cell).moreStatementDetail.text sizeWithFont:((SalesReturnCell1*)cell).moreStatementDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (moreStatementDetailSize.height < 17) {
                            moreStatementDetailSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setSize:CGSizeMake(140, moreStatementDetailSize.height)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence1 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence1.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence2 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence2.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence3 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence3.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        int extraPicHeight = 0;
                        
                        NSArray *picArray = [_user_CustomerReturnApplyDic getArray:@"PictureUrls"];
                        
                        if ([picArray count] > 0) {
                            
                            DictionaryWrapper* wrapper1 = [picArray[0]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence1 requestPicture:[wrapper1 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn1 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn1 setOrigin:((SalesReturnCell1*)cell).pictureEvidence1.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = YES;
                            ((SalesReturnCell1*)cell).pictureEvidence.text = @"图片凭证：(暂无)";
                        }
                        if ([picArray count] > 1) {
                            
                            DictionaryWrapper* wrapper2 = [picArray[1]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence2 requestPicture:[wrapper2 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn2 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn2 setOrigin:((SalesReturnCell1*)cell).pictureEvidence2.origin];
                        }else {
                        
                             ((SalesReturnCell1*)cell).pictureEvidence2.hidden = YES;
                        }
                        if ([picArray count] > 2) {
                            
                            DictionaryWrapper* wrapper3 = [picArray[2]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence3 requestPicture:[wrapper3 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn3 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn3 setOrigin:((SalesReturnCell1*)cell).pictureEvidence3.origin];
                        }else {
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = YES;
                        }
                        
                        if ([picArray count] > 3) {
                            
                            DictionaryWrapper* wrapper4 = [picArray[3]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence4 setOrigin:CGPointMake(87, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            [((SalesReturnCell1*)cell).pictureEvidence4 requestPicture:[wrapper4 getString:@"Url"]];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn4 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn4 setOrigin:((SalesReturnCell1*)cell).pictureEvidence4.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = YES;
                        }
                        
                        if ([picArray count] > 4) {
                            
                            DictionaryWrapper* wrapper5 = [picArray[4]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence5 requestPicture:[wrapper5 getString:@"Url"]];
                            [((SalesReturnCell1*)cell).pictureEvidence5 setOrigin:CGPointMake(147, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn5 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn5 setOrigin:((SalesReturnCell1*)cell).pictureEvidence5.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = YES;
                        }
                        
                        [((SalesReturnCell1*)cell).theBackGroundView setSize:CGSizeMake(290, returnReasonSize.height + moreStatementDetailSize.height + 200 - 28 + extraPicHeight)];
                        cell.cellHeight = 238 + returnReasonSize.height + moreStatementDetailSize.height - 28 + extraPicHeight;
                        break;
                    }
                    case 1:{
                        
                        cell = [BaseSalesReturnCell createCell:2];
                        ((SalesReturnCell2*)cell).timeLabel.text = _creatTime;
                        ((SalesReturnCell2*)cell).ifYouAgreeTitle.text = @"如果商家同意:";
                        ((SalesReturnCell2*)cell).cellTitle.text = @"等待商家处理退货申请";
                        ((SalesReturnCell2*)cell).ifYouAgreeDetail.text = @"申请将达成,需您退货给商家";
                        ((SalesReturnCell2*)cell).ifYouRejectTitle.text = @"如果商家拒绝:";
                        ((SalesReturnCell2*)cell).ifYouRejectDetail.text = @"您可以发起官方申诉";
                        ((SalesReturnCell2*)cell).ifYouNotHandleTitle.text = @"如果商家未处理:";
                        ((SalesReturnCell2*)cell).ifYouNotHandleDetail.text = @"超过3天,则申请自动达成,需您退货给商家";
                        cell.cellHeight = 209;
                        break;}
                    default:
                        break;
                }
                break;
            }
                
            case 402:{
                
                switch (indexPath.row) {
                    case 0:{
                        
                        cell = [BaseSalesReturnCell createCell:1];
                        ((SalesReturnCell1*)cell).userLabel.text = @"您";
                        ((SalesReturnCell1*)cell).creatTimeLabel.text = [self configTime:[_user_CustomerReturnApplyDic getString:@"CreateTime"]];
                        ((SalesReturnCell1*)cell).cellTitle.text = @"您创建了退货申请";
                        ((SalesReturnCell1*)cell).returnReasonDetail.text = [_user_CustomerReturnApplyDic getString:@"Comment"];
                        ((SalesReturnCell1*)cell).returnAmountDetail.text = [NSString stringWithFormat:@"%.2f",[_user_CustomerReturnApplyDic getFloat:@"ReturnPrice"]];
                        ((SalesReturnCell1*)cell).moreStatementDetail.text = [_user_CustomerReturnApplyDic getString:@"AddComment"];
                        
                        if (![_user_CustomerReturnApplyDic getString:@"AddComment"]||[[_user_CustomerReturnApplyDic getString:@"AddComment"] isEqualToString:@""]) {
                            
                            ((SalesReturnCell1*)cell).moreStatement.text = @"补充说明：(暂无)";
                        }
                        
                        CGSize returnReasonSize = [((SalesReturnCell1*)cell).returnReasonDetail.text sizeWithFont:((SalesReturnCell1*)cell).returnReasonDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (returnReasonSize.height < 17) {
                            
                            returnReasonSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).returnReasonDetail setSize:CGSizeMake(140, returnReasonSize.height)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmount setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmount.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmountDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmountDetail.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatement setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatement.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatementDetail.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        CGSize moreStatementDetailSize = [((SalesReturnCell1*)cell).moreStatementDetail.text sizeWithFont:((SalesReturnCell1*)cell).moreStatementDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (moreStatementDetailSize.height < 17) {
                            
                            moreStatementDetailSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setSize:CGSizeMake(140, moreStatementDetailSize.height)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence1 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence1.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence2 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence2.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence3 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence3.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        NSArray *picArray = [_user_CustomerReturnApplyDic getArray:@"PictureUrls"];
                        
                        int extraPictureHeight = 0;
                        
                        if ([picArray count] > 0) {
                            
                            DictionaryWrapper* wrapper1 = [picArray[0]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence1 requestPicture:[wrapper1 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn1 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn1 setOrigin:((SalesReturnCell1*)cell).pictureEvidence1.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = YES;
                            ((SalesReturnCell1*)cell).pictureEvidence.text =  @"图片凭证：(暂无)";
                        }
                        if ([picArray count] > 1) {
                            
                            DictionaryWrapper* wrapper2 = [picArray[1]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence2 requestPicture:[wrapper2 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn2 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn2 setOrigin:((SalesReturnCell1*)cell).pictureEvidence2.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = YES;
                        }
                        if ([picArray count] > 2) {
                            
                            DictionaryWrapper* wrapper3 = [picArray[2]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence3 requestPicture:[wrapper3 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn3 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn3 setOrigin:((SalesReturnCell1*)cell).pictureEvidence3.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = YES;
                        }
                        
                        if ([picArray count] > 3) {
                            
                            DictionaryWrapper* wrapper4 = [picArray[3]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence4 setOrigin:CGPointMake(87, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            [((SalesReturnCell1*)cell).pictureEvidence4 requestPicture:[wrapper4 getString:@"Url"]];
                            extraPictureHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn4 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn4 setOrigin:((SalesReturnCell1*)cell).pictureEvidence4.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = YES;
                        }
                        
                        if ([picArray count] > 4) {
                            
                            DictionaryWrapper* wrapper5 = [picArray[4]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence5 requestPicture:[wrapper5 getString:@"Url"]];
                            [((SalesReturnCell1*)cell).pictureEvidence5 setOrigin:CGPointMake(147, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            extraPictureHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn5 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn5 setOrigin:((SalesReturnCell1*)cell).pictureEvidence5.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = YES;
                        }
                        [((SalesReturnCell1*)cell).theBackGroundView setSize:CGSizeMake(290, returnReasonSize.height + moreStatementDetailSize.height + 200 - 28 + extraPictureHeight)];
                        cell.cellHeight = 238 + returnReasonSize.height + moreStatementDetailSize.height - 28 + extraPictureHeight;
                        break;}
                    case 1:{
                        
                        cell = [BaseSalesReturnCell createCell:2];
                        ((SalesReturnCell2*)cell).timeLabel.text = _creatTime;
                        ((SalesReturnCell2*)cell).cellTitle.text = @"等待商家处理的退货申请";
                        ((SalesReturnCell2*)cell).ifYouAgreeTitle.text = @"如果商家同意:";
                        ((SalesReturnCell2*)cell).ifYouAgreeDetail.text = @"申请将达成,需您退货给商家";
                        ((SalesReturnCell2*)cell).ifYouRejectTitle.text = @"如果商家拒绝:";
                        ((SalesReturnCell2*)cell).ifYouRejectDetail.text = @"用户可能发起申诉";
                        ((SalesReturnCell2*)cell).ifYouNotHandleTitle.text = @"如果商家未处理:";
                        ((SalesReturnCell2*)cell).ifYouNotHandleDetail.text = @"超过3天,则申请自动达成,需您退货给商家";
                        cell.cellHeight = 209;
                        break;}
                    case 2:{
                        
                        cell = [BaseSalesReturnCell createCell:7];
                        ((AgreeReturnCell*)cell).timeLabel.text = [self configTime:[_user_AgreeDic getString:@"CreateTime"]];
                        ((AgreeReturnCell*)cell).cellTitle.text = @"商家同意退货";
                        ((AgreeReturnCell*)cell).userLabel.text = @"商家";
                        cell.cellHeight = 153;
                        break;}
                    default:
                        break;
                }
                break;
            }
                
            case 403:{
                switch (indexPath.row) {
                    case 0:{
                        
                        cell = [BaseSalesReturnCell createCell:1];
                        ((SalesReturnCell1*)cell).userLabel.text = @"您";
                        ((SalesReturnCell1*)cell).creatTimeLabel.text = [self configTime:[_user_CustomerReturnApplyDic getString:@"CreateTime"]];
                        ((SalesReturnCell1*)cell).cellTitle.text = @"您创建了退货申请";
                        ((SalesReturnCell1*)cell).returnReasonDetail.text = [_user_CustomerReturnApplyDic getString:@"Comment"];
                        ((SalesReturnCell1*)cell).returnAmountDetail.text = [NSString stringWithFormat:@"%.2f",[_user_CustomerReturnApplyDic getFloat:@"ReturnPrice"]];
                        ((SalesReturnCell1*)cell).moreStatementDetail.text = [_user_CustomerReturnApplyDic getString:@"AddComment"];
                        
                        if (![_user_CustomerReturnApplyDic getString:@"AddComment"]||[[_user_CustomerReturnApplyDic getString:@"AddComment"] isEqualToString:@""]) {
                            
                            ((SalesReturnCell1*)cell).moreStatement.text = @"补充说明：(暂无)";
                        }
                        
                        CGSize returnReasonSize = [((SalesReturnCell1*)cell).returnReasonDetail.text sizeWithFont:((SalesReturnCell1*)cell).returnReasonDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (returnReasonSize.height < 17) {
                            
                            returnReasonSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).returnReasonDetail setSize:CGSizeMake(140, returnReasonSize.height)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmount setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmount.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmountDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmountDetail.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatement setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatement.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatementDetail.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        CGSize moreStatementDetailSize = [((SalesReturnCell1*)cell).moreStatementDetail.text sizeWithFont:((SalesReturnCell1*)cell).moreStatementDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (moreStatementDetailSize.height < 17) {
                            
                            moreStatementDetailSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setSize:CGSizeMake(140, moreStatementDetailSize.height)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence1 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence1.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence2 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence2.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence3 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence3.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        NSArray *picArray = [_user_CustomerReturnApplyDic getArray:@"PictureUrls"];
                        
                        int extraPicheight = 0;
                        
                        if ([picArray count] > 0) {
                            
                            DictionaryWrapper* wrapper1 = [picArray[0]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence1 requestPicture:[wrapper1 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn1 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn1 setOrigin:((SalesReturnCell1*)cell).pictureEvidence1.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = YES;
                            ((SalesReturnCell1*)cell).pictureEvidence.text = @"图片凭证：(暂无)";
                        }
                        if ([picArray count] > 1) {
                            
                            DictionaryWrapper* wrapper2 = [picArray[1]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence2 requestPicture:[wrapper2 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn2 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn2 setOrigin:((SalesReturnCell1*)cell).pictureEvidence2.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = YES;
                        }
                        if ([picArray count] > 2) {
                            
                            DictionaryWrapper* wrapper3 = [picArray[2]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence3 requestPicture:[wrapper3 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn3 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn3 setOrigin:((SalesReturnCell1*)cell).pictureEvidence3.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = YES;
                        }
                        
                        if ([picArray count] > 3) {
                            
                            DictionaryWrapper* wrapper4 = [picArray[3]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence4 setOrigin:CGPointMake(87, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            [((SalesReturnCell1*)cell).pictureEvidence4 requestPicture:[wrapper4 getString:@"Url"]];
                            extraPicheight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn4 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn4 setOrigin:((SalesReturnCell1*)cell).pictureEvidence4.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = YES;
                        }
                        
                        if ([picArray count] > 4) {
                            
                            DictionaryWrapper* wrapper5 = [picArray[4]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence5 requestPicture:[wrapper5 getString:@"Url"]];
                            [((SalesReturnCell1*)cell).pictureEvidence5 setOrigin:CGPointMake(147, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            extraPicheight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn5 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn5 setOrigin:((SalesReturnCell1*)cell).pictureEvidence5.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = YES;
                        }
                        [((SalesReturnCell1*)cell).theBackGroundView setSize:CGSizeMake(290, returnReasonSize.height + moreStatementDetailSize.height + 200 - 28 + extraPicheight)];
                        cell.cellHeight = 238 + returnReasonSize.height + moreStatementDetailSize.height - 28 + extraPicheight;
                        break;}
                    case 1:{
                        
                        cell = [BaseSalesReturnCell createCell:2];
                        ((SalesReturnCell2*)cell).timeLabel.text = _creatTime;
                        ((SalesReturnCell2*)cell).cellTitle.text = @"等待商家处理的退货申请";
                        ((SalesReturnCell2*)cell).ifYouAgreeTitle.text = @"如果商家同意:";
                        ((SalesReturnCell2*)cell).ifYouAgreeDetail.text = @"申请将达成,需您退货给商家";
                        ((SalesReturnCell2*)cell).ifYouRejectTitle.text = @"如果商家拒绝:";
                        ((SalesReturnCell2*)cell).ifYouRejectDetail.text = @"用户可能发起申诉";
                        ((SalesReturnCell2*)cell).ifYouNotHandleTitle.text = @"如果商家未处理:";
                        ((SalesReturnCell2*)cell).ifYouNotHandleDetail.text = @"超过3天,则申请自动达成,需您退货给商家";
                        cell.cellHeight = 209;
                        break;}
                    case 2:{
                        
                        cell = [BaseSalesReturnCell createCell:6];
                        ((DisagreeCell*)cell).cellTitle.text = @"商家不同意退货";
                        ((DisagreeCell*)cell).userTitle.text = @"商家";
                        ((DisagreeCell*)cell).returnReason.text = @"商家理由";
                        ((DisagreeCell*)cell).timeLabel.text = [self configTime:[_user_MerchantDisagreeDic getString:@"CreateTime"]];
                        ((DisagreeCell*)cell).returnReasonDetail.text = [_user_MerchantDisagreeDic getString:@"Comment"];
                        
                        CGSize returnReasonSize = [((DisagreeCell*)cell).returnReasonDetail.text sizeWithFont:((DisagreeCell*)cell).returnReasonDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (returnReasonSize.height < 17) {
                            
                            returnReasonSize.height = 14;
                        }
                        
                        [((DisagreeCell*)cell).returnReasonDetail setSize:CGSizeMake(140, returnReasonSize.height)];
                        
                        [((DisagreeCell*)cell).pictureEvidence setOrigin:CGPointMake( ((DisagreeCell*)cell).pictureEvidence.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + 12)];
                        
                        [((DisagreeCell*)cell).pictureEvidenceDetail1 setOrigin:CGPointMake(((DisagreeCell*)cell).pictureEvidenceDetail1.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + 12)];
                        
                        [((DisagreeCell*)cell).pictureEvidenceDetail2 setOrigin:CGPointMake(((DisagreeCell*)cell).pictureEvidenceDetail2.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + 12)];
                        
                        [((DisagreeCell*)cell).picEvidenceDetail3 setOrigin:CGPointMake(((DisagreeCell*)cell).picEvidenceDetail3.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + 12)];
                        
                        NSArray *disAgreePic = [_user_MerchantDisagreeDic getArray:@"PictureUrls"];
                        
                        int disAgreePicExtraHeight = 0;
                        
                        if ([disAgreePic count] > 0) {
                            
                            DictionaryWrapper* wrapper1 = [disAgreePic[0]wrapper];
                            [((DisagreeCell*)cell).pictureEvidenceDetail1 requestPicture:[wrapper1 getString:@"Url"]];
                            ((DisagreeCell*)cell).pictureEvidenceDetail1.hidden = NO;
                            [((DisagreeCell*)cell).picBtn1 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((DisagreeCell*)cell).picBtn1 setOrigin:((DisagreeCell*)cell).pictureEvidenceDetail1.origin];
                        }else {
                        
                            ((DisagreeCell*)cell).pictureEvidenceDetail1.hidden = YES;
                            ((DisagreeCell*)cell).pictureEvidence.text = @"图片凭证：(暂无)";
                        }
                        if ([disAgreePic count] > 1) {
                            
                            DictionaryWrapper* wrapper2 = [disAgreePic[1]wrapper];
                            [((DisagreeCell*)cell).pictureEvidenceDetail2 requestPicture:[wrapper2 getString:@"Url"]];
                            ((DisagreeCell*)cell).pictureEvidenceDetail2.hidden = NO;
                            [((DisagreeCell*)cell).picBtn2 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((DisagreeCell*)cell).picBtn2 setOrigin:((DisagreeCell*)cell).pictureEvidenceDetail2.origin];
                        }else {
            
                            ((DisagreeCell*)cell).pictureEvidenceDetail2.hidden = YES;
                        }
                        if ([disAgreePic count] > 2) {
                            
                            DictionaryWrapper* wrapper3 = [disAgreePic[2]wrapper];
                            [((DisagreeCell*)cell).picEvidenceDetail3 requestPicture:[wrapper3 getString:@"Url"]];
                            ((DisagreeCell*)cell).picEvidenceDetail3.hidden = NO;
                            [((DisagreeCell*)cell).picBtn3 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((DisagreeCell*)cell).picBtn3 setOrigin:((DisagreeCell*)cell).picEvidenceDetail3.origin];
                        }else {
                        
                            ((DisagreeCell*)cell).picEvidenceDetail3.hidden = YES;
                        }
                        
                        if ([disAgreePic count] > 3) {
                            
                            DictionaryWrapper* wrapper4 = [disAgreePic[3]wrapper];
                            [((DisagreeCell*)cell).pictureEvidenceDetail4 requestPicture:[wrapper4 getString:@"Url"]];
                            disAgreePicExtraHeight = 60;
                            
                            [((DisagreeCell*)cell).pictureEvidenceDetail4 setOrigin:CGPointMake(((DisagreeCell*)cell).pictureEvidenceDetail4.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + disAgreePicExtraHeight +12)];
                            ((DisagreeCell*)cell).pictureEvidenceDetail4.hidden = NO;
                            [((DisagreeCell*)cell).picBtn4 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((DisagreeCell*)cell).picBtn4 setOrigin:((DisagreeCell*)cell).pictureEvidenceDetail4.origin];
                        }else {
                        
                            ((DisagreeCell*)cell).pictureEvidenceDetail4.hidden = YES;
                        }
                        
                        if ([disAgreePic count] > 4) {
                            
                            DictionaryWrapper* wrapper5 = [disAgreePic[4]wrapper];
                            [((DisagreeCell*)cell).pictureEvidenceDetail5 requestPicture:[wrapper5 getString:@"Url"]];
                            disAgreePicExtraHeight = 60;
                            
                            [((DisagreeCell*)cell).pictureEvidenceDetail5 setOrigin:CGPointMake(((DisagreeCell*)cell).pictureEvidenceDetail5.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + disAgreePicExtraHeight +12)];
                            ((DisagreeCell*)cell).pictureEvidenceDetail5.hidden = NO;
                            [((DisagreeCell*)cell).picBtn5 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((DisagreeCell*)cell).picBtn5 setOrigin:((DisagreeCell*)cell).pictureEvidenceDetail5.origin];
                        }else {
                        
                            ((DisagreeCell*)cell).pictureEvidenceDetail5.hidden = YES;
                        }
                        
                        [((DisagreeCell*)cell).backGroundView setSize:CGSizeMake(290, 147 + returnReasonSize.height - 14 + disAgreePicExtraHeight)];
                        
                        cell.cellHeight = 178 + returnReasonSize.height - 14 + disAgreePicExtraHeight;
                        break;}
                    default:
                        break;
                }
                break;
            }
                
            case 404:{
                
                switch (indexPath.row) {
                    case 0:{
                        
                        cell = [BaseSalesReturnCell createCell:1];
                        ((SalesReturnCell1*)cell).userLabel.text = @"您";
                        ((SalesReturnCell1*)cell).creatTimeLabel.text = [self configTime:[_user_CustomerReturnApplyDic getString:@"CreateTime"]];
                        ((SalesReturnCell1*)cell).cellTitle.text = @"您创建了退货申请";
                        ((SalesReturnCell1*)cell).returnReasonDetail.text = [_user_CustomerReturnApplyDic getString:@"Comment"];
                        ((SalesReturnCell1*)cell).returnAmountDetail.text = [NSString stringWithFormat:@"%.2f",[_user_CustomerReturnApplyDic getFloat:@"ReturnPrice"]];
                        ((SalesReturnCell1*)cell).moreStatementDetail.text = [_user_CustomerReturnApplyDic getString:@"AddComment"];
                        
                        if (![_user_CustomerReturnApplyDic getString:@"AddComment"]||[[_user_CustomerReturnApplyDic getString:@"AddComment"] isEqualToString:@""]) {
                            
                            ((SalesReturnCell1*)cell).moreStatement.text = @"补充说明：(暂无)";
                        }
                        
                        CGSize returnReasonSize = [((SalesReturnCell1*)cell).returnReasonDetail.text sizeWithFont:((SalesReturnCell1*)cell).returnReasonDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (returnReasonSize.height < 17) {
                            
                            returnReasonSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).returnReasonDetail setSize:CGSizeMake(140, returnReasonSize.height)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmount setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmount.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmountDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmountDetail.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatement setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatement.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatementDetail.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        CGSize moreStatementDetailSize = [((SalesReturnCell1*)cell).moreStatementDetail.text sizeWithFont:((SalesReturnCell1*)cell).moreStatementDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (moreStatementDetailSize.height < 17) {
                            
                            moreStatementDetailSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setSize:CGSizeMake(140, moreStatementDetailSize.height)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence1 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence1.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence2 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence2.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence3 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence3.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        NSArray *picArray = [_user_CustomerReturnApplyDic getArray:@"PictureUrls"];
                        
                        int extraPicHeight = 0;
                        if ([picArray count] > 0) {
                            
                            DictionaryWrapper* wrapper1 = [picArray[0] wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence1 requestPicture:[wrapper1 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn1 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn1 setOrigin:((SalesReturnCell1*)cell).pictureEvidence1.origin];
                        }else {
                            
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = YES;
                            ((SalesReturnCell1*)cell).pictureEvidence.text = @"图片凭证：(暂无)";
                        }
                        if ([picArray count] > 1) {
                            
                            DictionaryWrapper* wrapper2 = [picArray[1] wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence2 requestPicture:[wrapper2 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn2 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn2 setOrigin:((SalesReturnCell1*)cell).pictureEvidence2.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = YES;
                        }
                        if ([picArray count] > 2) {
                            
                            DictionaryWrapper* wrapper3 = [picArray[2] wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence3 requestPicture:[wrapper3 getString:@"Url"]];
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn3 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn3 setOrigin:((SalesReturnCell1*)cell).pictureEvidence3.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = YES;
                        }
                        
                        if ([picArray count] > 3) {
                            
                            DictionaryWrapper* wrapper4 = [picArray[3]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence4 setOrigin:CGPointMake(87, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            [((SalesReturnCell1*)cell).pictureEvidence4 requestPicture:[wrapper4 getString:@"Url"]];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn4 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn4 setOrigin:((SalesReturnCell1*)cell).pictureEvidence4.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = YES;
                        }
                        
                        if ([picArray count] > 4) {
                            
                            DictionaryWrapper* wrapper5 = [picArray[4]wrapper];
                            [((SalesReturnCell1*)cell).pictureEvidence5 requestPicture:[wrapper5 getString:@"Url"]];
                            [((SalesReturnCell1*)cell).pictureEvidence5 setOrigin:CGPointMake(147, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn5 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn5 setOrigin:((SalesReturnCell1*)cell).pictureEvidence5.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = YES;
                        }
                        [((SalesReturnCell1*)cell).theBackGroundView setSize:CGSizeMake(290, returnReasonSize.height + moreStatementDetailSize.height + 200 - 28 + extraPicHeight)];
                        cell.cellHeight = 238 + returnReasonSize.height + moreStatementDetailSize.height - 28 + extraPicHeight;
                        break;}
                    case 1:{
                        cell = [BaseSalesReturnCell createCell:2];
                        ((SalesReturnCell2*)cell).timeLabel.text = _creatTime;
                        ((SalesReturnCell2*)cell).cellTitle.text = @"等待商家处理的退货申请";
                        ((SalesReturnCell2*)cell).ifYouAgreeTitle.text = @"如果商家同意:";
                        ((SalesReturnCell2*)cell).ifYouAgreeDetail.text = @"申请将达成,需您退货给商家";
                        ((SalesReturnCell2*)cell).ifYouRejectTitle.text = @"如果商家拒绝:";
                        ((SalesReturnCell2*)cell).ifYouRejectDetail.text = @"用户可能发起申诉";
                        ((SalesReturnCell2*)cell).ifYouNotHandleTitle.text = @"如果商家未处理:";
                        ((SalesReturnCell2*)cell).ifYouNotHandleDetail.text = @"超过3天,则申请自动达成,需您退货给商家";
                         cell.cellHeight = 209;
                        break;}
                    case 2:{
                        cell = [BaseSalesReturnCell createCell:7];
                        ((AgreeReturnCell*)cell).timeLabel.text = [self configTime:[_user_AgreeDic getString:@"CreateTime"]];
                        ((AgreeReturnCell*)cell).cellTitle.text = @"商家同意退货";
                        ((AgreeReturnCell*)cell).userLabel.text = @"商家";
                        cell.cellHeight = 153;
                        break;}
                    case 3:{
                        cell = [BaseSalesReturnCell createCell:4];
                        ((SalesReturnCell4*)cell).timeLabel.text = [self configTime:[_user_CustomerReturnLogisticsDic getString:@"CreateTime"]];
                        ((SalesReturnCell4*)cell).cellTitle.text = @"您已经退货";
                        ((SalesReturnCell4*)cell).userLabel.text = @"您";
                        ((SalesReturnCell4*)cell).logisticsName.text = [_user_CustomerReturnLogisticsDic getString:@"CompanyName"];
                        ((SalesReturnCell4*)cell).logisticsNumberDetail.text = [_user_CustomerReturnLogisticsDic getString:@"BillNo"];
                        cell.cellHeight = 162;
                        break;}
                    case 4:{
                        
                        cell = [BaseSalesReturnCell createCell:8];
                        cell.cellHeight = 230;
                        ((WaitMerchantEnsureCell*)cell).creatTime.text = _creatTime;
                    break;}
                    default:
                        break;
                }
                break;
            }
            default:
                break;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    //发广告协商退货
    if (_type == 2) {
        switch (_status) {
                
            //401用户发起退货
            case 401:{
                
                switch (indexPath.row) {
                    case 0:{
                        cell = [BaseSalesReturnCell createCell:1];
                        ((SalesReturnCell1*)cell).userLabel.text = @"用户";
                        ((SalesReturnCell1*)cell).creatTimeLabel.text = [self configTime:[_merchant_ReturnDetail getString:@"ReturnDate"]];
                        ((SalesReturnCell1*)cell).cellTitle.text = @"用户创建了退货申请";
                        ((SalesReturnCell1*)cell).returnReasonDetail.text = [_merchant_ReturnDetail getString:@"ReturnReason"];
                        ((SalesReturnCell1*)cell).returnAmountDetail.text = [NSString stringWithFormat:@"%.2f",[_merchant_ReturnDetail getFloat:@"ReturnAmount"]];
                        ((SalesReturnCell1*)cell).moreStatementDetail.text = [_merchant_ReturnDetail getString:@"ReturnComment"];
                        
                        if (![_merchant_ReturnDetail getString:@"ReturnComment"]||[[_merchant_ReturnDetail getString:@"ReturnComment"] isEqualToString:@""]) {
                            
                            ((SalesReturnCell1*)cell).moreStatement.text = @"补充说明：(暂无)";
                        }
                        
                        CGSize returnReasonSize = [((SalesReturnCell1*)cell).returnReasonDetail.text sizeWithFont:((SalesReturnCell1*)cell).returnReasonDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (returnReasonSize.height < 17) {
                            
                            returnReasonSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).returnReasonDetail setSize:CGSizeMake(140, returnReasonSize.height)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmount setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmount.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmountDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmountDetail.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatement setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatement.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatementDetail.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        CGSize moreStatementDetailSize = [((SalesReturnCell1*)cell).moreStatementDetail.text sizeWithFont:((SalesReturnCell1*)cell).moreStatementDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (moreStatementDetailSize.height < 17) {
                            
                            moreStatementDetailSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setSize:CGSizeMake(140, moreStatementDetailSize.height)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence1 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence1.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence2 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence2.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence3 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence3.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                       
                        NSArray *picArray = [_merchant_ReturnDetail getArray:@"Pictures"];
                        int extraPicHeight = 0;
                        if ([picArray count] > 0) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence1 requestPicture:picArray[0]];
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn1 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn1 setOrigin:((SalesReturnCell1*)cell).pictureEvidence1.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence.text = @"图片凭证：(暂无)";
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = YES;
                        }
                        if ([picArray count] > 1) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence2 requestPicture:picArray[1]];
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn2 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn2 setOrigin:((SalesReturnCell1*)cell).pictureEvidence2.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = YES;
                        }
                        if ([picArray count] > 2) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence3 requestPicture:picArray[2]];
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn3 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn3 setOrigin:((SalesReturnCell1*)cell).pictureEvidence3.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = YES;
                        }
                        
                        if ([picArray count] > 3) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence4 setOrigin:CGPointMake(87, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            [((SalesReturnCell1*)cell).pictureEvidence4 requestPicture:picArray[3]];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn4 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn4 setOrigin:((SalesReturnCell1*)cell).pictureEvidence4.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = YES;
                        }
                        
                        if ([picArray count] > 4) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence5 requestPicture:picArray[4]];
                            [((SalesReturnCell1*)cell).pictureEvidence5 setOrigin:CGPointMake(147, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn5 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn5 setOrigin:((SalesReturnCell1*)cell).pictureEvidence5.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = YES;
                        }
                         [((SalesReturnCell1*)cell).theBackGroundView setSize:CGSizeMake(290, returnReasonSize.height + moreStatementDetailSize.height + 200 - 28 + extraPicHeight)];
                        cell.cellHeight = 238 + returnReasonSize.height + moreStatementDetailSize.height - 28 + extraPicHeight;
                        break;}
                    case 1:{
                        cell = [BaseSalesReturnCell createCell:2];
                        ((SalesReturnCell2*)cell).timeLabel.text = _creatTime;
                        ((SalesReturnCell2*)cell).cellTitle.text = @"等待您处理退货申请";
                        ((SalesReturnCell2*)cell).ifYouAgreeTitle.text = @"如果您同意:";
                        ((SalesReturnCell2*)cell).ifYouAgreeDetail.text = @"申请将达成,需用户退货给您";
                        ((SalesReturnCell2*)cell).ifYouRejectTitle.text = @"如果您拒绝:";
                        ((SalesReturnCell2*)cell).ifYouRejectDetail.text = @"用户可能发起申诉";
                        ((SalesReturnCell2*)cell).ifYouNotHandleTitle.text = @"如果您未处理:";
                        ((SalesReturnCell2*)cell).ifYouNotHandleDetail.text = @"超过3天,则申请自动达成,需用户退货给您";
                         cell.cellHeight = 209;
                        break;}
                    default:
                        break;
                }
                break;
            }
                
            //402商家同意退货
            case 402:{
                
                switch (indexPath.row) {
                    case 0:{
                        
                        cell = [BaseSalesReturnCell createCell:1];
                        ((SalesReturnCell1*)cell).userLabel.text = @"用户";
                        ((SalesReturnCell1*)cell).creatTimeLabel.text = [self configTime:[_merchant_ReturnDetail getString:@"ReturnDate"]];
                        ((SalesReturnCell1*)cell).cellTitle.text = @"用户创建了退货申请";
                        ((SalesReturnCell1*)cell).returnReasonDetail.text = [_merchant_ReturnDetail getString:@"ReturnReason"];
                        ((SalesReturnCell1*)cell).returnAmountDetail.text = [NSString stringWithFormat:@"%.2f",[_merchant_ReturnDetail getFloat:@"ReturnAmount"]];
                        ((SalesReturnCell1*)cell).moreStatementDetail.text = [_merchant_ReturnDetail getString:@"ReturnComment"];
                        
                        if (![_merchant_ReturnDetail getString:@"ReturnComment"]||[[_merchant_ReturnDetail getString:@"ReturnComment"] isEqualToString:@""]) {
                            
                            ((SalesReturnCell1*)cell).moreStatement.text = @"补充说明：(暂无)";
                        }
                        
                        CGSize returnReasonSize = [((SalesReturnCell1*)cell).returnReasonDetail.text sizeWithFont:((SalesReturnCell1*)cell).returnReasonDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (returnReasonSize.height < 17) {
                            
                            returnReasonSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).returnReasonDetail setSize:CGSizeMake(140, returnReasonSize.height)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmount setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmount.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmountDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmountDetail.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatement setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatement.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatementDetail.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        CGSize moreStatementDetailSize = [((SalesReturnCell1*)cell).moreStatementDetail.text sizeWithFont:((SalesReturnCell1*)cell).moreStatementDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (moreStatementDetailSize.height < 17) {
                            
                            moreStatementDetailSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setSize:CGSizeMake(140, moreStatementDetailSize.height)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence1 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence1.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence2 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence2.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence3 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence3.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        NSArray *picArray = [_merchant_ReturnDetail getArray:@"Pictures"];
                        int extraPicHeight = 0;
                        if ([picArray count] > 0) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence1 requestPicture:picArray[0]];
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn1 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn1 setOrigin:((SalesReturnCell1*)cell).pictureEvidence1.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = YES;
                            ((SalesReturnCell1*)cell).pictureEvidence.text = @"图片凭证：(暂无)";
                        }
                        if ([picArray count] > 1) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence2 requestPicture:picArray[1]];
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn2 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn2 setOrigin:((SalesReturnCell1*)cell).pictureEvidence2.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = YES;
                        }
                        if ([picArray count] > 2) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence3 requestPicture:picArray[2]];
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn3 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn3 setOrigin:((SalesReturnCell1*)cell).pictureEvidence3.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = YES;
                        }
                        
                        if ([picArray count] > 3) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence4 setOrigin:CGPointMake(87, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            [((SalesReturnCell1*)cell).pictureEvidence4 requestPicture:picArray[3]];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn4 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn4 setOrigin:((SalesReturnCell1*)cell).pictureEvidence4.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = YES;
                        }
                        
                        if ([picArray count] > 4) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence5 requestPicture:picArray[4]];
                            [((SalesReturnCell1*)cell).pictureEvidence5 setOrigin:CGPointMake(147, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn5 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn5 setOrigin:((SalesReturnCell1*)cell).pictureEvidence5.origin];

                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = YES;
                        }
                        
                        cell.cellHeight = 238 + returnReasonSize.height + moreStatementDetailSize.height - 28 + extraPicHeight;
                        [((SalesReturnCell1*)cell).theBackGroundView setSize:CGSizeMake(290, returnReasonSize.height + moreStatementDetailSize.height + 200 - 28 + extraPicHeight)];
                        break;}
                    case 1:{
                        cell = [BaseSalesReturnCell createCell:2];
                        ((SalesReturnCell2*)cell).timeLabel.text = _creatTime;
                        ((SalesReturnCell2*)cell).cellTitle.text = @"等待您处理退货申请";
                        ((SalesReturnCell2*)cell).ifYouAgreeTitle.text = @"如果您同意:";
                        ((SalesReturnCell2*)cell).ifYouAgreeDetail.text = @"申请将达成,需用户退货给您";
                        ((SalesReturnCell2*)cell).ifYouRejectTitle.text = @"如果您拒绝:";
                        ((SalesReturnCell2*)cell).ifYouRejectDetail.text = @"用户可能发起申诉";
                        ((SalesReturnCell2*)cell).ifYouNotHandleTitle.text = @"如果您未处理:";
                        ((SalesReturnCell2*)cell).ifYouNotHandleDetail.text = @"超过3天,则申请自动达成,需用户退货给您";
                         cell.cellHeight = 209;
                        break;}
                    case 2:{
                        cell = [BaseSalesReturnCell createCell:3];
                        ((SalesReturnCell3*)cell).tiemLabel.text = _creatTime;
                        ((SalesReturnCell3*)cell).cellTitle.text = @"您同意退货";
                        ((SalesReturnCell3*)cell).userLabel.text = @"您";
                        ((SalesReturnCell3*)cell).waitingForReturn.text = @"请等待用户退货:";
                        ((SalesReturnCell3*)cell).waitingForReturnDetail.text = @"如果确认货物无误,请确认退货";
                        ((SalesReturnCell3*)cell).ifYouRejectTitle.text = @"如果用户不退货:";
                        ((SalesReturnCell3*)cell).ifYouRejectDetail.text = @"超过3天,将视为放弃退货,恢复正常流程,并不再可以退货";
                        
                        DictionaryWrapper * item = [_merchant_ReturnDetail getDictionaryWrapper:@"WaitReturnDetails"];
                        ((SalesReturnCell3*)cell).tiemLabel.text = [self configTime:[item getString:@"AgreeReturnTime"]];
                        cell.cellHeight = 201;
                    break;}
                    default:
                        break;
                }
                break;
            }
                
            //403商家不同意退货
            case 403:{
                switch (indexPath.row) {
                    case 0:{
                        
                        cell = [BaseSalesReturnCell createCell:1];
                        ((SalesReturnCell1*)cell).userLabel.text = @"用户";
                        ((SalesReturnCell1*)cell).creatTimeLabel.text = [self configTime:[_merchant_ReturnDetail getString:@"ReturnDate"]];
                        ((SalesReturnCell1*)cell).cellTitle.text = @"用户创建了退货申请";
                        ((SalesReturnCell1*)cell).returnReasonDetail.text = [_merchant_ReturnDetail getString:@"ReturnReason"];
                        ((SalesReturnCell1*)cell).returnAmountDetail.text = [NSString stringWithFormat:@"%.2f",[_merchant_ReturnDetail getFloat:@"ReturnAmount"]];
                        ((SalesReturnCell1*)cell).moreStatementDetail.text = [_merchant_ReturnDetail getString:@"ReturnComment"];
                        
                        if (![_merchant_ReturnDetail getString:@"ReturnComment"]||[[_merchant_ReturnDetail getString:@"ReturnComment"] isEqualToString:@""]) {
                            
                            ((SalesReturnCell1*)cell).moreStatement.text = @"补充说明：(暂无)";
                        }
                        
                        CGSize returnReasonSize = [((SalesReturnCell1*)cell).returnReasonDetail.text sizeWithFont:((SalesReturnCell1*)cell).returnReasonDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (returnReasonSize.height < 17) {
                            
                            returnReasonSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).returnReasonDetail setSize:CGSizeMake(140, returnReasonSize.height)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmount setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmount.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmountDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmountDetail.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatement setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatement.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatementDetail.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        CGSize moreStatementDetailSize = [((SalesReturnCell1*)cell).moreStatementDetail.text sizeWithFont:((SalesReturnCell1*)cell).moreStatementDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (moreStatementDetailSize.height < 17) {
                            
                            moreStatementDetailSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setSize:CGSizeMake(140, moreStatementDetailSize.height)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence1 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence1.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence2 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence2.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence3 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence3.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        NSArray *picArray = [_merchant_ReturnDetail getArray:@"Pictures"];
                        int extraPicHeight = 0;
                        if ([picArray count] > 0) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence1 requestPicture:picArray[0]];
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn1 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn1 setOrigin:((SalesReturnCell1*)cell).pictureEvidence1.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = YES;
                            ((SalesReturnCell1*)cell).pictureEvidence.text = @"图片凭证：(暂无)";
                        }
                        if ([picArray count] > 1) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence2 requestPicture:picArray[1]];
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn2 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn2 setOrigin:((SalesReturnCell1*)cell).pictureEvidence2.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = YES;
                        }
                        if ([picArray count] > 2) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence3 requestPicture:picArray[2]];
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn3 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn3 setOrigin:((SalesReturnCell1*)cell).pictureEvidence3.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = YES;
                        }
                        
                        if ([picArray count] > 3) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence4 setOrigin:CGPointMake(87, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            [((SalesReturnCell1*)cell).pictureEvidence4 requestPicture:picArray[3]];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn4 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn4 setOrigin:((SalesReturnCell1*)cell).pictureEvidence4.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = YES;
                        }
                        
                        if ([picArray count] > 4) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence5 requestPicture:picArray[4]];
                            [((SalesReturnCell1*)cell).pictureEvidence5 setOrigin:CGPointMake(147, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn5 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn5 setOrigin:((SalesReturnCell1*)cell).pictureEvidence5.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = YES;
                        }
                        cell.cellHeight = 238 + returnReasonSize.height + moreStatementDetailSize.height - 28 + extraPicHeight;
                        [((SalesReturnCell1*)cell).theBackGroundView setSize:CGSizeMake(290, returnReasonSize.height + moreStatementDetailSize.height + 200 - 28 + extraPicHeight)];
                        break;}
                    case 1:{
                        cell = [BaseSalesReturnCell createCell:2];
                        ((SalesReturnCell2*)cell).timeLabel.text = _creatTime;
                        ((SalesReturnCell2*)cell).cellTitle.text = @"等待您处理退货申请";
                        ((SalesReturnCell2*)cell).ifYouAgreeTitle.text = @"如果您同意:";
                        ((SalesReturnCell2*)cell).ifYouAgreeDetail.text = @"申请将达成,需用户退货给您";
                        ((SalesReturnCell2*)cell).ifYouRejectTitle.text = @"如果您拒绝:";
                        ((SalesReturnCell2*)cell).ifYouRejectDetail.text = @"用户可能发起申诉";
                        ((SalesReturnCell2*)cell).ifYouNotHandleTitle.text = @"如果您未处理:";
                        ((SalesReturnCell2*)cell).ifYouNotHandleDetail.text = @"超过3天,则申请自动达成,需用户退货给您";
                         cell.cellHeight = 209;
                        break;}
                    case 2:{
                        cell = [BaseSalesReturnCell createCell:6];
                        ((DisagreeCell*)cell).userTitle.text = @"您";
                        ((DisagreeCell*)cell).cellTitle.text = @"您不同意退货";
                        ((DisagreeCell*)cell).timeLabel.text = [self configTime:[_merchant_MerchantDisagreeDic getString:@"NotAgreeTime"]];
                        ((DisagreeCell*)cell).returnReasonDetail.text = [_merchant_MerchantDisagreeDic getString:@"Reason"];
                        
                        CGSize returnReasonSize = [((DisagreeCell*)cell).returnReasonDetail.text sizeWithFont:((DisagreeCell*)cell).returnReasonDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (returnReasonSize.height < 17) {
                            
                            returnReasonSize.height = 14;
                        }
                        
                        [((DisagreeCell*)cell).returnReasonDetail setSize:CGSizeMake(140, returnReasonSize.height)];
                        
                        [((DisagreeCell*)cell).pictureEvidence setOrigin:CGPointMake( ((DisagreeCell*)cell).pictureEvidence.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + 12)];
                        
                        [((DisagreeCell*)cell).pictureEvidenceDetail1 setOrigin:CGPointMake(((DisagreeCell*)cell).pictureEvidenceDetail1.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + 12)];
                        
                        [((DisagreeCell*)cell).pictureEvidenceDetail2 setOrigin:CGPointMake(((DisagreeCell*)cell).pictureEvidenceDetail2.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + 12)];
                        
                        [((DisagreeCell*)cell).picEvidenceDetail3 setOrigin:CGPointMake(((DisagreeCell*)cell).picEvidenceDetail3.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + 12)];
                        
                        
                        
                        NSArray *disAgreePic = [_merchant_MerchantDisagreeDic getArray:@"Pictures"];
                        int disAgreeExtraPicHeight = 0;
                        if ([disAgreePic count] > 0) {
                            
                            [((DisagreeCell*)cell).pictureEvidenceDetail1 requestPicture:disAgreePic[0]];
                            ((DisagreeCell*)cell).pictureEvidenceDetail1.hidden = NO;
                            [((DisagreeCell*)cell).picBtn1 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((DisagreeCell*)cell).picBtn1 setOrigin:((DisagreeCell*)cell).pictureEvidenceDetail1.origin];
                        }else {
                        
                            ((DisagreeCell*)cell).pictureEvidenceDetail1.hidden = YES;
                            ((DisagreeCell*)cell).pictureEvidence.text = @"图片凭证：(暂无)";
                        }
                        if ([disAgreePic count] > 1) {
                            
                            [((DisagreeCell*)cell).pictureEvidenceDetail2 requestPicture:disAgreePic[1]];
                            ((DisagreeCell*)cell).pictureEvidenceDetail2.hidden = NO;
                            [((DisagreeCell*)cell).picBtn2 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((DisagreeCell*)cell).picBtn2 setOrigin:((DisagreeCell*)cell).pictureEvidenceDetail2.origin];
                        }else {
                        
                            ((DisagreeCell*)cell).pictureEvidenceDetail2.hidden = YES;
                        }
                        if ([disAgreePic count] > 2) {
                            
                            [((DisagreeCell*)cell).picEvidenceDetail3 requestPicture:disAgreePic[2]];
                            ((DisagreeCell*)cell).picEvidenceDetail3.hidden = NO;
                            [((DisagreeCell*)cell).picBtn3 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((DisagreeCell*)cell).picBtn3 setOrigin:((DisagreeCell*)cell).picEvidenceDetail3.origin];
                        }else {
                        
                            ((DisagreeCell*)cell).picEvidenceDetail3 .hidden = YES;
                        }
                        
                        if ([disAgreePic count] > 3) {
                            
                            [((DisagreeCell*)cell).pictureEvidenceDetail4 requestPicture:disAgreePic[3]];
                            disAgreeExtraPicHeight = 60;
                            
                            [((DisagreeCell*)cell).pictureEvidenceDetail4 setOrigin:CGPointMake(((DisagreeCell*)cell).pictureEvidenceDetail4.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + disAgreeExtraPicHeight +12)];
                            ((DisagreeCell*)cell).pictureEvidenceDetail4.hidden = NO;
                            [((DisagreeCell*)cell).picBtn4 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((DisagreeCell*)cell).picBtn4 setOrigin:((DisagreeCell*)cell).pictureEvidenceDetail4.origin];
                        }else {
                        
                            ((DisagreeCell*)cell).pictureEvidenceDetail4.hidden = YES;
                        }
                        
                        if ([disAgreePic count] > 4) {
                            
                            [((DisagreeCell*)cell).pictureEvidenceDetail5 requestPicture:disAgreePic[4]];
                            disAgreeExtraPicHeight = 60;
                            
                            [((DisagreeCell*)cell).pictureEvidenceDetail5 setOrigin:CGPointMake(((DisagreeCell*)cell).pictureEvidenceDetail5.origin.x, ((DisagreeCell*)cell).returnReasonDetail.origin.y + returnReasonSize.height + disAgreeExtraPicHeight +12)];
                            ((DisagreeCell*)cell).pictureEvidenceDetail5.hidden = NO;
                            [((DisagreeCell*)cell).picBtn5 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((DisagreeCell*)cell).picBtn5 setOrigin:((DisagreeCell*)cell).pictureEvidenceDetail5.origin];
                        }else {
                        
                            ((DisagreeCell*)cell).pictureEvidenceDetail5.hidden = YES;
                        }
                        
                        [((DisagreeCell*)cell).backGroundView setSize:CGSizeMake(290, 147 + returnReasonSize.height - 14 + disAgreeExtraPicHeight)];
                        cell.cellHeight = 178 + returnReasonSize.height - 14 + disAgreeExtraPicHeight;
                        break;}
                    default:
                        break;
                }
                break;
            }
                
            //404用户快递发回货物
            case 404:{
                
                switch (indexPath.row) {
                    case 0:{
                        cell = [BaseSalesReturnCell createCell:1];
                        ((SalesReturnCell1*)cell).userLabel.text = @"用户";
                        ((SalesReturnCell1*)cell).creatTimeLabel.text = [self configTime:[_merchant_ReturnDetail getString:@"ReturnDate"]];
                        ((SalesReturnCell1*)cell).cellTitle.text = @"用户创建了退货申请";
                        ((SalesReturnCell1*)cell).returnReasonDetail.text = [_merchant_ReturnDetail getString:@"ReturnReason"];
                        ((SalesReturnCell1*)cell).returnAmountDetail.text = [NSString stringWithFormat:@"%.2f",[_merchant_ReturnDetail getFloat:@"ReturnAmount"]];
                        ((SalesReturnCell1*)cell).moreStatementDetail.text = [_merchant_ReturnDetail getString:@"ReturnComment"];
                        
                        if (![_merchant_ReturnDetail getString:@"ReturnComment"]||[[_merchant_ReturnDetail getString:@"ReturnComment"] isEqualToString:@""]) {
                            
                            ((SalesReturnCell1*)cell).moreStatement.text = @"补充说明：(暂无)";
                        }
                        
                        CGSize returnReasonSize = [((SalesReturnCell1*)cell).returnReasonDetail.text sizeWithFont:((SalesReturnCell1*)cell).returnReasonDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (returnReasonSize.height < 17) {
                            
                            returnReasonSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).returnReasonDetail setSize:CGSizeMake(140, returnReasonSize.height)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmount setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmount.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        
                        [((SalesReturnCell1*)cell).returnAmountDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).returnAmountDetail.origin.x, ((SalesReturnCell1*)cell).returnReasonDetail.size.height + ((SalesReturnCell1*)cell).returnReasonDetail.origin.y + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatement setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatement.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setOrigin:CGPointMake(((SalesReturnCell1*)cell).moreStatementDetail.origin.x, ((SalesReturnCell1*)cell).returnAmount.origin.y + ((SalesReturnCell1*)cell).returnAmount.size.height + 12)];
                        
                        CGSize moreStatementDetailSize = [((SalesReturnCell1*)cell).moreStatementDetail.text sizeWithFont:((SalesReturnCell1*)cell).moreStatementDetail.font constrainedToSize:CGSizeMake(140, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        if (moreStatementDetailSize.height < 17) {
                            
                            moreStatementDetailSize.height = 14;
                        }
                        
                        [((SalesReturnCell1*)cell).moreStatementDetail setSize:CGSizeMake(140, moreStatementDetailSize.height)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence1 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence1.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence2 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence2.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        [((SalesReturnCell1*)cell).pictureEvidence3 setOrigin:CGPointMake(((SalesReturnCell1*)cell).pictureEvidence3.origin.x, ((SalesReturnCell1*)cell).moreStatementDetail.origin.y + ((SalesReturnCell1*)cell).moreStatementDetail.size.height + 12)];
                        
                        NSArray *picArray = [_merchant_ReturnDetail getArray:@"Pictures"];
                        int extraPicHeight = 0;
                        if ([picArray count] > 0) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence1 requestPicture:picArray[0]];
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn1 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn1 setOrigin:((SalesReturnCell1*)cell).pictureEvidence1.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence1.hidden = YES;
                            ((SalesReturnCell1*)cell).pictureEvidence.text = @"图片凭证：(暂无)";
                        }
                        if ([picArray count] > 1) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence2 requestPicture:picArray[1]];
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn2 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn2 setOrigin:((SalesReturnCell1*)cell).pictureEvidence2.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence2.hidden = YES;
                        }
                        if ([picArray count] > 2) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence3 requestPicture:picArray[2]];
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn3 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn3 setOrigin:((SalesReturnCell1*)cell).pictureEvidence3.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence3.hidden = YES;
                        }
                        
                        if ([picArray count] > 3) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence4 setOrigin:CGPointMake(87, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            [((SalesReturnCell1*)cell).pictureEvidence4 requestPicture:picArray[3]];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn4 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn4 setOrigin:((SalesReturnCell1*)cell).pictureEvidence4.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence4.hidden = YES;
                        }
                        
                        if ([picArray count] > 4) {
                            
                            [((SalesReturnCell1*)cell).pictureEvidence5 requestPicture:picArray[4]];
                            [((SalesReturnCell1*)cell).pictureEvidence5 setOrigin:CGPointMake(147, ((SalesReturnCell1*)cell).pictureEvidence1.frame.origin.y + 60)];
                            extraPicHeight = 60;
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = NO;
                            [((SalesReturnCell1*)cell).picBtn5 addTarget:self action:@selector(previewPic:) forControlEvents:UIControlEventTouchUpInside];
                            [((SalesReturnCell1*)cell).picBtn5 setOrigin:((SalesReturnCell1*)cell).pictureEvidence5.origin];
                        }else {
                        
                            ((SalesReturnCell1*)cell).pictureEvidence5.hidden = YES;
                        }
                        
                        cell.cellHeight = 238 + returnReasonSize.height + moreStatementDetailSize.height - 28 + extraPicHeight;
                        [((SalesReturnCell1*)cell).theBackGroundView setSize:CGSizeMake(290, returnReasonSize.height + moreStatementDetailSize.height + 200 - 28 + extraPicHeight)];
                        break;}
                    case 1:{
                        cell = [BaseSalesReturnCell createCell:2];
                        ((SalesReturnCell2*)cell).timeLabel.text = _creatTime;
                        ((SalesReturnCell2*)cell).cellTitle.text = @"等待您处理退货申请";
                        ((SalesReturnCell2*)cell).ifYouAgreeTitle.text = @"如果您同意:";
                        ((SalesReturnCell2*)cell).ifYouAgreeDetail.text = @"申请将达成,需用户退货给您";
                        ((SalesReturnCell2*)cell).ifYouRejectTitle.text = @"如果您拒绝:";
                        ((SalesReturnCell2*)cell).ifYouRejectDetail.text = @"用户可能发起申诉";
                        ((SalesReturnCell2*)cell).ifYouNotHandleTitle.text = @"如果您未处理:";
                        ((SalesReturnCell2*)cell).ifYouNotHandleDetail.text = @"超过3天,则申请自动达成,需用户退货给您";
                        cell.cellHeight = 209;
                        break;}
                    case 2:{
                        cell = [BaseSalesReturnCell createCell:3];
                        ((SalesReturnCell3*)cell).cellTitle.text = @"您同意退货";
                        ((SalesReturnCell3*)cell).userLabel.text = @"您";
                        ((SalesReturnCell3*)cell).waitingForReturn.text = @"请等待用户退货:";
                        ((SalesReturnCell3*)cell).waitingForReturnDetail.text = @"如果确认货物无误,请确认退货";
                        ((SalesReturnCell3*)cell).ifYouRejectTitle.text = @"如果用户不退货:";
                        ((SalesReturnCell3*)cell).ifYouRejectDetail.text = @"超过3天,将视为放弃退货,恢复正常流程,并不再可以退货";
                        
                        
                        DictionaryWrapper *item = [_merchant_ReturnDetail getDictionaryWrapper:@"WaitConfirmReturnDetails"];
                        ((SalesReturnCell3*)cell).tiemLabel.text = [self configTime:[item getString:@"AgreeReturnTime"]];
                        cell.cellHeight = 201;
                        break;}
                    case 3:{
                        
                        cell = [BaseSalesReturnCell createCell:4];
                        
                        DictionaryWrapper *item = [_merchant_ReturnDetail getDictionaryWrapper:@"WaitConfirmReturnDetails"];
                        ((SalesReturnCell4*)cell).timeLabel.text = [self configTime:[item getString:@"CustomerReturnTime"]];
                        ((SalesReturnCell4*)cell).cellTitle.text = @"用户已经退货";
                        ((SalesReturnCell4*)cell).userLabel.text = @"用户";
                        ((SalesReturnCell4*)cell).logisticsName.text = [_merchant_CustomerReturnLogisticsDic getString:@"CompanyName"];
                        ((SalesReturnCell4*)cell).logisticsNumberDetail.text = [_merchant_CustomerReturnLogisticsDic getString:@"BillNo"];
                        cell.cellHeight = 162;
                        break;}
                    case 4:{
                        cell = [BaseSalesReturnCell createCell:5];
                        ((SalesReturnCell5*)cell).timeLabel.text = _creatTime;
                        ((SalesReturnCell5*)cell).userLabel.text = @"系统";
                        ((SalesReturnCell5*)cell).cellTitle.text = @"待您确认货品";
                        ((SalesReturnCell5*)cell).ifYouAgree.text = @"如果您同意:";
                        ((SalesReturnCell5*)cell).ifYouAgreeDetail.text = @"则完成退货,稍后自动退款";
                        ((SalesReturnCell5*)cell).ifYouReject.text = @"如果您拒绝:";
                        ((SalesReturnCell5*)cell).ifYouRejectDetail.text = @"建议先和用户协商;如果您利益受损,可以发起申诉";
                        ((SalesReturnCell5*)cell).ifYouNotHandle.text = @"如果您未处理:";
                        ((SalesReturnCell5*)cell).ifYouNotHandleDetail.text = @"超过7天,则视为您确认退货";
                    cell.height = 231;
                        break;}
                    default:
                        break;
                }
                break;
            }
            default:
                break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *temp = WEAK_OBJECT(UIView, init);
    return temp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_user_CustomerReturnApplyDic release];
    [_user_MerchantDisagreeDic release];
    [_user_CustomerReturnLogisticsDic release];
    [_user_AgreeDic release];
    
    [_merchant_ReturnDetail release];
    [_merchant_MerchantDisagreeDic release];
    [_merchant_MerchantAgreeDic release];
    [_merchant_CustomerReturnLogisticsDic release];
    
    
    [_creatTime release];
    [_mainTable release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setMainTable:nil];
    [super viewDidUnload];
}
@end
