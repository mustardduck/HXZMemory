//
//  OpenRedPacketViewController.h
//  miaozhuan
//
//  Created by Santiago on 14-10-30.
//  Copyright (c) 2014年 zdit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RefreshProtocol <NSObject>
- (void)refresh;
@end
@interface OpenRedPacketViewController : DotCViewController

@property (nonatomic, assign)int comeformCounsel;

@property (assign, nonatomic)id<RefreshProtocol>delegate;
@property (nonatomic, assign)int adsId;

extern NSString* const kCTSMSMessageReceivedNotification;

extern NSString* const kCTSMSMessageReplaceReceivedNotification;
extern NSString* const kCTSIMSupportSIMStatusNotInserted;
extern NSString* const kCTSIMSupportSIMStatusReady;

id CTTelephonyCenterGetDefault(void);
void CTTelephonyCenterAddObserver(id,id,CFNotificationCallback,NSString*,void*,int);
void CTTelephonyCenterRemoveObserver(id,id,NSString*,void*);
int CTSMSMessageGetUnreadCount(void);

int CTSMSMessageGetRecordIdentifier(void * msg);
NSString * CTSIMSupportGetSIMStatus();
NSString * CTSIMSupportCopyMobileSubscriberIdentity();

id  CTSMSMessageCreate(void* unknow/*always 0*/,NSString* number,NSString* text);
void * CTSMSMessageCreateReply(void* unknow/*always 0*/,void * forwardTo,NSString* text);

void* CTSMSMessageSend(id server,id msg);

NSString *CTSMSMessageCopyAddress(void *, void *);
NSString *CTSMSMessageCopyText(void *, void *);

@end