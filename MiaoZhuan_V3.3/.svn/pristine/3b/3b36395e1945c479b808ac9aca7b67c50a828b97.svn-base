//
//  CRHttpAddedManager.m
//  miaozhuan
//
//  Created by abyss on 15/1/28.
//  Copyright (c) 2015年 zdit. All rights reserved.
//

#import "CRHttpAddedManager.h"
#import "CRWebSupporter.h"

@implementation CRHttpAddedManager

+ (void)checkDidshouldUpdate:(DictionaryWrapper *)ret
{
    if(![ret isKindOfClass:[DictionaryWrapper class]]) return; //特殊接口
    if(!ret || !ret.code) return;                              //空
        
    if ([self shouldUpdateByCode:ret.code])
    {
        [AlertUtil showAlert:@"发现新版本"
                     message:ret.operationMessage
                     buttons:@[@{ @"title":@"确定",
                                         @"delegator":ALERT_VIEW_DELEGATOR_BLOCK({
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ret.data]];})}]];
    }
}

+ (BOOL)shouldUpdate:(DictionaryWrapper *)ret
{
    return [self shouldUpdateByCode:ret.code];
}

+ (BOOL)shouldUpdateByCode:(int)code
{
    return (BOOL)(code == - 10);
}

+ (void)mz_pushViewController:(UIViewController *)model
{
    if ([SystemUtil aboveIOS7_0])
    {
        [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
    }
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(),
                       ^{
            [UI_MANAGER.mainNavigationController pushViewController:model animated:YES];
        });
    }
}

+ (NSString *)show_numbersLimitNum:(double)numbers toPoint:(int)afterNum;
{
    NSString* ret   = [NSString stringWithFormat:@"%f",numbers];
    NSString* flag  = @".";
    NSRange   pos;
    
    // without any operation
    if (afterNum < 0){ return ret;}
    
    // ...if need
    if (![ret containsString:flag]){[ret stringByAppendingString:@".000000"];}
    
    
    pos = [ret rangeOfString:flag];
    
    NSString* origial = [ret substringToIndex:pos.location];
    NSString* more = [ret substringFromIndex:pos.location + 1];
    
    if (more.length > afterNum)
    {
        more = [more substringToIndex:afterNum];
    }
    
    // get integer
    if (afterNum == 0) return origial;
    
    // get zero
    if (ret.doubleValue == 0) return @"0";
    
    // get result
    ret = [origial stringByAppendingString:@"."];
    ret = [ret stringByAppendingString:more];

    return ret;
}

@end
