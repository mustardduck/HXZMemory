//
//  MJRefreshController.h
//
//  Created by Ynag G on 14-5-30.
//  Copyright (c) 2014年 .C . All rights reserved.
//

@class MJRefreshController;

typedef DictionaryWrapper* (^ MJRefreshURLGenerator)(NSString* refreshName, int pageIndex,int pageSize);
typedef DictionaryWrapper* (^ MJRefreshNetData2MJData)(DictionaryWrapper* refreshData);
typedef void (^ MJRefreshRequest)(DelegatorID delegatorID, BOOL byHeader, DictionaryWrapper* refreshData);
typedef void (^ MJRefreshOnRequestDone)(MJRefreshController* controller, BOOL byHeader, DictionaryWrapper* netData);

typedef BOOL (^ MJRefreshPrevRequestHandler)(MJRefreshController* controller, BOOL byHeader, DelegatorArguments* arguments);
typedef void (^ MJRefreshPostRequestHandler)(MJRefreshController* controller, BOOL byHeader, DelegatorArguments* arguments);


#define MJREFRESH_URL_GENERATOR_BLOCK ^ DictionaryWrapper* (NSString* refreshName, int pageIndex,int pageSize)

#define MJREFRESH_NETDATA2MJDATA_BLOCK ^ DictionaryWrapper* (DictionaryWrapper* refreshData)

#define MJREFRESH_REQUEST_BLOCK ^ void (DelegatorID delegatorID, BOOL byHeader, DictionaryWrapper* refreshData)

#define MJREFRESH_PREV_REQUEST_HANDLER ^ BOOL (MJRefreshController* controller, BOOL byHeader, DelegatorArguments* arguments)

#define MJREFRESH_POST_REQUEST_HANDLER ^ void (MJRefreshController* controller, BOOL byHeader, DelegatorArguments* arguments)

#define MJREFRESH_ON_REQUEST_DONE ^ void (MJRefreshController* controller, BOOL byHeader, DictionaryWrapper* netData)

DECL_DELEGATOR_FEATURE_CLASS(__DFCMJRefreshController, NSObject)

@interface MJRefreshController : __DFCMJRefreshController
- (NSArray*) refreshData;
- (int) refreshCount;
- (id) dataAtIndex:(int)index;

- (void) setURLGenerator:(MJRefreshURLGenerator) urlGenerator;
- (void) setDataConverter:(MJRefreshNetData2MJData) dataConverter;
- (void) setRequester:(MJRefreshRequest)requester;
- (void) setOnRequestDone:(MJRefreshOnRequestDone)onRequestDone;
- (void) setPrevRequestHandler:(MJRefreshPrevRequestHandler)prev;
- (void) setPostRequestHandler:(MJRefreshPostRequestHandler)post;

- (void) setPageSize:(int)pageSize;

- (void) refresh;
- (void) refreshWithLoading;
- (void) removeDataAtIndex:(int)index;
- (void) removeDataAtIndex:(int)index andView:(UITableViewRowAnimation)animation;

+ (void) setDefaultURLGenerator:(MJRefreshURLGenerator) urlGenerator;
+ (void) setDefaultDataConverter:(MJRefreshNetData2MJData) dataConverter;
+ (void) setDefaultRequester:(MJRefreshRequest)requester;
+ (void) setDefaultOnRequestDone:(MJRefreshOnRequestDone)onRequestDone;
+ (void) setDefaultPrevRequestHandler:(MJRefreshPrevRequestHandler)prev;
+ (void) setDefaultPostRequestHandler:(MJRefreshPostRequestHandler)post;
+ (void) setDefaultHeaderContentViewClass:(Class)cls;

+ (instancetype) controllerFrom:(UITableView*)refreshView name:(NSString*)refreshName;
+ (instancetype) controllerNoHeadersFrom:(UITableView*)refreshView name:(NSString*)refreshName;
+ (instancetype) controllerNoFooterFrom:(UITableView*)refreshView name:(NSString*)refreshName;

@end

#import "MJHeaderContentView.h"
